import 'package:dyplom/tresc_screen/tresc_screen.dart';
import 'package:dyplom/ranking_screen/ranking_screen.dart';
import 'package:flutter/material.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage1> {
  int _pageIndex = 0;

  late List<Widget> pageList = [
   
    const TrescScreen(),
    //const NewsPage(),
    const RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Treść',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              print('Lista');
            },
            icon: const Icon(
              Icons.arrow_drop_down,
              size: 35.0,
            ),
          ),
        ],
        
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (int index) {
          setState(() {
            _pageIndex = index;
            pageList[_pageIndex];
          });
        },
        
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Konto',
            
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Wiadomości',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.align_vertical_bottom),
            label: 'Rankingi',
          ),
        ],
      ),

      
      body: pageList[_pageIndex],
    );
  }
}
