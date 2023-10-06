import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class contact extends StatelessWidget {
  const contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(

          children: [
            SizedBox(height: 80,),
            SizedBox(
              child: Image(
                height: 200,
                width: 300,
                image: AssetImage('assets/contact.png',),
              ),
            ),
            SizedBox(height: 50,),
            Text(
              'No Contact Yet',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade300),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Fluttertoast.showToast(msg: 'first permission granted');
              },
              child: Text('Add Contact'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
