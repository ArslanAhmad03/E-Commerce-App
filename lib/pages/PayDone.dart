import 'package:flutter/material.dart';
import 'package:selectable_container/selectable_container.dart';

class PayDone extends StatefulWidget {
  const PayDone({super.key});

  @override
  State<PayDone> createState() => _PayDoneState();
}

class _PayDoneState extends State<PayDone> {
  //List<bool> _select = [false, false, false];
  bool _select1 = false;
  bool _select2 = false;
  bool _select3 = false;

  /*void _isSelected(int index) {
    setState(() {
      for (int i = 0; i < _select.length; i++) {
        if (i == index) {
          _select[i] = !_select[i];
        } else {
          _select[i] = false;
        }
      }
    });
  }*/

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
            selected: _select1,
            onValueChanged: (value1) {
              setState(() {
                _select1 = value1;
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/paypal.png'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          SelectableContainer(
            selected: _select2,
            onValueChanged: (value1) {
              setState(() {
                _select2 = value1;
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/strip.png'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          SelectableContainer(
            selected: _select3,
            onValueChanged: (value1) {
              setState(() {
                _select3 = value1;
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/cod.png'),
                fit: BoxFit.cover,
              )),
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: const EdgeInsets.only(top: 220),
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(10)),
            child: TextButton(
              onPressed: () {
                debugPrint('place order');
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
