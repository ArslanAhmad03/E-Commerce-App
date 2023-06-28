import 'package:flutter/material.dart';
import 'package:shop/main_screen.dart';
import 'package:shop/pages/sign_inPage.dart';

class sign_upPage extends StatefulWidget {
  const sign_upPage({super.key});

  @override
  State<sign_upPage> createState() => _sign_upPageState();
}

class _sign_upPageState extends State<sign_upPage> {
  bool hidepass = true;
  bool hidepas = true;

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmpass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          centerTitle: true,
          title: Text("Create New Account"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Colors.white,
            child: Column(children: [
              SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/profile.png'),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.camera_alt,
                      ),
                      splashColor: Colors.purple.shade200,
                      splashRadius: 30,
                    ),
                  )
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
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('   User Name'),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 45,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(
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
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter Phone No....',
                      labelText: 'phone',
                      prefixIcon: const Icon(Icons.phone, color: Colors.purple),
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
                  height: 45,
                  width: 320,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Enter email....',
                      labelText: 'email',
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
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 45,
                        width: 320,
                        child: TextFormField(
                          obscureText: hidepass,
                          obscuringCharacter: '*',
                          controller: _pass,
                          style: const TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'password',
                              hintText: 'Enter Password....',
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.purple),
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
                          validator: (value) {
                            if (value!.isEmpty) return 'Empty';
                            return null;
                          },
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
                              height: 45,
                              width: 320,
                              child: TextFormField(
                                controller: _confirmpass,
                                keyboardType: TextInputType.text,
                                obscureText: hidepas,
                                obscuringCharacter: '*',
                                style: const TextStyle(fontSize: 15),
                                decoration: InputDecoration(
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
                                            hidepas = !hidepas;
                                          });
                                        },
                                        icon: hidepas
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility))),
                                validator: (value) {
                                  if (value!.isEmpty) return 'Empty';
                                  if (value != _pass) return 'Notmatch';
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SizedBox(
                              height: 40,
                              width: 320,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MyHomePage()));
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.purple,
                                    elevation: 8,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    )),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]))
              ]),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Acount?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const sign_inPage()));
                        },
                        child: Text('Sign in')),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
