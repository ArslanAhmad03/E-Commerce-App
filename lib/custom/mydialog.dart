import 'package:flutter/material.dart';

class MYdialog extends StatelessWidget {
  const MYdialog({super.key});

  static const TextStyle _textStyle =
      TextStyle(color: Colors.black, fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 235, bottom: 235),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(left: 10, right: 10)),
          const Text(
            'Profile',
            style: _textStyle,
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            child: Column(
              children: [
                const Row(
                  children: [
                    Text('Name : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: TextField(
                        style: TextStyle(),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                const Row(
                  children: [
                    Text('Email : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: TextField(),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 100),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK')),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
