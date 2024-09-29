import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class SalesItem extends StatelessWidget {
  final Transaction transaction;

  SalesItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Transaction ID: ${transaction.id}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            ...transaction.items.map((product) => Text('${product.name} - \$${product.price}')).toList(),
            Divider(),
            Text('Total: \$${transaction.total}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: CupertinoColors.activeGreen)),
          ],
        ),
      ),
    );
  }
}
