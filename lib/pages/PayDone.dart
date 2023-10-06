
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:selectable_container/selectable_container.dart';
import 'package:shop/main_screen.dart';

class PayDone extends StatefulWidget {
  const PayDone({super.key,});

  @override
  State<PayDone> createState() => _PayDoneState();
}

class _PayDoneState extends State<PayDone> {

  int selectedPaymentMethod = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Select Payment Method'),
      ),
      body: Column(
        children: [
          SelectableContainer(
            selected: selectedPaymentMethod == 0,
            onValueChanged: (index) {
              setState(() {
                selectedPaymentMethod = index ? 0 : -1;
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/paypal.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('PayPal Payment'),
                    ),
                  ]),
            ),
          ),
          SelectableContainer(
            selected: selectedPaymentMethod == 1,
            onValueChanged: (index) {
              setState(() {
                selectedPaymentMethod = index ? 1 : -1;
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/strip.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Stripe Payment'),
                    ),
                  ]
              ),
            ),
          ),
          SelectableContainer(
            selected: selectedPaymentMethod == 2,
            onValueChanged: (index) {
              setState(() {
                selectedPaymentMethod = index ? 2 : -1;
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/cod.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Cash On Delivery'),
                    ),
                  ]),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 220),
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () async{
                try{
                  if(selectedPaymentMethod == -1){
                    Fluttertoast.showToast(msg: 'select only one payment method',gravity: ToastGravity.CENTER);
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Order Placed successfully',gravity: ToastGravity.CENTER);
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  }
                }catch (e){
                  print(e.toString());
                }
                //
              },
              child: const Text(
                'Place My Order',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
