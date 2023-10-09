import 'package:flutter/material.dart';
import 'package:dyplom/main.dart';
import 'package:dyplom/dostepnosc_screen/dostepnosc_screen.dart';
import 'package:dyplom/ranking_screen/ranking_screen.dart';
import 'package:dyplom/tresc_screen/tresc_screen.dart';
import 'package:dyplom/nowe/home_page.dart';

class EkranGlowny extends StatefulWidget {
  const EkranGlowny({super.key});

  @override
  State<EkranGlowny> createState() => _EkranGlownyState();
}

class _EkranGlownyState extends State<EkranGlowny> {
  int _pageIndex = 0;

  late List<Widget> pageList = [
    const TrescScreen(),
    //const NewsPage(),
    const RankingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);

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
      //body: pageList[_pageIndex],

      
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Container(child: pageList[_pageIndex],),
            Container(
              width: 200,
              height: 200,
              child: Image.asset('lib/assets/logo1.png'),
            ),

            /*ElevatedButton(
              // onPressed: () {
              // Navigator.push(
              //   context,
              // MaterialPageRoute(builder: (context) => HomePage()),
              
              // );
              // },
              onPressed: () => _showLoginDialog(context),
              child: Text('Zaloguj się'),
            ),
*/
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Zarejestruj się'),
            ),

//------------------------------------------------------------------
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('home'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DostepnoscScreen()),
                );
              },
              child: Text('dostępność'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RankingScreen()),
                );
              },
              child: Text('ranking'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TrescScreen()),
                );
              },
              child: Text('treść'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage1()),
                );
              },
              child: Text('nowe'),
            ),
//----------------------------------------------------
          Container(child: pageList[_pageIndex],)
          ],
        ),
      ),
    );
  }
}
