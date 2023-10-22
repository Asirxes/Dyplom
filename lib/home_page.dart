import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    _user = _auth.currentUser;
  }

  void _refreshUser() async {
    User? refreshedUser = _auth.currentUser;
    setState(() {
      _user = refreshedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studenci dla studentów"),
        actions: [
          _user == null
              ? IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login')
                        .then((_) => _refreshUser());
                  },
                )
              : IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.pushNamed(context, '/logout')
                        .then((_) => _refreshUser());
                  },
                ),
          _user == null
              ? IconButton(
                  icon: Icon(Icons.app_registration),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration')
                        .then((_) => _refreshUser());
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: Center(
        child:
            _user == null ? Text('Zaloguj się') : Text('Witaj ${_user!.email}'),
      ),
    );
  }
}