// import 'package:dyplom/ranking_screen/RatingModel.dart';
// import 'package:dyplom/tresc_screen/Category.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ContentTile extends StatelessWidget {
//   final Category category;

//   const ContentTile({required this.category, Key? key}) : super(key: key);

//   Future<void> saveRating(CategoryType categoryType, String itemName, double rating) async {
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
//     return Column(
//       children: [
//         Text(category.name,
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//         for (String item in category.items)
//           ListTile(
//             title: Text(item),
//             subtitle: RatingBar.builder(
//               itemSize: 25.0,
//               initialRating: category.ratings
//                   .firstWhere((rating) => rating.itemName == item,
//                       orElse: () => RatingModel(item, 0.0))
//                   .rating,
//               minRating: 1,
//               direction: Axis.horizontal,
//               allowHalfRating: true,
//               itemCount: 5,
//               itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//               itemBuilder: (context, _) => const Icon(Icons.star),
//               onRatingUpdate: (rating) {
//                 final ratingModel = RatingModel(item, rating);
//                 int index =
//                     category.ratings.indexWhere((r) => r.itemName == item);
//                 if (index != -1) {
//                   category.ratings[index] = ratingModel;
//                 } else {
//                   category.ratings.add(ratingModel);
//                 }
//               },
//             ),
//           ),
//       ],
//     );
//   }
// }



import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContentTile extends StatelessWidget {
  final Category category;
  final User? user; // Add a user parameter

  const ContentTile({required this.category, required this.user, Key? key})
      : super(key: key);

  Future<void> saveRating(
      CategoryType categoryType, String itemName, double rating) async {
    //await Firebase.initializeApp(); // Upewnij się, że Firebase jest zainicjowane.
    final firestore = FirebaseFirestore.instance;

    // Tworzenie referencji do odpowiedniej kolekcji i dokumentu
    final collection = 'ratings'; // Możesz dostosować nazwę kolekcji
    final document = '$categoryType-$itemName'; // Unikalny identyfikator dla każdego elementu

    // Zapis oceny do bazy danych
    await firestore.collection(collection).doc(document).set({
      'categoryType': categoryType.toString(),
      'itemName': itemName,
      'rating': rating,
      'userId': user?.uid, // Add the user ID to the document
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(category.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        for (String item in category.items)
          ListTile(
            title: Text(item),
            subtitle: RatingBar.builder(
              itemSize: 25.0,
              initialRating: category.ratings
                  .firstWhere((rating) => rating.itemName == item,
                      orElse: () => RatingModel(item, 0.0))
                  .rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(Icons.star),
              onRatingUpdate: (rating) {
                final ratingModel = RatingModel(item, rating);
                int index =
                    category.ratings.indexWhere((r) => r.itemName == item);
                if (index != -1) {
                  category.ratings[index] = ratingModel;
                } else {
                  category.ratings.add(ratingModel);
                }

                // Call the saveRating method with the user ID
                saveRating(category.type, item, rating);
              },
            ),
          ),
      ],
    );
  }
}
