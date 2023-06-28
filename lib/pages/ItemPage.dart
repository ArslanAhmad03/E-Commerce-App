/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop/pages/CartPage.dart';
import 'package:shop/widgets/ItemAppBar.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  static const TextStyle _textStyle = TextStyle(fontSize: 20);
  //const ItemPage({super.key});
  List<Color> clrs = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.black,
  ];
  static List<String> name = [
    'Sandals',
    'Watch',
    'Laptop Bag',
    'Travel Bag',
    'handbag',
    'Sandals Heels',
    'Watch',
  ];

  static List<String> des = [
    'New Design Heeled Shoes Comfortable For Women and Girl',
    'New Fashion Sports Leather Strap Wristwatches',
    'Laptop Sleeve Business Briefcase Compatible With Laptop',
    'Leather Travelling Bag Travel Bag Luggage bag',
    'new stylish handbag new design handbag girls',
    'New Design High Heeled Shoes Comfortable For Girls',
    'New Fashion Sports Leather Strap Wristwatches',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            const ItemAppBar(),
            Image.asset('assets/S1.png'),
            Container(
              child: Row(
                children: [
                  for (int i = 0; i <= name.length; i++)
                    Text(
                      '$i',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: RatingBar.builder(
                      itemBuilder: (context, index) => const Icon(
                        Icons.favorite,
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        //margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                spreadRadius: 3,
                                blurRadius: 8,
                                offset: const Offset(0, 3))
                          ],
                        ),
                        child: const Icon(CupertinoIcons.minus),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                          '01',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.5),
                                spreadRadius: 3,
                                blurRadius: 8,
                                offset: const Offset(0, 3))
                          ],
                        ),
                        child: const Icon(CupertinoIcons.plus),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18,
              ),
              child: Text(
                'Detail description of the product! A shoe is an item of footwear intended to protect and comfort the human foot.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15, color: Colors.purple),
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
                        width: 10,
                      ),
                      Row(children: [
                        for (int i = 0; i < 5; i++)
                          Container(
                            height: 25,
                            width: 25,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: clrs[i],
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                  )
                                ]),
                          ),
                      ]),
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
                      const Text(
                        '\$55',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartPage()));
                        },
                        icon: const Icon(Icons.shopping_cart_checkout),
                        label: const Text(
                          'Add to cart',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
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
                    children: [
                      const SizedBox(
                        child: Text('PhonNo:'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const SizedBox(
                        height: 18,
                        width: 150,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: '0300 000 0000',
                              border: InputBorder.none
                              //prefixIcon:
                              //  const Icon(Icons.phone, color: Colors.purple),
                              ),
                          keyboardType: TextInputType.number,
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
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                    ),
                                    child: const Padding(
                                        padding: EdgeInsets.all(15.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(children: [
                                                Icon(Icons.chat),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Message',
                                                  style: _textStyle,
                                                ),
                                              ]),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(children: [
                                                Icon(Icons.phone),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Phone',
                                                  style: _textStyle,
                                                ),
                                              ]),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Row(children: [
                                                Icon(Icons.send),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Shere',
                                                  style: _textStyle,
                                                ),
                                              ]),
                                            ])),
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
        )
        //bottomNavigationBar: const bottomNavBar(),
        );
  }
}

class Pro {
  final String title;
  final Image image;

  Pro({
    required this.title,
    required this.image,
  });
}

final List<Pro> list = [
  Pro(title: "title", image: Image.asset('assets/S0.png')),
  Pro(title: "title1", image: Image.asset('assets/S1.png')),
  Pro(title: "title2", image: Image.asset('assets/S2.png')),
  Pro(title: "title3", image: Image.asset('assets/S3.png')),
  Pro(title: "title4", image: Image.asset('assets/S4.png')),
  Pro(title: "title5", image: Image.asset('assets/S5.png')),
  Pro(title: "title6", image: Image.asset('assets/S6.png')),
];
*/