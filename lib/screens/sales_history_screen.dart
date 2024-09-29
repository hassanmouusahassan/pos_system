import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/sales_cubit.dart';
import '../models/transaction.dart';
import '../widgets/sales_item.dart';

class SalesHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Sales History', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: BlocBuilder<SalesCubit, List<Transaction>>(
        builder: (context, salesHistory) {
          if (salesHistory.isEmpty) {
            return Center(child: Text('No sales history available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: salesHistory.length,
              itemBuilder: (context, index) {
                return SalesItem(transaction: salesHistory[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
