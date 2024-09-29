import 'product.dart';

class Transaction {
  final String id;
  final List<Product> items;
  final double total;

  Transaction({
    required this.id,
    required this.items,
    required this.total,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'items': items.map((item) => item.toJson()).toList(),
    'total': total,
  };

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      items: (json['items'] as List).map((i) => Product.fromJson(i)).toList(),
      total: json['total'],
    );
  }
}
