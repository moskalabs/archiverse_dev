import 'package:flutter/material.dart';

class AppTheme {
  static const double fontSize22 = 22;
  static const double fontSize18 = 18;
  static const double fontSize16 = 16;
  static const double fontSize12 = 12;

  static ThemeData themeData() {
    final base = ThemeData(
      brightness: Brightness.light,
      useMaterial3: false,
    );

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme),
    );
  }

  static TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontSize: fontSize22),
      displayMedium: base.displayMedium?.copyWith(fontSize: fontSize22),
      displaySmall: base.displaySmall?.copyWith(fontSize: fontSize22),
      headlineLarge: base.headlineLarge?.copyWith(fontSize: fontSize18),
      headlineMedium: base.headlineMedium?.copyWith(fontSize: fontSize18),
      headlineSmall: base.headlineSmall?.copyWith(fontSize: fontSize18),
      titleLarge: base.titleLarge?.copyWith(fontSize: fontSize16),
      titleMedium: base.titleMedium?.copyWith(fontSize: fontSize16),
      titleSmall: base.titleSmall?.copyWith(fontSize: fontSize16),
      labelLarge: base.labelLarge?.copyWith(fontSize: fontSize12),
      labelMedium: base.labelMedium?.copyWith(fontSize: fontSize12),
      labelSmall: base.labelSmall?.copyWith(fontSize: fontSize12),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: fontSize16),
      bodyMedium: base.bodyMedium?.copyWith(fontSize: fontSize16),
      bodySmall: base.bodySmall?.copyWith(fontSize: fontSize12),
    );
  }
}
