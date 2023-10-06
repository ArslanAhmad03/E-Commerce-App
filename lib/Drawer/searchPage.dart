import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class searchPage extends StatefulWidget {
  @override
  _searchPageState createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  final CollectionReference chatRef =
  FirebaseFirestore.instance.collection('Groups');

  List<Map<String, dynamic>> chatGroup = [];

  void filterProducts(String query) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await chatRef
        .where('Groups', isGreaterThanOrEqualTo: query)
        .where('Groups', isLessThan: query + 'z')
        .get() as QuerySnapshot<Map<String, dynamic>>;

    setState(() {
      chatGroup = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            IconButton(
              onPressed: () {
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
                    labelText: 'Search group',
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black54)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chatGroup.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chatGroup[index]['Groups']),
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
