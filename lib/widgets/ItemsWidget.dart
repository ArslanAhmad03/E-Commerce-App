// ignore: file_names

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: GridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children: List.generate(itemList.length, (index) {
            final item = itemList[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(item: item),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 2, right: 2),
                child: Card(
                  elevation: 5,
                  color: Colors.grey.shade100,
                  borderOnForeground: true,
                  shadowColor: Colors.purple,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 3, top: 3, right: 130),
                          decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.purple)),
                          child: Text(
                            item.percent,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        //
                        SizedBox(height: 60, child: item.image),
                        //
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: _textStyle,
                                ),
                                Text(
                                  item.description,
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.purple),
                                ),
                                Text(
                                  item.price,
                                  style: _textStyle,
                                ),
                              ]),
                        ),
                      ]),
                ),
              ),
            );
          }),
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
