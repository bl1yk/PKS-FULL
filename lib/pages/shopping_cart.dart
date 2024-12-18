import 'package:flutter/material.dart';
import 'package:full_proj_pks/components/cart_product.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {

  const ShoppingCart({super.key});

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
        title: const Center(
          child: Text(
            "КОРЗИНА",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 40,
                color: Color.fromRGBO(102, 155, 188, 1)
            ),
          ),
        ),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index){
            return CartProduct(product: cartManager.cartProducts[index]);
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: cartManager.cartProducts.length,
      ),
    );
  }
}