import 'package:flutter/material.dart';

// ไอคอนแบบมีวงกลม
// ใช้เป็นไอคอนมีวงลมด้านหลัง มีสีของไอคอน สีวงกลมหลังไอคอน ไอคอนอะไร ขนาดไอคอน
class CircleIcon extends StatelessWidget {
  final Color? colorbg;
  final Widget? icon;
  final Function()? function;
  final double padding;

  const CircleIcon({
    required this.icon,
    required this.colorbg,
    required this.function,
    required this.padding,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: function,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(CircleBorder()),
            padding: WidgetStateProperty.all(EdgeInsets.all(padding)),
            backgroundColor: WidgetStateProperty.all(colorbg), // <-- Button color
            overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.blueGrey; // <-- Splash color
              }
              return null;
            }),
          ),
          child: icon!
        ),
      ],
    );
  }
}

// ไอคอนแบบธรรมดา มีไอคอนและตัวหนังสือ
class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color backgroundColor;
  final double size;
  final double fontSize;
  const IconText({super.key, required this.icon, required this.text, required this.color, required this.backgroundColor, required this.size, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: backgroundColor, 
        borderRadius: BorderRadius.all(Radius.circular(10)), 
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ]
      ),
      child: Row(
        children: [
          Icon(icon, color: color,size: size),
          const SizedBox(width: 10),
          Text(text, style: TextTheme.of(context).titleMedium!.copyWith(color: color, fontWeight: FontWeight.w600)),
          const SizedBox(width: 10)
        ],
      ),
    );
  }
}