import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  static List<String> name = [
    'Sandals',
    'Watch',
    'Laptop Bag',
    'Travel Bag',
    'handbag',
    'Sandals Heels',
    'Watch'
  ];

  static const TextStyle _textStyle = TextStyle(
      fontSize: 15, color: Colors.purple, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    int i = 0;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (i = 0; i <= 6; i++)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.purple)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    //
                    'assets/S$i.png',
                    //
                    width: 40,
                    height: 40,
                  ),
                  Text(name[i], style: _textStyle)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
//
