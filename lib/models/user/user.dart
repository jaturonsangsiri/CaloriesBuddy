class UserResponse {
  String? message;
  bool? success;
  UserData? data;

  UserResponse({this.message, this.success, this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class UserData {
  String? display;
  String? pic;
  String? role;
  String? id;
  String? username;
  String? password;
  double? carbohydrate;
  double? maxCabohydrate;
  double? protien;
  double? maxProtien;
  double? fat;
  double? maxFat;
  double? calories;
  double? maxCalories;

  UserData({required this.display, required this.pic, required this.role, required this.id, required this.username, required this.carbohydrate, required this.maxCabohydrate, required this.protien, required this.maxProtien, required this.fat, required this.maxFat, required this.calories, required this.maxCalories});

  UserData.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    username = json['username'];
    display = json['display'];
    pic = json['pic'];
    role = json['role'];
    carbohydrate = json['carbohydrate'];
    maxCabohydrate = json['maxCabohydrate'];
    protien = json['protien'];
    maxProtien = json['maxProtien'];
    fat = json['fat'];
    maxFat = json['maxFat'];
    calories = json['calories'];
    maxCalories = json['maxCalories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['display'] = display;
    data['pic'] = pic;
    data['role'] = role;
    data['carbohydrate'] = carbohydrate;
    data['maxCabohydrate'] = maxCabohydrate;
    data['protien'] = protien;
    data['maxProtien'] = maxProtien;
    data['fat'] = fat;
    data['maxFat'] = maxFat;
    data['calories'] = calories;
    data['maxCalories'] = maxCalories;
    return data; 
  }
}