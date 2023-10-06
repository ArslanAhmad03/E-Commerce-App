import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/custom/const.dart';
import 'package:shop/pages/ContSho.dart';
import 'package:shop/widgets/ItemAppBar.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool checks = true;
  int _colorIndex = 0;
  int _counter = 1;

  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  void _increamentCounter() {
    setState(() {
      if (_counter < 6) {
        _counter++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: const EdgeInsets.only(left: 120, right: 120, bottom: 50),
            duration: const Duration(milliseconds: 500),
            backgroundColor: Colors.grey.shade300,
            behavior: SnackBarBehavior.floating,
            content: const Text(
              "order limit is full",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            )));
      }
    });
  }

  void _decreamentCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            margin: const EdgeInsets.only(left: 120, right: 120, bottom: 50),
            duration: const Duration(milliseconds: 500),
            backgroundColor: Colors.grey.shade300,
            behavior: SnackBarBehavior.floating,
            content: const Text(
              "value cant't be negative",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
            )));
      }
    });
  }

  final phoneController = TextEditingController();

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
              phoneController.text = userData['phone'];
            });
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
  }

  void cartto() async {
    try {
      await FirebaseFirestore.instance.collection('Cart').add(
          {
            'title': "${(widget.product['title']) + '( *$_counter)'.toString()}",
            'description': widget.product['description'],
            'price': '${double.parse(widget.product['price']) * _counter}',
            'image_url': widget.product['urls'],
          }
      );
      Fluttertoast.showToast(msg: 'Item add to cart');
    } catch (e) {
      print(e.toString());
    }
  }

  Future <void> OrderCart ()async{
    try{
        await FirebaseFirestore.instance.collection('Orders').add({
          'title': widget.product['title'],
          'description': widget.product['description'],
          'price': '${double.parse(widget.product['price']) * _counter}',
          'imageUrls': widget.product['urls'],
        });

      await FirebaseFirestore.instance.collection('Cart').get().then((value) {
        for(DocumentSnapshot doc in value.docs){
          doc.reference.delete();
        }
      });
      Fluttertoast.showToast(msg: 'Order placed successfully\nadd detail info');
    }catch (e){
      print(e.toString());
    }
  }

  List imageList = [
    {"image_path": 'assets/sliderImages/sale.jpg'},
    {"image_path": 'assets/sliderImages/shoe.jpg'},
    {"image_path": 'assets/sliderImages/watch.jpg'},
    {"image_path": 'assets/sliderImages/freedel.jpeg'},
    {"image_path": 'assets/sliderImages/purse.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              ItemAppBar(
                title: widget.product['title'],
                description: widget.product['description'],
                price: widget.product['price'],
                urls: widget.product['urls'],
              ),
              Container(
                height: 200,
                width: double.infinity,
                child: CarouselSlider(
                  items: (widget.product['urls'] as List<dynamic>).map((url) {
                    return Image.network(url as String, fit: BoxFit.cover);
                  }).toList(),
                  options: CarouselOptions(
                    viewportFraction: 0.9,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    widget.product['title'],
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.product['description'],
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 15, color: Colors.purple),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Size: ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 27,
                    ),
                    Row(children: [
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6)),
                      for (int i = 5; i < 10; i++)
                        Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.5),
                                  spreadRadius: 3,
                                  blurRadius: 10,
                                )
                              ]),
                          child: Text(
                            i.toString(),
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                        ),
                    ]),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    const Text(
                      'Quantity:',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                          ),
                          InkWell(
                            splashColor: Colors.white,
                            radius: 10,
                            hoverColor: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              _decreamentCounter();
                            },
                            child: const Icon(CupertinoIcons.minus),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              '$_counter',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.purple,
                            radius: 8,
                            hoverColor: Colors.purple,
                            borderRadius: BorderRadius.circular(25),
                            onTap: () {
                              _increamentCounter();
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('6 available')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Colors: ',
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _colorIndex = (_colorIndex + 1) % _colors.length;
                            });
                          },
                          child: Container(
                            height: 22,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _colors[_colorIndex],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 10),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          '${double.parse(widget.product['price']) * _counter}',
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () {
                            cartto();
                          },
                          icon: const Icon(Icons.shopping_cart_checkout),
                          label: const Text(
                            'Add to cart',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    bottomLeft: Radius.circular(20)),
                              ))),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            OrderCart();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ContShop()));
                          },
                          icon: const Icon(Icons.sell),
                          label: const Text(
                            'Buy',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                              ))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 10),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.5),
                          spreadRadius: 1,
                          blurRadius: 1,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('PhonNo:'),
                        const SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          height: 16,
                          width: 160,
                          child: TextField(
                            controller: phoneController,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: '0300 000 0000',
                            ),
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
                            onTap: () async {
                              final phoneNumber = phoneController.text;
                              Uri phoneno = Uri.parse('tel: $phoneNumber');
                              if (await launchUrl(phoneno)) {
                                print('print $phoneController');
                                debugPrint('debug $phoneController');
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Contact Not Found');
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),

                            ///
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                      ),
                                      child: ListView(
                                        children: [
                                          ListTile(
                                            leading: Icon(Icons.chat),
                                            title: Text('Message'),
                                            tileColor: Colors.grey,
                                            onTap: () async {
                                              await FlutterShare.share(
                                                title: 'name',
                                              );
                                              //Fluttertoast.showToast(msg: 'message not sent');
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text('Phone'),
                                            tileColor: Colors.grey,
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      body: Center(
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 10,
                                                                  right: 10),
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 25,
                                                                  right: 25,
                                                                  top: 270,
                                                                  bottom: 270),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            border:
                                                                Border.all(),
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                'Phnone Number',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                                width: 200,
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      phoneController,
                                                                  readOnly:
                                                                      true,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        '0300 000 0000',
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .phone),
                                                                  ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  final phoneNumber =
                                                                      phoneController
                                                                          .text;
                                                                  Uri phoneNo =
                                                                      Uri.parse(
                                                                          'tel: $phoneNumber');
                                                                  if (await canLaunchUrl(
                                                                      phoneNo)) {
                                                                    await launchUrl(
                                                                        phoneNo);
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                'Contact Not Found');
                                                                  }
                                                                },
                                                                child: Text(
                                                                    'Contact'),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  });
                                            },
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.share),
                                            title: Text('share'),
                                            tileColor: Colors.grey,
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            right: 25,
                                                            top: 270,
                                                            bottom: 270),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          'Share',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                      "assets/sharing.png",
                                                                    ),
                                                                    radius: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Container(
                                                                      width: 80,
                                                                      child: Text(
                                                                          'Nearby Share',
                                                                          style: TextStyle(
                                                                              fontSize: 8,
                                                                              color: Colors.black),
                                                                          textAlign: TextAlign.center)),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                      "assets/whatsapp.png",
                                                                    ),
                                                                    radius: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Container(
                                                                      width: 80,
                                                                      child: Text(
                                                                          'Whatsapp',
                                                                          style: TextStyle(
                                                                              fontSize: 8,
                                                                              color: Colors.black),
                                                                          textAlign: TextAlign.center)),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                      "assets/facebook.png",
                                                                    ),
                                                                    radius: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Container(
                                                                      width: 80,
                                                                      child: Text(
                                                                          'Facebook',
                                                                          style: TextStyle(
                                                                              fontSize: 8,
                                                                              color: Colors.black),
                                                                          textAlign: TextAlign.center)),
                                                                ],
                                                              ),
                                                              Column(
                                                                children: [
                                                                  CircleAvatar(
                                                                    child: Icon(
                                                                      Icons
                                                                          .bluetooth,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    radius: 20,
                                                                  ),
                                                                  SizedBox(
                                                                      height:
                                                                          5),
                                                                  Container(
                                                                      width: 80,
                                                                      child: Text(
                                                                          'Bluetooth',
                                                                          style: TextStyle(
                                                                              fontSize: 8,
                                                                              color: Colors.black),
                                                                          textAlign: TextAlign.center)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: const Text('Contact'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]),
          )),
    );
  }

  List imageLists = [
    {"id": 1, "image_path": 'assets/sliderImages/sale.jpg'},
    {"id": 2, "image_path": 'assets/sliderImages/shoe.jpg'},
    {"id": 3, "image_path": 'assets/sliderImages/watch.jpg'},
    {"id": 4, "image_path": 'assets/sliderImages/freedel.jpeg'},
    {"id": 4, "image_path": 'assets/sliderImages/purse.jpg'},
  ];
}

product() async {
  // TODO: implement item
  itemList;
  //throw UnimplementedError();
}
/*
Padding(
                padding: const EdgeInsets.only(left: 6),
                child: RatingBar.builder(
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    size: 15,
                    color: Colors.purple,
                  ),
                  onRatingUpdate: (index) {},
                  initialRating: 4,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20.0,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                ),
              ),
 */