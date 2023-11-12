import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wiadomości'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Adres email odbiorcy'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'Treść wiadomości'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _sendMessage();
              },
              child: Text('Wyślij wiadomość'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;
    print(user);
    if (user != null) {
      String user1 = user.displayName ?? user.email ?? 'unknown';
      String user2 = emailController.text;
      String text = textController.text;

      if (user2.isNotEmpty && text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('messages').add({
          'user1': user1,
          'user2': user2,
          'text': text,
        });

        emailController.clear();
        textController.clear();

      } else {

      }
    }
  }
}
