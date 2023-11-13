import 'package:dyplom/ranking_screen/RatingModel.dart';

enum CategoryType {
  Uczelnie,
  Wydzialy,
  Kierunki,
  Przedmioty,
}

class Category {
  final CategoryType type;
  final String name;
  List<String> items;
  List<RatingModel> ratings;

  Category(this.type, this.name, this.items, this.ratings);
}

