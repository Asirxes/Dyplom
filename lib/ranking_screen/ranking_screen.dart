import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:dyplom/theme/theme.dart';

class RankingScreen extends StatefulWidget {
  const RankingScreen({super.key});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  @override
  Widget build(BuildContext context) {
    //final themeNotifier = Provider.of<ThemeNotifier>(context);

    return const Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Text(
          'Ranking',
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
      ),
    );

  }
}



