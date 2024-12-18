import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/favorite_manager.dart';
import 'package:provider/provider.dart';
import 'package:full_proj_pks/components/product_item.dart';

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {

  @override
  Widget build(BuildContext context) {
    final favoriteManager = Provider.of<FavoriteManager>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
        title: const Center(
          child: Text(
            "ИЗБРАННОЕ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 40,
                color: Color.fromRGBO(102, 155, 188, 1)
            ),
          ),
        ),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // количество элементов в сетке
            crossAxisSpacing: 2.0, // расстояние между столбцами
            mainAxisSpacing: 2.0, // расстояние между строками
            childAspectRatio: 0.76, // соотношение сторон элементов
          ),
          itemBuilder: (BuildContext context, int index) {
            return ProductItem(product: favoriteManager.favProducts[index], index: index,);
          },
          itemCount: favoriteManager.favProducts.length,
      ),
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
    );
  }
}






