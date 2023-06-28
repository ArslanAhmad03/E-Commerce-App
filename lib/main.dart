import 'package:flutter/material.dart';
import 'package:shop/splashscreen.dart';

void main() {
  Future.delayed(const Duration(seconds: 40));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const splashscreen(),
    );
  }
}
