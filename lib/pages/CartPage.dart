import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/Drawer/MyAcc.dart';
import 'package:shop/custom/notificationService.dart';
import 'package:shop/pages/ContSho.dart';
import 'package:shop/pages/DetailPage.dart';
import 'package:shop/widgets/cartAppbar.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Future<void> OrderCart() async {
    try {
      final cartSnapshot =
          await FirebaseFirestore.instance.collection('Cart').get();
      final cartProducts = cartSnapshot.docs.map((doc) => doc.data()).toList();
      for (int i = 0; i < cartProducts.length; i++) {
        final product = cartProducts[i];
        await FirebaseFirestore.instance.collection('Orders').add({
          'title': product['title'],
          'description': product['description'],
          'price': product['price'],
          'imageUrls': product['image_url'],
        });

      }

      await FirebaseFirestore.instance.collection('Cart').get().then((value) {
        for (DocumentSnapshot doc in value.docs) {
          doc.reference.delete();
        }
      });
      Fluttertoast.showToast(msg: 'Order placed successfully\nadd detail info');
    } catch (e) {
      print(e.toString());
    }
  }

  double _totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const CartAppBar(),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                height: 400,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Cart')
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
                        child: Text('No Cart products yet.'),
                      );
                    }

                    double totalPrice = 0.0;

                    for (final cartProduct in CartProducts) {
                      final product = cartProduct.data() as Map<dynamic, dynamic>?;
                      if (product != null && product['price'] != null) {
                        totalPrice += double.tryParse(product['price'].toString()) ?? 0.0;
                      }
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
                                      (product['image_url'] is List &&
                                              product['image_url'].isNotEmpty)
                                          ? product['image_url'][0].toString()
                                          : 'No Image',
                                    ),
                                    title:
                                        Text(product['title'] ?? 'No Title'),
                                    subtitle: Text(product['description'] ??
                                        'No Description'),
                                    trailing: Text(
                                        '\$ ${product['price'] ?? 'N/A'}'),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _removeFromFavorites(
                                          CartProducts[index].reference);
                                    },
                                    icon: const Icon(Icons.delete_outline),
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
              ),

            ]),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 180,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Column(children: [
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Cart')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final cartProducts = snapshot.data?.docs ?? [];
                  double totalPrice = 0.0;

                  for (var product in cartProducts) {
                    final productData = product.data() as Map<dynamic, dynamic>?;
                    if (productData != null && productData['price'] != null) {
                      totalPrice += double.parse(productData['price'].toString());
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('SubTotal :'),
                            Spacer(),
                            Text('RS/= ${totalPrice.toStringAsFixed(2)}'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('Shipping :'),
                            Spacer(),
                            Text('....  '),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text('Total :'),
                            Spacer(),
                            Text('RS/= ${totalPrice.toStringAsFixed(2)}'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              Row(
                children: [
                  IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Fluttertoast.showToast(msg: 'No add coupon yet');
                    },
                    icon: const Icon(
                      Icons.add_circle_rounded,
                      color: Colors.purple,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(
                      'Add Coupon Code',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 135,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        OrderCart();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ContShop(),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(color: Colors.white),
                      ),
                    ), //
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 190,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyAcc()),
                        );
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: const Text(
                        'Check Out',
                        style: TextStyle(color: Colors.white),
                      ), //
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
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
