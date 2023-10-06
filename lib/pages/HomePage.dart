import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shop/Drawer/MyAcc.dart';
import 'package:shop/Drawer/chatScreen.dart';
import 'package:shop/Drawer/contact.dart';
import 'package:shop/Drawer/favPage.dart';
import 'package:shop/appbarnoti/wallet.dart';
import 'package:shop/noti.dart';
import 'package:shop/main_screen.dart';
import 'package:shop/pages/accPage.dart';
import 'package:shop/pages/searchPage.dart';
import 'package:shop/pages/sign_inPage.dart';
import 'package:shop/widgets/CategoriesWidget.dart';
import 'package:shop/widgets/ItemsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const TextStyle _textheading = TextStyle(
      fontSize: 25, color: Colors.purple, fontWeight: FontWeight.bold);

  static const TextStyle _textdrawer = TextStyle(
      fontSize: 15, color: Colors.purple, fontWeight: FontWeight.bold);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final imageUrlController = TextEditingController();

  String _name = '';
  String _email = '';
  String _imageUrl = '';

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
              _name = userData['name'];
              _email = userData['email'];
              _imageUrl = userData['imageUrl'];
            });
          }
        },
      );
    } on FirebaseException catch (e) {
      print(e.code);
      // Handle specific Firebase exceptions here
    } catch (e) {
      print(e.toString());
      // Handle other exceptions here
    }
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  List imageList = [
    {"id": 1, "image_path": 'assets/sliderImages/sale.jpg'},
    {"id": 2, "image_path": 'assets/sliderImages/shoe.jpg'},
    {"id": 3, "image_path": 'assets/sliderImages/watch.jpg'},
    {"id": 4, "image_path": 'assets/sliderImages/freedel.jpeg'},
    {"id": 4, "image_path": 'assets/sliderImages/purse.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.purple,
              title: Text('Click Shop'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductSearch()));
                  },
                  icon: const Icon(Icons.search),
                  tooltip: 'search',
                  splashRadius: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const notification()));
                  },
                  icon: const Icon(Icons.notifications),
                  tooltip: 'notification',
                  splashRadius: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const wallet()),);
                  },
                  icon: const Icon(Icons.account_balance_wallet_rounded),
                  tooltip: 'wallet',
                  splashRadius: 20,
                ),
              ],
            ),
            body: ListView(children: [
              SizedBox(
                height: 3,
              ),
              Container(
                  height: 140,
                  width: double.infinity,
                  child: CarouselSlider(
                    items: imageList
                        .map(
                          (item) => Image.asset(
                            item['image_path'],
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      viewportFraction: 0.9,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                    ),
                  ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text(
                  'Categories',
                  style: HomePage._textheading,
                ),
              ),
              const CategoriesWidget(),
              Container(
                alignment: Alignment.centerLeft,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: const Text('Best Selling', style: HomePage._textheading),
              ),
              const ItemsWidget(),
              SizedBox(height: 10,),
            ]),
            drawer: Drawer(
                backgroundColor: Colors.white,
                width: 230,
                child: FutureBuilder(
                    future: _getUserData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return ListView(
                          children: [
                            UserAccountsDrawerHeader(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                              ),
                              accountName: Text(_name),
                              accountEmail: Text(_email),
                              currentAccountPicture: ClipOval(
                                child: OptimizedCacheImage(
                                  imageUrl: _imageUrl,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.dashboard),
                              title: const Text(
                                'DashBoard',
                                style: HomePage._textdrawer,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MyHomePage()));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.chat),
                              title: const Text('My Chat',
                                  style: HomePage._textdrawer),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             chatScreen(name: _name,))
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.account_box_outlined),
                              title: const Text('My Account',
                                  style: HomePage._textdrawer),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyAcc()));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.contact_page),
                              title: const Text('My Contacts',
                                  style: HomePage._textdrawer),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const contact()),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.favorite_outline),
                              title: const Text('Favourite',
                                  style: HomePage._textdrawer),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const favPage()),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.update),
                              title: const Text('Update Data',
                                  style: HomePage._textdrawer),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const accPage()));
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout_outlined),
                              title: const Text('LogOut',
                                  style: HomePage._textdrawer),
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text("LogOut"),
                                      content:
                                          const Text("Sure you want to logout"),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text("Ok"),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const sign_inPage()));
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
                              child: const Text(
                                'my e-commerce app',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        );
                      }
                    }),),),
      ),
    );
  }
}
