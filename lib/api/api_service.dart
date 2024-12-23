import 'package:dio/dio.dart';
import 'package:full_proj_pks/models/product.dart';

class ApiService {
  final Dio _dio = Dio();

  // Получение списка продуктов
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('http://192.168.1.43:8080/products');
      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((product) => Product.fromJson(product))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  // Получение продукта по ID
  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('http://192.168.1.43:8080/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to load product with id: $id');
      }
    } catch (e) {
      throw Exception('Error fetching product: $e');
    }
  }

  // Создание нового продукта
  Future<Product> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.43:8080/products/create',
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to create product');
      }
    } catch (e) {
      throw Exception('Error creating product: $e');
    }
  }

  // Обновление продукта
  Future<Product> updateProduct(int id, Product product) async {
    try {
      final response = await _dio.put(
        'http://192.168.1.43:8080/products/update/$id',
        data: product.toJson(),
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to update product with id: $id');
      }
    } catch (e) {
      throw Exception('Error updating product: $e');
    }
  }

  // Удаление продукта
  Future<void> deleteProduct(int id) async {
    try {
      final response = await _dio.delete('http://192.168.1.43:8080/products/delete/$id');
      if (response.statusCode != 204) {
        throw Exception('Failed to delete product with id: $id');
      }
    } catch (e) {
      throw Exception('Error deleting product: $e');
    }
  }
}