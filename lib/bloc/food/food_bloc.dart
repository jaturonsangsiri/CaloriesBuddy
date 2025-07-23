import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:CaloriesBuddy/models/food.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodState()) {
    on<GetFoodList>((event, emit) {
      emit(state.copyWidth(
        showList: event.showList ?? [],
        foodList: event.foodList ?? [],
      ));
    });
    on<FilterFood>((event, emit) {
      emit(state.copyWidth(
        showList: event.showList ?? [],
      ));
    });
  }
}
