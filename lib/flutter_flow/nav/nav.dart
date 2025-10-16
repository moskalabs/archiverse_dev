import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';
import '/auth/supabase_auth/auth_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? HomeWidget() : LoginPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) {
            // 루트 경로로 직접 접근 시 무조건 로그아웃 후 로그인 페이지로
            if (appStateNotifier.loggedIn) {
              Future.microtask(() async {
                await authManager.signOut();
                // 로그아웃 후 현재 경로가 여전히 '/'인지 확인하고 loginPage로 이동
                if (GoRouter.of(context).getCurrentLocation() == '/') {
                  GoRouter.of(context).go('/loginPage');
                }
              });
            }
            return LoginPageWidget();
          },
        ),
        FFRoute(
          name: LoginPageWidget.routeName,
          path: LoginPageWidget.routePath,
          builder: (context, params) => LoginPageWidget(
            buttonProfessorColor: params.getParam(
              'buttonProfessorColor',
              ParamType.Color,
            ),
            emailTextField: params.getParam(
              'emailTextField',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ResetPasswordWidget.routeName,
          path: ResetPasswordWidget.routePath,
          builder: (context, params) => ResetPasswordWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: RegisterPageWidget.routeName,
          path: RegisterPageWidget.routePath,
          builder: (context, params) => RegisterPageWidget(),
        ),
        FFRoute(
          name: MessageWidget.routeName,
          path: MessageWidget.routePath,
          builder: (context, params) => MessageWidget(),
        ),
        FFRoute(
          name: EditProfileWidget.routeName,
          path: EditProfileWidget.routePath,
          builder: (context, params) => EditProfileWidget(),
        ),
        FFRoute(
          name: SettingWidget.routeName,
          path: SettingWidget.routePath,
          builder: (context, params) => SettingWidget(),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) => ChatWidget(),
        ),
        FFRoute(
          name: DahsboardMasterWidget.routeName,
          path: DahsboardMasterWidget.routePath,
          requireAuth: true,
          builder: (context, params) => DahsboardMasterWidget(),
        ),
        FFRoute(
          name: DahsboardGeneralWidget.routeName,
          path: DahsboardGeneralWidget.routePath,
          builder: (context, params) => DahsboardGeneralWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DahsboardViceWidget.routeName,
          path: DahsboardViceWidget.routePath,
          builder: (context, params) => DahsboardViceWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: DahsboardWidget.routeName,
          path: DahsboardWidget.routePath,
          builder: (context, params) => DahsboardWidget(
            professorType: params.getParam(
              'professorType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TestWidget.routeName,
          path: TestWidget.routePath,
          builder: (context, params) => TestWidget(),
        ),
        FFRoute(
          name: ProfAttendanceSheetWidget.routeName,
          path: ProfAttendanceSheetWidget.routePath,
          builder: (context, params) => ProfAttendanceSheetWidget(),
        ),
        FFRoute(
          name: ProfGradeSheetWidget.routeName,
          path: ProfGradeSheetWidget.routePath,
          builder: (context, params) => ProfGradeSheetWidget(),
        ),
        FFRoute(
          name: ProfLectureMaterialsWidget.routeName,
          path: ProfLectureMaterialsWidget.routePath,
          builder: (context, params) => ProfLectureMaterialsWidget(),
        ),
        FFRoute(
          name: ProfSubjectPortpolioWidget.routeName,
          path: ProfSubjectPortpolioWidget.routePath,
          builder: (context, params) => ProfSubjectPortpolioWidget(),
        ),
        FFRoute(
          name: StudentWorkEvalFormWidget.routeName,
          path: StudentWorkEvalFormWidget.routePath,
          builder: (context, params) => StudentWorkEvalFormWidget(),
        ),
        FFRoute(
          name: StudentRegistrationWidget.routeName,
          path: StudentRegistrationWidget.routePath,
          builder: (context, params) => StudentRegistrationWidget(),
        ),
        FFRoute(
          name: MyProfileCopyWidget.routeName,
          path: MyProfileCopyWidget.routePath,
          builder: (context, params) => MyProfileCopyWidget(),
        ),
        FFRoute(
          name: TestCopyWidget.routeName,
          path: TestCopyWidget.routePath,
          builder: (context, params) => TestCopyWidget(),
        ),
        FFRoute(
          name: StudentRegistrationCopyWidget.routeName,
          path: StudentRegistrationCopyWidget.routePath,
          builder: (context, params) => StudentRegistrationCopyWidget(),
        ),
        FFRoute(
          name: StudentSubjectPortpolioWidget.routeName,
          path: StudentSubjectPortpolioWidget.routePath,
          builder: (context, params) => StudentSubjectPortpolioWidget(),
        ),
        FFRoute(
          name: CalendarDetailWidget.routeName,
          path: CalendarDetailWidget.routePath,
          builder: (context, params) => CalendarDetailWidget(),
        ),
        FFRoute(
          name: AdminDashBackupWidget.routeName,
          path: AdminDashBackupWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminDashBackupWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AdminStudentSubmitWidget.routeName,
          path: AdminStudentSubmitWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminStudentSubmitWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ProfCoursePlanWidget.routeName,
          path: ProfCoursePlanWidget.routePath,
          builder: (context, params) => ProfCoursePlanWidget(),
        ),
        FFRoute(
          name: ProfResultsMidtermWidget.routeName,
          path: ProfResultsMidtermWidget.routePath,
          builder: (context, params) => ProfResultsMidtermWidget(),
        ),
        FFRoute(
          name: ProfResultsFinalWidget.routeName,
          path: ProfResultsFinalWidget.routePath,
          builder: (context, params) => ProfResultsFinalWidget(),
        ),
        FFRoute(
          name: StudentCoursePlanWidget.routeName,
          path: StudentCoursePlanWidget.routePath,
          builder: (context, params) => StudentCoursePlanWidget(),
        ),
        FFRoute(
          name: StudentLectureMaterialWidget.routeName,
          path: StudentLectureMaterialWidget.routePath,
          builder: (context, params) => StudentLectureMaterialWidget(),
        ),
        FFRoute(
          name: StudentResultsMidtermWidget.routeName,
          path: StudentResultsMidtermWidget.routePath,
          builder: (context, params) => StudentResultsMidtermWidget(),
        ),
        FFRoute(
          name: StudentResultsFinalWidget.routeName,
          path: StudentResultsFinalWidget.routePath,
          builder: (context, params) => StudentResultsFinalWidget(),
        ),
        FFRoute(
          name: CalendarWidget.routeName,
          path: CalendarWidget.routePath,
          builder: (context, params) => CalendarWidget(),
        ),
        FFRoute(
          name: StudentCalenderWidget.routeName,
          path: StudentCalenderWidget.routePath,
          builder: (context, params) => StudentCalenderWidget(),
        ),
        FFRoute(
          name: AdminLoginWidget.routeName,
          path: AdminLoginWidget.routePath,
          builder: (context, params) => AdminLoginWidget(
            buttonProfessorColor: params.getParam(
              'buttonProfessorColor',
              ParamType.Color,
            ),
            emailTextField: params.getParam(
              'emailTextField',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AdminDashWidget.routeName,
          path: AdminDashWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminDashWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AdminClassChangeWidget.routeName,
          path: AdminClassChangeWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminClassChangeWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) => HomeWidget(),
        ),
        FFRoute(
          name: ProfDashboardWidget.routeName,
          path: ProfDashboardWidget.routePath,
          builder: (context, params) => ProfDashboardWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StudentDashboardWidget.routeName,
          path: StudentDashboardWidget.routePath,
          builder: (context, params) => StudentDashboardWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: StudentHomeWidget.routeName,
          path: StudentHomeWidget.routePath,
          builder: (context, params) => StudentHomeWidget(),
        ),
        FFRoute(
          name: StudentMyProfileWidget.routeName,
          path: StudentMyProfileWidget.routePath,
          builder: (context, params) => StudentMyProfileWidget(),
        ),
        FFRoute(
          name: ProfMyProfileWidget.routeName,
          path: ProfMyProfileWidget.routePath,
          builder: (context, params) => ProfMyProfileWidget(),
        ),
        FFRoute(
          name: AdminPortfolioWidget.routeName,
          path: AdminPortfolioWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminPortfolioWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AdminAccountManageWidget.routeName,
          path: AdminAccountManageWidget.routePath,
          requireAuth: true,
          builder: (context, params) => AdminAccountManageWidget(
            userType: params.getParam(
              'userType',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: TestDrawersWidget.routeName,
          path: TestDrawersWidget.routePath,
          builder: (context, params) => TestDrawersWidget(),
        ),
        FFRoute(
          name: ModelViewerWidget.routeName,
          path: ModelViewerWidget.routePath,
          builder: (context, params) => ModelViewerWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/loginPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/__.png',
                    fit: BoxFit.contain,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
