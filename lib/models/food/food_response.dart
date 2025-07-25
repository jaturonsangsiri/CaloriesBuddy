import 'package:calories_buddy/models/food/food.dart';

class FoodResponse {
  String? message;
  bool? success;
  List<FoodData>? data;

  FoodResponse({this.message, this.success, this.data});

  FoodResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? List<FoodData>.from(
      (json['data'] as List).map((item) => FoodData.fromJson(item))
    ) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((food) => food.toJson()).toList();
    }

    return data;
  }
}

class FoodData {
  Food? food;

  FoodData({this.food});

  FoodData.fromJson(Map<String?, dynamic> json) {
    food!.name = json['name'];
    food!.description = json['description'];
    food!.type = json['type'];
    food!.image = json['image'];
    food!.calories = json['calories'];
    food!.carb = json['carb'];
    food!.protein = json['protein'];
    food!.fat = json['fat'];
    food!.createdAt = json['createdAt'];
    food!.updatedAt = json['updatedAt'];
    food!.updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = food!.name;
    data['description'] = food!.description;
    data['type'] = food!.type;
    data['image'] = food!.image;
    data['calories'] = food!.calories;
    data['carb'] = food!.carb;
    data['protein'] = food!.protein;
    data['fat'] = food!.fat;
    data['createdAt'] = food!.createdAt;
    data['updatedAt'] = food!.updatedAt;
    data['updatedBy'] = food!.updatedBy;
    return data;
  }
}