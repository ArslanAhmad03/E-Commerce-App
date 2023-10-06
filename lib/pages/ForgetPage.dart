import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPage extends StatefulWidget {
  const ForgetPage({super.key});

  @override
  State<ForgetPage> createState() => _ForgetPageState();
}

class _ForgetPageState extends State<ForgetPage> {

  bool _emailvaliid = false;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Text("Reset Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
              ),

              const Text('   Email'),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 50,
                width: 320,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    errorText: _emailvaliid ? 'email required': null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'email',
                    hintText: 'Enter email....',
                    prefixIcon: const Icon(Icons.email, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 320,
                child: ElevatedButton(
                  onPressed: () async {
                    ///
                    try {
                      FirebaseAuth.instance.sendPasswordResetEmail(
                        email: emailController.text,
                      );
                      if (emailController.text.isEmpty) {
                        Fluttertoast.showToast(msg: 'email required',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      }
                      else {
                        Fluttertoast.showToast(msg: 'your request sent',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                      }
                    }on FirebaseAuthException catch (e){
                      print(e.code);
                      if (e.code == 'user-not-found') {
                        Fluttertoast.showToast(
                            msg: 'Enter your registered email id',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM);
                        //print('The account does not exist');
                      }
                      setState(() {
                        _emailvaliid = false;
                      });
                    };
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  child: const Text(
                    'Forget Password',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
