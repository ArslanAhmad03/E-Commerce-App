import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          IconButton(
            color: Colors.white,
            icon: const Icon(
              Icons.sort,
            ),
            onPressed: () {},
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Click Shop',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const Spacer(),
          Badge(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.all(7.0),
            child: InkWell(
              onTap: () {
                //////
              },
              child: const Icon(
                Icons.notifications,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
