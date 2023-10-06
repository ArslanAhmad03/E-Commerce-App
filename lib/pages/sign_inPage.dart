import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop/main_screen.dart';
import 'package:shop/pages/ForgetPage.dart';
import 'package:shop/pages/sign_upPage.dart';

class sign_inPage extends StatefulWidget {
  const sign_inPage({super.key});

  @override
  State<sign_inPage> createState() => _sign_inPageState();
}

class _sign_inPageState extends State<sign_inPage> {
  bool hidepassword = true;
  bool _emailvalidate = false;
  bool _passvalidate = false;

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.asset('assets/city.gif'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Sign In',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
            const Text('Welcome back! Login with your credentials'),
            const SizedBox(
              height: 20,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('   Email'),
              SizedBox(
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
                    labelText: 'Email',
                    hintText: 'Enter email....',
                    prefixIcon: const Icon(Icons.email, color: Colors.purple),
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
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 70,
                        width: 320,
                        child: TextField(
                          controller: passController,
                          keyboardType: TextInputType.text,
                          obscureText: hidepassword,
                          obscuringCharacter: '*',
                          maxLength: 10,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            errorText: _passvalidate ? 'enter password' : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: 'Enter Password....',
                            labelText: 'password',
                            prefixIcon:
                                const Icon(Icons.lock, color: Colors.purple),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidepassword = !hidepassword;
                                });
                              },
                              icon: hidepassword
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 200),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgetPage()));
                          },
                          child: Text('Forget Password'),
                        ),
                      )
                    ]),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 320,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passController.text,
                    );
                    if (emailController.text.isEmpty) {
                      setState(() {
                        _emailvalidate = true;
                      });
                    } else if (passController.text.isEmpty) {
                      setState(() {
                        _passvalidate = true;
                      });
                    } else {
                      Fluttertoast.showToast(msg: 'sign in success');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    }
                  } on FirebaseAuthException catch (e) {
                    print(e.code);
                    if (e.code == 'user-not-found') {
                      Fluttertoast.showToast(
                          msg: 'The account does not exist',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                    }
                    if (e.code == 'wrong-password') {
                      Fluttertoast.showToast(
                        msg: 'wrong password',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }
                    if (e.code == 'unknown') {
                      Fluttertoast.showToast(
                        msg: 'unknown',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    }

                    setState(() {
                      _emailvalidate = false;
                      _passvalidate = false;
                    });
                  }
                  //
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an acount?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const sign_upPage()));
                      },
                      child: Text('Sign up')),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

//
/*if (email.text.isEmpty || pass.text.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please fill the complete data',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM);
                  }

                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email.text,
                    password: pass.text,
                  );
                  if(userCredential == null)
                    {
                      Fluttertoast.showToast(
                          msg: 'user email not exist',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM);
                    }
                  else{
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(),
                      ),

                    );
                    Fluttertoast.showToast(msg: 'sign in successfuly',
                    toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );*/
//}
