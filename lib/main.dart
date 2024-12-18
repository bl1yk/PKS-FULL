import 'package:flutter/material.dart';
import 'package:full_proj_pks/components/b_nav_bar.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:full_proj_pks/models/favorite_manager.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:full_proj_pks/models/product_manager.dart';
import 'package:provider/provider.dart';

void main() {
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
      title: 'VINYL STORE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const BNavBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}