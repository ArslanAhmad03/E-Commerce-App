import 'package:flutter/material.dart';
import 'package:shop/Drawer/MyAcc.dart';
import 'package:shop/main_screen.dart';

class wallet extends StatefulWidget {
  const wallet({super.key});

  static const TextStyle _textStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle _textColor = TextStyle(color: Colors.purple);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  static List<String> items = <String>[
    'All Transection',
    'Complete',
    'Pending',
    'Cancel',
  ];
  String? value;
  String dropdownValue = items.first;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text(
          'My Wallet',
          style: wallet._textStyle,
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              PopupMenuItem(
                //value: 1,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()));
                  },
                  child: const Text(
                    "Home",
                    style: wallet._textColor,
                  ),
                ),
              ),
              PopupMenuItem(
                //value: 1,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Messages",
                    style: wallet._textColor,
                  ),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyAcc()));
                  },
                  child: const Text(
                    "My Account",
                    style: wallet._textColor,
                  ),
                ),
              ),
              PopupMenuItem(
                //value: 1,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Need Help?",
                    style: wallet._textColor,
                  ),
                ),
              ),
            ];
          })
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.deepPurple,
                  Colors.cyanAccent,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(color: Colors.white),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PKR',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      ' 0',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text(
                      'DEPOSIT',
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blueAccent.shade100.withOpacity(.8)),
                      child: const Icon(
                        Icons.list_alt_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Detail >')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blueAccent.shade100.withOpacity(.8)),
                      child: const Icon(
                        Icons.send_to_mobile_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Mobile Top Up')
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.blueAccent.shade100.withOpacity(.8)),
                      child: const Icon(
                        Icons.discount_outlined,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Vouchers')
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.all(10.0),
              child: DropdownButton<String>(
                  value: dropdownValue,
                  isExpanded: true,
                  elevation: 0,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (index) {
                    value = index;
                  })

              /*Text(
              'All Transections',
              style: TextStyle(fontSize: 15),
            ),*/
              ),
          const SizedBox(
            height: 20,
          ),
          const ListTile(
            leading: Icon(Icons.sell_outlined),
            title: Text('PAYMENT'),
            subtitle: Text('Order: 0123456789'),
            trailing: Text('Rs. 200'),
            style: ListTileStyle.list,
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          const ListTile(
            leading: Icon(Icons.sell_outlined),
            title: Text('PAYMENT'),
            subtitle: Text('Order: 0123456789'),
            trailing: Text('Rs. 200'),
            style: ListTileStyle.list,
          )
        ],
      ),
    );
  }
}
