import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ratingDialog extends StatelessWidget {
  const ratingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
      title: const Text(
        'Ratings',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      submitButtonText: 'submit',
      initialRating: 1.0,
      starColor: Colors.yellow,
      starSize: 30,
      message: const Text(
        'rating dialog',
        textAlign: TextAlign.center,
      ),
      enableComment: true,
      commentHint: 'tell us about your comment',
      image: const FlutterLogo(
        size: 60,
      ),
      onSubmitted: (response) {},
    );
  }
}
