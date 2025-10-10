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
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();

  await SupaFlow.initialize();

  final appState = FFAppState();
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
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
      ),
      themeMode: _themeMode,
      routerConfig: _router,
      builder: (context, child) {
        if (child == null) return Container();
        
        final screenWidth = MediaQuery.sizeOf(context).width;
        final screenHeight = MediaQuery.sizeOf(context).height;
        
        print('🚀 MAIN: ${screenWidth}px x ${screenHeight}px');
        
        // 모바일
        if (!kIsWeb || (screenWidth <= 768 && screenHeight <= 768)) {
          return child;
        }
        
        // 스크롤 필요 여부 판단
        final needsHScroll = screenWidth < 1400;
        final needsVScroll = screenHeight < 800;
        
        print('🚀 스크롤: 가로=$needsHScroll, 세로=$needsVScroll');
        
        // 가로 + 세로 둘 다 스크롤
        if (needsHScroll && needsVScroll) {
          print('🚀 보라: 가로+세로 1400x800 고정');
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: 1400.0,
                height: 800.0,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(size: Size(1500.0, 1000.0)),
                  child: child,
                ),
              ),
            ),
          );
        }
        
        // 가로 스크롤만
        if (needsHScroll) {
          print('🚀 빨간: 가로 1400px 고정');
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1400.0,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(size: Size(1500.0, 1000.0)),
                child: child,
              ),
            ),
          );
        }
        
        // 세로 스크롤만
        if (needsVScroll) {
          print('🚀 초록: 세로 800px 고정');
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              height: 800.0,
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(size: Size(1500.0, 1000.0)),
                child: child,
              ),
            ),
          );
        }
        
        return child;
      },
    );
  }
}
