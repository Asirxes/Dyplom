// class RatingModel {
//   String itemName;
//   double rating;

//   RatingModel(this.itemName, this.rating);
// }


class RatingModel {
  String itemName;
  double rating;
  double averageRating;

  RatingModel(this.itemName, this.rating, this.averageRating);

  // Add a factory constructor to create a RatingModel instance without specifying averageRating
  factory RatingModel.fromMap(Map<String, dynamic> map) {
    return RatingModel(
      map['itemName'] ?? '',
      map['rating'] ?? 0.0,
      map['averageRating'] ?? 0.0,
    );
  }
}