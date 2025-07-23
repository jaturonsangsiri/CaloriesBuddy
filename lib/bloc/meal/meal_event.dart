import 'package:equatable/equatable.dart';
import 'package:CaloriesBuddy/models/meals.dart';

sealed class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class GetMealList extends MealEvent {
  final List<Meals>? mealList;

  const GetMealList({this.mealList});

  @override
  List<Object> get props => [mealList!];
}
