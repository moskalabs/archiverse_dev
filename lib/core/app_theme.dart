import 'package:flutter/material.dart';

import 'font_constants.dart';

/// Centralizes application-wide typography rules so that every text style
/// adheres to the fixed desktop layout requirements.
class AppTheme {
  const AppTheme._();

  static const double fontSizeXL = FontConstants.sizeXLarge;
  static const double fontSizeL = FontConstants.sizeLarge;
  static const double fontSizeM = FontConstants.sizeMedium;
  static const double fontSizeS = FontConstants.sizeSmall;

  static TextStyle textStyleXL({
    Color? color,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
  }) => _baseTextStyle(
        size: fontSizeXL,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: fontFamily,
      );

  static TextStyle textStyleL({
    Color? color,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
  }) => _baseTextStyle(
        size: fontSizeL,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: fontFamily,
      );

  static TextStyle textStyleM({
    Color? color,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
  }) => _baseTextStyle(
        size: fontSizeM,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: fontFamily,
      );

  static TextStyle textStyleS({
    Color? color,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
  }) => _baseTextStyle(
        size: fontSizeS,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: fontFamily,
      );

  static TextStyle _baseTextStyle({
    required double size,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
  }) {
    final base = TextStyle(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      height: height,
      fontFamily: fontFamily,
    );
    return base;
  }
}
