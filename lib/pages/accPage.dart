// ignore: file_names
// ignore: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:shop/pages/settingPage.dart';
import 'package:path/path.dart' as path;

// ignore: camel_case_types
class accPage extends StatefulWidget {
  const accPage({super.key});

  @override
  State<accPage> createState() => _accPageState();
}

class _accPageState extends State<accPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final imageUrlController = TextEditingController();

  XFile? image;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _getImage(ImageSource source) async {
    final photo = await _picker.pickImage(source: source);
    if (photo != null) {
      setState(() {
        image = photo;
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    final file = File(image!.path);
    final filename = path.basename(file.path);
    final ref = _storage.ref().child(filename);
    final uploadTask = ref.putFile(file);

    await uploadTask;
    final downurl = await ref.getDownloadURL().then((value) {
      setState(() {
        imageUrlController.text = value;
      });
    });

    ///test
    print('imageUrl: $imageUrlController');
  }

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
              phoneController.text = userData['phone'];
              emailController.text = userData['email'];
              imageUrlController.text = userData['imageUrl'];
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

  Future<void> _updateData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'name': nameController.text,
      'phone': phoneController.text,
      'email': emailController.text,
      'imageUrl': imageUrlController.text,
    });
  }

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('Profile'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const settingPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipOval(
                      ///
                      child: OptimizedCacheImage(
                        imageUrl: imageUrlController.text,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),

                      ///
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                ),
                                child: Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: IconButton(
                                                  onPressed: () {
                                                    _getImage(
                                                        ImageSource.gallery);
                                                  },
                                                  icon: Image.asset(
                                                    'assets/gallery.png',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Gallery',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: 60,
                                                width: 60,
                                                child: IconButton(
                                                  onPressed: () {
                                                    _getImage(
                                                        ImageSource.camera);
                                                  },
                                                  icon: Image.asset(
                                                    'assets/camera.png',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Camera',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ],
                                          ),
                                        ])),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.camera_alt,
                      ),
                      splashColor: Colors.purple.shade200,
                      splashRadius: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                nameController.text,
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 50),
              const Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.purple,
                thickness: 2,
                height: 5,
              ),
              const SizedBox(height: 10),
              //// ---
              SizedBox(
                height: 70,
                width: 320,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'name',
                    hintText: 'Enter Name....',
                    prefixIcon: const Icon(Icons.person, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 70,
                width: 320,
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'phone',
                    hintText: 'Phone....',
                    prefixIcon: const Icon(Icons.phone, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 70,
                width: 320,
                child: TextField(
                  controller: emailController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'email',
                    hintText: 'Email....',
                    prefixIcon: const Icon(Icons.email, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 320,
                child: ElevatedButton(
                  onPressed: () {
                    _updateData();
                    Fluttertoast.showToast(
                      msg: 'Update your profiel',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Update profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
