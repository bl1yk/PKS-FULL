import 'package:flutter/material.dart';
import 'package:full_proj_pks/api/api_service.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/models/product_manager.dart';
import 'package:full_proj_pks/pages/product_page.dart';
import 'package:full_proj_pks/models/favorite_manager.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final int index;

  const ProductItem({super.key, required this.product, required this.index});

  @override
  _ProductItemState createState() => _ProductItemState(product: product);
}

class _ProductItemState extends State<ProductItem> {
  final Product product;
  _ProductItemState({required this.product}) : super();

  late Future<List<Product>> _products;

  @override
  void initState() {
    super.initState();
    _products = ApiService().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0), // Увеличен отступ для плиток
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductPage(product: widget.product)),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromRGBO(233, 79, 55, 1),
          ),
          width: MediaQuery.of(context).size.width * 0.45, // Увеличенная ширина плитки
          height: MediaQuery.of(context).size.height * 0.4, // Увеличенная высота плитки
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        widget.product.productImage,
                        height: 150, // Увеличенная высота изображения
                        width: double.infinity, // Ширина на всю плитку
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      widget.product.productTitle, // Название продукта
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16, // Увеличенный размер текста
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Center(
                    child: Text(
                      '${widget.product.productPrice}₽', // Цена продукта
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    favoriteManager.isFavorite(product) ? Icons.favorite : Icons.favorite_border,
                    color: favoriteManager.isFavorite(product) ? const Color.fromRGBO(102, 155, 188, 1) : Colors.grey,
                  ),
                  onPressed: () {
                    if (favoriteManager.isFavorite(product)) {
                      favoriteManager.removeFromFavorite(product);
                    } else {
                      favoriteManager.addToFavorite(product);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}