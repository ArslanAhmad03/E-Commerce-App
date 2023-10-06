import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class groupChat extends StatefulWidget {
  final String groupName, name;

  const groupChat({super.key, required this.groupName, required this.name});

  @override
  State<groupChat> createState() => _groupChatState();
}

class _groupChatState extends State<groupChat> {
  final _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.groupName),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .where('groupName', isEqualTo: widget.groupName)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading messages.'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data?.docs ?? [];
                messages.sort((a, b) {
                  final aTimestamp = a['timestamp'] as Timestamp?;
                  final bTimestamp = b['timestamp'] as Timestamp?;

                  // Handle null timestamps by treating them as equal
                  if (aTimestamp == null && bTimestamp == null) {
                    return 0;
                  } else if (aTimestamp == null) {
                    return 1;
                  } else if (bTimestamp == null) {
                    return -1;
                  }

                  return bTimestamp.compareTo(aTimestamp);
                });

                if (messages.isEmpty) {
                  return const Center(
                    child: Text('No chat yet!'),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index]['text'];
                    final senderName = messages[index]['sender'];
                    final time = messages[index]['time'];
                    if (message != null) {
                      return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.lightGreenAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        senderName,style: const TextStyle(fontSize: 12.0,color: Colors.purple),
                                        softWrap: true,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    message,
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                  ),
                                  Row(
                                    children: [
                                      const Spacer(),
                                      Text(
                                        time,
                                        style: const TextStyle(fontSize: 8.0,color: Colors.purple),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                    } else {
                      return const Center(
                        child: Text('No chat yet!'),
                      );
                    }
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Enter a message',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                ),
                IconButton(
                  icon: _isSendingMessage
                      ? CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                      : Icon(Icons.send),
                  onPressed: _isSendingMessage
                      ? null
                      : () async {
                    setState(() {
                      _isSendingMessage = true;
                    });
                    await Future.delayed(Duration(seconds: 2));
                    _firestore.collection('messages').add({
                      'text': _messageController.text,
                      'groupName': widget.groupName,
                      'sender': widget.name,
                      'timestamp': FieldValue.serverTimestamp(),
                      'time': DateFormat.jm().format(DateTime.now()),
                    });
                    _messageController.clear();
                    setState(() {
                      _isSendingMessage = false;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool _isSendingMessage = false;
}
