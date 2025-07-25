part of 'food_bloc.dart';

sealed class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class GetFoodList extends FoodEvent {
  final List<Food>? foodList;
  final List<Food>? showList;

  const GetFoodList({this.foodList, this.showList});

  @override
  List<Object> get props => [foodList!, showList!];
}

class FilterFood extends FoodEvent {
  final List<Food>? showList;

  const FilterFood({this.showList});

  @override
  List<Object> get props => [showList!];
}

class SetFood extends FoodEvent {
  final List<Food>? foodList;
  final List<Food>? showList;

  const SetFood({this.foodList, this.showList});
}