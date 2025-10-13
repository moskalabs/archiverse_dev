// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color brand200;
  late Color gray400;
  late Color textFieldBachGround;
  late Color success100;
  late Color error100;
  late Color brand100;
  late Color bgWhite;
  late Color brand900;
  late Color brand800;
  late Color brand700;
  late Color brand600;
  late Color brand400;
  late Color brand300;
  late Color neutral900;
  late Color neutral800;
  late Color neutral700;
  late Color neutral600;
  late Color neutral500;
  late Color neutral400;
  late Color neutral300;
  late Color neutral200;
  late Color neutral100;
  late Color white0;
  late Color success900;
  late Color success800;
  late Color success700;
  late Color success600;
  late Color success500;
  late Color success400;
  late Color success300;
  late Color success200;
  late Color error900;
  late Color error800;
  late Color error700;
  late Color error600;
  late Color error500;
  late Color error400;
  late Color error300;
  late Color error200;
  late Color warning900;
  late Color warning800;
  late Color warning700;
  late Color warning600;
  late Color warning500;
  late Color warning400;
  late Color warning300;
  late Color warning200;
  late Color warning100;
  late Color information900;
  late Color information800;
  late Color information700;
  late Color information600;
  late Color information500;
  late Color information400;
  late Color information300;
  late Color information200;
  late Color information100;
  late Color blurBg;
  late Color bgModal;
  late Color bgBlurWhite;
  late Color mainColor1;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  bool get displayLargeIsCustom => typography.displayLargeIsCustom;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  bool get displayMediumIsCustom => typography.displayMediumIsCustom;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  bool get displaySmallIsCustom => typography.displaySmallIsCustom;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  bool get headlineLargeIsCustom => typography.headlineLargeIsCustom;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  bool get headlineMediumIsCustom => typography.headlineMediumIsCustom;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  bool get headlineSmallIsCustom => typography.headlineSmallIsCustom;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  bool get titleLargeIsCustom => typography.titleLargeIsCustom;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  bool get titleMediumIsCustom => typography.titleMediumIsCustom;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  bool get titleSmallIsCustom => typography.titleSmallIsCustom;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  bool get labelLargeIsCustom => typography.labelLargeIsCustom;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  bool get labelMediumIsCustom => typography.labelMediumIsCustom;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  bool get labelSmallIsCustom => typography.labelSmallIsCustom;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  bool get bodyLargeIsCustom => typography.bodyLargeIsCustom;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  bool get bodyMediumIsCustom => typography.bodyMediumIsCustom;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  bool get bodySmallIsCustom => typography.bodySmallIsCustom;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF2E5DD5);
  late Color secondary = const Color(0xFF39D2C0);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF080B1F);
  late Color secondaryText = const Color(0xFF76777E);
  late Color primaryBackground = const Color(0xFFFFFFFF);
  late Color secondaryBackground = const Color(0xFFFAFAFA);
  late Color accent1 = const Color(0x4C4B39EF);
  late Color accent2 = const Color(0x4D39D2C0);
  late Color accent3 = const Color(0x4DEE8B60);
  late Color accent4 = const Color(0xCCFFFFFF);
  late Color success = const Color(0xFF66B949);
  late Color warning = const Color(0xFFF2C94C);
  late Color error = const Color(0xFFFF4332);
  late Color info = const Color(0xFFFFFFFF);

  late Color brand200 = const Color(0xFFB7CFFC);
  late Color gray400 = const Color(0xFFA9B4CD);
  late Color textFieldBachGround = const Color(0xFFF4F4F4);
  late Color success100 = const Color(0xFFCFFCD4);
  late Color error100 = const Color(0xFFFFE6D6);
  late Color brand100 = const Color(0xFFDBE8FD);
  late Color bgWhite = const Color(0x74FFFFFF);
  late Color brand900 = const Color(0xFF0E1D70);
  late Color brand800 = const Color(0xFF192252);
  late Color brand700 = const Color(0xFF2540A8);
  late Color brand600 = const Color(0xFF3658C9);
  late Color brand400 = const Color(0xFF769AF2);
  late Color brand300 = const Color(0xFF92B2F8);
  late Color neutral900 = const Color(0xFF192252);
  late Color neutral800 = const Color(0xFF2A3563);
  late Color neutral700 = const Color(0xFF424F7B);
  late Color neutral600 = const Color(0xFF606D93);
  late Color neutral500 = const Color(0xFF848FAC);
  late Color neutral400 = const Color(0xFFA9B4CD);
  late Color neutral300 = const Color(0xFFC5D0E6);
  late Color neutral200 = const Color(0xFFDFE8F6);
  late Color neutral100 = const Color(0xFFEFF3FA);
  late Color white0 = const Color(0xFFFFFFFF);
  late Color success900 = const Color(0xFF16671A);
  late Color success800 = const Color(0xFF1A6D66);
  late Color success700 = const Color(0xFF298876);
  late Color success600 = const Color(0xFF3BA285);
  late Color success500 = const Color(0xFF52BD94);
  late Color success400 = const Color(0xFF7BD7AB);
  late Color success300 = const Color(0xFF9BEBBC);
  late Color success200 = const Color(0xFFA1F9B4);
  late Color error900 = const Color(0xFF7A0925);
  late Color error800 = const Color(0xFF930F25);
  late Color error700 = const Color(0xFFB71926);
  late Color error600 = const Color(0xFFDB2424);
  late Color error500 = const Color(0xFFFF4332);
  late Color error400 = const Color(0xFFFF7E65);
  late Color error300 = const Color(0xFFFFA283);
  late Color error200 = const Color(0xFFFFC7AD);
  late Color warning900 = const Color(0xFF7A4B04);
  late Color warning800 = const Color(0xFF935F07);
  late Color warning700 = const Color(0xFFB77C0B);
  late Color warning600 = const Color(0xFFDB9B10);
  late Color warning500 = const Color(0xFFFFBD16);
  late Color warning400 = const Color(0xFFFFD250);
  late Color warning300 = const Color(0xFFFFDF73);
  late Color warning200 = const Color(0xFFFFECA1);
  late Color warning100 = const Color(0xFFFFF7D0);
  late Color information900 = const Color(0xFF071561);
  late Color information800 = const Color(0xFF0D1F76);
  late Color information700 = const Color(0xFF142D92);
  late Color information600 = const Color(0xFF1D3EAF);
  late Color information500 = const Color(0xFF2952CC);
  late Color information400 = const Color(0xFF597FE0);
  late Color information300 = const Color(0xFF7C9FEF);
  late Color information200 = const Color(0xFFAAC4F9);
  late Color information100 = const Color(0xFFD4E2FC);
  late Color blurBg = const Color(0x5AFFFFFF);
  late Color bgModal = const Color(0x4DFFFFFF);
  late Color bgBlurWhite = const Color(0x65FAFAFA);
  late Color mainColor1 = const Color(0xFF284E75);
}

abstract class Typography {
  String get displayLargeFamily;
  bool get displayLargeIsCustom;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  bool get displayMediumIsCustom;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  bool get displaySmallIsCustom;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  bool get headlineLargeIsCustom;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  bool get headlineMediumIsCustom;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  bool get headlineSmallIsCustom;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  bool get titleLargeIsCustom;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  bool get titleMediumIsCustom;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  bool get titleSmallIsCustom;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  bool get labelLargeIsCustom;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  bool get labelMediumIsCustom;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  bool get labelSmallIsCustom;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  bool get bodyLargeIsCustom;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  bool get bodyMediumIsCustom;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  bool get bodySmallIsCustom;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Open Sans';
  bool get displayLargeIsCustom => false;
  TextStyle get displayLarge => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get displayMediumFamily => 'Open Sans';
  bool get displayMediumIsCustom => false;
  TextStyle get displayMedium => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get displaySmallFamily => 'Open Sans';
  bool get displaySmallIsCustom => false;
  TextStyle get displaySmall => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get headlineLargeFamily => 'Open Sans';
  bool get headlineLargeIsCustom => false;
  TextStyle get headlineLarge => GoogleFonts.openSans();
  String get headlineMediumFamily => 'Open Sans';
  bool get headlineMediumIsCustom => false;
  TextStyle get headlineMedium => GoogleFonts.openSans();
  String get headlineSmallFamily => 'Open Sans';
  bool get headlineSmallIsCustom => false;
  TextStyle get headlineSmall => GoogleFonts.openSans();
  String get titleLargeFamily => 'Open Sans';
  bool get titleLargeIsCustom => false;
  TextStyle get titleLarge => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get titleMediumFamily => 'Open Sans';
  bool get titleMediumIsCustom => false;
  TextStyle get titleMedium => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get titleSmallFamily => 'Open Sans';
  bool get titleSmallIsCustom => false;
  TextStyle get titleSmall => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get labelLargeFamily => 'Open Sans';
  bool get labelLargeIsCustom => false;
  TextStyle get labelLarge => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get labelMediumFamily => 'Open Sans';
  bool get labelMediumIsCustom => false;
  TextStyle get labelMedium => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get labelSmallFamily => 'Open Sans';
  bool get labelSmallIsCustom => false;
  TextStyle get labelSmall => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get bodyLargeFamily => 'Open Sans';
  bool get bodyLargeIsCustom => false;
  TextStyle get bodyLarge => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get bodyMediumFamily => 'Open Sans';
  bool get bodyMediumIsCustom => false;
  TextStyle get bodyMedium => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
  String get bodySmallFamily => 'Open Sans';
  bool get bodySmallIsCustom => false;
  TextStyle get bodySmall => GoogleFonts.openSans().copyWith(overflow: TextOverflow.ellipsis);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    TextStyle? font,
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = false,
    TextDecoration? decoration,
    double? lineHeight,
    List<Shadow>? shadows,
    String? package,
  }) {
    if (useGoogleFonts && fontFamily != null) {
      font = GoogleFonts.getFont(fontFamily,
          fontWeight: fontWeight ?? this.fontWeight,
          fontStyle: fontStyle ?? this.fontStyle);
    }

    final result = font != null
        ? font.copyWith(
            color: color ?? this.color,
            fontSize: fontSize ?? this.fontSize,
            letterSpacing: letterSpacing ?? this.letterSpacing,
            fontWeight: fontWeight ?? this.fontWeight,
            fontStyle: fontStyle ?? this.fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
            overflow: TextOverflow.ellipsis, // 오버플로우 처리 추가
          )
        : copyWith(
            fontFamily: fontFamily,
            package: package,
            color: color,
            fontSize: fontSize,
            letterSpacing: letterSpacing,
            fontWeight: fontWeight,
            fontStyle: fontStyle,
            decoration: decoration,
            height: lineHeight,
            shadows: shadows,
            overflow: TextOverflow.ellipsis, // 오버플로우 처리 추가
          );
    
    return result;
  }
}
