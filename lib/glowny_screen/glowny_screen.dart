import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/user_pages/login_page.dart';
import 'package:dyplom/user_pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:dyplom/main.dart';
import 'package:dyplom/dostepnosc_screen/dostepnosc_screen.dart';
// import 'package:dyplom/ranking_screen/ranking_screen.dart';
// import 'package:dyplom/tresc_screen/tresc_screen.dart';
// import 'package:dyplom/nowe/AppBar.dart';
import 'package:dyplom/AppBar/AppBar1.dart';

class EkranGlowny extends StatefulWidget {
  const EkranGlowny({super.key});

  @override
  State<EkranGlowny> createState() => _EkranGlownyState();
}

class _EkranGlownyState extends State<EkranGlowny> {
  

  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar10(),//dodanie appbar10 z pliku appbar1
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Container(
              width: 200,
              height: 200,
              child: Image.asset('lib/assets/logo1.png'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(onLogin: () {  },)),
                );
              },
              child: Text('Zaloguj się'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage(onRegister: () {  },)),
                );
              },
              child: Text('Zarejestruj się'),
            ),

//------------------------------------------------------------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DostepnoscScreen()),
                );
              },
              child: Text('dostępność'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
