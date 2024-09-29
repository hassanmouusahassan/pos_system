import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/transaction.dart';
import '../repositories/sales_repository.dart';

class SalesCubit extends Cubit<List<Transaction>> {
  final SalesRepository _salesRepository;

  SalesCubit(this._salesRepository) : super([]) {
    loadSalesHistory();  // Load the saved sales history when the cubit is created
  }

  // Load sales history from the repository
  void loadSalesHistory() async {
    final transactions = await _salesRepository.getSalesTransactions();
    emit(transactions);
  }

  // Record a new sale and save it to SharedPreferences
  void recordSale(Transaction transaction) async {
    await _salesRepository.addTransaction(transaction);
    emit(List.from(state)..add(transaction));
  }
}
