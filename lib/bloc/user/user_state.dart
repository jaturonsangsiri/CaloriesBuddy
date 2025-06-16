part of 'user_bloc.dart';

class UserState extends Equatable {
  final String display;
  final String pic;
  final String role;
  final String id;
  final String username;
  final bool error;
  final num carbohydrate;
  final num maxCabohydrate;
  final num protien;
  final num maxProtien;
  final num fat;
  final num maxFat;
  final num calories;
  final num maxCalories;

  const UserState({
    this.display = '', this.pic = '', this.role = '', this.id = '', this.username = '', this.error = false, this.carbohydrate = 0, this.maxCabohydrate = 0, this.fat = 0, this.maxFat = 0, this.protien = 0, this.maxProtien = 0, this.calories = 0, this.maxCalories = 0
  });

  UserState copyWith({String? display, String? pic, String? role, String? id, String? username, bool? error, num? carbohydrate, num? maxCabohydrate, num? fat, num? maxFat, num? protien, num? maxProtien, num? calories, num? maxCalories}) {
    return UserState(
      display: display ?? this.display,
      pic: pic ?? this.pic,
      role: role ?? this.role,
      id: id ?? this.id,
      username: username ?? this.username,
      error: error ?? this.error,
      carbohydrate: carbohydrate ?? this.carbohydrate,
      maxCabohydrate: maxCabohydrate ?? this.maxCabohydrate,
      protien: protien ?? this.protien,
      maxProtien: maxProtien ?? this.maxProtien,
      fat: fat ?? this.fat,
      maxFat: maxFat ?? this.maxFat,
      calories: calories ?? this.calories,
      maxCalories: maxCalories ?? this.maxCalories
    );
  }

  @override
  List<Object> get props => [display, pic, role, id, username, error, carbohydrate, maxCabohydrate, protien, maxProtien, fat, maxFat, calories, maxCalories];
}
