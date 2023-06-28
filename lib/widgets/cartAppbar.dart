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
          InkWell(
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 125),
            child: Text(
              'Cart',
              style: _textStyle,
            ),
          ),
          Spacer(),
          Icon(
            Icons.more_vert,
            size: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
