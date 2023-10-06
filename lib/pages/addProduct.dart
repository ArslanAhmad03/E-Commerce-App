import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class addProduct extends StatefulWidget {
  const addProduct({super.key});

  @override
  State<addProduct> createState() => _addProductState();
}

class _addProductState extends State<addProduct> {
  bool _tittleValidate = false;
  bool _descriptionValidate = false;
  bool _priceValidate = false;

  final emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _desController = TextEditingController();
  final _priceController = TextEditingController();
  String imageUrl = " ";

  void dispose() {
    emailController.dispose();
    _titleController.dispose();
    _desController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  List<File> selectedImages = [];

  Future<void> _pickImages() async {
    final images = await ImagePicker().pickMultiImage();
    setState(() {
      selectedImages = images.map((image) => File(image.path)).toList();
    });
  }

  Future<void> _uploadInfo() async {
    List<String> imageUrlList = [];
    for (var image in selectedImages) {
      String fileName = File(image.path).path.split('/').last;
      final ref = FirebaseStorage.instance.ref().child('images/$fileName');
      await ref.putFile(image);

      final String downlaodURL = await ref.getDownloadURL();
      imageUrlList.add(downlaodURL);
    }
    await FirebaseFirestore.instance.collection('Images').add({
      'title': _titleController.text,
      'description': _desController.text,
      'price': _priceController.text,
      'urls': imageUrlList,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 60,
                                          child: IconButton(
                                            onPressed: () {
                                              _pickImages();
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
                                  ])),
                        );
                      });
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Product Name'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 70,
                    width: 320,
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'enter product tittle....',
                        labelText: 'tittle',
                        errorText: _tittleValidate ? 'enter title' : null,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Product description'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 70,
                    width: 320,
                    child: TextField(
                      controller: _desController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'enter product description....',
                        labelText: 'description',
                        errorText:
                            _descriptionValidate ? 'enter description' : null,
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text('Product price'),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 70,
                    width: 320,
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'enter product price....',
                        labelText: 'price',
                        errorText: _priceValidate ? 'enter price' : null,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_titleController.text.isEmpty) {
                          setState(() {
                            _tittleValidate = true;
                          });
                        } else if (_desController.text.isEmpty) {
                          setState(() {
                            _descriptionValidate = true;
                          });
                        } else if (_priceController.text.isEmpty) {
                          setState(() {
                            _priceValidate = true;
                          });
                        } else {
                          _uploadInfo();
                          Fluttertoast.showToast(
                              msg: 'Data Added', gravity: ToastGravity.CENTER);
                        }
                      },
                      child: Text(
                        'Add Product',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.purple,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              width: double.infinity,
              color: Colors.white,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: selectedImages.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    selectedImages[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

