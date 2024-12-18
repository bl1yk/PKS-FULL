import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/models/favorite_manager.dart';
import 'package:provider/provider.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:badges/badges.dart' as badges;
import 'package:full_proj_pks/models/product_manager.dart';
import 'package:full_proj_pks/pages/edit_product_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    final cartManager = Provider.of<CartManager>(context);
    final productManager = Provider.of<ProductManager>(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1), // Цвет заднего фона как в AppBar
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
        title: Text(
          widget.product.productTitle,
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              favoriteManager.isFavorite(widget.product)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: favoriteManager.isFavorite(widget.product)
                  ? const Color.fromRGBO(102, 155, 188, 1)
                  : Colors.grey,
            ),
            onPressed: () {
              if (favoriteManager.isFavorite(widget.product)) {
                favoriteManager.removeFromFavorite(widget.product);
              } else {
                favoriteManager.addToFavorite(widget.product);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            color: const Color.fromRGBO(102, 155, 188, 1),
            onPressed: () async {
              await productManager.removeProduct(widget.product.productId); // Удаляем продукт через API
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            color: const Color.fromRGBO(102, 155, 188, 1),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProductPage(product: widget.product), // Переходим на страницу редактирования
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(
              widget.product.productImage,
              height: MediaQuery.of(context).size.height * 0.5, // Уменьшена высота изображения
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Center(
              child: Text(
                '${widget.product.productPrice}₽',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Белый цвет текста
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "Описание:\n",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Белый цвет текста
                      ),
                    ),
                    TextSpan(
                      text: widget.product.productAbout,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white, // Белый цвет текста
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.justify, // Выравнивание текста по ширине
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final listenUrl = widget.product.productListen; // Получаем ссылку
                if (listenUrl.isNotEmpty) {
                  final Uri uri = Uri.parse(listenUrl); // Преобразуем строку в Uri
                  if (await canLaunchUrl(uri)) { // Проверяем, можно ли открыть ссылку
                    await launchUrl(uri); // Открываем ссылку
                  } else {
                    throw 'Could not launch $listenUrl'; // Обрабатываем ошибку
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Ссылка отсутствует"),
                    ),
                  );
                }
              },
              child: const Text(
                "Слушать",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(233, 79, 55, 1), // Цвет кнопки "Слушать"
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(57, 62, 65, 1),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Row(
            children: [
              Container(
                child: badges.Badge(
                  badgeContent: Text(
                    "${widget.product.quantity}",
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.red,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      cartManager.addToCart(widget.product);
                    },
                    child: const Text("В корзину"),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                      backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(102, 155, 188, 1)),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontSize: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Купить"),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(14)),
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}