import 'package:flutter/material.dart';

class AppTheme {
  static const double fontSize1 = 22.0;
  static const double fontSize2 = 18.0;
  static const double fontSize3 = 16.0;
  static const double fontSize4 = 12.0;

  static TextStyle get headline1 => const TextStyle(
        fontSize: fontSize1,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get headline2 => const TextStyle(
        fontSize: fontSize2,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get bodyText1 => const TextStyle(
        fontSize: fontSize3,
        overflow: TextOverflow.ellipsis,
      );

  static TextStyle get caption => TextStyle(
        fontSize: fontSize4,
        color: Colors.grey.shade600,
        overflow: TextOverflow.ellipsis,
      );
}
