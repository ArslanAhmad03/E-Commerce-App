import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class no_use extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Product Count'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final CartProducts = snapshot.data?.docs ?? [];
          int productCount = CartProducts.length;

          return Center(
            child: Text(
              'Number of Products in Cart: $productCount',
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
