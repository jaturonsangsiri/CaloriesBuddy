import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/app.dart';
import 'package:my_cal_track/bloc/exercises/exercises_bloc.dart';
import 'package:my_cal_track/bloc/food/food_bloc.dart';
import 'package:my_cal_track/bloc/meal/meal_bloc.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/bloc/user/user_bloc.dart';

void main() {
  // ดึง Bloc ทั้งหมดมา
  final foodBloc = BlocProvider<FoodBloc>(create: (context) => FoodBloc());
  final userBloc = BlocProvider<UserBloc>(create: (context) => UserBloc());
  final exerciseBloc = BlocProvider<ExerciseBloc>(create: (context) => ExerciseBloc());
  final mealBloc = BlocProvider<MealBloc>(create: (context) => MealBloc());
  final themeBloc = BlocProvider<ThemeBloc>(create: (context) => ThemeBloc());

  runApp(
    MultiBlocProvider(
      providers: [foodBloc, userBloc, exerciseBloc, mealBloc, themeBloc], 
      child: App()
    ),
  );
}