// ignore_for_file: sort_constructors_first

import 'package:flutter/material.dart';

enum AppTextFontWeight {
  medium(FontWeight.w500),
  semibold(FontWeight.w600);

  final FontWeight weight;

  const AppTextFontWeight(this.weight);
}

class AppText extends StatelessWidget {
  const AppText({
    required this.text,
    super.key,
    this.size = 14,
    this.fontWeight = AppTextFontWeight.medium,
    this.color,
  });

  final String text;
  final double size;
  final AppTextFontWeight fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: fontWeight.weight,
        color: color,
      ),
    );
  }
}
