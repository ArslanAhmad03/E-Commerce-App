import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/Drawer/groupChat.dart';
import 'package:shop/Drawer/searchPage.dart';

class chatScreen extends StatefulWidget {
  final String name;
  const chatScreen({super.key, required this.name});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final messageController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Groups'),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => searchPage()),
              );
            },
            visualDensity:
            const VisualDensity(horizontal: -4.0, vertical: -4.0),
            icon: const Icon(Icons.search),
            tooltip: 'search',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Groups').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final group = snapshot.data?.docs ?? [];
          if (group.isEmpty) {
            return Center(
              child: Text('No Groups yet.'),
            );
          }
          return ListView.builder(
              itemCount: group.length,
              itemBuilder: (context, index) {
                final allGroup = group[index].data() as Map<dynamic, dynamic>?;

                if (allGroup != null) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        allGroup['Groups'][0],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    title: Text(allGroup['Groups'] ?? 'No Groups'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => groupChat(
                              groupName: allGroup['Groups'],
                              name: widget.name,
                            )),
                      );
                    },
                  );
                } else {
                  return ListTile(
                    title: Text('data not found'),
                  );
                }
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 260,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create a group',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              labelText: 'enter group name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('cencel'),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  try {
                                    await FirebaseFirestore.instance
                                        .collection('Groups')
                                        .add({
                                      'Groups': messageController.text,
                                    });
                                  } catch (e) {
                                    e.toString();
                                  }

                                },
                                child: const Text('create'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),

    );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;
  ChatMessage({required this.text, required this.isUserMessage});
}
/*
Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: messageController,
              onSubmitted: _sendMessage,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
                suffixIcon:
                    IconButton(icon: const Icon(Icons.send), onPressed: () {}),
              ),
            ),
          ),
          */