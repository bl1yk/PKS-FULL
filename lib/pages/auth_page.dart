import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:full_proj_pks/components/b_nav_bar.dart';
import 'package:full_proj_pks/api/supabase_service.dart';
import 'package:full_proj_pks/pages/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _supabase = SupabaseService().client;

  Future<void> _signIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        // Если авторизация успешна, переходим на главную страницу
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BNavBar()),
        );
      } else {
        // Если пользователь не найден, показываем сообщение об ошибке
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверный email или пароль')),
        );
      }
    } on AuthException catch (error) {
      // Обрабатываем ошибки авторизации
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message)),
      );
    } catch (error) {
      // Обрабатываем другие ошибки
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Произошла ошибка: ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(57, 62, 65, 1), // Цвет фона страницы
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1), // Цвет AppBar
        title: const Text(
          'Авторизация',
          style: TextStyle(color: Colors.white), // Цвет текста в AppBar
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white), // Цвет текста в текстовом поле
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                hintText: "Введите email",
                hintStyle: const TextStyle(color: Colors.white54), // Цвет подсказки
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.white), // Цвет метки
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(color: Colors.white), // Цвет текста в текстовом поле
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                hintText: "Введите пароль",
                hintStyle: const TextStyle(color: Colors.white54), // Цвет подсказки
                labelText: "Пароль",
                labelStyle: const TextStyle(color: Colors.white), // Цвет метки
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _signIn,
              child: const Text(
                'Войти',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black, // Цвет текста на кнопке
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(102, 155, 188, 1), // Цвет кнопки
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text(
                'Нет аккаунта? Зарегистрируйтесь',
                style: TextStyle(
                  color: Colors.white, // Цвет текста на кнопке
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}