import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class User {
  final String email;
  final String password;
  User(this.email, this.password);
}

class Uczelnia {
  final String nazwa;
  final String miasto;
  Uczelnia({required this.nazwa, required this.miasto});
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
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late Database database;
  List<Uczelnia> uczelnie = [];
  List<User> users = [];
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = "${documentsDirectory.path}/sample.db";
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE uczelnie (id INTEGER PRIMARY KEY, nazwa TEXT, miasto TEXT)");
        await db.execute(
            "CREATE TABLE users (id INTEGER PRIMARY KEY, email TEXT, password TEXT)");
        await db.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO uczelnie(nazwa, miasto) VALUES("Politechnika Warszawska", "Warszawa")');
          await txn.rawInsert(
              'INSERT INTO uczelnie(nazwa, miasto) VALUES("Uniwersytet Jagielloński", "Kraków")');
          await txn.rawInsert(
              'INSERT INTO uczelnie(nazwa, miasto) VALUES("Uniwersytet Wrocławski", "Wrocław")');
        });
      },
    );

    _loadUczelnie();
  }

  Future<void> _loadUczelnie() async {
    List<Map> list = await database.rawQuery('SELECT * FROM uczelnie');
    list.forEach((element) {
      uczelnie.add(Uczelnia(nazwa: element['nazwa'], miasto: element['miasto']));
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studenci dla studentów"),
        actions: [
          loggedInUser == null
              ? IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () => _showLoginDialog(context),
                )
              : IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () => _logout(),
                ),
          loggedInUser == null
              ? IconButton(
                  icon: Icon(Icons.app_registration),
                  onPressed: () => _showRegistrationDialog(context),
                )
              : SizedBox.shrink(),
        ],
      ),
      body: loggedInUser == null
          ? Center(child: Text('Zaloguj się'))
          : ListView.builder(
              itemCount: uczelnie.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(uczelnie[index].nazwa),
                  subtitle: Text(uczelnie[index].miasto),
                );
              },
            ),
    );
  }

  void _showLoginDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
              onPressed: () {
                _login(emailController.text, passwordController.text);
                Navigator.pop(context);
              },
              child: Text('Zaloguj'),
            )
          ],
        );
      },
    );
  }

  void _login(String email, String password) async {
    // Simuluj logowanie (możesz zastąpić prawdziwą autoryzacją)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedPassword = prefs.getString(email);
    if (savedPassword != null && savedPassword == password) {
      Fluttertoast.showToast(
          msg: "Zalogowano",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      setState(() {
        loggedInUser = User(email, password);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Nieprawidłowy email lub hasło",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
    }
  }

  void _showRegistrationDialog(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
              onPressed: () {
                _register(emailController.text, passwordController.text);
                Navigator.pop(context);
              },
              child: Text('Zarejestruj'),
            ),
          ],
        );
      },
    );
  }

  void _register(String email, String password) async {
    // Simuluj rejestrację (możesz zastąpić prawdziwą rejestrację)
    if (password.length < 8) {
      Fluttertoast.showToast(
          msg: "Hasło musi mieć co najmniej 8 znaków",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(email) != null) {
      Fluttertoast.showToast(
          msg: "Email jest już zajęty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM);
      return;
    }

    prefs.setString(email, password);
    Fluttertoast.showToast(
        msg: "Zarejestrowano",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
  }

  void _logout() {
    Fluttertoast.showToast(
        msg: "Wylogowano",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    setState(() {
      loggedInUser = null;
    });
  }
}
