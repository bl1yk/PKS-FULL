import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:full_proj_pks/api/supabase_service.dart';
import 'package:full_proj_pks/pages/auth_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _supabase = SupabaseService().client;

  Future<void> _signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    try {
      // Попытка регистрации
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      // Проверяем, есть ли пользователь в ответе
      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Регистрация прошла успешно. Проверьте вашу почту для подтверждения.'),
          ),
        );
        Navigator.of(context).pop(); // Возвращаемся на страницу авторизации
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Произошла ошибка при регистрации.')),
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
          'Регистрация',
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
              onPressed: _signUp,
              child: const Text(
                'Зарегистрироваться',
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
                  MaterialPageRoute(builder: (context) => const AuthPage()),
                );
              },
              child: const Text(
                'Уже есть аккаунт? Войти',
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