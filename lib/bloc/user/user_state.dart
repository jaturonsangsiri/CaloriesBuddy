part of 'user_bloc.dart';

class UserState extends Equatable {
  final String display;
  final String pic;
  final String role;
  final String id;
  final String username;
  final bool loading;
  final bool error;
  final num carbohydrate;
  final num maxCabohydrate;
  final num protien;
  final num maxProtien;
  final num fat;
  final num maxFat;
  final num calories;
  final num tdee;
  final num weight;
  final int height;
  final int age;
  final String gender;

  const UserState({
    this.display = '', this.pic = URL.DEFAULT_PIC, this.role = '', this.id = '', this.username = '', this.loading = true, this.error = false, this.carbohydrate = 0, this.maxCabohydrate = 1, this.fat = 0, this.maxFat = 1, this.protien = 0, this.maxProtien = 1, this.calories = 0, this.tdee = 0,
    this.weight = 0, this.height = 0, this.age = 0, this.gender = ''
  });

  UserState copyWith({String? display, String? pic, String? role, String? id, String? username, bool? loading, bool? error, num? carbohydrate, num? maxCabohydrate, num? fat, num? maxFat, num? protien, num? maxProtien, num? calories, num? tdee, double? weight, int? height,
  int? age, String? gender}) {
    return UserState(
      display: display ?? this.display,
      pic: pic ?? this.pic,
      role: role ?? this.role,
      id: id ?? this.id,
      username: username ?? this.username,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      carbohydrate: carbohydrate ?? this.carbohydrate,
      maxCabohydrate: maxCabohydrate ?? this.maxCabohydrate,
      protien: protien ?? this.protien,
      maxProtien: maxProtien ?? this.maxProtien,
      fat: fat ?? this.fat,
      maxFat: maxFat ?? this.maxFat,
      calories: calories ?? this.calories,
      tdee: tdee ?? this.tdee,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      age: age ?? this.age,
      gender: gender ?? this.gender
    );
  }

  @override
  List<Object> get props => [display, pic, role, id, username, loading, error, carbohydrate, maxCabohydrate, protien, maxProtien, fat, maxFat, calories, tdee, weight, height, age, gender, tdee];
}
