import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/user_pages/login_page.dart';
import 'package:dyplom/user_pages/registration_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:dyplom/main.dart';
import 'package:dyplom/dostepnosc_screen/dostepnosc_screen.dart';
import 'package:dyplom/AppBar/AppBar1.dart';

class EkranGlowny extends StatefulWidget {
  @override
  State<EkranGlowny> createState() => _EkranGlownyState();
}

class _EkranGlownyState extends State<EkranGlowny> {
  late User? _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar10(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset('lib/assets/logo1.png'),
            ),
            SizedBox(height: 20.0),

            if (_user == null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(onLogin: checkLoginStatus)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  minimumSize: Size(200.0, 0),
                ),
                child: Text('Zaloguj się'),
              ),
            SizedBox(height: 20.0),

            if (_user == null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage(onRegister: checkLoginStatus)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  minimumSize: Size(200.0, 0),
                ),
                child: Text('Zarejestruj się'),
              ),
            SizedBox(height: 20.0),

            if (_user != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DostepnoscScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                  minimumSize: Size(200.0, 0),
                ),
                child: Text('Dostępność'),
              ),
          ],
        ),
      ),
      bottomNavigationBar: _user != null ? CustomBottomNavigationBar() : null,
    );
  }

  void checkLoginStatus() {
    setState(() {
      
    });
  }
}
