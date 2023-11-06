import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/ranking_screen/ranking_screen.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';
import 'package:dyplom/main.dart';
import 'package:dyplom/AppBar/AppBar1.dart';
import 'package:provider/provider.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  Widget build(BuildContext context) {
    //final repository = Provider.of<CategoryRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar10(), //dodanie appbar10 z pliku appbar1
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
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

            ElevatedButton(
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

//------------------------------------------------------------------
            ElevatedButton(
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

            ElevatedButton(
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
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
