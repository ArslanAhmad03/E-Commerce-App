import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/Dummy/detailPage.dart';

class ImageCardPage extends StatefulWidget {
  const ImageCardPage({
    super.key,
  });

  @override
  State<ImageCardPage> createState() => _ImageCardPageState();
}

class _ImageCardPageState extends State<ImageCardPage> {
  static const TextStyle _textStyle = TextStyle(
      fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold);

  List<Map<String, dynamic>>_product = [];

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text('Catagories'),
        ),
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
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: _product.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageDetailPage(product: _product)));
                    print('press card page');
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            _product[index]['urls']
                                [0], // Assuming urls is a list of image URLs.
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
        ));
  }
}
/*
  Future<void> _getUserData() async {
    try {
      await FirebaseFirestore.instance.collection('user').doc().get().then(
        (DocumentSnapshot userDoc) {
          if (userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            setState(() {
              _titleController.text = userData['title'] ?? [];
              imageUrl = List.from(userData['url'] ?? []);
              imageUrlController.text = imageUrl.isNotEmpty ? imageUrl[0] : '';
            });
            print(imageUrlController.text);
            print(_titleController);
            debugPrint('image url : $imageUrl');
            print('url : $imageUrl');
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'path.isNotEmpty') {
        Fluttertoast.showToast(
            msg: 'a document path must be a non-empty string',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }

     CarouselSlider.builder(
                        itemCount: snapShot.data.length,
                        options: CarouselOptions(
                          initialPage: 0,
                          autoPlay: true,
                        ),
                        itemBuilder: (BuildContext context, int index,
                            int pageViewIndex) {
                          DocumentSnapshot images =
                          snapShot.data[index];

                          return Image.network(
                            images['url'],
                            fit: BoxFit.cover,
                          );
                        }
                    ),
  }*/
