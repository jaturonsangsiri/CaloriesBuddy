import 'package:flutter/material.dart';
import 'package:calories_buddy/models/food/food.dart';

class Meals {
  final String name;
  final IconData icon;
  final List<Food> foods;

  Meals({
    required this.name,
    required this.icon,
    this.foods = const [],
  });
}