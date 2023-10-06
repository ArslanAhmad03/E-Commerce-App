
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop/custom/notificationService.dart';
import 'package:shop/splashscreen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationManager notificationManager = LocalNotificationManager();
  await notificationManager.initialize();

  await Firebase.initializeApp();

  FirebaseFirestore.instance.collection('messages').snapshots().listen(
        (querySnapshot) {
      for (var change in querySnapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          String sender = change.doc['sender'];
          String message = change.doc['text'];
          notificationManager.showNotification(sender, message);
          print('/////////////.............////////////');
          print(sender);
          print(message);
          print('/////////////.............////////////');
        }
      }
    },
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const splashscreen(),
    );
  }
}
