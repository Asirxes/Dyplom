// import 'package:dyplom/main.dart';
// import 'package:dyplom/ranking_screen/RatingModel.dart';
// import 'package:dyplom/tresc_screen/Category.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Kierunki(),
//   ));
// }

// class Kierunki extends StatelessWidget {
//   final CategoryRepository repository = CategoryRepository();
//   final CategoryType selectedCategory = CategoryType.Kierunki; // Zmień na wybraną kategorię

//   // Funkcja do zapisu oceny użytkownika w bazie danych Firestore
//   Future<void> saveRatingToFirestore(CategoryType categoryType, String itemName, double rating) async {
//     await Firebase.initializeApp(); // Upewnij się, że Firebase jest zainicjowane.
//     final firestore = FirebaseFirestore.instance;

//     // Tworzenie referencji do odpowiedniej kolekcji i dokumentu
//     final collection = 'ratings'; // Możesz dostosować nazwę kolekcji
//     final document = '$categoryType-$itemName'; // Unikalny identyfikator dla każdego elementu

//     // Zapis oceny do bazy danych
//     await firestore.collection(collection).doc(document).set({
//       'categoryType': categoryType.toString(),
//       'itemName': itemName,
//       'rating': rating,
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<String> items = repository.categories
//         .firstWhere((category) => category.type == selectedCategory,
//             orElse: () => Category(selectedCategory, '', [], []))
//         .items;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Category: ${selectedCategory.toString()}'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text(items[index]),
//             subtitle: RatingBar.builder(
//               itemSize: 25.0,
//               initialRating: repository.categories
//                   .firstWhere((category) => category.type == selectedCategory)
//                   .ratings
//                   .firstWhere(
//                     (rating) => rating.itemName == items[index],
//                     orElse: () => RatingModel(items[index], 0.0),
//                   )
//                   .rating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//               itemBuilder: (context, _) => const Icon(Icons.star),
//               onRatingUpdate: (rating) {
//                 final ratingModel = RatingModel(items[index], rating);
//                 final selectedCategoryIndex = repository.categories
//                     .indexWhere((category) => category.type == selectedCategory);
//                 if (selectedCategoryIndex != -1) {
//                   int itemIndex = repository.categories[selectedCategoryIndex].ratings
//                       .indexWhere((r) => r.itemName == items[index]);
//                   if (itemIndex != -1) {
//                     repository.categories[selectedCategoryIndex].ratings[itemIndex] = ratingModel;
//                   } else {
//                     repository.categories[selectedCategoryIndex].ratings.add(ratingModel);
//                   }

//                   // Zapisz ocenę użytkownika w bazie danych Firestore
//                   saveRatingToFirestore(selectedCategory, items[index], rating);
//                 }
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



//-----------------
import 'package:dyplom/main.dart';
import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MaterialApp(
    home: Kierunki(),
  ));
}

class Kierunki extends StatelessWidget {
  final CategoryRepository repository = CategoryRepository();
  final CategoryType selectedCategory = CategoryType.Kierunki;

  Future<void> saveRatingToFirestore(CategoryType categoryType, String itemName, double rating) async {
    //await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case where the user is not authenticated.
      return;
    }

    final collection = 'ratings';
    final document = '$categoryType-$itemName';

    await firestore.collection(collection).doc(document).set({
      'categoryType': categoryType.toString(),
      'itemName': itemName,
      'rating': rating,
      'userId': user.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = repository.categories
        .firstWhere((category) => category.type == selectedCategory,
        orElse: () => Category(selectedCategory, '', [], []))
        .items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Category: ${selectedCategory.toString()}'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            subtitle: RatingBar.builder(
              itemSize: 25.0,
              initialRating: repository.categories
                  .firstWhere((category) => category.type == selectedCategory)
                  .ratings
                  .firstWhere(
                    (rating) => rating.itemName == items[index],
                    orElse: () => RatingModel(items[index], 0.0),
                  )
                  .rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(Icons.star),
              onRatingUpdate: (rating) {
                final ratingModel = RatingModel(items[index], rating);
                final selectedCategoryIndex = repository.categories
                    .indexWhere((category) => category.type == selectedCategory);
                if (selectedCategoryIndex != -1) {
                  int itemIndex = repository.categories[selectedCategoryIndex].ratings
                      .indexWhere((r) => r.itemName == items[index]);
                  if (itemIndex != -1) {
                    repository.categories[selectedCategoryIndex].ratings[itemIndex] = ratingModel;
                  } else {
                    repository.categories[selectedCategoryIndex].ratings.add(ratingModel);
                  }

                  saveRatingToFirestore(selectedCategory, items[index], rating);
                }
              },
            ),
          );
        },
      ),
    );
  }
}
