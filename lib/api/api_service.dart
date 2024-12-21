import 'package:dio/dio.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/models/order.dart';

class ApiService {
  final Dio _dio = Dio();

  // Получение списка продуктов
  Future<List<Product>> getProducts({
    String searchQuery = "",
    double minPrice = 0,
    double maxPrice = 10000,
    String sortBy = "",
    String sortOrder = "asc",
  }) async {
    try {
      final response = await _dio.get('http://192.168.1.43:8080/products', queryParameters: {
        'search': searchQuery,
        'min_price': minPrice,
        'max_price': maxPrice,
        'sort_by': sortBy,
        'sort_order': sortOrder,
      });
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

  // Обновление количества товара
  Future<Product> updateProductQuantity(int productId, int quantity) async {
    try {
      final response = await _dio.put(
        'http://192.168.1.43:8080/products/quantity/$productId',
        data: {'quantity': quantity},
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to update product quantity');
      }
    } catch (e) {
      throw Exception('Error updating product quantity: $e');
    }
  }

  // Добавление/удаление товара из избранного
  Future<Product> toggleFavorite(int productId) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.43:8080/products/favorite/$productId',
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to toggle favorite');
      }
    } catch (e) {
      throw Exception('Error toggling favorite: $e');
    }
  }

  // Обновление флага InCart (добавление/удаление из корзины)
  Future<Product> toggleCart(int productId) async {
    try {
      final response = await _dio.post(
        'http://192.168.1.43:8080/products/cart/$productId',
      );
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      } else {
        throw Exception('Failed to toggle cart');
      }
    } catch (e) {
      throw Exception('Error toggling cart: $e');
    }
  }

  Future<void> createOrder(double totalPrice, List<Map<String, dynamic>> products) async {
    try {
      await _dio.post('http://192.168.1.43:8080/orders/create', data: {
        'user_id': 1,
        'total_price': totalPrice,
        'products': products,
      });
    } catch (e) {
      throw Exception('Error creating order: $e');
    }
  }

  // Метод для получения заказов пользователя
  Future<List<Order>> getOrders(int userId) async {
    try {
      final response = await _dio.get('http://192.168.1.43:8080/orders?user_id=$userId');
      if (response.statusCode == 200) {
        List<Order> orders = (response.data as List).map((order) => Order.fromJson(order)).toList();
        return orders;
      } else {
        throw Exception('Failed to load orders');
      }
    } catch (e) {
      throw Exception('Error fetching orders: $e');
    }
  }

  Future<void> updateProductInCartStatus(int productId, bool inCart) async {
    try {
      await _dio.post('http://192.168.1.43:8080/products/cart/$productId', data: {
        'in_cart': inCart,
      });
    } catch (e) {
      throw Exception('Error updating product in cart status: $e');
    }
  }
}