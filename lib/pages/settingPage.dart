import 'package:flutter/material.dart';

import 'package:shop/custom/mydialog.dart';
import 'package:shop/custom/rating.dart';
import 'package:shop/pages/sign_inPage.dart';

class settingPage extends StatelessWidget {
  //const settingPage({super.key});

  static const TextStyle _textStyle =
      TextStyle(color: Colors.black, fontSize: 20);

  const settingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15)),
              child: ListTile(
                leading: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('assets/Icon/profile.png'),
                ),
                title: const Text(
                  'Profile',
                  style: _textStyle,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const MYdialog();
                    },
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('assets/Icon/checklist.png'),
                ),
                title: const Text(
                  'Rate list',
                  style: _textStyle,
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('assets/Icon/communicate.png'),
                ),
                title: const Text(
                  'Contact us',
                  style: _textStyle,
                ),
                onTap: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('assets/Icon/star.png'),
                ),
                title: const Text(
                  'Rating',
                  style: _textStyle,
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const ratingDialog());
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Container(
              height: 50,
              padding: const EdgeInsets.only(
                left: 10,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage('assets/Icon/shutdown.png'),
                ),
                title: const Text(
                  'Logout',
                  style: _textStyle,
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("LogOut"),
                        content: const Text("Sure you want to logout"),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
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
            ),
          ),
        ],
      ),
    );
  }
}
