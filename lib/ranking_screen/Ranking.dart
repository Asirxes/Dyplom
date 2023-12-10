import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/ranking_screen/ranking_screen.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dyplom/AppBar/AppBar1.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final buttonWidth = 150.0;

    return Scaffold(
      appBar: AppBar10(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RankingScreen(selectedCategory: CategoryType.Uczelnie),
                    ),
                  );
                },
                child: Text('Uczelnie'),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RankingScreen(selectedCategory: CategoryType.Wydzialy),
                    ),
                  );
                },
                child: Text('Wydzialy'),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RankingScreen(selectedCategory: CategoryType.Kierunki),
                    ),
                  );
                },
                child: Text('Kierunki'),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RankingScreen(selectedCategory: CategoryType.Przedmioty),
                    ),
                  );
                },
                child: Text('Przedmioty'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: user != null ? CustomBottomNavigationBar() : null,
    );
  }
}
