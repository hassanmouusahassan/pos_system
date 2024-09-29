import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/cart_cubit.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price} | Stock: ${product.stock}'),
      trailing: ElevatedButton(
        onPressed: product.stock > 0
            ? () {
          context.read<CartCubit>().addItem(product);
        }
            : null,
        child: Text('Add to Cart'),
      ),
    );
  }
}
