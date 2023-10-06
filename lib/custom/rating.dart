import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ratingDialog extends StatefulWidget {
  const ratingDialog({super.key});

  @override
  State<ratingDialog> createState() => _ratingDialogState();
}

class _ratingDialogState extends State<ratingDialog> {
  final emailController = TextEditingController();

  void _signUp(double rating, String comment) async {
    try {
      await FirebaseFirestore.instance
          .collection('Rating')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .set({
        'Rating': rating,
        'Comment' : comment,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'What do you think about Our App?',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      submitButtonText: 'submit',
      initialRating: 3.0,
      starColor: Colors.yellow,
      starSize: 30,
      message: const Text(
        'Please leave a rating',
        textAlign: TextAlign.center,
      ),
      enableComment: true,
      commentHint: 'tell us about your comment',
      image: Image.asset('assets/Sp2.png',height: 50,width: 50,),
      onSubmitted: (response) {
        double rating = response.rating;
        String comment = response.comment ?? '';
        _signUp(rating, comment);
        Fluttertoast.showToast(msg: 'Thanks for rating!');
      },
    );
  }
}
