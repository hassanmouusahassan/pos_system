import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/inventory_cubit.dart';
import '../cubits/cart_cubit.dart';
import '../models/product.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Products', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CupertinoSearchTextField(
                placeholder: "Search Products",
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query.toLowerCase();
                  });
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<InventoryCubit, List<Product>>(
                builder: (context, products) {
                  final filteredProducts = products.where((product) {
                    return product.name.toLowerCase().contains(_searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductTile(context, product);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductTile(BuildContext context, Product product) {
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${product.price}', style: TextStyle(color: CupertinoColors.systemGreen)),
                Text('Stock: ${product.stock}', style: TextStyle(color: CupertinoColors.systemGrey)),
              ],
            ),
            CupertinoButton(
              child: Icon(CupertinoIcons.add_circled, size: 30, color: CupertinoColors.activeGreen),
              onPressed: () {
                context.read<CartCubit>().addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.name} added to cart!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
