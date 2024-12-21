import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:full_proj_pks/api/supabase_service.dart'; // Импортируйте SupabaseService
import 'package:full_proj_pks/pages/auth_page.dart';

import 'order_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Переменная для хранения email пользователя
  String? _userEmail;

  @override
  void initState() {
    super.initState();
    // Получаем текущую сессию пользователя
    _loadUserEmail();
  }

  // Метод для загрузки email пользователя
  Future<void> _loadUserEmail() async {
    final supabase = SupabaseService().client; // Получаем клиент Supabase
    final session = supabase.auth.currentSession;

    if (session != null && session.user != null) {
      setState(() {
        _userEmail = session.user!.email; // Получаем email пользователя
      });
    } else {
      // Если пользователь не авторизован, перенаправляем на страницу авторизации
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final supabase = SupabaseService().client; // Получаем клиент Supabase

    return Scaffold(
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
        title: const Center(
          child: Center(
            child: Text(
              'ПРОФИЛЬ',
              style: TextStyle(fontWeight: FontWeight.bold,
                  letterSpacing: 6,
                  fontSize: 40,
                  color: Color.fromRGBO(102, 155, 188, 1)
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Color.fromRGBO(102, 155, 188, 1), // Устанавливаем цвет иконки
            ),
            onPressed: () async {
              await supabase.auth.signOut(); // Используем supabase для выхода
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const AuthPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/1.png'),
              ),
              const SizedBox(height: 16),
              const Text(
                'David Gilmour',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Телефон: +7 (123) 456-78-90',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text(
                'Email: pinkfloyd@fan.com',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              ListTile(
                title: const Text(
                  'Мои заказы',
                  style: TextStyle(
                    color: Colors.white, // Белый цвет текста
                    fontSize: 25, // Увеличенный размер текста
                    fontWeight: FontWeight.bold, // Добавлен жирный шрифт для акцента
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

  }
}