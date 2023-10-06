import 'package:flutter/material.dart';
import 'package:shop/Drawer/MyAcc.dart';
import 'package:shop/pages/ContSho.dart';

// ignore: camel_case_types
class no_use_page extends StatelessWidget {

  const no_use_page({super.key,});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 50,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 135,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContShop()),
                        );
                      },
                      child: const Text(
                        'Continue Shopping',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                      ),
                    ), //
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 40,
                    width: 190,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20)),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyAcc()),
                        );
                      },
                      child: const Text(
                        'Check Out',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                      ), //
                    ),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
