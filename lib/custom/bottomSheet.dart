/*
import 'dart:html';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';



/*
FirebaseStorage storage = FirebaseStorage.instance;

Future<void> _upload(String inputSource) async {
  final picker = ImagePicker();
  XFile? pickedImage;

  try {
    pickedImage = await picker.pickImage(
        source: inputSource == 'camera'
            ? ImageSource.camera
            : ImageSource.gallery,
        maxWidth: 1920);
*/

    try {
      final storage = FirebaseStorage.instance;
      final image = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      final reference = storage
          .ref()
          .child('images');
      await reference.putFile(image as File);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
  }
}*/
