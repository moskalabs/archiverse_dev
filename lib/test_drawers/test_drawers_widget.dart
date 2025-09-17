import '/components/default_layout/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'test_drawers_model.dart';
export 'test_drawers_model.dart';

class TestDrawersWidget extends StatefulWidget {
  const TestDrawersWidget({super.key});

  static String routeName = 'testDrawers';
  static String routePath = '/testDrawers';

  @override
  State<TestDrawersWidget> createState() => _TestDrawersWidgetState();
}

class _TestDrawersWidgetState extends State<TestDrawersWidget> {
  late TestDrawersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TestDrawersModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        endDrawer: Container(
          width: MediaQuery.sizeOf(context).width * 0.825,
          child: Drawer(
            elevation: 16.0,
            child: WebViewAware(
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).mainColor1,
                ),
                child: Visibility(
                  visible: responsiveVisibility(
                    context: context,
                    tabletLandscape: false,
                    desktop: false,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.5,
                                height: 50.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                ),
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor:
                                    FlutterFlowTheme.of(context).mainColor1,
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: FlutterFlowTheme.of(context).info,
                                  size: 25.0,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ].divide(SizedBox(width: 4.0)),
                          ),
                        if ((FFAppState().navbarMobile == true) &&
                            responsiveVisibility(
                              context: context,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 9,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                    HomeWidget.routeName);
                                              },
                                              child: wrapWithModel(
                                                model: _model.menuItemModel1,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: MenuItemWidget(
                                                  isActivePage: FFAppState()
                                                          .currentPage ==
                                                      'Home',
                                                  text: '통계/대시보드',
                                                  icon: Icon(
                                                    Icons.home,
                                                    color: Colors.white,
                                                    size: 24.0,
                                                  ),
                                                  hasNumberTag: false,
                                                  hasSubMenu: false,
                                                  subMenuExpanded: false,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.goNamed(
                                                  CalendarWidget.routeName,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.menuItemModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: MenuItemWidget(
                                                  isActivePage: FFAppState()
                                                          .currentPage ==
                                                      'Calender',
                                                  text: '학생 계정 관리',
                                                  icon: Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.white,
                                                    size: 24.0,
                                                  ),
                                                  hasNumberTag: false,
                                                  hasSubMenu: false,
                                                  subMenuExpanded: false,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.goNamed(
                                                  StudentWorkEvalFormWidget
                                                      .routeName,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.menuItemModel3,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: MenuItemWidget(
                                                  isActivePage: FFAppState()
                                                          .currentPage ==
                                                      'StudentWorkEvalForm',
                                                  text: '학생 제출 관리',
                                                  icon: Icon(
                                                    Icons
                                                        .drive_file_rename_outline_outlined,
                                                    color: Colors.white,
                                                    size: 24.0,
                                                  ),
                                                  hasNumberTag: false,
                                                  hasSubMenu: false,
                                                  subMenuExpanded: false,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.goNamed(
                                                  ProfResultsMidtermWidget
                                                      .routeName,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.menuItemModel4,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: MenuItemWidget(
                                                  isActivePage: FFAppState()
                                                          .currentPage ==
                                                      'MidtermResults',
                                                  text: '평가/검수 지원',
                                                  icon: Icon(
                                                    Icons
                                                        .format_list_bulleted_sharp,
                                                    color: Colors.white,
                                                    size: 24.0,
                                                  ),
                                                  hasNumberTag: false,
                                                  hasSubMenu: false,
                                                  subMenuExpanded: false,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.goNamed(
                                                  ProfResultsFinalWidget
                                                      .routeName,
                                                  extra: <String, dynamic>{
                                                    kTransitionInfoKey:
                                                        TransitionInfo(
                                                      hasTransition: true,
                                                      transitionType:
                                                          PageTransitionType
                                                              .fade,
                                                    ),
                                                  },
                                                );
                                              },
                                              child: wrapWithModel(
                                                model: _model.menuItemModel5,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: MenuItemWidget(
                                                  isActivePage: FFAppState()
                                                          .currentPage ==
                                                      'FinalResults',
                                                  text: '공지/알림관리',
                                                  icon: Icon(
                                                    Icons.filter_1_outlined,
                                                    color: Colors.white,
                                                    size: 24.0,
                                                  ),
                                                  hasNumberTag: false,
                                                  tagColor: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  hasSubMenu: false,
                                                  subMenuExpanded: false,
                                                ),
                                              ),
                                            ),
                                            if (false)
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.goNamed(
                                                    StudentRegistrationWidget
                                                        .routeName,
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                      ),
                                                    },
                                                  );
                                                },
                                                child: wrapWithModel(
                                                  model: _model.menuItemModel6,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: MenuItemWidget(
                                                    isActivePage: FFAppState()
                                                            .currentPage ==
                                                        'StudentRegistration',
                                                    text: '관리자 계정/관리',
                                                    icon: Icon(
                                                      Icons.settings_sharp,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                    ),
                                                    hasNumberTag: false,
                                                    tagColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    hasSubMenu: false,
                                                    subMenuExpanded: false,
                                                  ),
                                                ),
                                              ),
                                            if (false)
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  context.goNamed(
                                                    StudentRegistrationWidget
                                                        .routeName,
                                                    extra: <String, dynamic>{
                                                      kTransitionInfoKey:
                                                          TransitionInfo(
                                                        hasTransition: true,
                                                        transitionType:
                                                            PageTransitionType
                                                                .fade,
                                                      ),
                                                    },
                                                  );
                                                },
                                                child: wrapWithModel(
                                                  model: _model.menuItemModel7,
                                                  updateCallback: () =>
                                                      safeSetState(() {}),
                                                  child: MenuItemWidget(
                                                    isActivePage: FFAppState()
                                                            .currentPage ==
                                                        'StudentRegistration',
                                                    text: '로그아웃',
                                                    icon: Icon(
                                                      Icons.logout_rounded,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                    ),
                                                    hasNumberTag: false,
                                                    tagColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    hasSubMenu: false,
                                                    subMenuExpanded: false,
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ].divide(SizedBox(height: 8.0)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ]
                          .divide(SizedBox(height: 24.0))
                          .addToStart(SizedBox(height: 16.0)),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primary,
          automaticallyImplyLeading: false,
          title: Text(
            FFLocalizations.of(context).getText(
              '4hueg5o3' /* Page Title */,
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.openSans(
                    fontWeight:
                        FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                    fontStyle:
                        FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                  ),
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [],
          ),
        ),
      ),
    );
  }
}
