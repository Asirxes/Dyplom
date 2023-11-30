import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/main.dart';
import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MaterialApp(
    home: Uczelnie(),
  ));
}

class Uczelnie extends StatelessWidget {
  final CategoryRepository repository = CategoryRepository();
  final CategoryType selectedCategory = CategoryType.Uczelnie; // Zmień na wybraną kategorię

  Future<void> saveRatingToFirestore(CategoryType categoryType, String itemName, double rating) async {
    final firestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return;
    }

    final collection = 'ratings';
    final document = '$categoryType-$itemName';

     final documentReference = firestore.collection(collection).doc(document);

  // await firestore.collection(collection).doc(document).set({
  //   'categoryType': categoryType.toString(),
  //   'itemName': itemName,
  //   'rating': rating,
  //   'userId': user.uid,
  // });

  // Sprawdzenie, czy użytkownik już ocenił ten przedmiot
  final existingData = await documentReference.get();

  if (existingData.exists) {
    final List<dynamic> ratings = existingData.data()?['ratings'] ?? [];
    final userHasRated = ratings.any((ratingData) => ratingData['userId'] == user.uid);

    if (userHasRated) {
      // Użytkownik już ocenił ten przedmiot, możesz tu podjąć odpowiednie działania
      print('Użytkownik już ocenił ten przedmiot.');
      return;
    }
  }

  // Dodanie nowej oceny do listy w Firestore
  await documentReference.update({
    'ratings': FieldValue.arrayUnion([
      {
        'rating': rating,
        'userId': user.uid,
      }
    ])
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
        //title: Text('Category: ${selectedCategory.toString()}'),
        title: Text('Oceń Uczelnie'),
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
                    orElse: () => RatingModel(items[index], 0.0, 0.0),
                  )
                  .rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) => const Icon(Icons.star),
              onRatingUpdate: (rating) {
                final ratingModel = RatingModel(items[index], rating, 0.0);
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
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}