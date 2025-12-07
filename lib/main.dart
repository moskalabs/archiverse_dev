import 'dart:async';
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
  Timer? _sessionTimer;
  DateTime? _lastActivityTime;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
    userStream = realEstateDashboardUIKitSupabaseUserStream()
      ..listen((user) {
        _appStateNotifier.update(user);

        // 로그인 시 30분 idle 타이머 시작
        if (user.loggedIn) {
          _startSessionTimer();
        } else {
          _cancelSessionTimer();
        }
      });
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(milliseconds: 1000),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  void _resetActivityTimer() {
    final appState = FFAppState();
    _lastActivityTime = DateTime.now();
    appState.loginTimestamp = _lastActivityTime!.toIso8601String();

    // 타이머 재시작
    _cancelSessionTimer();
    _sessionTimer = Timer(Duration(minutes: 30), () async {
      print('🔒 30분 비활성 - 자동 로그아웃');
      await authManager.signOut();
      _router.go('/loginPage');
    });
  }

  void _startSessionTimer() {
    _cancelSessionTimer(); // 기존 타이머 취소

    final appState = FFAppState();
    final lastActivityStr = appState.loginTimestamp;

    // 저장된 마지막 활동 시간 체크
    if (lastActivityStr.isNotEmpty) {
      try {
        final lastActivity = DateTime.parse(lastActivityStr);
        final now = DateTime.now();
        final elapsed = now.difference(lastActivity);

        // 이미 30분이 지났으면 즉시 로그아웃
        if (elapsed.inMinutes >= 30) {
          print('🔒 30분 비활성 (새로고침 시) - 자동 로그아웃');
          Future.delayed(Duration.zero, () async {
            await authManager.signOut();
            _router.go('/loginPage');
          });
          return;
        }

        // 남은 시간만큼 타이머 설정
        final remainingTime = Duration(minutes: 30) - elapsed;
        _lastActivityTime = lastActivity;
        _sessionTimer = Timer(remainingTime, () async {
          print('🔒 30분 비활성 - 자동 로그아웃');
          await authManager.signOut();
          _router.go('/loginPage');
        });

        print('✅ 세션 타이머 재개: 마지막 활동 ${_lastActivityTime}, 남은 시간: ${remainingTime.inMinutes}분 ${remainingTime.inSeconds % 60}초');
        return;
      } catch (e) {
        print('⚠️ 마지막 활동 시간 파싱 오류: $e');
      }
    }

    // 새로운 로그인 - 30분 idle 타이머 시작
    _resetActivityTimer();
    print('✅ 세션 타이머 시작: ${_lastActivityTime} (30분 비활성 후 로그아웃)');
  }

  void _cancelSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = null;
  }

  @override
  void dispose() {
    _cancelSessionTimer();
    super.dispose();
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

        // 사용자 활동 감지 (클릭, 스크롤, 키보드 입력 등)
        child = Listener(
          onPointerDown: (_) {
            // 로그인된 상태에서만 타이머 리셋
            if (_appStateNotifier.loggedIn) {
              _resetActivityTimer();
            }
          },
          child: child,
        );

        final screenWidth = MediaQuery.sizeOf(context).width;
        final screenHeight = MediaQuery.sizeOf(context).height;

        // 모바일
        if (!kIsWeb || (screenWidth <= 768 && screenHeight <= 768)) {
          return child;
        }
        
        // 스크롤 필요 여부 판단
        final needsHScroll = screenWidth < 1400;
        final needsVScroll = screenHeight < 800;
        
        // 가로 + 세로 둘 다 스크롤
        if (needsHScroll && needsVScroll) {
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
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1400.0,
              child: Builder(
                builder: (innerContext) {
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      size: Size(1500.0, 1000.0),
                      devicePixelRatio: 1.0,
                      textScaleFactor: 1.0, // 텍스트 스케일 고정
                      padding: EdgeInsets.zero,
                      viewInsets: EdgeInsets.zero,
                    ),
                    child: child!,
                  );
                },
              ),
            ),
          );
        }
        
        // 세로 스크롤만
        if (needsVScroll) {
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
