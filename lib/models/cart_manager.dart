import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/models/product.dart';

class CartManager with ChangeNotifier{
  final List<Product> _cartProducts = <Product>[];

  List<Product> get cartProducts => _cartProducts;

  void addToCart(Product product){
    if (!_cartProducts.contains(product)){
      _cartProducts.add(product);
      product.quantity++;
      notifyListeners();
    }
  }

  void removeFromCart(Product product, BuildContext context){
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text('Подтверждение удаления'),
            content: const Text('Вы уверены, что хотите удалить этот товар?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Отмена',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Удалить',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  _cartProducts.remove(product);
                  notifyListeners();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      product.quantity = 0;
  }

  bool isInCart(Product product){
    return _cartProducts.contains(product);
  }
}