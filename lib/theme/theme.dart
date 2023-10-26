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
     canvasColor: Colors.green,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: red1, // Set the initial color
          ),
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

          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: red1, // Set the initial color
          ),

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
        );
        break;

      case AppTheme.Black:
        _currentTheme = ThemeData(
          primarySwatch: white1,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.black,
          //textTheme: TextTheme(bodyText1: TextStyle(color: white1)),
          colorScheme: ColorScheme.fromSeed(
            seedColor: white1,
            brightness: Brightness.dark,
            primary: white1,
          ),

          // colorScheme: ColorScheme.fromSeed(
          //   seedColor: white1,
          //   brightness: Brightness.dark,
          //   primary: white1,
          //   onPrimary: black1,//+ tekst w guzikach
          //   primaryContainer: Color.fromARGB(68, 7, 219, 7),
          //   onPrimaryContainer: Color.fromARGB(255, 254, 0, 0),
          //   secondary: white1,//+ kolor floatingActionButton
          //   onSecondary: black1,
          //   secondaryContainer: Color.fromARGB(177, 90, 208, 102),
          //   onSecondaryContainer: Color.fromARGB(255, 99, 61, 190),
          //   tertiary: Color.fromARGB(255, 194, 194, 7),
          //   onTertiary: Color(0xFF99FF88),

          // ),
        );
        break;
    }
    notifyListeners();
  }
}
