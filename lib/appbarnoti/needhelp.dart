import 'package:flutter/material.dart';

class needHelp extends StatelessWidget {
  const needHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: Text('Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person,size: 120,),
            Text("Hellow, How can we \n         Help you?",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),
            ListTile(
              leading: Icon(Icons.person_2),
              title: Text('Contact Live Chat'),
              trailing: Icon(Icons.arrow_forward),
              tileColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Sent us an E-mail'),
              trailing: Icon(Icons.arrow_forward),
              tileColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),

            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text("FAQ's"),
              trailing: Icon(Icons.arrow_forward),
              tileColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
