import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/dostepnosc_screen/dostepnosc_screen.dart';
import 'package:dyplom/user_pages/password_change_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../glowny_screen/glowny_screen.dart';

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
            ElevatedButton(
              onPressed: () {
                _logout(context);
              },
              child: Text('Wyloguj się'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                minimumSize: Size(200.0, 0), // Ustawienie minimalnej szerokości
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PasswordChangePage()),
                );
              },
              child: Text('Edycja hasła'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                minimumSize: Size(200.0, 0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DostepnoscScreen()),
                );
              },
              child: Text('Dostępność'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 80.0),
                minimumSize: Size(200.0, 0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Future<void> _logout(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    await checkLoginStatus(context);
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  Future<void> checkLoginStatus(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EkranGlowny()),
      );
    }
  }
}
