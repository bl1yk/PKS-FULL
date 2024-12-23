class Product {
  final int productId;
  final String productTitle;
  final String productImage;
  final int productPrice;
  final String productAbout;
  final String productListen;
  int quantity;

  Product({required this.productId, required this.productTitle,
    required this.productImage,
    required this.productPrice, required this.productAbout,
    required this.productListen, this.quantity = 0,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID': productId,
      'Title': productTitle,
      'ImageURL': productImage,
      'Price': productPrice,
      'Description': productAbout,
      'Specifications': productListen,
      'Quantity': quantity,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      productId: json['ID'],
      productTitle: json['Title'],
      productImage: json['ImageURL'],
      productPrice: json['Price'],
      productAbout: json['Description'],
      productListen: json['Listen'],
      quantity: json['Quantity'],
    );
  }
}