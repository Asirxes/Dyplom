import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home_page.dart';
import 'user_pages/login_page.dart';
import 'user_pages/logout_page.dart';
import 'user_pages/password_change_page.dart';
import 'user_pages/registration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyBNd_Vx1xdImlJ1sZg6WfTDfhYqic5A990',
      authDomain: 'dyplom-986dd.firebaseapp.com',
      projectId: 'dyplom-986dd',
      storageBucket: 'dyplom-986dd.appspot.com',
      messagingSenderId: '232096191273',
      appId: '1:232096191273:web:051de7f6986206c56b5d38',
      measurementId: 'G-HE5TEZBXRF',
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studenci dla studentów',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.brown,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(onLogin: () {}),
        '/registration': (context) => RegistrationPage(onRegister: () {}),
        '/logout': (context) => LogoutPage(),
        '/password_change': (context) => PasswordChangePage(),
      },
    );
  }
}






