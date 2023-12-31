// import 'package:dyplom/main.dart';
// import 'package:dyplom/ranking_screen/ContentTile1.dart';
// import 'package:dyplom/ranking_screen/RatingModel.dart';
// import 'package:dyplom/tresc_screen/Category.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class RankingScreen extends StatelessWidget {
//   final CategoryRepository repository;
//   //final CategoryRepository repository = CategoryRepository();
//   final CategoryType selectedCategory = CategoryType.Wydzialy; 

//   RankingScreen({required this.repository});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ratings'),
//       ),
//       body: ListView.builder(
//         itemCount: repository.categories.length,
//         itemBuilder: (context, index) {
//           final category = repository.categories[index];
//           return ContentTile1(category: category);
//           //return ContentTile1(category: category);
//         },
//       ),
//     );
//   }
// }




import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RankingScreen extends StatefulWidget {
  final CategoryType selectedCategory; // Wybrana kategoria

  RankingScreen({required this.selectedCategory});

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  List<RatingModel> ratings = [];

  @override
  void initState() {
    super.initState();
    // Zainicjowanie Firebase, jeśli jeszcze nie zostało zainicjowane
    Firebase.initializeApp();
    loadRatings();
  }

  Future<void> loadRatings() async {
    final loadedRatings = await getRatingsForCategory(widget.selectedCategory);
    if (loadedRatings != null) {
      setState(() {
        ratings = loadedRatings;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category: ${widget.selectedCategory.toString()}'),
      ),
      body: ratings.isEmpty
          ? Center(child: Text('Brak dostępnych ocen.'))
          : ListView.builder(
              itemCount: ratings.length,
              itemBuilder: (context, index) {
                final rating = ratings[index];
                return ListTile(
                  title: Text(rating.itemName),
                  subtitle: RatingBar.builder(
                    itemSize: 25.0,
                    initialRating: rating.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, _) => const Icon(Icons.star),
                    onRatingUpdate: (newRating) {
                      // Tutaj możesz dodać obsługę aktualizacji oceny
                    },
                  ),
                );
              },
            ),
    );
  }
}




Future<List<RatingModel>> getRatingsForCategory(CategoryType categoryType) async {
  await Firebase.initializeApp(); 
  final firestore = FirebaseFirestore.instance;

  final collection = 'ratings'; // To musi być taka sama nazwa, jak w kodzie zapisu oceny

  // Wykonanie zapytania do Firestore
  final querySnapshot = await firestore.collection(collection)
      .where('categoryType', isEqualTo: categoryType.toString())
      .orderBy('rating', descending: true) // Sortowanie od najlepiej ocenianego do najgorszego
      .get();

  // Konwersja wyników na obiekty RatingModel
  final ratings = querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    final itemName = data['itemName'];
    final rating = data['rating'];
    return RatingModel(itemName, rating);
  }).toList();

  return ratings;
}


