import 'package:CaloriesBuddy/models/tag.dart';

class Food {
  final String name;
  final String detail;
  final String type;
  final String image;
  final int calories;
  final int carbohydrate;
  final int protein;
  final int fat;
  List<Tag> tags = [];

  Food({required this.name,required this.detail,required this.type,required this.image,required this.calories,required this.carbohydrate,required this.protein,required this.fat, required this.tags});
}