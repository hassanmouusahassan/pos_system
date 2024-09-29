import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../repositories/inventory_repository.dart';
import '../models/transaction.dart';
import '../repositories/sales_repository.dart';
import 'sales_cubit.dart';

class CartCubit extends Cubit<List<Product>> {
  final InventoryRepository _inventoryRepository;
  final SalesRepository _salesRepository;
  final SalesCubit _salesCubit;  // Added SalesCubit to record transactions

  CartCubit(this._inventoryRepository, this._salesRepository, this._salesCubit) : super([]);

  void addItem(Product product) {
    if (product.stock > 0) {
      product.stock--;  // Decrease stock locally
      emit(List.from(state)..add(product));
    }
  }

  void removeItem(Product product) {
    state.remove(product);
    product.stock++;  // Increase stock back locally
    emit(List.from(state));
  }

  double calculateTotal() {
    return state.fold(0, (sum, item) => sum + item.price);
  }

  void checkout() {
    if (state.isNotEmpty) {
      final transaction = Transaction(
        id: DateTime.now().toString(),
        items: List.from(state),
        total: calculateTotal(),
      );

      // Update the stock levels in the repository
      for (var product in state) {
        _inventoryRepository.updateProductStock(product, product.stock);
      }

      // Record the transaction in the sales repository and sales cubit
      _salesRepository.addTransaction(transaction);
      _salesCubit.recordSale(transaction);  // Record sale in SalesCubit

      clearCart();  // Clear the cart after successful checkout
    }
  }

  void clearCart() {
    emit([]);
  }
}
