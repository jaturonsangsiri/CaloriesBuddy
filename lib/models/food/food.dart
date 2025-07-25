import 'package:calories_buddy/models/tag.dart';

class Food {
  String? name;
  String? description;
  String? type;
  String? image;
  num? calories;
  num? carb;
  num? protein;
  num? fat;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? updatedBy;
  List<Tag> tags = [];

  Food({required name,required description,required type,required image,required calories,required carb,required protein,required fat, required tags});

  Food.fromJson(Map<String?, dynamic> json) {
    name = json['name'];
    description = json['description'];
    type = json['type'];
    image = json['image'];
    calories = json['calories'];
    carb = json['carb'];
    protein = json['protein'];
    fat = json['fat'];
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['type'] = type;
    data['image'] = image;
    data['calories'] = calories;
    data['carb'] = carb;
    data['protein'] = protein;
    data['fat'] = fat;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['updatedBy'] = updatedBy;
    return data;
  }
}