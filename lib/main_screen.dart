import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shop/pages/CartPage.dart';
import 'package:shop/pages/HomePage.dart';
import 'package:shop/pages/addProduct.dart';
import 'package:shop/pages/sevicesPage.dart';
import 'package:shop/pages/accPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  static List Screen = [
    const HomePage(),
    const CartPage(),
    const addProduct(),
    const sevicesPage(),
    const accPage(),
  ];

  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Screen[myIndex],
      bottomNavigationBar: CurvedNavigationBar(
          height: 55,
          index: 0,
          backgroundColor: Colors.transparent,
          color: Colors.purple,
          animationDuration: const Duration(milliseconds: 30),
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          letIndexChange: (index) => true,
          items: const [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.shopping_cart,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.design_services_sharp,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ]),
    );
  }
}
