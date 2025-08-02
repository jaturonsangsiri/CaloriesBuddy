part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends UserEvent {
  final String? display;
  final String? pic;
  final String? role;
  final String? id;
  final String? username;
  final bool? loading;
  final bool? error;
  final num? carbohydrate;
  final num? maxCabohydrate;
  final num? protien;
  final num? maxProtien;
  final num? fat;
  final num? maxFat;
  final num? calories;
  final num? tdee;
  final num? weight;
  final num? height;
  final num? age;
  final String? gender;

  const GetUser({this.display, this.pic, this.role, this.id, this.username, this.loading, this.error = false, this.carbohydrate, this.maxCabohydrate, this.protien, this.maxProtien,
   this.fat, this.maxFat, this.calories, this.tdee, this.weight, this.height, this.age, this.gender
  });

  @override
  List<Object> get props => [display!, pic!, role!, id!, username!, loading!, error!, carbohydrate!, maxCabohydrate!, protien!, maxProtien!, fat!, maxFat!, calories!, tdee!, weight!, height!, age!, gender!];
}

class SetUser extends UserEvent {
  final bool? loading;
  final num? tdee;
  final num? maxCabohydrate;
  final num? maxProtien;
  final num? maxFat;

  const SetUser({this.loading, this.tdee, this.maxCabohydrate, this.maxProtien, this.maxFat});

  @override
  List<Object> get props => [loading!, maxCabohydrate!, maxProtien!, maxFat!, tdee!];
}

class SetError extends UserEvent {
  final bool error;
  const SetError(this.error);

  @override
  List<Object> get props => [error];
}

class RemoveUser extends UserEvent {}