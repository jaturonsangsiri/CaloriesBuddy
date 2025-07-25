
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:CaloriesBuddy/src/services/firebase_api.dart';

class ConfigStorage {
  //final firebase = FirebaseApi();

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", accessToken);
    await prefs.setString("refresh_token", refreshToken);
  }

  Future<void> saveUser(String userId, String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("userId", userId);
    await prefs.setString("role", role);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("refresh_token");
  }

  Future<bool> getNotification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("notification") ?? false;
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("userId");
  }

  Future<String?> getRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("role");
  }

  Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("theme_app");
  }

  Future<void> setTheme(bool theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("theme_app", theme);
  }

  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    // await setNotification(false);
    // await setDoorNotification(false);
    // await setLegacyNotification(false);
    await prefs.clear();
  }
}
