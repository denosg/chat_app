import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/1fZCnzqmNoOfXhXwTHLp/messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final documents = snapshot.data!.docs;
            return ListView.builder(
              itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
              itemCount: documents.length,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/1fZCnzqmNoOfXhXwTHLp/messages')
              .add({
            'text': 'This was added by clicking the button',
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
