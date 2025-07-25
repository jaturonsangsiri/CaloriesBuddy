
import 'dart:convert';

import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/contants/date_time_constants.dart';
import 'package:CaloriesBuddy/configs/routes.dart' as custom_route;
import 'package:CaloriesBuddy/models/login.dart';
import 'package:CaloriesBuddy/models/user/refresh.dart';
import 'package:CaloriesBuddy/services/preference.dart';
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
            print("Role: USER");
            break;
          case "ADMIN":
            print("Role: ADMIN");
            break;
          default:
            print("Role: SUPER_ADMIN");
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
}