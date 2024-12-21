import 'package:flutter/material.dart';
import 'package:full_proj_pks/components/b_nav_bar.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:full_proj_pks/models/favorite_manager.dart';
import 'package:full_proj_pks/models/product_manager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:full_proj_pks/api//supabase_service.dart';
import 'package:full_proj_pks/pages/auth_page.dart';
import 'package:full_proj_pks/pages/home_page.dart';
import 'package:full_proj_pks/pages/order_page.dart';
import 'package:full_proj_pks/pages/shopping_cart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService().initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavoriteManager()),
        ChangeNotifierProvider(create: (_) => CartManager()),
        ChangeNotifierProvider(create: (_) => ProductManager()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/cart': (context) => const ShoppingCart(), // Страница корзины
        '/orders': (context) => OrdersPage(), // Страница заказов
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AuthChecker(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = SupabaseService().client;

    return StreamBuilder<AuthState>(
      stream: supabase.auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session;

        if (session != null) {
          return const BNavBar();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}