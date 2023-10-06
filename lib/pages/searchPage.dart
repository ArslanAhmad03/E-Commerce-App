import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductSearch extends StatefulWidget {
  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final CollectionReference productsRef =
  FirebaseFirestore.instance.collection('Images');

  List<Map<String, dynamic>> _product = [];

  void filterProducts(String query) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await productsRef
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: query + 'z')
        .get() as QuerySnapshot<Map<String, dynamic>>;

    setState(() {
      _product = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            IconButton(onPressed: (){
              Navigator.pop(context);
            },
              icon: Icon(Icons.arrow_back),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: TextField(
                  onChanged: (value) => filterProducts(value),
                  decoration: InputDecoration(
                    labelText: 'Search products',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black54)
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: _product.length,
                itemBuilder: (context, index) {
                  var urls = _product[index]['urls'] as List<dynamic>;
                  var imageUrl = urls.isNotEmpty ? urls.first.toString() : 'No Image';
                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(imageUrl,fit: BoxFit.contain,),
                        ),
                        ListTile(
                          title: Text(_product[index]['title']),
                          subtitle: Text(_product[index]['description'].toString()),
                          trailing: Text('\$ ${_product[index]['price']}'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
