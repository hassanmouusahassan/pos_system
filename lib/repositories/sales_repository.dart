import 'package:shared_preferences/shared_preferences.dart';
import '../models/transaction.dart';
import 'dart:convert';

class SalesRepository {
  final String _salesKey = 'sales_transactions';

  // Load sales transactions from SharedPreferences
  Future<List<Transaction>> getSalesTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsListJson = prefs.getString(_salesKey);

    if (transactionsListJson != null) {
      final List<dynamic> decodedTransactions = jsonDecode(transactionsListJson);
      return decodedTransactions.map((json) => Transaction.fromJson(json)).toList();
    }
    return [];
  }

  // Save a new transaction to SharedPreferences
  Future<void> addTransaction(Transaction transaction) async {
    final transactions = await getSalesTransactions();
    transactions.add(transaction);

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_salesKey, jsonEncode(transactions.map((t) => t.toJson()).toList()));
  }
}
