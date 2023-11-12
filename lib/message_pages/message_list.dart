import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_page.dart';

class MessageListPage extends StatefulWidget {
  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User? _user;
  List<String> _usersWithMessages = [];
  String? _selectedUser;
  List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUsersWithMessages();
  }

  void _loadUsersWithMessages() async {
    if (_user != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('messages')
          .where('user1', isEqualTo: _user!.email)
          .get();

      List<String> users = [];
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        String user2 = document['user2'];
        if (!users.contains(user2)) {
          users.add(user2);
        }
      }

      querySnapshot = await _firestore
          .collection('messages')
          .where('user2', isEqualTo: _user!.email)
          .get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        String user1 = document['user1'];
        if (!users.contains(user1)) {
          users.add(user1);
        }
      }

      setState(() {
        _usersWithMessages = users;
      });
    }
  }

  void _loadMessages(String user) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('messages')
        .where('user1', isEqualTo: _user!.email)
        .where('user2', isEqualTo: user)
        .get();

    List<Message> messages = [];
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      messages.add(Message.fromMap(data));
    }

    querySnapshot = await _firestore
        .collection('messages')
        .where('user1', isEqualTo: user)
        .where('user2', isEqualTo: _user!.email)
        .get();

    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      messages.add(Message.fromMap(data));
    }

    // Sortuj wiadomości według timestamp w odwrotnej kolejności
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    setState(() {
      _messages = messages;
      _selectedUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wiadomości"),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: _usersWithMessages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_usersWithMessages[index]),
                  onTap: () {
                    _loadMessages(_usersWithMessages[index]);
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: _buildChatView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MessagesPage()),
          );

          if (result != null && result == true) {
            _loadUsersWithMessages();
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  Widget _buildChatView() {
    return _selectedUser != null
        ? Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    Message message = _messages[index];
                    bool isCurrentUser = message.user1 == _user!.email;
                    return _buildMessageBubble(message.text, isCurrentUser);
                  },
                ),
              ),
              _buildMessageInput(),
            ],
          )
        : Container();
  }

  Widget _buildMessageBubble(String text, bool isCurrentUser) {
    return Align(
      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Napisz wiadomość...',
              ),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            onPressed: () {
              _sendMessage();
            },
            child: Text('Wyślij'),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_user != null && _selectedUser != null) {
      String user1 = _user!.email ?? _user!.email ?? 'unknown';
      String user2 = _selectedUser!;
      String text = _messageController.text;

      if (user2.isNotEmpty && text.isNotEmpty) {
        try {
          List<String> signInMethods =
              await FirebaseAuth.instance.fetchSignInMethodsForEmail(user2);

          if (signInMethods.isEmpty) {
            _showToast('Użytkownik o podanej nazwie nie istnieje.');
          } else {
            await FirebaseFirestore.instance.collection('messages').add({
              'user1': user1,
              'user2': user2,
              'text': text,
              'timestamp': FieldValue.serverTimestamp(),
            });

            _messageController.clear();

            // Odśwież wiadomości po wysłaniu nowej wiadomości
            _loadMessages(user2);
          }
        } catch (e) {
          _showToast('Wystąpił błąd. Spróbuj ponownie.');
        }
      } else {
        _showToast('Podaj adres email i treść wiadomości.');
      }
    }
  }

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class Message {
  final String user1;
  final String user2;
  final String text;
  final Timestamp timestamp;

  Message({
    required this.user1,
    required this.user2,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      user1: map['user1'] ?? '',
      user2: map['user2'] ?? '',
      text: map['text'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
