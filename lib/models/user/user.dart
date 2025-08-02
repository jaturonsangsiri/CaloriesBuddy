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
  String? name;
  String? pic;
  String? role;
  String? id;
  String? accName;
  String? password;
  num? carbohydrate;
  num? maxCabohydrate;
  num? protien;
  num? maxProtien;
  num? fat;
  num? maxFat;
  num? calories;
  num? tdee;
  bool? loading;
  bool? error;
  num? weight;
  num? height;
  num? age;
  String? gender;

  UserData({this.name, this.pic, this.role, this.id, this.accName, this.carbohydrate, this.maxCabohydrate, this.protien, this.maxProtien, this.fat, 
  this.maxFat, this.calories, this.tdee, this.weight, this.height, this.age, this.gender, this.loading, this.error});

  UserData.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    accName = json['accName'];
    name = json['name'];
    pic = json['pic'];
    role = json['role'];
    carbohydrate = json['carbohydrate'];
    maxCabohydrate = json['maxCabohydrate'];
    protien = json['protien'];
    maxProtien = json['maxProtien'];
    fat = json['fat'];
    maxFat = json['maxFat'];
    calories = json['calories'];
    tdee = json['tdee'];
    weight = json['weight'];
    height = json['height'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accName'] = accName;
    data['name'] = name;
    data['pic'] = pic;
    data['role'] = role;
    data['carbohydrate'] = carbohydrate;
    data['maxCabohydrate'] = maxCabohydrate;
    data['protien'] = protien;
    data['maxProtien'] = maxProtien;
    data['fat'] = fat;
    data['maxFat'] = maxFat;
    data['calories'] = calories;
    data['tdee'] = tdee;
    data['weight'] = weight;
    data['height'] = height;
    data['age'] = age;
    data['gender'] = gender;
    return data; 
  }
}