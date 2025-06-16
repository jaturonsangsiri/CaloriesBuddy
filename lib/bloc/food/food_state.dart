part of 'food_bloc.dart';

class FoodState extends Equatable {
  final List<Food> foodList;
  final List<Food> showList;
  const FoodState({
    this.foodList = const [],
    this.showList = const []
  });

  FoodState copyWidth({List<Food>? foodList, List<Food>? showList}) {
    return FoodState(foodList: foodList ?? this.foodList, showList: showList ?? this.showList);
  }

  @override
  List<Object> get props => [foodList, showList];
}
