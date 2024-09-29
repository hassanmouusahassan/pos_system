import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../repositories/inventory_repository.dart';

class InventoryCubit extends Cubit<List<Product>> {
  final InventoryRepository _inventoryRepository;

  InventoryCubit(this._inventoryRepository) : super([]) {
    _loadFakeInventory(); // Load fake products
  }

  void _loadFakeInventory() {
    final products = [
      Product(id: '1', name: 'Apple', price: 1.5, stock: 20),
      Product(id: '2', name: 'Banana', price: 1.0, stock: 30),
      Product(id: '3', name: 'Orange', price: 1.2, stock: 25),
      Product(id: '4', name: 'Mango', price: 2.0, stock: 15),
      Product(id: '5', name: 'Grapes', price: 3.5, stock: 10),
      Product(id: '6', name: 'Watermelon', price: 4.0, stock: 8),
      Product(id: '7', name: 'Pineapple', price: 5.0, stock: 12),
      Product(id: '8', name: 'Strawberry', price: 6.0, stock: 9),
      Product(id: '9', name: 'Peach', price: 2.5, stock: 18),
      Product(id: '10', name: 'Blueberry', price: 7.0, stock: 5),
      Product(id: '11', name: 'Pear', price: 2.0, stock: 16),
      Product(id: '12', name: 'Plum', price: 2.3, stock: 22),
      Product(id: '13', name: 'Kiwi', price: 1.8, stock: 14),
      Product(id: '14', name: 'Coconut', price: 3.0, stock: 6),
      Product(id: '15', name: 'Avocado', price: 5.5, stock: 8),
      Product(id: '16', name: 'Papaya', price: 3.8, stock: 10),
      Product(id: '17', name: 'Lemon', price: 0.7, stock: 50),
      Product(id: '18', name: 'Guava', price: 1.9, stock: 20),
      Product(id: '19', name: 'Dragon Fruit', price: 8.0, stock: 3),
      Product(id: '20', name: 'Lychee', price: 4.5, stock: 7),
    ];
    emit(products);
  }

  void updateStock(Product product, int quantity) {
    _inventoryRepository.updateProductStock(product, quantity);
    emit(List.from(state));  // Refresh state after updating stock
  }
}
