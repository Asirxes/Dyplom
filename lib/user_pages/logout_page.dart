import 'package:dyplom/dostepnosc_screen/dostepnosc_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Konto"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  _logout(context);
                },
                child: Text('Wyloguj się'),
                style: ElevatedButton.styleFrom(
                  
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
                  textStyle: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context,
                      '/password_change'); // Przenosi do ekranu zmiany hasła
                },
                child: Text('Edycja hasła'),
                style: ElevatedButton.styleFrom(
                  
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
                  textStyle: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 40.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DostepnoscScreen()),
                );
              },
                child: Text('Dostępność'),
                style: ElevatedButton.styleFrom(
                  
                  padding:
                      EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
                  textStyle: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }
}