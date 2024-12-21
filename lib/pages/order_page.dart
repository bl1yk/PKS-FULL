import 'package:flutter/material.dart';
import 'package:full_proj_pks/api/api_service.dart';
import 'package:full_proj_pks/models/order.dart';

class OrdersPage extends StatelessWidget {
  final ApiService _apiService = ApiService();

  OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1), // Фон страницы
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1), // Фон AppBar
        title: const Center(
          child: Center(
            child: Text(
              'МОИ ЗАКАЗЫ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 6,
                fontSize: 30,
                color: Color.fromRGBO(102, 155, 188, 1), // Акцентный цвет
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Order>>(
        future: _apiService.getOrders(1), // Замените на реальный ID пользователя
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(102, 155, 188, 1), // Акцентный цвет
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ошибка: ${snapshot.error}',
                style: const TextStyle(
                  color: Colors.white, // Белый текст
                  fontSize: 16,
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'У вас пока нет заказов',
                style: TextStyle(
                  color: Colors.white, // Белый текст
                  fontSize: 18,
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                return Card(
                  color: const Color.fromRGBO(102, 155, 188, 1), // Цвет карточки
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    title: Text(
                      'Заказ №${order.id}',
                      style: const TextStyle(
                        color: Colors.white, // Белый текст
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'Дата: ${order.orderDate.toString().substring(0, 10)}', // Отображаем только дату
                          style: const TextStyle(
                            color: Colors.white, // Белый текст
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Сумма: ${order.totalPrice.toStringAsFixed(2)}₽',
                          style: const TextStyle(
                            color: Colors.white, // Белый текст
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white, // Белый цвет иконки
                      ),
                      onPressed: () {
                        // Переход на страницу деталей заказа
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}