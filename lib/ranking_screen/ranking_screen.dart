import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dyplom/AppBar/BottomNavigationBar.dart';
import 'package:dyplom/main.dart';
import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';

class RankingScreen extends StatefulWidget {
  final CategoryType selectedCategory;

  RankingScreen({required this.selectedCategory});

  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final CategoryRepository repository = CategoryRepository();

  Future<double> calculateAverageRatingForItem(String itemName) async {
    final firestore = FirebaseFirestore.instance;
    final collection = 'ratings';
    final document = '${widget.selectedCategory.toString()}-$itemName'; // Użyj zmiennej widget do dostępu do selectedCategory

    final documentReference = firestore.collection(collection).doc(document);
    final documentSnapshot = await documentReference.get();

    if (documentSnapshot.exists) {
      final List<dynamic> ratings = documentSnapshot.data()?['ratings'] ?? [];
      if (ratings.isNotEmpty) {
        double totalRating = 0;
        for (var rating in ratings) {
          totalRating += rating['rating'];
        }
        double averageRating = totalRating / ratings.length;
        print('Item: $itemName, Average Rating: $averageRating');
        return averageRating;
      }
    }

    return 0; // Domyślna wartość, jeśli nie ma ocen
  }

  Widget buildRatingStars(double averageRating) {
    int numberOfStars = averageRating.round();

    return Row(
      children: List.generate(
        5,
        (index) => Icon(
          index < numberOfStars ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
      ),
    );
  }

  String getCategoryTitle(CategoryType categoryType) {
    switch (categoryType) {
      case CategoryType.Kierunki:
        return 'Kierunków';
      // Dodaj pozostałe kategorie
      case CategoryType.Uczelnie:
        return 'Uczelni';
      case CategoryType.Przedmioty:
        return 'Przedmiotów';
      case CategoryType.Wydzialy:
        return 'Wydziałów';

      default:
        return ':)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> items = repository.categories
        .firstWhere((category) => category.type == widget.selectedCategory) // Użyj zmiennej widget do dostępu do selectedCategory
        .items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking ${getCategoryTitle(widget.selectedCategory)}'),
        //title: Text('Rabking Kierunków'),
      ),
      body: FutureBuilder(
        future: _loadRatings(items), // Wywołaj funkcję ładowania ocen dla przedmiotów
        builder: (BuildContext context, AsyncSnapshot<List<double>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Wyświetl wskaźnik ładowania, jeśli nadal się ładuje
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]),
                    subtitle: buildRatingStars(snapshot.data![index]),
                  );
                },
              );
            } else {
              return Text('Brak danych'); // Wyświetl komunikat, jeśli brak danych
            }
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

 Future<List<double>> _loadRatings(List<String> items) async {
  List<Map<String, dynamic>> ratingsData = [];

  for (var item in items) {
    double averageRating = await calculateAverageRatingForItem(item);
    ratingsData.add({'item': item, 'rating': averageRating});
  }

  ratingsData.sort((a, b) => b['rating'].compareTo(a['rating'])); // Sortowanie malejąco

  List<double> sortedRatings = ratingsData.map((data) => data['rating'] as double).toList();

  return sortedRatings;
}

}
