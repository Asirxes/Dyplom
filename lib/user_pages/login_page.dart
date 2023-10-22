import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLogin;

  LoginPage({required this.onLogin});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController =
      TextEditingController(); // Nowa kontrolka

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logowanie"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 120.0,
              color: Colors.brown,
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _login(
                  oldPasswordController.text, // Nowa kontrolka
                  emailController.text,
                  passwordController.text,
                );
              },
              child: Text('Zaloguj się'),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login(
    String oldPassword, // Nowy parametr
    String email,
    String password,
  ) async {
    try {
      if (oldPassword.isNotEmpty) {
        // Jeśli stare hasło nie jest puste, spróbuj zmienić hasło
        User user = _auth.currentUser!;
        final AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);
        await user.updatePassword(password);
      } else {
        // W przeciwnym razie, zaloguj się normalnie
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        setState(() {
          _user = userCredential.user;
        });
      }
      Fluttertoast.showToast(
        msg: "Zalogowano",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
      widget.onLogin();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Nieprawidłowy email lub hasło",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}