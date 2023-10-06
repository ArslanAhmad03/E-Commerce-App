// ignore: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/custom/const.dart';
import 'package:shop/pages/DetailPage.dart';

class ItemsWidget extends StatefulWidget {
  const ItemsWidget({super.key});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  static const TextStyle _textStyle = TextStyle(
      fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold);

  List<Map<String, dynamic>> _product = [];

  getProduct() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('Images').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _product.add({
          'title': qn.docs[i]['title'],
          'description': qn.docs[i]['description'],
          'price': qn.docs[i]['price'],
          "urls": qn.docs[i]["urls"],
        });
        print('............//${_product[i]['title']}');
        print('............//${_product[i]['description']}');
        print('............//${_product[i]['price']}');
        print('............//${_product[i]['urls']}');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: Scaffold(
            body: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Images').snapshots(),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return Center(child: Text('Loading...'));
                }
                var latestData = snap.data?.docs.last;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Set the number of columns here
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: _product.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(product: _product[index])));
                        print('press card page');
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                _product[index]['urls'][0],
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              title: Text(_product[index]['title']),
                              subtitle: Text(_product[index]['description']),
                              trailing: Text(
                                '${_product[index]['price']}',
                                style: _textStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
        ),
      ),
    );
  }
}

/*
\
/
\
/
\
*/

item() async {
  // TODO: implement item
  itemList;
  //throw UnimplementedError();
}

/*
class Item {
  String percent;
  Image image;
  String title;
  String description;
  String price;
  // Add any other propercentties you need

  Item({
    required this.percent,
    required this.image,
    required this.title,
    required this.description,
    required this.price,
  });
}

List<Item> itemList = [
  Item(
      percent: '35%',
      image: Image.asset('assets/S0.png'),
      title: 'Sandal',
      description: 'Heeled Shoes Comfortable For Women and Girl',
      price: 'RS: 3000'),
  Item(
      percent: '20%',
      image: Image.asset('assets/S1.png'),
      title: 'Watch',
      description: 'New Fashion Sports Leather Strap Wristwatches',
      price: 'RS: 800'),
  Item(
      percent: '30%',
      image: Image.asset('assets/S2.png'),
      title: 'Laptop Bag',
      description: 'Sleeve Business Briefcase Compatible With Laptop',
      price: 'RS: 2000'),
  Item(
      percent: '30%',
      image: Image.asset('assets/S3.png'),
      title: 'Travel Bag',
      description: 'Leather Travelling Bag Travel Bag Luggage bag',
      price: 'RS: 2000'),
  Item(
      percent: '15%',
      image: Image.asset('assets/S4.png'),
      title: 'HandBag',
      description: 'new stylish handbag new design handbag girls',
      price: 'RS: 1800'),
  Item(
      percent: '10%',
      image: Image.asset('assets/S5.png'),
      title: 'High Heel',
      description: 'Leather Travelling Bag Travel Bag Luggage bag',
      price: 'RS: 4000'),
  Item(
      percent: '40%',
      image: Image.asset('assets/S6.png'),
      title: 'Watch',
      description: 'New Fashion Sports Leather Strap Wristwatches',
      price: 'RS: 1000'),
  // Add more items as needed
];*/
