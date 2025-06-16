import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/meal/meal_event.dart';
import 'package:my_cal_track/bloc/meal/meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  MealBloc() : super(MealState()) {
    on<GetMealList>((event, emit) {
      emit(state.copyWidth(
        mealList: event.mealList ?? [],
      ));
    });
  }
}
