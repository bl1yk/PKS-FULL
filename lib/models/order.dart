import 'package:full_proj_pks/models/product.dart';

class Order {
  final int id;
  final int userId;
  final double totalPrice;
  final DateTime orderDate;
  final List<Product> products;

  Order({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.orderDate,
    required this.products,
  });

  // Фабрика для создания Order из JSON
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      userId: json['user_id'],
      totalPrice: json['total_price'].toDouble(),
      orderDate: DateTime.parse(json['order_date']),
      products: List<Product>.from(
        json['products'].map((product) => Product.fromJson(product)),
      ),
    );
  }
}