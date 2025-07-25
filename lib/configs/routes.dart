import 'package:calories_buddy/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:calories_buddy/pages/home_page.dart';

class Routes {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState = GlobalKey<ScaffoldMessengerState>();
  static const home = '/';
  static const login = '/login';
  static const register = '/register';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    login: (context) => const LoginPage(),
    home: (context) => const HomePage()
  };
}