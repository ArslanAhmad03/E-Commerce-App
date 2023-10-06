import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/main_screen.dart';
import 'package:shop/pages/sign_inPage.dart';
import 'package:path/path.dart' as path;

class sign_upPage extends StatefulWidget {
  const sign_upPage({super.key});

  @override
  State<sign_upPage> createState() => _sign_upPageState();
}

class _sign_upPageState extends State<sign_upPage> {
  bool hidepass = true;
  bool hidepas = true;
  bool markbox = false;

  bool _namevalidate = false;
  bool _phonevalidate = false;
  bool _emailvalidate = false;
  bool _passvalidate = false;
  bool _confirmvalidate = false;

  bool nameset = false;
  bool phoneset = false;
  bool emailset = false;
  bool passset = false;
  bool conpassset = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmpassController = TextEditingController(); // solution //
  String imageUrl = " ";

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmpassController.dispose();
    super.dispose();
  }

  void _signUp() async {
    try{
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(
            msg: 'The password provided is too weak.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
      }
    } catch (e) {
      print(e);
    }
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(emailController.text)
          .set(
        {
          'name': nameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'password': passController.text,
          'imageUrl': imageUrl,
        },
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } catch (e) {
      print(e.toString());
    }
  }

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
    imageUrl = '';
    final file = File(image!.path);
    final filename = path.basename(file.path);
    final ref = _storage.ref().child(filename);
    final uploadTask = ref.putFile(file);

    await uploadTask;
    final downurl = await ref.getDownloadURL().then((value) {
      setState(() {
        imageUrl = value;
      });
    });
    ///test
    print('imageUrl: $imageUrl');
  }

  @override
  Widget build(BuildContext context) {
    final double circleRadius = 70.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: const Text("Create New Account"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: CircleAvatar(
                      radius: circleRadius,
                      child: image == null
                          ? Image.asset('assets/profile.png')
                          :ClipOval(
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                                width: circleRadius * 2,
                                height: circleRadius * 2,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,

                    ///icon button
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
                      splashRadius: 30,
                    ),
                  ),
                ],
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('   User Name'),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 70,
                        width: 320,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            errorText: _namevalidate ? 'enter name' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter User Name....',
                            labelText: 'name',
                            prefixIcon:
                                const Icon(Icons.person, color: Colors.purple),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text('   Phone'),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 70,
                        width: 320,
                        child: TextField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            errorText:
                                _phonevalidate ? 'enter phone number' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter Phone No....',
                            labelText: 'phone',
                            prefixIcon:
                                const Icon(Icons.phone, color: Colors.purple),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                        ),
                      ),
                      const Text('   Email'),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 70,
                        width: 320,
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            errorText: _emailvalidate ? 'enter email' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter email....',
                            labelText: 'email',
                            prefixIcon: Icon(Icons.email, color: Colors.purple),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            const Text('   Password'),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 70,
                              width: 320,
                              child: TextField(
                                controller: passController,
                                obscureText: hidepass,
                                obscuringCharacter: '*',
                                maxLength: 10,
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
                                    errorText:
                                        _passvalidate ? 'enter password' : null,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'password',
                                    hintText: 'Enter Password....',
                                    prefixIcon: const Icon(Icons.lock,
                                        color: Colors.purple),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            hidepass = !hidepass;
                                          });
                                        },
                                        icon: hidepass
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility))),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('   Confirm Password'),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    height: 70,
                                    width: 320,
                                    child: TextField(
                                      controller: confirmpassController,
                                      keyboardType: TextInputType.text,
                                      obscureText: hidepas,
                                      obscuringCharacter: '*',
                                      maxLength: 10,
                                      style: const TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                          errorText: _confirmvalidate
                                              ? 'enter confirm password'
                                              : null,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          labelText: 'password',
                                          hintText: 'Enter Password....',
                                          prefixIcon: const Icon(Icons.lock,
                                              color: Colors.purple),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  hidepas = !hidepas;
                                                });
                                              },
                                              icon: hidepas
                                                  ? const Icon(
                                                      Icons.visibility_off)
                                                  : const Icon(
                                                      Icons.visibility)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 20),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              markbox = !markbox;
                                            });
                                          },
                                          icon: markbox
                                              ? const Icon(Icons.check_box)
                                              : const Icon(Icons
                                                  .check_box_outline_blank),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                            "Accept the terms and conditions"),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 320,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (nameController.text.isEmpty) {
                                          setState(() {
                                            _namevalidate = true;
                                          });
                                        } else if (phoneController
                                            .text.isEmpty) {
                                          setState(() {
                                            _phonevalidate = true;
                                          });
                                        } else if (emailController
                                            .text.isEmpty) {
                                          setState(() {
                                            _emailvalidate = true;
                                          });
                                        } else if (passController
                                            .text.isEmpty) {
                                          setState(() {
                                            _passvalidate = true;
                                          });
                                        } else if (confirmpassController
                                            .text.isEmpty) {
                                          setState(() {
                                            _confirmvalidate = true;
                                          });
                                        } else if (!markbox) {
                                          Fluttertoast.showToast(
                                            msg:
                                                'Accept the terms & conditions',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        } else if (passController.text !=
                                            confirmpassController.text) {
                                          Fluttertoast.showToast(
                                            msg: 'password not same',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        } else if (image == null) {
                                          Fluttertoast.showToast(
                                            msg:
                                            'please select image',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                        } else {
                                          _signUp();
                                          Fluttertoast.showToast(
                                            msg: 'sign up successfuly!',
                                            gravity: ToastGravity.BOTTOM,
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyHomePage()),
                                          );
                                        }
                                      },
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purple,
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]))
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an Account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const sign_inPage()));
                      },
                      child: const Text('Sign in')),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

