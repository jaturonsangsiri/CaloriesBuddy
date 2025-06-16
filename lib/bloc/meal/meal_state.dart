import 'package:equatable/equatable.dart';
import 'package:my_cal_track/models/meals.dart';

class MealState extends Equatable {
  final List<Meals> mealList;
  const MealState({
    this.mealList = const []
  });

  MealState copyWidth({List<Meals>? mealList}) {
    return MealState(mealList: mealList ?? this.mealList);
  }

  @override
  List<Object> get props => [mealList];
}
