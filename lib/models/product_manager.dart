import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/api/api_service.dart';

class ProductManager with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = []; // Локальный массив для хранения продуктов

  List<Product> get products => _products;

  // Метод для загрузки продуктов с сервера
  Future<void> fetchProducts({
    String searchQuery = "",
    double minPrice = 0,
    double maxPrice = 10000,
    String sortBy = "",
    String sortOrder = "asc",
  }) async {
    try {
      _products = await _apiService.getProducts(
        searchQuery: searchQuery,
        minPrice: minPrice,
        maxPrice: maxPrice,
        sortBy: sortBy,
        sortOrder: sortOrder,
      );
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }
  // Метод для добавления продукта через API
  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _apiService.createProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  // Метод для удаления продукта через API
  Future<void> removeProduct(int productId) async {
    try {
      await _apiService.deleteProduct(productId);
      _products.removeWhere((product) => product.productId == productId);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }

  // Метод для обновления продукта через API
  Future<void> updateProduct(int productId, Product updatedProduct) async {
    try {
      final updated = await _apiService.updateProduct(productId, updatedProduct);
      final index = _products.indexWhere((product) => product.productId == productId);
      if (index != -1) {
        _products[index] = updated;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }
}