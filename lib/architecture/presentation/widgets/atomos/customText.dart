import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final String? fontFamily;

  const CustomText({super.key,
    required this.text,
    this.fontSize,
    this.color = Colors.white,
    this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontFamily: fontFamily,
      ),
    );
  }
}
