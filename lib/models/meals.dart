import 'package:flutter/material.dart';
import 'package:my_cal_track/models/food.dart';

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