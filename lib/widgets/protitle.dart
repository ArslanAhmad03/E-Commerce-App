/*import 'package:flutter/material.dart';
import 'package:shop/pages/DetailPage.dart';

class Protitle extends StatelessWidget {
  const Protitle({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Set the desired number of columns
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
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(item.title),
                  SizedBox(height: 8),
                  Text(item.description),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Rest of the code remains the same

class Item {
  String title;
  String description;
  String price;
  // Add any other properties you need

  Item({required this.title, required this.description, required this.price});
}

List<Item> itemList = [
  Item(title: 'Item 1', description: 'Description for Item 1', price: '100'),
  Item(title: 'Item 2', description: 'Description for Item 2', price: '100'),
  Item(title: 'Item 3', description: 'Description for Item 2', price: '100'),
  // Add more items as needed
];
*/