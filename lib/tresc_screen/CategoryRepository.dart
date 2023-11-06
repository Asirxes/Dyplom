import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';

class CategoryRepository extends ChangeNotifier {
  List<Category> categories = [
    Category(CategoryType.Uczelnie, 'Uczelnie', ['Item1', 'Item2'], []), // Initialize an empty ratings list
    Category(CategoryType.Wydzialy, 'Wydziały', [
      'Wydział Budownictwa i Architektury',
      'Wydział Elektrotechniki i Informatyki',
      'Wydział Inżynierii Środowiska',
      'Wydział Mechaniczny',
      'Wydział Matematyki i Informatyki Technicznej',
      'Wydział Zarządzania'
    ], []),
    Category(CategoryType.Kierunki, 'Kierunki', [
      'Budownictwo',
      'Architektura',
      'Elektrotechnika',
      'Informatyka',
      'Inżynierskie zastosowania informatyki w elektrotechnice',
      'Inżynieria multimediów',
      'Inżynieria recyklingu',
      'Inżynieria odnawialnych źródeł energii',
      'Inżynieria środowiska',
      'Energetyka',
      'Mechanika i budowa maszyn',
      'Mechatronika',
      'Zarządzanie i inżynieria produkcji',
      'Transport',
      'Inżynieria biomedyczna',
      'Robotyzacja procesów wytwórczych',
      'Inżynieria pojazdów',
      'Matematyka (studia inżynierskie)',
      'Edukacja techniczno-informatyczna',
      'Inżynieria bezpieczeństwa',
      'Inżynieria i analiza danych',
      'Zarządzanie',
      'Finanse i rachunkowość',
      'Marketing i komunikacja rynkowa',
      'Inżynieria logistyki',
      'Sztuczna inteligencja w biznesie'
    ], []),
    Category(CategoryType.Przedmioty, 'Przedmioty', ['Item7', 'Item8'], []),
  ];

  // Add a method to update ratings for items
  void updateRating(CategoryType categoryType, String itemName, double rating) {
    final categoryIndex = categories.indexWhere((category) => category.type == categoryType);

    if (categoryIndex != -1) {
      final itemIndex = categories[categoryIndex].items.indexOf(itemName);

      if (itemIndex != -1) {
        categories[categoryIndex].ratings.add(RatingModel(itemName, rating));
      }
    }
  }

  // Add a method to remove categories or items
  void removeCategory(CategoryType categoryType) {
    categories.removeWhere((category) => category.type == categoryType);
  }

  void removeItem(CategoryType categoryType, String itemName) {
    final categoryIndex = categories.indexWhere((category) => category.type == categoryType);

    if (categoryIndex != -1) {
      categories[categoryIndex].items.remove(itemName);
    }
  }

  // Add a method to add new categories
  void addNewCategory(CategoryType categoryType, String categoryName, List<String> items) {
    final newCategory = Category(categoryType, categoryName, items, []);
    categories.add(newCategory);
  }
  
}
