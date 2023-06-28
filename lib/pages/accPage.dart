// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart';
import 'package:shop/pages/settingPage.dart';

// ignore: camel_case_types
class accPage extends StatelessWidget {
  const accPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('Profile'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const settingPage()));
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage('assets/profile.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                      ),
                      splashColor: Colors.purple.shade200,
                      splashRadius: 15,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'name',
              ),
              const Text(
                'subname',
              ),
              const SizedBox(height: 20),

              /// -- BUTTON
              const SizedBox(height: 30),
              const Divider(
                indent: 30,
                endIndent: 30,
                color: Colors.purple,
                thickness: 2,
                height: 5,
              ),
              const SizedBox(height: 10),
              //// ---
              SizedBox(
                height: 45,
                width: 320,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'name',
                    hintText: 'Enter Name....',
                    prefixIcon: const Icon(Icons.person, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 45,
                width: 320,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'email',
                    hintText: 'Email....',
                    prefixIcon: const Icon(Icons.email, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 45,
                width: 320,
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'phone',
                    hintText: 'Phone....',
                    prefixIcon: const Icon(Icons.phone, color: Colors.purple),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 40,
                width: 320,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
      ),
    );
  }
}
