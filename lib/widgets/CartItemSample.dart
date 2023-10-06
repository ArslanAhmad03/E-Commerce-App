
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class no_use_CartAddPage extends StatefulWidget {
  const no_use_CartAddPage({super.key,});

  @override
  State<no_use_CartAddPage> createState() => _no_use_CartAddPageState();
}

class _no_use_CartAddPageState extends State<no_use_CartAddPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final CartProducts = snapshot.data?.docs ?? [];

          if (CartProducts.isEmpty) {
            return Center(
              child: Text('No Cart products yet.'),
            );
          }
          return ListView.builder(
            itemCount: CartProducts.length,
            itemBuilder: (context, index) {
              final product = CartProducts[index].data() as Map<dynamic, dynamic>?;

              if (product == null) {
                return ListTile(
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
                          //'https://www.unigreet.com/wp-content/uploads/2022/11/100-very-special-good-morning-images-quotes-photos.jpg'
                          leading: Image.network(
                            (product['image_url'] is List && product['image_url'].isNotEmpty)
                              ? product['image_url'][0].toString()
                              : 'No Image',
                          ),
                          title: Text(product['title'] ?? 'No Title'),
                          subtitle: Text(product['description'] ?? 'No Description'),
                          trailing: Text('\$ ${product['price'] ?? 'N/A'}'),
                          onTap: () {
                            print('tile press');
                          },
                        ),
                        IconButton(onPressed: (){
                          _removeFromFavorites(CartProducts[index].reference);
                        }, icon: Icon(Icons.delete_outline),
                        )
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
  void _removeFromFavorites(DocumentReference documentReference) {
    documentReference.delete().then((value) {
      Fluttertoast.showToast(msg: 'Product removed from Cart');
    }).catchError((error) {
      print('Failed to remove product: $error');
    });
  }
}