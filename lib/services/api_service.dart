
import 'dart:convert';

import 'package:calories_buddy/contants/contants.dart';
import 'package:calories_buddy/contants/date_time_constants.dart';
import 'package:calories_buddy/configs/routes.dart' as custom_route;
import 'package:calories_buddy/models/food/food.dart';
import 'package:calories_buddy/models/login.dart';
import 'package:calories_buddy/models/user/refresh.dart';
import 'package:calories_buddy/models/user/user.dart';
import 'package:calories_buddy/services/preference.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIService {
  final Dio _dio = Dio();
  final ConfigStorage storage = ConfigStorage();

  /* Setup Interceptor to handle requests and responses.
    Interceptor is a tool that to edit requests
    and responses before they are returned to the application.
  */
  APIService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:(options, handler) async {
        final accessToken = await storage.getAccessToken();
        if (accessToken != null) {
          options.headers["Authorization"] = 'Bearer $accessToken';
        }
        options.baseUrl = URL.BASE_URL;
        options.validateStatus = (status) => status != null && status < 400; // Accept only 2xx and 3xx status codes
        options.headers["Content-Type"] = "application/json"; // Set default content type to JSON
        options.connectTimeout = TimerConstants.CONNECT_TIMEOUT;
        options.receiveTimeout = TimerConstants.RECEIVE_TIMEOUT;
        return handler.next(options);
      },
      onResponse:(response, handler) {
        return handler.next(response);
      },
      onError:(error, handler) async {
        // Check if unauthorized or token expired.
        if (error.response?.statusCode == 401 && !error.requestOptions.path.contains('/auth/refresh')) {
          try {
            // Try to refresh the token
            final newToken = await refreshToken();
            if (newToken != null) {
              final newRequest = error.requestOptions;
              newRequest.baseUrl = URL.BASE_URL;
              newRequest.validateStatus = (status) => status != null && status < 400; // Accept only 2xx and 3xx status codes
              newRequest.headers["Content-Type"] = "application/json"; // Set default content type to JSON
              newRequest.connectTimeout = TimerConstants.CONNECT_TIMEOUT;
              newRequest.receiveTimeout = TimerConstants.RECEIVE_TIMEOUT;

              final response = await _dio.fetch(newRequest);
              return handler.resolve(response);
            // If refresh token fails, clear tokens and redirect to login
            } else {
              await storage.clearToken();
              custom_route.Routes.navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
              return;
            }
          // If refresh token fails, clear tokens and redirect to login
          } catch (err) {
            await storage.clearToken();
            custom_route.Routes.navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
            return;
          }
        }

        return handler.next(error);
      },
    ));
  }

  Future<String?> refreshToken() async {
    try {
      final String? refreshToken = await storage.getRefreshToken();
      if (refreshToken == null) {
        throw Exception("No refresh token found");
      }
      final Response response = await _dio.post('/users/refresh', data: {'token': refreshToken});
      RefreshToken token = RefreshToken.fromJson(json.decode(response.data));
      await storage.saveTokens(token.data!.token!, refreshToken);
      return token.data!.token!;
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error);
    }
  }

  Future<Login> checkLogin(String username, String password) async {
    try {
      final Response response = await _dio.post('/users/login', data: {'username': username, 'password': password});
      if (response.statusCode != 200) {
        Login user = Login.fromJson(json.decode(jsonEncode(response.data)));
        await storage.saveTokens(user.data!.token!, user.data!.refreshToken!);

        switch(user.data!.role) {
          case "USER":
            if (kDebugMode) print("Role: USER");
            break;
          case "ADMIN":
            if (kDebugMode) print("Role: ADMIN");
            break;
          default:
            if (kDebugMode) print("Role: SUPER_ADMIN");
            break;
        }

        await storage.saveUser(user.data!.id!, user.data!.role!);
        //await _tokenStorage.setNotification(true);

        return user;
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.response?.data['message'] ?? error);
      throw Exception(error.response?.data['message'] ?? 'Unknown error occurred');
    } 
  }

  Future<UserResponse> getUserProfile(String userId) async {
    try {
      final Response response = await _dio.get('/users/$userId');
      if (response.statusCode == 200) {
        UserResponse user = UserResponse.fromJson(json.decode(response.data));
        return user;
      } else {
        throw Exception('Failed to get user profile');
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error.response?.data['message'] ?? 'Unknown error occurred');
    }
  }

  Future<List<Food>> getAllFoods() async {
    try {
      final Response response = await _dio.get('/foods');
      if (response.statusCode == 200) {
        List jsonList = response.data;
        List<Food> foodList = jsonList.map((foodData) => Food.fromJson(foodData)).toList();
        return foodList;
      } else {
        throw Exception('Failed to get food');
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error.response?.data['message'] ?? 'Unknown error occurred');
    }
  }

  Future<bool> register(String username, String password, String display, String email) async {
    try {
      final Response response = await _dio.post('/users', data: {
        "name": display,
        "accName": username,
        "password": password,
        "email": email,
        "gender": "MALE",
        "age": 0,
        "height": 0,
        "weight": 0,
        "activityLevel": "MEDIUM",
        "goal": "GAIN_WEIGHT",
        "tdee": 0,
        "role": "USER"
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch (error) {
      if (kDebugMode) print(error.message);
      throw Exception(error.response?.data['message'] ?? 'Unknown error occurred');
    }
  }
}