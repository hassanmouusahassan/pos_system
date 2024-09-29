import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'dart:convert';

class InventoryRepository {
  Future<List<Product>> getProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productListJson = prefs.getString('products');

    if (productListJson != null) {
      final List<dynamic> decodedProducts = jsonDecode(productListJson);
      return decodedProducts.map((json) => Product.fromJson(json)).toList();
    }
    return [];  // Return empty list if no products are found
  }

  Future<void> updateProductStock(Product product, int stock) async {
    product.stock = stock;
    final products = await getProducts();
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('products', jsonEncode(products.map((p) => p.toJson()).toList()));
  }
}
