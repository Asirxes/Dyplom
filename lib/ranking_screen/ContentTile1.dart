import 'package:dyplom/ranking_screen/RatingModel.dart';
import 'package:dyplom/tresc_screen/Category.dart';
import 'package:flutter/material.dart';

class ContentTile1 extends StatelessWidget {
  final Category category;

  ContentTile1({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          category.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        for (RatingModel rating in category.ratings)
          ListTile(
            title: Text(rating.itemName),
            subtitle: Text('Rating: ${rating.rating.toStringAsFixed(1)}'),
          ),
      ],
    );
  }
}
