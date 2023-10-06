
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class myOrder extends StatefulWidget {
  const myOrder({super.key});

  @override
  State<myOrder> createState() => _myOrderState();
}

class _myOrderState extends State<myOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Orders'),
        backgroundColor: Colors.purple,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final CartProducts = snapshot.data?.docs ?? [];

          if (CartProducts.isEmpty) {
            return const Center(
              child: Text('No Order products yet.'),
            );
          }
          return ListView.builder(
            itemCount: CartProducts.length,
            itemBuilder: (context, index) {
              final product = CartProducts[index].data()
              as Map<dynamic, dynamic>?;

              if (product == null) {
                return const ListTile(
                  title: Text('Product is null'),
                  subtitle: Text('Description not available'),
                  trailing: Text('Price N/A'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 122,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ListTile(
                          leading: Image.network(
                            (product['imageUrls'] is List && product['imageUrls'].isNotEmpty)
                                ? product['imageUrls'][0].toString()
                                : 'No Image',
                          ),
                          title:
                          Text(product['title'] ?? 'No Title'),
                          subtitle: Text(product['description'] ?? 'No Description'),
                          trailing: Text('\$ ${product['price'] ?? 'N/A'}'),
                          onTap: () {
                            print('tile press');
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
