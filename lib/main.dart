import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calories_buddy/app.dart';
import 'package:calories_buddy/bloc/exercises/exercises_bloc.dart';
import 'package:calories_buddy/bloc/food/food_bloc.dart';
import 'package:calories_buddy/bloc/meal/meal_bloc.dart';
import 'package:calories_buddy/bloc/theme/theme_bloc.dart';
import 'package:calories_buddy/bloc/user/user_bloc.dart';

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