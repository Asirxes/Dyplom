import 'package:dyplom/colors.dart';
import 'package:dyplom/AppBar/AppBar1.dart';
import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DostepnoscScreen extends StatefulWidget {
  const DostepnoscScreen({super.key});

  @override
  State<DostepnoscScreen> createState() => _DostepnoscScreenState();
}

class _DostepnoscScreenState extends State<DostepnoscScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar10(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              // Text(
              //   'Current Theme',
              //   style: TextStyle(fontSize: 20),
              //   //style: Theme.of(context).textTheme.headline6,
              // ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                themeNotifier.setTheme(AppTheme.Red);
              },
              style: ElevatedButton.styleFrom(primary: red1,
              onPrimary: Colors.white,
              side: BorderSide(color: Colors.white,),
              
              ),
              child: Text('A'),
            ),
            ElevatedButton(
              onPressed: () {
                themeNotifier.setTheme(AppTheme.Yellow);
              },
              style: ElevatedButton.styleFrom(primary: Colors.black,
              onPrimary: yellow1,
              side: BorderSide(color: yellow1,),
              ),
              child: Text('A'),
            ),
            ElevatedButton(
              onPressed: () {
                themeNotifier.setTheme(AppTheme.BlacknY);
              },
              style: ElevatedButton.styleFrom(primary: yellow1,
              onPrimary: Colors.black,
              side: BorderSide(color: Colors.black,),
              ),
              child: Text('A'),
            ),

            ElevatedButton(
              onPressed: () {
                themeNotifier.setTheme(AppTheme.Black);
              },
              style: ElevatedButton.styleFrom(primary: Colors.black,
              onPrimary: Colors.white,
              side: BorderSide(color: Colors.white,),
            ),
              child: Text('A'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}