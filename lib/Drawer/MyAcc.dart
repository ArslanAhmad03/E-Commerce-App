import 'package:flutter/material.dart';

class MyAcc extends StatelessWidget {
  const MyAcc({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 440,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              InkWell(
                child: const Icon(Icons.arrow_back_ios_new_outlined),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/group.png',
                      ),
                      radius: 35,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name'),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Email@gmail.com')
                        ]),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('0'), Text('in your cart')],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('0'), Text('in your WishList')],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text('0'), Text('your Orders')],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 14),
                height: 200,
                width: 330,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: const Icon(
                        Icons.list,
                        size: 30,
                      ),
                      title: const Text(
                        'My Orders',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: const Icon(
                        Icons.list,
                        size: 30,
                      ),
                      title: const Text(
                        'My WishLists',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {},
                    ),
                    const Divider(
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      tileColor: Colors.grey.shade200,
                      leading: const Icon(
                        Icons.message_outlined,
                        size: 30,
                      ),
                      title: const Text(
                        'Messages',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
