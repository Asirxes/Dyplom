// class RatingModel {
//   String itemName;
//   double rating;

//   RatingModel(this.itemName, this.rating);
// }

class RatingModel {
  final String itemName;
  final double rating;
  final double averageRating; // Add averageRating field

  RatingModel(this.itemName, this.rating, this.averageRating);
  //RatingModel(this.itemName, this.averageRating);
}