import 'package:flutter/material.dart';

class ItemAppBar extends StatefulWidget {
  const ItemAppBar({super.key});

  @override
  State<ItemAppBar> createState() => _ItemAppBarState();
}

class _ItemAppBarState extends State<ItemAppBar> {
  static const TextStyle _textStyle =
      TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);

  bool _favo = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Product',
              style: _textStyle,
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                setState(() {
                  _favo = !_favo;
                });
              },
              icon: _favo
                  ? Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )
                  : Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )),
        ],
      ),
    );
  }
}
