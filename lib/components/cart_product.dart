import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'package:full_proj_pks/pages/product_page.dart';
import 'package:full_proj_pks/api/api_service.dart';

class CartProduct extends StatefulWidget {
  final Product product;

  const CartProduct({super.key, required this.product});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductPage(product: widget.product,)),
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.network(
                    widget.product.productImage,
                    height: 140,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        '\₽${widget.product.productPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 165,
            child: IconButton(
              onPressed: () {
                cartManager.removeFromCart(widget.product, context);
              },
              icon: const Icon(Icons.delete_outline),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 230,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove, color: Colors.white),
                  onPressed: () async {
                    if (widget.product.quantity > 1) {
                      setState(() {
                        widget.product.quantity--;
                      });
                      // Обновляем quantity на сервере
                      await _apiService.updateProductQuantity(widget.product.productId, widget.product.quantity);
                    } else {
                      cartManager.removeFromCart(widget.product, context);
                    }
                  },
                ),
                Text(
                  "${widget.product.quantity}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  onPressed: () async {
                    setState(() {
                      widget.product.quantity++;
                    });
                    // Обновляем quantity на сервере
                    await _apiService.updateProductQuantity(widget.product.productId, widget.product.quantity);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}