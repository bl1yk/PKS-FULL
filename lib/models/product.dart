class Product {
  final int productId;
  final String productTitle;
  final String productImage;
  final int productPrice;
  final String productAbout;
  final String productListen;
  int quantity;
  bool favourite;
  bool inCart;

  Product({required this.productId, required this.productTitle,
    required this.productImage,
    required this.productPrice, required this.productAbout,
    required this.productListen, this.quantity = 0, this.favourite = false, this.inCart = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'title': productTitle,
      'image_url': productImage,
      'price': productPrice,
      'description': productAbout,
      'listen': productListen,
      'quantity': quantity,
      'is_favourite': favourite,
      'in_cart': inCart,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      productId: json['id'],
      productTitle: json['title'],
      productImage: json['image_url'],
      productPrice: json['price'],
      productAbout: json['description'],
      productListen: json['listen'],
      quantity: json['quantity'] ?? 0,
      favourite: json['is_favourite'] ?? false,
      inCart: json['in_cart'] ?? false,
    );
  }
}