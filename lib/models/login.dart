class Login {
  String? message;
  bool? success;
  Data? data;

  Login({required this.message, required this.success, required this.data});

  Login.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    data['data'] = this.data?.toJson();
    return data;
  }
}

class Data {
  String? token;
  String? refreshToken;
  String? id;
  String? role;
  String? name;
  String? profileImg;

  Data({required this.token, required this.refreshToken, required this.id, required this.role, required this.name, required this.profileImg});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    id = json['id'];
    role = json['role'];
    name = json['name'];
    profileImg = json['profileImg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['toekn'] = token;
    data['refreshToken'] = refreshToken;
    data['id'] = id;
    data['role'] = role;
    data['name'] = name;
    data['profileImg'] = profileImg;
    return data;  
  }
}