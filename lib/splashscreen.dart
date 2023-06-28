import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop/pages/sign_InUpPage.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  //bool isloading = true;
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => sign_InUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple,
        body: Center(
          child: Image.asset(
            'assets/Sp3.png',
            fit: BoxFit.cover,
          ),
        ));
  }
}
/*
Scaffold(
        body: isloading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Image.asset('assets/signin.jpg'),
              ));*/