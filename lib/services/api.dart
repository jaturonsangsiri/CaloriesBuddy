import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/contants/date_time_constants.dart';
import 'package:CaloriesBuddy/models/user/refresh.dart';
import 'package:CaloriesBuddy/models/user/user.dart';
import 'package:CaloriesBuddy/services/preference.dart';

class APIService {
  final Dio _dio = Dio();
  final ConfigStorage _tokenStorage = ConfigStorage();
  
  API() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final accessToken = await _tokenStorage.getAccessToken();
        if (accessToken != null) {
          options.headers['Authorization'] = 'Bearer $accessToken';
        }
        options.baseUrl = URL.BASE_URL;
        options.validateStatus = (status) => status != null && status < 400;
        options.headers["Content-Type"] = "application/json";
        options.connectTimeout = DateTimeConstants.CONNECT_TIMEOUT;
        options.receiveTimeout = DateTimeConstants.RECEIVE_TIMEOUT;
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException error, handler) async {
        //if ()
      },
    ));
  }

  Future<UserData?> checkLogin(String username, String password) async {
    try {
      final Response response = await _dio.post('/users/login', data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        UserResponse user = UserResponse.fromJson(json.decode(jsonEncode(response.data)));
        //await _tokenStorage.saveUser(user.data!.id!, user.data!.role!);
        return user.data!;
      } else {  
        throw Exception('Failed to login');
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.response?.data['message'] ?? error);
      throw Exception(error.response?.data['message'] ?? 'Unknown error occurred');
    }
  }

  Future<String?> refreshToken() async {
    try {
      final String? refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token found');
      }
      final Response response = await _dio.post('/users/refresh', data: {'token': refreshToken});
      Refresh token = Refresh.fromJson(json.decode(response.data));
      return token.data!.token!;
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error);
    }
  }

  Future<UserData> getUser() async {
    try {
      // final userId = await _tokenStorage.getUserId();
      // if (userId == null) {
      //   throw Exception('Failed to get user ID');
      // }

      final Response response = await _dio.get('/users/68356b25bbf10f4343bd254a/');
      if (response.statusCode == 200 && response.data != null) {
        UserResponse user = UserResponse.fromJson(json.decode(jsonEncode(response.data)));
        return user.data!; 
      }
      throw Exception('Failed to fetch user data');
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error);
    }
  }

  Future<bool> register(UserData user) async {
    try {
      final Response response = await _dio.post('/users/register', data: {
        'username': user.username,
        'passwrod': user.password
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error);
    }
  }

  Future<bool> updateUser(String userID, UserData user) async {
    try {
      final Response response = await _dio.post('/users/register', data: user);
      if (response.statusCode == 200) {
        UserResponse user = UserResponse.fromJson(json.decode(jsonEncode(response.data)));
        if (kDebugMode) print(user.data!.display);
        return true;
      } else {
        throw Exception('Failed to update user');
      }
    } on DioException catch (error) {
      throw Exception(error);
    }
  }

  Future<bool> deleteUser(String userID) async {
    try {
      final Response response = await _dio.delete('/users/$userID');
      if (response.statusCode! < 400) {
        return true;
      } else {
        throw Exception('Failed to delete user');
      }
    } on DioException catch (error) {
      if(kDebugMode) print(error);
      throw Exception(error);
    }
  }

  Future<bool> changePass(String userID, String password, String newPassword) async {
    try {
      final Response response = await _dio.patch('/users/change-password/$userID', data: {'oldPassword': password, 'password': newPassword});
      if (response.statusCode == 200) {
        return true;
      } else {  
        throw Exception('Failed to change password');
      }
    } catch (error) {
      if(kDebugMode) print(error);
      throw Exception(error);
    }
  }
}