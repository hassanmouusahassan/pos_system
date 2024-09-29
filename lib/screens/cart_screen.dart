import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cart_cubit.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cart', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: BlocBuilder<CartCubit, List<Product>>(
        builder: (context, cartItems) {
          if (cartItems.isEmpty) {
            return Center(child: Text('No items in the cart.'));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final product = cartItems[index];
                    return _buildCartTile(context, product);
                  },
                ),
              ),
              _buildTotalBar(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCartTile(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                SizedBox(height: 5),
                Text('\$${product.price}', style: TextStyle(fontSize: 16, color: CupertinoColors.systemGreen)),
                SizedBox(height: 5),
                Text('Stock: ${product.stock}', style: TextStyle(fontSize: 14, color: CupertinoColors.systemGrey)),
              ],
            ),
            CupertinoButton(
              child: Icon(CupertinoIcons.minus_circled, color: CupertinoColors.destructiveRed),
              onPressed: () {
                context.read<CartCubit>().removeItem(product);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalBar(BuildContext context) {
    final total = context.read<CartCubit>().calculateTotal();
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, -8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text('\$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, color: CupertinoColors.activeGreen)),
          CupertinoButton.filled(
            child: Text('Checkout'),
            onPressed: () {
              context.read<CartCubit>().checkout();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Checkout Successful!')),
              );
            },
          ),
        ],
      ),
    );
  }
}
