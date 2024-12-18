import 'package:flutter/material.dart';
import 'package:full_proj_pks/components/product_item.dart';
import 'package:full_proj_pks/pages/add_product_page.dart';
import 'package:full_proj_pks/models/product_manager.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Загружаем продукты при инициализации страницы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductManager>(context, listen: false).fetchProducts();
    });
  }

  void navigateToAddProductPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddProductPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productManager = Provider.of<ProductManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "VINYL STORE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 6,
              fontSize: 40,
              color: Color.fromRGBO(102, 155, 188, 1),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      ),
      body: productManager.products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2.0,
          mainAxisSpacing: 2.0,
          childAspectRatio: 0.76,
        ),
        itemCount: productManager.products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductItem(
              product: productManager.products[index], index: index);
        },
      ),
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromRGBO(102, 155, 188, 1),
        onPressed: () => navigateToAddProductPage(context),
        child: const Icon(Icons.add_box_rounded),
        tooltip: "Добавить товар",
      ),
    );
  }
}