import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studenci dla studentów',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;
  String? _email;
  String? _password;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadUserState();
  }

  _loadUserState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = _prefs!.getBool('isLoggedIn') ?? false;
      _email = _prefs!.getString('email');
      _password = _prefs!.getString('password');
    });
  }

  _register(String email, String password) async {
    if (_prefs!.getString(email) == null) {
      if (password.length >= 8) {
        _prefs!.setString(email, password);
        _login(email, password);
        Fluttertoast.showToast(msg: "Rejestracja udana!");
      } else {
        Fluttertoast.showToast(msg: "Hasło musi mieć co najmniej 8 znaków!");
      }
    } else {
      Fluttertoast.showToast(msg: "Email jest już zajęty!");
    }
  }

  _login(String email, String password) async {
    String? storedPassword = _prefs!.getString(email);
    if (storedPassword == password) {
      _prefs!.setBool('isLoggedIn', true);
      _prefs!.setString('email', email);
      _prefs!.setString('password', password);
      setState(() {
        _isLoggedIn = true;
        _email = email;
        _password = password;
      });
      Fluttertoast.showToast(msg: "Zalogowano pomyślnie!");
    } else {
      Fluttertoast.showToast(msg: "Złe dane logowania!");
    }
  }

  _logout() {
    setState(() {
      _isLoggedIn = false;
    });
    _prefs!.remove('isLoggedIn');
    Fluttertoast.showToast(msg: "Wylogowano!");
  }

  _changePassword(String newPassword) {
    if (newPassword.length >= 8) {
      _prefs!.setString(_email!, newPassword);
      Fluttertoast.showToast(msg: "Hasło zostało zmienione!");
    } else {
      Fluttertoast.showToast(msg: "Hasło musi mieć co najmniej 8 znaków!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Studenci dla studentów'),
        backgroundColor: Colors.brown,
        actions: [
          if (_isLoggedIn)
            ...[
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  _showInfoDialog();
                },
              ),
              IconButton(
                icon: Icon(Icons.vpn_key),
                onPressed: () {
                  _showChangePasswordDialog();
                },
              ),
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: _logout,
              ),
            ]
          else
            ...[
              IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  _showDialog('Logowanie', _login);
                },
              ),
              IconButton(
                icon: Icon(Icons.person_add),
                onPressed: () {
                  _showDialog('Rejestracja', _register);
                },
              ),
            ],
        ],
      ),
      body: Center(
        child: Text(_isLoggedIn ? 'Zalogowano jako: $_email' : 'Nie jesteś zalogowany'),
      ),
    );
  }

  _showDialog(String title, Function(String, String) onActionPressed) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Hasło'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Anuluj'),
            ),
            TextButton(
              onPressed: () {
                onActionPressed(emailController.text, passwordController.text);
                Navigator.pop(context);
              },
              child: Text('Zatwierdź'),
            ),
          ],
        );
      },
    );
  }

  _showChangePasswordDialog() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Zmień hasło'),
          content: TextField(
            controller: passwordController,
            decoration: InputDecoration(labelText: 'Nowe hasło'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Anuluj'),
            ),
            TextButton(
              onPressed: () {
                _changePassword(passwordController.text);
                Navigator.pop(context);
              },
              child: Text('Zatwierdź'),
            ),
          ],
        );
      },
    );
  }

  _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Informacje o użytkowniku'),
          content: Text('Email: $_email\nHasło: $_password'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Zamknij'),
            ),
          ],
        );
      },
    );
  }
}
