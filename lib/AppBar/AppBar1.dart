import 'package:dyplom/tresc_screen/Kierunki.dart';
import 'package:dyplom/tresc_screen/Przedmioty.dart';
import 'package:dyplom/tresc_screen/Uczelnie.dart';
import 'package:dyplom/tresc_screen/tresc.dart';
import 'package:flutter/material.dart';

class AppBar10 extends StatefulWidget implements PreferredSizeWidget {
  @override
  _AppBar10State createState() => _AppBar10State();
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBar10State extends State<AppBar10> {
  String selectedCategory = 'Uczelnie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Uczelnie()));
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
              switch (newValue) {
                case 'Uczelnie':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Uczelnie()));
                  break;
                case 'Wydziały':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Tresc1()));
                  break;
                case 'Kierunki':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Kierunki()));
                  break;
                case 'Przedmioty':
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Przedmioty()));
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              'Uczelnie',
              'Wydziały',
              'Kierunki',
              'Przedmioty',
              //'Prowadzący',
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
    );
  }
}
