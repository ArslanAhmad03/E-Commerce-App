import 'package:flutter/material.dart';
import 'package:shop/pages/sign_inPage.dart';
import 'package:shop/pages/sign_upPage.dart';

class sign_InUpPage extends StatelessWidget {
  const sign_InUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Hello There!',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
              'Automatic identity varification which enable you to\n                           verify your identity'),
          Image.asset('assets/signup.jpg'),
          SizedBox(height: 10,),
          SizedBox(
            height: 40,
            width: 320,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const sign_inPage()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: const Text(
                'Sign in',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const sign_upPage()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: const Text(
                'Sign Up',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          /*SizedBox(
            height: 50,
            width: 320,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.connect_without_contact_outlined,size: 20,color: Colors.black,),
                  SizedBox(width: 5,),
                  Text(
                    'Use Without an Account',
                    style: TextStyle(fontSize: 15,color: Colors.black),
                  ),
                ],
              )
            ),
          ),*/
        ]),
      ),
    ));
  }
}
