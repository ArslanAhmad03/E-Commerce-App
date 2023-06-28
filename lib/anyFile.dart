import 'package:flutter/material.dart';

class anyFile extends StatefulWidget {
  const anyFile({super.key});

  @override
  State<anyFile> createState() => _anyFileState();
}

class _anyFileState extends State<anyFile> {
  final allChecked = CheckBoxModel(title: 'All Checked');
  final checkBoxList = [
    CheckBoxModel(title: 'Check1'),
    CheckBoxModel(title: 'Check2'),
    CheckBoxModel(title: 'Check3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text('Select Payment Method'),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/paypal.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  child: Checkbox(
                    value: allChecked.value,
                    onChanged: (value) {
                      allChecked.value = !allChecked.value;
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckBoxModel {
  String title;
  bool value;

  CheckBoxModel({required this.title, this.value = false});
}
