import 'package:flutter/material.dart';
import 'package:shop/Drawer/MyAcc.dart';
import 'package:shop/appbarnoti/wallet.dart';
import 'package:shop/pages/sign_inPage.dart';
import 'package:shop/widgets/CategoriesWidget.dart';

import 'package:shop/widgets/ItemsWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const TextStyle _textheading = TextStyle(
      fontSize: 25, color: Colors.purple, fontWeight: FontWeight.bold);

  static const TextStyle _textdrawer = TextStyle(
      fontSize: 15, color: Colors.purple, fontWeight: FontWeight.bold);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: AppBar(
              centerTitle: true,
              backgroundColor: Colors.purple,
              title: const Text(
                'Click Shop',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                  tooltip: 'notification',
                  splashRadius: 20,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const wallet()));
                  },
                  icon: const Icon(Icons.account_balance_wallet_rounded),
                  tooltip: 'wallet',
                  splashRadius: 20,
                )
              ],
            ),
          ),
          body: ListView(children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'search',
                        hintText: 'Search Here....',
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Text(
                'Categories',
                style: HomePage._textheading,
              ),
            ),
            const CategoriesWidget(),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: const Text('Best Selling', style: HomePage._textheading),
            ),
            const ItemsWidget(),
          ]),
          drawer: Drawer(
              backgroundColor: Colors.white,
              width: 250,
              child: ListView(
                children: [
                  const UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                    ),
                    accountName: Text(''),
                    accountEmail: Text('abc@gmail.com'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.dashboard),
                    title: const Text('DashBoard', style: HomePage._textdrawer),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat),
                    title: const Text('My Chat', style: HomePage._textdrawer),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_box_outlined),
                    title:
                        const Text('My Account', style: HomePage._textdrawer),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyAcc()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_page),
                    title:
                        const Text('My Contacts', style: HomePage._textdrawer),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.favorite_outline),
                    title: const Text('Favourite', style: HomePage._textdrawer),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.update),
                    title:
                        const Text('Update Data', style: HomePage._textdrawer),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text('LogOut', style: HomePage._textdrawer),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("LogOut"),
                            content: const Text("Sure you want to logout"),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: const Text("Ok"),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const sign_inPage()));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: const Text(
                      'my e-commerce app',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
