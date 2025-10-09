import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'auth/supabase_auth/supabase_user_provider.dart';
import 'auth/supabase_auth/auth_util.dart';

import '/backend/supabase/supabase.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import '/core/responsive_wrapper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await SupaFlow.initialize();

  // 오버플로우 에러 처리
  ErrorWidget.builder = (FlutterErrorDetails details) {
    print('🚨 오버플로우 에러 발생: ${details.exception}');
    
    // RenderFlex overflow 에러 처리
    if (details.exception.toString().contains('RenderFlex overflowed')) {
      return Container(
        color: Colors.red.withOpacity(0.1),
        child: Center(
          child: Text(
            '텍스트 오버플로우',
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    
    // 기본 에러 위젯
    return ErrorWidget(details.exception);
  };

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class MyAppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;
  String getRoute([RouteMatch? routeMatch]) {
    final RouteMatch lastMatch =
        routeMatch ?? _router.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : _router.routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  List<String> getRouteStack() =>
      _router.routerDelegate.currentConfiguration.matches
          .map((e) => getRoute(e))
          .toList();
  late Stream<BaseAuthUser> userStream;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = realEstateDashboardUIKitSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void setLocale(String language) {
    safeSetState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => safeSetState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'archiverse',
      scrollBehavior: MyAppScrollBehavior(),
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FallbackMaterialLocalizationDelegate(),
        FallbackCupertinoLocalizationDelegate(),
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: false,
        // 전역 텍스트 오버플로우 처리
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyLarge: ThemeData.light().textTheme.bodyLarge?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          bodyMedium: ThemeData.light().textTheme.bodyMedium?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          bodySmall: ThemeData.light().textTheme.bodySmall?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          titleLarge: ThemeData.light().textTheme.titleLarge?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          titleMedium: ThemeData.light().textTheme.titleMedium?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          titleSmall: ThemeData.light().textTheme.titleSmall?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          labelLarge: ThemeData.light().textTheme.labelLarge?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          labelMedium: ThemeData.light().textTheme.labelMedium?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
          labelSmall: ThemeData.light().textTheme.labelSmall?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      builder: (context, child) {
        if (child == null) return Container();
        
        final screenWidth = MediaQuery.sizeOf(context).width;
        final screenHeight = MediaQuery.sizeOf(context).height;
        
        print('🚀 MAIN BUILDER: ${screenWidth}px x ${screenHeight}px');
        
        // 모바일 (가로 AND 세로 둘 다 768px 이하)
        if (!kIsWeb || (screenWidth <= 768 && screenHeight <= 768)) {
          print('모바일: 기존');
          return child;
        }
        
        // 고정 레이아웃 처리
        final needsHScroll = screenWidth < 1400;
        final needsVScroll = screenHeight < 800;
        
        Widget result = child;
        
        // 세로 스크롤 먼저 처리
        if (needsVScroll) {
          print('🚀 세로 800px 고정!');
          result = SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 800.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.green, width: 4)),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(size: Size(1500.0, 1000.0)),
                child: result,
              ),
            ),
          );
        }
        
        // 가로 스크롤 처리
        if (needsHScroll) {
          print('🚀 가로 1400px 고정!');
          result = SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              width: 1400.0,
              decoration: BoxDecoration(border: Border.all(color: Colors.red, width: 4)),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(size: Size(1500.0, 1000.0)),
                child: result,
              ),
            ),
          );
        }
        
        return result;
      },
    );
  }
}
