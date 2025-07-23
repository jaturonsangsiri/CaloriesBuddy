import 'package:flutter/material.dart';
import 'package:CaloriesBuddy/contants/contants.dart';

class CustomProgressBar extends StatelessWidget {
  final double percentage;
  final double height;
  final Color backgroundColor;

  const CustomProgressBar({
    super.key,
    required this.percentage,
    this.height = 10,
    this.backgroundColor = const Color.fromRGBO(217, 217, 217, 1)
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: height,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: backgroundColor),
      child: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: percentage,
                height: height,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: progressColorDarkTheme),
              ),
            ),
          ),
        ],
      ),
    );
  }
}