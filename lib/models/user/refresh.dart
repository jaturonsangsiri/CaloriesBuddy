// Refresh Token Model data class
class RefreshToken {
  String? message;
  bool? success;
  Token? data;

  RefreshToken({this.message, this.success, this.data});

  // Get data from JSON Format (Json to Data)
  RefreshToken.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? Token.fromJson(json['data']) : null;
  }

  // Get Json to Data (Data to Json)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data?.toJson();
    }
    return data;
  }
}

// Token Model data class
class Token {
  String? token;
  String? refreshToken;

  Token({this.token, this.refreshToken});

  // Get data from JSON Format (Json to Data)
  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  // Get Json to Data (Data to Json)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    return data;
  }
}