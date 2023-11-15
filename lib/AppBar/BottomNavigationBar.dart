//import 'package:dyplom/main.dart';
//import 'package:dyplom/message_pages/message_page.dart';
import 'package:dyplom/ranking_screen/Ranking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:dyplom/glowny_screen/glowny_screen.dart';
import 'package:dyplom/theme/theme.dart';

import '../message_pages/message_list.dart';
import '../user_pages/logout_page.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {   
    return BottomAppBar(
      child: Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogoutPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageListPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.align_vertical_bottom),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Ranking()));
              },
            ),
          ],
        );
      }),
    );
  }
}
