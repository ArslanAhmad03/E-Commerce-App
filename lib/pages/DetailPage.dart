import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shop/custom/const.dart';
import 'package:shop/pages/CartPage.dart';
import 'package:shop/pages/ContSho.dart';
import 'package:shop/widgets/ItemAppBar.dart';

class DetailPage extends StatefulWidget {
  final item;

  const DetailPage({super.key, required this.item});

  static const TextStyle _textStyle = TextStyle(fontSize: 20);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool checks = true;

  int _colorIndex = 0;
  final List<Color> _colors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
  ];

  int _counter = 1;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const ItemAppBar(),
              widget.item.image, ////product image
              Row(
                children: [
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  Text(
                    widget.item.title, ////product name
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
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
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  widget.item.description,
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
                              padding: EdgeInsets.symmetric(horizontal: 5)),
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
                          widget.item.price,
                          style: const TextStyle(
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ContShop()));
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
                        const SizedBox(
                          child: Text('PhonNo:'),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const SizedBox(
                          height: 16,
                          width: 160,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: '0300 000 0000',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.phone,
                            maxLines: 1,
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
                                                    style:
                                                        DetailPage._textStyle,
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
                                                    style:
                                                        DetailPage._textStyle,
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
                                                    style:
                                                        DetailPage._textStyle,
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
          )),
    );
  }
}

item() async {
  // TODO: implement item
  itemList;
  //throw UnimplementedError();
}

/*_counter != 0
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                _decreamentCounter();
                              });
                            },
                            icon: Icon(Icons.remove))
                        : Container(),
                    Text(_counter.toString()),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _increamentCounter();
                          });
                        },
                        icon: Icon(Icons.add_circle_outline))*/
