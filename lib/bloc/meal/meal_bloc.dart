import 'package:calories_buddy/services/api_service.dart';
import 'package:calories_buddy/services/preference.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calories_buddy/bloc/meal/meal_event.dart';
import 'package:calories_buddy/bloc/meal/meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final APIService api = APIService();
  final ConfigStorage configStorage = ConfigStorage();

  MealBloc() : super(MealState()) {
    on<GetMealList>(_onGetMeals);
  }

  void _onGetMeals(GetMealList event, Emitter<MealState> emit) async {
    final userId = await configStorage.getUserId();
    final meals = await api.getMeals(userId!);
    emit(state.copyWith(mealList: meals.mealsList));
  }
}
