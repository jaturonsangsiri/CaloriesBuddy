import 'package:flutter/material.dart';

class Responsive {
  bool isTablet = false;
  double width = 0;
  double height = 0;

  void init(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    isTablet = mediaQuery.size.width > 700 ? true : false;
    width = mediaQuery.size.width;
    height = mediaQuery.size.height;
  } 
}