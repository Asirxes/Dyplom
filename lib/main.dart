import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
  }

  void _checkCurrentUser() {
    _user = _auth.currentUser;
  }

  void _refreshUser() async {
    User? refreshedUser = _auth.currentUser;
    setState(() {
      _user = refreshedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studenci dla studentów"),
        actions: [
          _user == null
              ? IconButton(
                  icon: Icon(Icons.login),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login')
                        .then((_) => _refreshUser());
                  },
                )
              : IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.pushNamed(context, '/logout')
                        .then((_) => _refreshUser());
                  },
                ),
          _user == null
              ? IconButton(
                  icon: Icon(Icons.app_registration),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration')
                        .then((_) => _refreshUser());
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: Center(
        child: _user == null
            ? Text('Zaloguj się')
            : Text('Witaj ${_user!.email}'),
      ),
    );
  }
}

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
  TextEditingController oldPasswordController = TextEditingController(); // Nowa kontrolka

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
                controller: oldPasswordController, // Nowa kontrolka
                decoration: InputDecoration(
                  labelText: 'Stare Hasło', // Nowy tekst
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
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

class RegistrationPage extends StatefulWidget {
  final VoidCallback onRegister;

  RegistrationPage({required this.onRegister});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rejestracja"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add,
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Potwierdź hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _register(
                  emailController.text,
                  passwordController.text,
                  confirmPasswordController.text,
                );
              },
              child: Text('Zarejestruj się'),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register(String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      Fluttertoast.showToast(
        msg: "Hasła nie pasują do siebie",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      setState(() {
        _user = userCredential.user;
      });
      Fluttertoast.showToast(
        msg: "Zarejestrowano",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
      widget.onRegister();
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Email jest już zajęty lub hasło jest za krótkie",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}

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
                  primary: Colors.brown,
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
                  Navigator.pushNamed(context, '/password_change'); // Przenosi do ekranu zmiany hasła
                },
                child: Text('Edycja hasła'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
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
                  // Dostępność (do zaimplementowania)
                },
                child: Text('Dostępność'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
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

class PasswordChangePage extends StatefulWidget {
  @override
  _PasswordChangePageState createState() => _PasswordChangePageState();
}

class _PasswordChangePageState extends State<PasswordChangePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zmiana hasła"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lock,
              size: 120.0,
              color: Colors.brown,
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  labelText: 'Stare Hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  labelText: 'Nowe Hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
              child: TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Potwierdź nowe hasło',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _changePassword(
                  oldPasswordController.text,
                  newPasswordController.text,
                  confirmPasswordController.text,
                );
              },
              child: Text('Zmień hasło'),
              style: ElevatedButton.styleFrom(
                primary: Colors.brown,
                padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 60.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      User user = _auth.currentUser!;
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      Fluttertoast.showToast(
        msg: "Zmieniono hasło",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Nie udało się zmienić hasła",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
