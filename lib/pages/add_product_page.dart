import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:provider/provider.dart';
import 'package:full_proj_pks/models/product_manager.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController productTitleController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productAboutController = TextEditingController();
  final TextEditingController productListenController = TextEditingController();

  @override
  void dispose() {
    productTitleController.dispose();
    productImageController.dispose();
    productPriceController.dispose();
    productAboutController.dispose();
    productListenController.dispose();
    super.dispose();
  }

  Future<void> _createProduct(BuildContext context) async {
    final productTitle = productTitleController.text;
    final productImage = productImageController.text;
    final productPrice = int.tryParse(productPriceController.text) ?? 0;
    final productAbout = productAboutController.text;
    final productListen = productListenController.text;

    if (productTitle.isNotEmpty && productImage.isNotEmpty && productPrice > 0 && productAbout.isNotEmpty && productListen.isNotEmpty) {
      final newProduct = Product(
        productId: 0, // ID будет назначен на сервере
        productTitle: productTitle,
        productImage: productImage,
        productPrice: productPrice,
        productAbout: productAbout,
        productListen: productListen,
      );

      final productManager = Provider.of<ProductManager>(context, listen: false);
      await productManager.addProduct(newProduct); // Добавляем продукт через API

      Navigator.pop(context); // Возвращаемся на предыдущую страницу
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пожалуйста, заполните все поля корректно.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
        title: const Text(
          "Добавление товара",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: productTitleController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите название товара",
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelText: "Название",
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productImageController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите ссылку на изображение",
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelText: "Ссылка",
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productPriceController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите стоимость товара",
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelText: "Стоимость",
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productAboutController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите описание товара",
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelText: "Описание",
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productListenController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите ссылку на прослушивание",
                  hintStyle: const TextStyle(color: Colors.white54),
                  labelText: "Прослушивание",
                  labelStyle: const TextStyle(color: Colors.white),
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 16),

              // Кнопка перехода к методу создания экземпляра класса Product
              ElevatedButton(
                onPressed: () => _createProduct(context),
                child: const Text(
                  "Добавить товар",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  minimumSize: const Size(300, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}