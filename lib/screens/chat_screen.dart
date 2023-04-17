import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(8),
          child: Text('WorkS !'),
        ),
        itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Firebase.initializeApp();
          // snapshots emits new values every time the data changes
          FirebaseFirestore.instance
              .collection('chats/1fZCnzqmNoOfXhXwTHLp/messages')
              .snapshots()
              .listen((event) {
            event.docs.forEach((document) {
              print(document['text']);
            });
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
