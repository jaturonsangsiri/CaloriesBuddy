import 'package:flutter/material.dart';
import 'package:calories_buddy/models/food/food.dart';

class MealResponse {
  bool? success;
  String? message;
  List<Meals>? mealsList;

  MealResponse({this.success, this.message, this.mealsList});

  MealResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      mealsList = (json['data'] as List)
          .map((item) => Meals.fromJson(item as Map<String, dynamic>))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (mealsList != null) {
      data['data'] = mealsList!.map((meal) => {
        'id': meal.id,
        'name': meal.name,
        'type': meal.type,
        // You may want to add foods serialization here if needed
      }).toList();
    }
    return data;
  }
}

class Meals {
  String? id;
  String? name;
  String? type;
  IconData? icon;
  List<Food>? foods;

  Meals({
    required this.id,
    required this.name,
    required this.type,
    required this.icon,
    required this.foods
  });

  static Map switchMealType(String meal) {
    switch (meal.toUpperCase()) {
      case 'BREAKFAST':
        return {'name': 'มื้อเช้า','icon': Icons.wb_sunny};
      case 'LUNCH':
        return {'name': 'มื้อกลางวัน', 'icon': Icons.wb_cloudy};
      case 'DINNER':
        return {'name': 'มื้อเย็น', 'icon': Icons.nightlight_round};
      case 'SNACKS':
        return {'name': 'ของว่าง', 'icon': Icons.coffee};
      case 'LATE_NIGHT':
        return {'name': 'มื้อดึก', 'icon': Icons.bedtime};
      default:
        return {'name': 'อื่นๆ', 'icon': Icons.help_outline_sharp};
    }
  }

  Meals.fromJson(Map<String, dynamic> json) {
    Map types = switchMealType(json['type']?.toString() ?? '');

    id = json['id']?.toString() ?? '';
    name = types['name']?.toString() ?? '';
    icon = types['icon'];
    type = json['type']?.toString() ?? '';
    if (json['mealItems'] != null && json['mealItems'] is List) {
      foods = (json['mealItems'] as List)
          .map((item) => Food(
                name: item['name']?.toString(),
                description: item['description']?.toString(),
                type: item['type']?.toString(),
                image: item['image']?.toString(),
                calories: item['calories'],
                carb: item['carb'],
                protein: item['protein'],
                fat: item['fat'],
                tags: []
              ))
          .toList();
    } else {
      foods = [];
    }
  }
}