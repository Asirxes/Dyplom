import 'package:dyplom/glowny_screen/glowny_screen.dart';
//import 'package:dyplom/main.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:dyplom/ranking_screen/ranking_screen.dart';
import 'package:dyplom/tresc_screen/tresc.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:dyplom/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppBar1(),
    );
  }
}

class AppBar1 extends StatefulWidget {
  @override
  _AppBar1State createState() => _AppBar1State();
}

class _AppBar1State extends State<AppBar1> {
  String selectedCategory = 'Uczelnie';

  @override
  Widget build(BuildContext context) {
    //final repository = Provider.of<CategoryRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // Navigate to the home screen or any other screen you desire.
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Tresc1()));
          },
          child: Text('Tresc'),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.arrow_drop_down),
            onSelected: (String newValue) {
              setState(() {
                selectedCategory = newValue;
              });

              // Navigate to the selected category screen
              switch (newValue) {
                case 'Uczelnie':
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => UczelnieScreen()));
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EkranGlowny()));
                  break;
                case 'Wydziały':
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WydzialyScreen()));
                  break;
                // Add cases for other categories
              }
            },
            itemBuilder: (BuildContext context) => [
              'Uczelnie',
              'Wydziały',
              'Kierunki',
              'Przedmioty',
              'Prowadzący',
            ].map((String category) {
              return PopupMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
      body: Center(
        child: Text('Selected Category: $selectedCategory'),
      ),
      bottomNavigationBar: BottomAppBar(
        child:
            Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Navigate to the 'Konto' screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EkranGlowny()));
                },
              ),
              IconButton(
                icon: Icon(Icons.message),
                onPressed: () {
                  // Navigate to the 'Wiadomości' screen
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EkranGlowny()));
                },
              ),
              IconButton(
                icon: Icon(Icons.align_vertical_bottom),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RankingScreen(
                          selectedCategory: CategoryType.Wydzialy),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}

//--------------------
class UczelnieScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uczelnie Screen'),
      ),
      body: Center(
        child: Text('Uczelnie Screen Content'),
      ),
    );
  }
}

class WydzialyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wydzialy Screen'),
      ),
      body: Center(
        child: Text('Wydzialy Screen Content'),
      ),
    );
  }
}

class KontoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konto Screen'),
      ),
      body: Center(
        child: Text('Konto Screen Content'),
      ),
    );
  }
}

class WiadomosciScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wiadomosci Screen'),
      ),
      body: Center(
        child: Text('Wiadomosci Screen Content'),
      ),
    );
  }
}
