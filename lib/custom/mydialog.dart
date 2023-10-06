import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MYdialog extends StatefulWidget {
  const MYdialog({super.key});

  @override
  State<MYdialog> createState() => _MYdialogState();
}

class _MYdialogState extends State<MYdialog> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 235, bottom: 235),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Material(
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Name : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: TextField(
                        controller: nameController,
                        readOnly: true,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text('Email : ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 30,
                      width: 200,
                      child: TextField(
                        controller: emailController,
                        readOnly: true,
                      ),
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
