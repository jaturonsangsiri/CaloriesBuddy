import 'package:flutter/material.dart';

class Responsive {
  static bool isTablet = false;
  static double width = 0;
  static double height = 0;

  static void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    isTablet = mediaQuery.size.width > 700 ? true : false;
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
  } 
}