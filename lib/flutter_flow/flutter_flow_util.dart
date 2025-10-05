import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:from_css_color/from_css_color.dart';
import 'dart:math' show pow, pi, sin;
import 'package:intl/intl.dart';
import 'package:json_path/json_path.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';


export 'keep_alive_wrapper.dart';
export 'lat_lng.dart';
export 'place.dart';
export 'uploaded_file.dart';
export '../app_state.dart';
export '../app_constants.dart';
export 'flutter_flow_model.dart';
export 'dart:math' show min, max;
export 'dart:typed_data' show Uint8List;
export 'dart:convert' show jsonEncode, jsonDecode;
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';
export 'custom_icons.dart' show FFIcons;
export 'internationalization.dart' show FFLocalizations;
export 'nav/nav.dart';

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

void _setTimeagoLocales() {
  timeago.setLocaleMessages('ko', timeago.KoMessages());
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
}

String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    _setTimeagoLocales();
    return timeago.format(dateTime, locale: locale, allowFromNow: true);
  }
  return DateFormat(format, locale).format(dateTime);
}

Theme wrapInMaterialDatePickerTheme(
  BuildContext context,
  Widget child, {
  required Color headerBackgroundColor,
  required Color headerForegroundColor,
  required TextStyle headerTextStyle,
  required Color pickerBackgroundColor,
  required Color pickerForegroundColor,
  required Color selectedDateTimeBackgroundColor,
  required Color selectedDateTimeForegroundColor,
  required Color actionButtonForegroundColor,
  required double iconSize,
}) {
  final baseTheme = Theme.of(context);
  final dateTimeMaterialStateForegroundColor =
      WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.disabled)) {
      return pickerForegroundColor.applyAlpha(0.60);
    }
    if (states.contains(WidgetState.selected)) {
      return selectedDateTimeForegroundColor;
    }
    if (states.isEmpty) {
      return pickerForegroundColor;
    }
    return null;
  });

  final dateTimeMaterialStateBackgroundColor =
      WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.selected)) {
      return selectedDateTimeBackgroundColor;
    }
    return null;
  });

  return Theme(
    data: baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        onSurface: pickerForegroundColor,
      ),
      disabledColor: pickerForegroundColor.applyAlpha(0.3),
      textTheme: baseTheme.textTheme.copyWith(
        headlineSmall: headerTextStyle,
        headlineMedium: headerTextStyle,
      ),
      iconTheme: baseTheme.iconTheme.copyWith(
        size: iconSize,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              actionButtonForegroundColor,
            ),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return actionButtonForegroundColor.applyAlpha(0.04);
              }
              if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return actionButtonForegroundColor.applyAlpha(0.12);
              }
              return null;
            })),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: pickerBackgroundColor,
        headerBackgroundColor: headerBackgroundColor,
        headerForegroundColor: headerForegroundColor,
        weekdayStyle: baseTheme.textTheme.labelMedium!.copyWith(
          color: pickerForegroundColor,
        ),
        dayBackgroundColor: dateTimeMaterialStateBackgroundColor,
        todayBackgroundColor: dateTimeMaterialStateBackgroundColor,
        yearBackgroundColor: dateTimeMaterialStateBackgroundColor,
        dayForegroundColor: dateTimeMaterialStateForegroundColor,
        todayForegroundColor: dateTimeMaterialStateForegroundColor,
        yearForegroundColor: dateTimeMaterialStateForegroundColor,
      ),
    ),
    child: child,
  );
}

Theme wrapInMaterialTimePickerTheme(
  BuildContext context,
  Widget child, {
  required Color headerBackgroundColor,
  required Color headerForegroundColor,
  required TextStyle headerTextStyle,
  required Color pickerBackgroundColor,
  required Color pickerForegroundColor,
  required Color selectedDateTimeBackgroundColor,
  required Color selectedDateTimeForegroundColor,
  required Color actionButtonForegroundColor,
  required double iconSize,
}) {
  final baseTheme = Theme.of(context);
  return Theme(
    data: baseTheme.copyWith(
      iconTheme: baseTheme.iconTheme.copyWith(
        size: iconSize,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(
              actionButtonForegroundColor,
            ),
            overlayColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.hovered)) {
                return actionButtonForegroundColor.applyAlpha(0.04);
              }
              if (states.contains(WidgetState.focused) ||
                  states.contains(WidgetState.pressed)) {
                return actionButtonForegroundColor.applyAlpha(0.12);
              }
              return null;
            })),
      ),
      timePickerTheme: baseTheme.timePickerTheme.copyWith(
        backgroundColor: pickerBackgroundColor,
        hourMinuteTextColor: pickerForegroundColor,
        dialHandColor: selectedDateTimeBackgroundColor,
        dialTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? selectedDateTimeForegroundColor
                : pickerForegroundColor),
        dayPeriodBorderSide: BorderSide(
          color: pickerForegroundColor,
        ),
        dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? selectedDateTimeForegroundColor
                : pickerForegroundColor),
        dayPeriodColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.selected)
                ? selectedDateTimeBackgroundColor
                : Colors.transparent),
        entryModeIconColor: pickerForegroundColor,
      ),
    ),
    child: child,
  );
}

Future launchURL(String url) async {
  var uri = Uri.parse(url);
  try {
    await launchUrl(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}

Color colorFromCssString(String color, {Color? defaultColor}) {
  try {
    return fromCssColor(color);
  } catch (_) {}
  return defaultColor ?? Colors.black;
}

enum FormatType {
  decimal,
  percent,
  scientific,
  compact,
  compactLong,
  custom,
}

enum DecimalType {
  automatic,
  periodDecimal,
  commaDecimal,
}

String formatNumber(
  num? value, {
  required FormatType formatType,
  DecimalType? decimalType,
  String? currency,
  bool toLowerCase = false,
  String? format,
  String? locale,
}) {
  if (value == null) {
    return '';
  }
  var formattedValue = '';
  switch (formatType) {
    case FormatType.decimal:
      switch (decimalType!) {
        case DecimalType.automatic:
          formattedValue = NumberFormat.decimalPattern().format(value);
          break;
        case DecimalType.periodDecimal:
          if (currency != null) {
            formattedValue = NumberFormat('#,##0.00', 'en_US').format(value);
          } else {
            formattedValue = NumberFormat.decimalPattern('en_US').format(value);
          }
          break;
        case DecimalType.commaDecimal:
          if (currency != null) {
            formattedValue = NumberFormat('#,##0.00', 'es_PA').format(value);
          } else {
            formattedValue = NumberFormat.decimalPattern('es_PA').format(value);
          }
          break;
      }
      break;
    case FormatType.percent:
      formattedValue = NumberFormat.percentPattern().format(value);
      break;
    case FormatType.scientific:
      formattedValue = NumberFormat.scientificPattern().format(value);
      if (toLowerCase) {
        formattedValue = formattedValue.toLowerCase();
      }
      break;
    case FormatType.compact:
      formattedValue = NumberFormat.compact().format(value);
      break;
    case FormatType.compactLong:
      formattedValue = NumberFormat.compactLong().format(value);
      break;
    case FormatType.custom:
      final hasLocale = locale != null && locale.isNotEmpty;
      formattedValue =
          NumberFormat(format, hasLocale ? locale : null).format(value);
  }

  if (formattedValue.isEmpty) {
    return value.toString();
  }

  if (currency != null) {
    final currencySymbol = currency.isNotEmpty
        ? currency
        : NumberFormat.simpleCurrency().format(0.0).substring(0, 1);
    formattedValue = '$currencySymbol$formattedValue';
  }

  return formattedValue;
}

DateTime get getCurrentTimestamp => DateTime.now();
DateTime dateTimeFromSecondsSinceEpoch(int seconds) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

extension DateTimeConversionExtension on DateTime {
  int get secondsSinceEpoch => (millisecondsSinceEpoch / 1000).round();
}

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

T? castToType<T>(dynamic value) {
  if (value == null) {
    return null;
  }
  switch (T) {
    case double:
      // Doubles may be stored as ints in some cases.
      return value.toDouble() as T;
    case int:
      // Likewise, ints may be stored as doubles. If this is the case
      // (i.e. no decimal value), return the value as an int.
      if (value is num && value.toInt() == value) {
        return value.toInt() as T;
      }
      break;
    default:
      break;
  }
  return value as T;
}

dynamic getJsonField(
  dynamic response,
  String jsonPath, [
  bool isForList = false,
]) {
  final field = JsonPath(jsonPath).read(response);
  if (field.isEmpty) {
    return null;
  }
  if (field.length > 1) {
    return field.map((f) => f.value).toList();
  }
  final value = field.first.value;
  if (isForList) {
    return value is! Iterable
        ? [value]
        : (value is List ? value : value.toList());
  }
  return value;
}

Rect? getWidgetBoundingBox(BuildContext context) {
  try {
    final renderBox = context.findRenderObject() as RenderBox?;
    return renderBox!.localToGlobal(Offset.zero) & renderBox.size;
  } catch (_) {
    return null;
  }
}

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isiOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

const kBreakpointSmall = 767.0;
const kBreakpointMedium = 1400.0;
const kBreakpointLarge = 1400.0;
const kMinHeightDesktop = 800.0;
bool isMobileWidth(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
  
  // 테스트용: 모바일 조건 비활성화
  print('isMobileWidth: 🚀 모바일 비활성화 - 무조건 FALSE (가로:${width}px)');
  return false; // 테스트용: 무조건 비모바일
  
  /*
  // 강제로 데스크톱 모드: 가로 769px 이상이면 무조건 비모바일
  if (kIsWeb && width > 768) {
    print('isMobileWidth: 강제 비모바일 (가로:${width}px > 768px)');
    return false;
  }
  
  // 진짜 모바일: 가로 AND 세로 둘 다 768px 이하
  final isMobile = !kIsWeb || (width <= 768 && height <= 768);
  print('isMobileWidth: 모바일 체크 - 가로:${width}px, 세로:${height}px, isMobile:$isMobile');
  
  return isMobile;
  */
}
// 전역 브레이크포인트 설정
const kCustomBreakpointTablet = 1400.0;

// 반응형 래퍼 위젯 - 스크롤 처리 포함
Widget buildResponsiveWrapper({
  required BuildContext context,
  required Widget child,
}) {
  final screenWidth = MediaQuery.sizeOf(context).width;
  final screenHeight = MediaQuery.sizeOf(context).height;
  final isMobile = screenWidth < kBreakpointSmall;
  final needsHScroll = screenWidth >= kBreakpointSmall && screenWidth < kCustomBreakpointTablet;
  final needsVScroll = screenHeight < kMinHeightDesktop && !isMobile;
  
  Widget content = child;
  
  if (!isMobile) {
    // 가로와 세로 둘 다 스크롤 필요
    if (needsHScroll && needsVScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: kCustomBreakpointTablet,
            height: kMinHeightDesktop,
            child: content,
          ),
        ),
      );
    }
    // 가로 스크롤만 필요
    else if (needsHScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          width: kCustomBreakpointTablet,
          child: content,
        ),
      );
    }
    // 세로 스크롤만 필요
    else if (needsVScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: kMinHeightDesktop,
          child: content,
        ),
      );
    }
  }
  
  return content;
}

bool responsiveVisibility({
  required BuildContext context,
  bool phone = true,
  bool tablet = true,
  bool tabletLandscape = true,
  bool desktop = true,
}) {
  final width = MediaQuery.sizeOf(context).width;
  final height = MediaQuery.sizeOf(context).height;
  
  // 호출 위치 추적
  final stackTrace = StackTrace.current.toString();
  final lineInfo = stackTrace.split('\n')[1]; // 호출한 위치 정보
  
  print('\n=== responsiveVisibility CALL ===');
  print('크기: ${width}px x ${height}px');
  print('조건: phone=$phone, tablet=$tablet, tabletLandscape=$tabletLandscape, desktop=$desktop');
  print('호출위치: $lineInfo');
  
  // 웹에서 가로 > 768px이면 데스크톱 레이아웃 강제
  if (kIsWeb && width > 768) {
    print('responsiveVisibility: 원래 조건: phone=$phone, tablet=$tablet, tabletLandscape=$tabletLandscape, desktop=$desktop');
    
    // 순수 데스크톱 전용 컴포너트만 표시
    if (!phone) {
      print('responsiveVisibility: 🚀🚀 순수 데스크톱 (phone=false) -> TRUE');
      print('   이것이 진짜 데스크톱 UI일 가능성!');
      return true;
    }
    
    // phone=true 가 포함된 모든 컴포너트 숨김 (모바일/태블릿 형태)
    if (phone) {
      print('responsiveVisibility: 🚀📱 모바일/태블릿 컴포너트 (phone=true) 강제 숨김 -> FALSE');
      print('   이것이 현재 보이는 모바일 형태 UI일 가능성!');
      return false;
    }
    
    print('responsiveVisibility: 🚀 기본 -> TRUE');
    return true;
  }
  
  // 진짜 모바일
  final isTrueMobile = !kIsWeb || (width <= 768 && height <= 768);
  if (isTrueMobile) {
    print('responsiveVisibility: 진짜 모바일 -> returning $phone');
    return phone;
  }
  
  print('responsiveVisibility: 대체 경로 -> true');
  return true;
}

// 반응형 레이아웃 헬퍼 함수들
bool isDesktopWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= kCustomBreakpointTablet;
bool needsHorizontalScroll(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= kBreakpointSmall && MediaQuery.sizeOf(context).width < kCustomBreakpointTablet;
bool needsVerticalScroll(BuildContext context) =>
    MediaQuery.sizeOf(context).height < kMinHeightDesktop && MediaQuery.sizeOf(context).width >= kBreakpointSmall;

const kTextValidatorUsernameRegex = r'^[a-zA-Z][a-zA-Z0-9_-]{2,16}$';
// https://stackoverflow.com/a/201378
const kTextValidatorEmailRegex =
    "^(?:[a-zA-Z0-9!#\$%&\'*+/=?^_`{|}~-]+(?:\\.[a-zA-Z0-9!#\$%&\'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-zA-Z0-9-]*[a-zA-Z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])\$";
const kTextValidatorWebsiteRegex =
    r'(https?:\/\/)?(www\.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|(https?:\/\/)?(www\.)?(?!ww)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

extension FFTextEditingControllerExt on TextEditingController? {
  String get text => this == null ? '' : this!.text;
  set text(String newText) => this?.text = newText;
}

extension IterableExt<T> on Iterable<T> {
  List<T> sortedList<S extends Comparable>(
      {S Function(T)? keyOf, bool desc = false}) {
    final sortedAscending = toList()
      ..sort(keyOf == null ? null : ((a, b) => keyOf(a).compareTo(keyOf(b))));
    if (desc) {
      return sortedAscending.reversed.toList();
    }
    return sortedAscending;
  }

  List<S> mapIndexed<S>(S Function(int, T) func) => toList()
      .asMap()
      .map((index, value) => MapEntry(index, func(index, value)))
      .values
      .toList();
}

void setAppLanguage(BuildContext context, String language) =>
    MyApp.of(context).setLocale(language);

void setDarkModeSetting(BuildContext context, ThemeMode themeMode) =>
    MyApp.of(context).setThemeMode(themeMode);

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: Container(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;

  String toCapitalization(TextCapitalization textCapitalization) {
    switch (textCapitalization) {
      case TextCapitalization.none:
        return this;
      case TextCapitalization.words:
        return split(' ').map(toBeginningOfSentenceCase).join(' ');
      case TextCapitalization.sentences:
        return toBeginningOfSentenceCase(this);
      case TextCapitalization.characters:
        return toUpperCase();
    }
  }
}

extension ListFilterExt<T> on Iterable<T?> {
  List<T> get withoutNulls => where((s) => s != null).map((e) => e!).toList();
}

extension MapFilterExtensions<T> on Map<String, T?> {
  Map<String, T> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value as T)),
      );
}

extension MapListContainsExt on List<dynamic> {
  bool containsMap(dynamic map) => map is Map
      ? any((e) => e is Map && const DeepCollectionEquality().equals(e, map))
      : contains(map);
}

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t, {bool Function(int)? filterFn}) => isEmpty
      ? []
      : (enumerate
          .map((e) => [e.value, if (filterFn == null || filterFn(e.key)) t])
          .expand((i) => i)
          .toList()
        ..removeLast());

  List<Widget> around(Widget t) => addToStart(t).addToEnd(t);

  List<Widget> addToStart(Widget t) =>
      enumerate.map((e) => e.value).toList()..insert(0, t);

  List<Widget> addToEnd(Widget t) =>
      enumerate.map((e) => e.value).toList()..add(t);

  List<Padding> paddingTopEach(double val) =>
      map((w) => Padding(padding: EdgeInsets.only(top: val), child: w))
          .toList();
}

extension StatefulWidgetExtensions on State<StatefulWidget> {
  /// Check if the widget exist before safely setting state.
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}

// For iOS 16 and below, set the status bar color to match the app's theme.
// https://github.com/flutter/flutter/issues/41067
Brightness? _lastBrightness;
void fixStatusBarOniOS16AndBelow(BuildContext context) {
  if (!isiOS) {
    return;
  }
  final brightness = Theme.of(context).brightness;
  if (_lastBrightness != brightness) {
    _lastBrightness = brightness;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        systemStatusBarContrastEnforced: true,
      ),
    );
  }
}

extension ColorOpacityExt on Color {
  Color applyAlpha(double val) => withValues(alpha: val);
}

String roundTo(double value, int decimalPoints) {
  final power = pow(10, decimalPoints);
  return ((value * power).round() / power).toString();
}

double computeGradientAlignmentX(double evaluatedAngle) {
  evaluatedAngle %= 360;
  final rads = evaluatedAngle * pi / 180;
  double x;
  if (evaluatedAngle < 45 || evaluatedAngle > 315) {
    x = sin(2 * rads);
  } else if (45 <= evaluatedAngle && evaluatedAngle <= 135) {
    x = 1;
  } else if (135 <= evaluatedAngle && evaluatedAngle <= 225) {
    x = sin(-2 * rads);
  } else {
    x = -1;
  }
  return double.parse(roundTo(x, 2));
}

double computeGradientAlignmentY(double evaluatedAngle) {
  evaluatedAngle %= 360;
  final rads = evaluatedAngle * pi / 180;
  double y;
  if (evaluatedAngle < 45 || evaluatedAngle > 315) {
    y = -1;
  } else if (45 <= evaluatedAngle && evaluatedAngle <= 135) {
    y = sin(-2 * rads);
  } else if (135 <= evaluatedAngle && evaluatedAngle <= 225) {
    y = 1;
  } else {
    y = sin(2 * rads);
  }
  return double.parse(roundTo(y, 2));
}

extension ListUniqueExt<T> on Iterable<T> {
  List<T> unique(dynamic Function(T) getKey) {
    var distinctSet = <dynamic>{};
    var distinctList = <T>[];
    for (var item in this) {
      if (distinctSet.add(getKey(item))) {
        distinctList.add(item);
      }
    }
    return distinctList;
  }
}

String getCurrentRoute(BuildContext context) =>
    context.mounted ? MyApp.of(context).getRoute() : '';
List<String> getCurrentRouteStack(BuildContext context) =>
    context.mounted ? MyApp.of(context).getRouteStack() : [];
