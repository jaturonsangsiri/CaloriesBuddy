import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:calories_buddy/configs/routes.dart' as custom_route;

class ShowSnackbar {
  static final scaffoldMessengerKey = custom_route.Routes.scaffoldMessengerState;
  static void snackbar(ContentType type, String title, String message) {
    SnackBar snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(title: title, message: message, contentType: type),
    );
    custom_route.Routes.scaffoldMessengerState.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}