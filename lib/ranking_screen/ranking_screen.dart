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

//--------------------------------------------------------------------


// import 'package:dyplom/AppBar/BottomNavigationBar.dart';
// import 'package:dyplom/ranking_screen/RatingModel.dart';
// import 'package:dyplom/tresc_screen/Category.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// class RankingScreen extends StatefulWidget {
//   final CategoryType selectedCategory; // Wybrana kategoria

//   RankingScreen({required this.selectedCategory});

//   @override
//   _RankingScreenState createState() => _RankingScreenState();
// }

// class _RankingScreenState extends State<RankingScreen> {
//   List<RatingModel> ratings = [];

//   @override
//   void initState() {
//     super.initState();
//     // Zainicjowanie Firebase, jeśli jeszcze nie zostało zainicjowane
//     Firebase.initializeApp();
//     loadRatings();
//   }

//   Future<void> loadRatings() async {
//     final loadedRatings = await getRatingsForCategory(widget.selectedCategory);
//     if (loadedRatings != null) {
//       setState(() {
//         ratings = loadedRatings;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Category: ${widget.selectedCategory.toString()}'),
//       ),
//       body: ratings.isEmpty
//           ? Center(child: Text('Brak dostępnych ocen.'))
//           : ListView.builder(
//               itemCount: ratings.length,
//               itemBuilder: (context, index) {
//                 final rating = ratings[index];
//                 return ListTile(
//                   title: Text(rating.itemName),
//                   subtitle: RatingBar.builder(
//                     itemSize: 25.0,
//                     initialRating: rating.rating,
//                     minRating: 1,
//                     direction: Axis.horizontal,
//                     allowHalfRating: true,
//                     itemCount: 5,
//                     itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//                     itemBuilder: (context, _) => const Icon(Icons.star),
//                     onRatingUpdate: (newRating) {
//                       // Tutaj możesz dodać obsługę aktualizacji oceny
//                     },
//                   ),
//                 );
//               },
//             ),
//             bottomNavigationBar: CustomBottomNavigationBar(),
//     );
//   }
// }

// Future<List<RatingModel>> getRatingsForCategory(CategoryType categoryType) async {
//   await Firebase.initializeApp(); 
//   final firestore = FirebaseFirestore.instance;

//   final collection = 'ratings'; // To musi być taka sama nazwa, jak w kodzie zapisu oceny

//   // Wykonanie zapytania do Firestore
//   final querySnapshot = await firestore.collection(collection)
//       .where('categoryType', isEqualTo: categoryType.toString())
//       .orderBy('rating', descending: true) // Sortowanie od najlepiej ocenianego do najgorszego
//       .get();

//   // Konwersja wyników na obiekty RatingModel
//   final ratings = querySnapshot.docs.map((doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     final itemName = data['itemName'];
//     final rating = data['rating'];
//     return RatingModel(itemName, rating);
//   }).toList();

//   return ratings;
// }



import 'package:dyplom/AppBar/BottomNavigationBar.dart';
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
  double averageRating = 0.0; // Dodaj zmienną przechowującą średnią ocen
  List<RatingModel> ratings = [];

  @override
  void initState() {
    super.initState();
    // Zainicjowanie Firebase, jeśli jeszcze nie zostało zainicjowane
    Firebase.initializeApp();
    loadAverageRating();
    loadRatings();
  }

  Future<void> loadAverageRating() async {
    final average = await getAverageRatingForCategory(widget.selectedCategory);
    setState(() {
      averageRating = average;
    });
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          averageRating == 0.0
              ? Center(child: Text('Brak dostępnych ocen.'))
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Średnia ocena: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    RatingBar.builder(
                      itemSize: 25.0,
                      initialRating: averageRating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        //color: Colors.amber,
                      ),
                      onRatingUpdate: (newRating) {
                        // Tutaj możesz dodać obsługę aktualizacji oceny
              },
                    ),
                  ],
                ),
        ],
        ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

Future<double> getAverageRatingForCategory(CategoryType categoryType) async {
  await Firebase.initializeApp(); 
  final firestore = FirebaseFirestore.instance;

  final collection = 'ratings'; 

  // Wykonanie zapytania do Firestore
  final querySnapshot = await firestore.collection(collection)
      .where('categoryType', isEqualTo: categoryType.toString())
      .orderBy('rating', descending: true)
      .get();

  // Obliczanie średniej oceny
  if (querySnapshot.docs.isNotEmpty) {
    final totalRating = querySnapshot.docs.fold(
      0.0,
      (previousValue, doc) => previousValue + (doc.data() as Map<String, dynamic>)['rating'],
    );

    final averageRating = totalRating / querySnapshot.docs.length;

    return averageRating;
  }

  // Jeśli nie ma ocen, zwróć 0
  return 0.0;
}

Future<List<RatingModel>> getRatingsForCategory(CategoryType categoryType) async {
  //await Firebase.initializeApp(); //-----------------------------------------------
  final firestore = FirebaseFirestore.instance;

  final collection = 'ratings'; 

  // Wykonanie zapytania do Firestore
  final querySnapshot = await firestore.collection(collection)
      .where('categoryType', isEqualTo: categoryType.toString())
      .orderBy('rating', descending: true)
      .get();

  // Konwersja wyników na obiekty RatingModel
  final ratings = querySnapshot.docs.map((doc) {
    final data = doc.data() as Map<String, dynamic>;
    final itemName = data['itemName'];
    final rating = data['rating'];
    return RatingModel(itemName, rating, 0.0); 
  }).toList();

  return ratings;
}


