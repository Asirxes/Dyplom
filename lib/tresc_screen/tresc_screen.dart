import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:dyplom/theme/theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrescScreen extends StatefulWidget {
  const TrescScreen({super.key});

  @override
  State<TrescScreen> createState() => _TrescScreenState();
}


// class _TrescScreenState extends State<TrescScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Treść'),
//       ),
//       );

//   }
// }

class _TrescScreenState extends State<TrescScreen> {
  late List<String> items = [
    'Administracja',
    'Advanced Materials and Nanotechnology',
    'Amerykanistyka',
    'Analityka medyczna',
    'Archeologia',
    'Astrofizyka i kosmologia',
    'Astronomia',
    'Bezpieczeństwo narodowe',
    'Biochemia',
    'Biofizyka',
    'Biofizyka molekularna i komórkowa',
    'Informatyka',
    'Psychologia',
    'Zarządzanie',
    'Prawo',
    'Ekonomia',
    'Finanse i rachunkowość',
    'Budownictwo',
    'Logistyka',
    'Fizjoterapia',
    'Pielęgniarstwo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        prototypeItem: ListTile(
          title: Text(items.first),
        ),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              print('Klik');
            },
            title: Align(
              alignment: Alignment.center,
              // child: Text(items[index]),
             // child: const ContentTile(category: null,),
            ),
          );
        },
      ),
    );
  }
}

class ContentTile extends StatelessWidget {
  const ContentTile({
    super.key, required Category category,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(children: [
        
        const SizedBox(width: 25.0),
        const Text('Test'),
        const SizedBox(width: 125.0),
        RatingBar.builder(
            itemSize: 25.0,
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, _) => const Icon(Icons.star),
            onRatingUpdate: (rating) {
              print(rating);
            }),
      ]),
    );
  }
}