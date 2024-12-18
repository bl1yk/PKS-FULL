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
        title: const Text("Добавление товара"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: productTitleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите название товара",
                  labelText: "Название",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productImageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите ссылку на изображение",
                  labelText: "Ссылка",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productPriceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите стоимость товара",
                  labelText: "Стоимость",
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productAboutController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите описание товара",
                  labelText: "Описание",
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: productListenController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  hintText: "Введите характеристики товара",
                  labelText: "Характеристики",
                ),
                maxLines: 7,
              ),
              const SizedBox(height: 16),

              // Кнопка перехода к методу создания экземпляра класса Product
              ElevatedButton(
                onPressed: () => _createProduct(context),
                child: const Text("Добавить товар",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amberAccent,
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