part of 'user_bloc.dart';

class UserState extends Equatable {
  final String name;
  final String pic;
  final String role;
  final String id;
  final String accName;
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
  final num height;
  final num age;
  final String gender;

  const UserState({
    this.name = '', this.pic = URL.DEFAULT_PIC, this.role = '', this.id = '', this.accName = '', this.loading = true, this.error = false, this.carbohydrate = 0, this.maxCabohydrate = 1, this.fat = 0, this.maxFat = 1, this.protien = 0, this.maxProtien = 1, this.calories = 0, this.tdee = 0,
    this.weight = 0, this.height = 0, this.age = 0, this.gender = ''
  });

  UserState copyWith({String? name, String? pic, String? role, String? id, String? accName, bool? loading, bool? error, num? carbohydrate, num? maxCabohydrate, num? fat, num? maxFat, num? protien, num? maxProtien, num? calories, num? tdee, num? weight, num? height,
  num? age, String? gender}) {
    return UserState(
      name: name ?? this.name,
      pic: pic ?? this.pic,
      role: role ?? this.role,
      id: id ?? this.id,
      accName: accName ?? this.accName,
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
  List<Object> get props => [name, pic, role, id, accName, loading, error, carbohydrate, maxCabohydrate, protien, maxProtien, fat, maxFat, calories, tdee, weight, height, age, gender, tdee];
}
