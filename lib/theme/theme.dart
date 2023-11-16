import 'package:dyplom/colors.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

enum AppTheme { Red, Yellow, BlacknY, Black }

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: red1,
    primarySwatch: red1,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
  );

  ThemeData get currentTheme => _currentTheme;
  void setTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.Red:
        _currentTheme = ThemeData(
          brightness: Brightness.light,
          primarySwatch: red1,
          primaryColor: red1,
          scaffoldBackgroundColor: Colors.white,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
        );
        break;
      case AppTheme.Yellow:
        _currentTheme = ThemeData(
          brightness: Brightness.dark,
          primarySwatch: yellow1,
          primaryColor: white1,
          scaffoldBackgroundColor: black1,
          textTheme: TextTheme(bodyText1: TextStyle(color: white1)),
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.yellow,
            brightness: Brightness.dark,
            primary: yellow1,
          ),
        );
        break;
      case AppTheme.BlacknY:
        _currentTheme = ThemeData(
          brightness: Brightness.light,
          primarySwatch: yellow1,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 112),
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: yellow1, // Set the initial color
          ),
          // colorScheme: ColorScheme.fromSeed(
          //   seedColor: white1,
          //   primary: yellow1,//kolor guzików i appbar
          //   onPrimary: black1,//tekst  
            
          // ),
        );
        break;

      case AppTheme.Black:
        _currentTheme = ThemeData(
          primarySwatch: white1,
          primaryColor: white1,
          scaffoldBackgroundColor: Colors.black,
          //scaffoldBackgroundColor:black1Accent,

          // colorScheme: ColorScheme.fromSeed(
          //   seedColor: white1,
          //   brightness: Brightness.dark,
          //   primary: white1,//kolor guzików i appbar w bright
          //   onPrimary: black1,//+ tekst  
          // ),
          // colorScheme: ColorScheme.fromSeed(
          //   seedColor: black1,
          //   brightness: Brightness.light,
          //   primary: black1,//kolor guzików i appbar w bright
          //   onPrimary: white1,//+ tekst  
          // ),
        );
        break;
    }
    notifyListeners();
  }
}
