import 'package:calories_buddy/models/food/food_response.dart';
import 'package:calories_buddy/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:calories_buddy/models/food/food.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final api = APIService();
  APIService apiService = APIService();

  FoodBloc() : super(FoodState()) {
    on<GetFoodList>(_onGetFoodList);
    on<FilterFood>(_onFilterFood);
    on<SetFood>(_onSetFood);
  }

  void _onGetFoodList(GetFoodList event, Emitter<FoodState> emit) {
    emit(state.copyWidth(
      showList: event.showList ?? [],
      foodList: event.foodList ?? [],
    ));
  }

  void _onFilterFood(FilterFood event, Emitter<FoodState> emit) {
    emit(state.copyWidth(
      showList: event.showList ?? [],
    ));
  }

  void _onSetFood(SetFood event, Emitter<FoodState> emit) async {
    try {
      final foods = await api.getAllFoods();
      emit(state.copyWidth(
        foodList: event.foodList ?? foods,
        showList: event.showList ?? foods,
      ));
    } catch (e) {
      throw Exception('Error setting food: $e');
    }
  }
}
