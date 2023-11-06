

//import 'package:dyplom/tresc_screen/CategoryRepository.dart';
import 'package:dyplom/main.dart';
import 'package:dyplom/ranking_screen/Ranking.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dyplom/glowny_screen/glowny_screen.dart';
//import 'package:dyplom/ranking_screen/ranking_screen.dart';
import 'package:dyplom/theme/theme.dart';

import '../user_pages/logout_page.dart';
//import 'package:dyplom/CategoryRepository.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final categoryRepository = Provider.of<CategoryRepository>(context);
    //final repository = Provider.of<CategoryRepository>(context, listen: false);
    
    return BottomAppBar(
      child: Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to the 'Konto' screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => LogoutPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {
                // Navigate to the 'Wiadomości' screen
                Navigator.push(context, MaterialPageRoute(builder: (context) => EkranGlowny()));
              },
            ),
            IconButton(
              icon: Icon(Icons.align_vertical_bottom),
              onPressed: () {
                // Navigate to the 'Rankingi' screen and pass the repository
                Navigator.push(context, MaterialPageRoute(builder: (context) => Ranking()));
              },
            ),
          ],
        );
      }),
    );
  }
}


// import 'package:dyplom/glowny_screen/glowny_screen.dart';
// import 'package:dyplom/ranking_screen/ranking_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:dyplom/theme/theme.dart';
// import 'package:provider/provider.dart';
// import 'package:dyplom/tresc_screen/Category.dart';
// import 'package:dyplom/tresc_screen/CategoryRepository.dart';



// class CustomBottomNavigationBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     //theme: themeNotifier.currentTheme,
//     //final themeNotifier = ThemeProvider.of(context);
//     return BottomAppBar(child:
//         Consumer<ThemeNotifier>(builder: (context, themeNotifier, child) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             icon: Icon(Icons.person),
//             onPressed: () {
//               // Navigate to the 'Konto' screen
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => EkranGlowny()));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.message),
//             onPressed: () {
//               // Navigate to the 'Wiadomości' screen
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => EkranGlowny()));
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.align_vertical_bottom),
//             onPressed: () {
//               // Navigate to the 'Rankingi' screen
//               Navigator.push(context,
//                   MaterialPageRoute(
//                     //builder: (context) => RankingScreen(repository: null,)
//                     builder: (context) => RankingScreen(repository: repository),
//                   ));
//             },
//           ),
//         ],
//       );
//     }));
//   }
// }
