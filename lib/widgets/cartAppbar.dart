import 'package:flutter/material.dart';

class CartAppBar extends StatelessWidget {
  const CartAppBar({super.key});

  static const TextStyle _textStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 125),
            child: Text(
              'Cart',
              style: _textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
