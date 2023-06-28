// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItemSample extends StatefulWidget {
  const CartItemSample({super.key});

  static const TextStyle _textStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.purple);

  @override
  State<CartItemSample> createState() => _CartItemSampleState();
}

class _CartItemSampleState extends State<CartItemSample> {
  bool select = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //for (int i = 0; i < 6; i++)
          Container(
            height: 110,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Radio(
                    value: '',
                    groupValue: '',
                    activeColor: Colors.purple,
                    onChanged: (index) {}),
                Container(
                  height: 70,
                  width: 70,
                  margin: const EdgeInsets.all(10),
                  child: Image.asset('assets/S6.png'),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Product Title',
                          style: CartItemSample._textStyle,
                        ),
                        Text(
                          '\$55',
                          style: CartItemSample._textStyle,
                        ),
                      ]),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.delete,
                          size: 20,
                          color: Colors.red,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.3))
                                  ]),
                              child: const Icon(
                                CupertinoIcons.add,
                                size: 15,
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: const Text(
                                '01',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(.3))
                                  ]),
                              child: const Icon(
                                CupertinoIcons.minus,
                                size: 15,
                              ),
                            ),
                          ],
                        )
                      ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
