import 'package:flutter/material.dart';
import 'package:full_proj_pks/models/product.dart';
import 'package:full_proj_pks/pages/fav_page.dart';
import 'package:full_proj_pks/pages/home_page.dart';
import 'package:full_proj_pks/pages/profile.dart';
import 'package:full_proj_pks/pages/shopping_cart.dart';
import 'package:full_proj_pks/models/cart_manager.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BNavBar extends StatefulWidget {
  const BNavBar({super.key});

  @override
  State<BNavBar> createState() => _BNavBarState();
}

class _BNavBarState extends State<BNavBar> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavPage(),
    ShoppingCart(),
    Profile(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartManager = Provider.of<CartManager>(context);
    return Scaffold(
      body:
      _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Главная",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Избранное",
          ),
          BottomNavigationBarItem(
            icon: badges.Badge(
                badgeContent: Text(
                  "${cartManager.cartProducts.length}",
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                child: const Icon(Icons.shopping_cart_outlined)
            ),
            label: "Корзина",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Личный кабинет",
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromRGBO(102, 155, 188, 1),
        unselectedItemColor: const Color.fromRGBO(102, 155, 188, 1),
        backgroundColor: const Color.fromRGBO(57, 62, 65, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}