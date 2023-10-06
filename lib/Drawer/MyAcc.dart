import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shop/Drawer/chatScreen.dart';
import 'package:shop/Dummy/itemCount.dart';
import 'package:shop/MyAcc/myOrder.dart';
import 'package:shop/MyAcc/myWishList.dart';

class MyAcc extends StatefulWidget {
  const MyAcc({super.key});

  @override
  State<MyAcc> createState() => _MyAccState();
}

class _MyAccState extends State<MyAcc> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final imageUrlController = TextEditingController();

  bool _isInitialized = false;

  Future<void> _getUserData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .get()
          .then(
            (DocumentSnapshot userDoc) {
          if (userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            setState(() {
              nameController.text = userData['name'];
              emailController.text = userData['email'];
              imageUrlController.text = userData['imageUrl'];
            });
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'unknown') {
        Fluttertoast.showToast(
            msg: 'data not found',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    }
  }
  Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance.collection('Cart').snapshots();
  int cartCount = 0;
  Stream<QuerySnapshot> _favStream = FirebaseFirestore.instance.collection('favorites').snapshots();
  int favCount = 0;
  Stream<QuerySnapshot> _orderStream = FirebaseFirestore.instance.collection('Orders').snapshots();
  int orderCount = 0;

  @override
  void initState() {
    super.initState();
    _cartStream.listen((snapshot) {
      final CartProducts = snapshot.docs;
      setState(() {
        cartCount = CartProducts.length;
      });
    });
    if (!_isInitialized) {
      _getUserData();
      _isInitialized = true;
    }
    _favStream.listen((snapshot) {
      final favProducts = snapshot.docs;
      setState(() {
        favCount = favProducts.length;
      });
    });
    _orderStream.listen((snapshot) {
      final orderProducts = snapshot.docs;
      setState(() {
        orderCount = orderProducts.length;
      });
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 450,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: const Icon(Icons.arrow_back,color: Colors.white,),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                   Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: ClipOval(
                      child: OptimizedCacheImage(
                        height: 80,
                        width: 80,
                        imageUrl: imageUrlController.text,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(nameController.text),
                          SizedBox(
                            height: 5,
                          ),
                          Text(emailController.text)
                        ]),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // here count the product
                        Text(cartCount.toString(),),
                        Text('your cart'),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(favCount.toString()),
                        Text('your WishList'),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(orderCount.toString()),
                        Text('your Orders'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 14),
                height: 200,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: const Icon(
                        Icons.list,
                        size: 30,
                      ),
                      title: const Text(
                        'My Orders',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const myOrder()));
                      },
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: const Icon(
                        Icons.list,
                        size: 30,
                      ),
                      title: const Text(
                        'My WishLists',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const myWishList()));
                      },
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: const Icon(
                        Icons.message_outlined,
                        size: 30,
                      ),
                      title: const Text(
                        'Messages',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => chatScreen(name: nameController.text,)));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
