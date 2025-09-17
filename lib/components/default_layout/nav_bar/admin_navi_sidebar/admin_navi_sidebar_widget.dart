import '/auth/supabase_auth/auth_util.dart';
import '/components/default_layout/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'admin_navi_sidebar_model.dart';
export 'admin_navi_sidebar_model.dart';

class AdminNaviSidebarWidget extends StatefulWidget {
  const AdminNaviSidebarWidget({
    super.key,
    required this.activePageName,
    bool? pageIsInSubMenu,
    this.subMenuName,
  }) : this.pageIsInSubMenu = pageIsInSubMenu ?? false;

  final String? activePageName;
  final bool pageIsInSubMenu;
  final String? subMenuName;

  @override
  State<AdminNaviSidebarWidget> createState() => _AdminNaviSidebarWidgetState();
}

class _AdminNaviSidebarWidgetState extends State<AdminNaviSidebarWidget> {
  late AdminNaviSidebarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminNaviSidebarModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return MouseRegion(
      opaque: false,
      cursor: MouseCursor.defer ?? MouseCursor.defer,
      child: Visibility(
        visible: responsiveVisibility(
          context: context,
          phone: false,
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: FFAppState().navOpen == true ? 230.0 : 72.0,
          height: double.infinity,
          constraints: BoxConstraints(
            minWidth: 90.0,
            maxWidth: 290.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF284E75),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Container(
                          width: 200.0,
                          height: 120.0,
                          decoration: BoxDecoration(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Icon(
                                      Icons.dehaze,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                          child: Container(
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                'assets/images/Rectangle_69.png',
                                                width: 45.0,
                                                height: 50.0,
                                                fit: BoxFit.fill,
                                                alignment: Alignment(-1.0, 0.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if ((FFAppState().navOpen == true) &&
                                          responsiveVisibility(
                                            context: context,
                                            phone: false,
                                          ))
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 5.0, 0.0, 0.0),
                                              child: Container(
                                                width: 150.0,
                                                height: 50.0,
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            'qqxaqtp4' /* 순천향대학교 */,
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 16.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Text(
                                                          FFLocalizations.of(
                                                                  context)
                                                              .getText(
                                                            '54sngwm7' /* 건축학과 */,
                                                          ),
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font: GoogleFonts
                                                                    .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 15.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      '62hmobjm' /* 관리자 */,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: () {
                                            if (MediaQuery.sizeOf(context)
                                                    .width <
                                                kBreakpointSmall) {
                                              return 10.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointMedium) {
                                              return 10.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointLarge) {
                                              return 10.0;
                                            } else {
                                              return 12.0;
                                            }
                                          }(),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ].divide(SizedBox(width: 4.0)),
                  ),
                ),
                Expanded(
                  flex: 10,
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
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AdminDashWidget.routeName,
                                        queryParameters: {
                                          'userType': serializeParam(
                                            0,
                                            ParamType.int,
                                          ),
                                          'email': serializeParam(
                                            '',
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.menuItemModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'AdminRecent',
                                        text: '대시보드',
                                        icon: Icon(
                                          FFIcons.kadmindash,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'Student_Home'
                                                ? Color(0xFF284E75)
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
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
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AdminClassChangeWidget.routeName,
                                        queryParameters: {
                                          'userType': serializeParam(
                                            FFAppState().usertype,
                                            ParamType.int,
                                          ),
                                          'email': serializeParam(
                                            currentUserEmail,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.menuItemModel2,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'AdminClassChange',
                                        text: '학생계정관리',
                                        icon: Icon(
                                          FFIcons.kstudentadmin,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'Student_MyProfile'
                                                ? Color(0xFF284E75)
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
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
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AdminStudentSubmitWidget.routeName,
                                        queryParameters: {
                                          'userType': serializeParam(
                                            FFAppState().usertype,
                                            ParamType.int,
                                          ),
                                          'email': serializeParam(
                                            currentUserEmail,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.menuItemModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'AdminStudentSubmit',
                                        text: '학생 제출 관리',
                                        icon: Icon(
                                          FFIcons.kadminStudentsubmit,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'Student_Calender'
                                                ? Color(0xFF284E75)
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
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
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AdminPortfolioWidget.routeName,
                                        queryParameters: {
                                          'userType': serializeParam(
                                            FFAppState().usertype,
                                            ParamType.int,
                                          ),
                                          'email': serializeParam(
                                            currentUserEmail,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.menuItemModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'AdminPortfolio',
                                        text: '평가/검수 지원',
                                        icon: Icon(
                                          FFIcons.kevaluationicon,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'AdminPortpolio'
                                                ? Color(0xFF284E75)
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                          size: 24.0,
                                        ),
                                        hasNumberTag: false,
                                        hasSubMenu: false,
                                        subMenuExpanded: false,
                                      ),
                                    ),
                                  ),
                                  wrapWithModel(
                                    model: _model.menuItemModel5,
                                    updateCallback: () => safeSetState(() {}),
                                    child: MenuItemWidget(
                                      isActivePage: widget.activePageName ==
                                          'Student_LectureMaterial',
                                      text: '공지/알람 관리',
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color: valueOrDefault<Color>(
                                          widget.activePageName ==
                                                  'Student_LectureMaterial'
                                              ? Color(0xFF284E75)
                                              : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        size: 24.0,
                                      ),
                                      hasNumberTag: false,
                                      hasSubMenu: false,
                                      subMenuExpanded: false,
                                    ),
                                  ),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.pushNamed(
                                        AdminAccountManageWidget.routeName,
                                        queryParameters: {
                                          'userType': serializeParam(
                                            FFAppState().usertype,
                                            ParamType.int,
                                          ),
                                          'email': serializeParam(
                                            currentUserEmail,
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    },
                                    child: wrapWithModel(
                                      model: _model.menuItemModel6,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'AdminManager',
                                        text: '관리자 계정/관리',
                                        icon: Icon(
                                          FFIcons.kadminidicon,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'SubjectPortpolio'
                                                ? Color(0xFF284E75)
                                                : FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                          size: 24.0,
                                        ),
                                        hasNumberTag: false,
                                        tagColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
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
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(AdminLoginWidget.routeName);
                              },
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                                decoration: BoxDecoration(),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                    ))
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width: 35.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Icon(
                                              Icons.logout,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if ((FFAppState().navOpen == true) &&
                                        responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                        ))
                                      Expanded(
                                        child: Container(
                                          width: 200.0,
                                          height: 50.0,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              if ((FFAppState().navOpen ==
                                                      true) &&
                                                  responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                  ))
                                                Flexible(
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '43a1mt1c' /* Log out */,
                                                    ),
                                                    maxLines: 1,
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyLarge
                                                            .override(
                                                              font: GoogleFonts
                                                                  .poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyLarge
                                                                    .fontStyle,
                                                              ),
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .tertiary,
                                                              fontSize: () {
                                                                if (MediaQuery.sizeOf(
                                                                            context)
                                                                        .width <
                                                                    kBreakpointSmall) {
                                                                  return 8.0;
                                                                } else if (MediaQuery.sizeOf(
                                                                            context)
                                                                        .width <
                                                                    kBreakpointMedium) {
                                                                  return 12.0;
                                                                } else if (MediaQuery.sizeOf(
                                                                            context)
                                                                        .width <
                                                                    kBreakpointLarge) {
                                                                  return 15.0;
                                                                } else {
                                                                  return 15.0;
                                                                }
                                                              }(),
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyLarge
                                                                      .fontStyle,
                                                            ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
      onEnter: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = true);
        if (FFAppState().navOpen == true) {
          FFAppState().navOpen = false;
          safeSetState(() {});
        } else {
          FFAppState().navOpen = true;
          safeSetState(() {});
        }
      }),
      onExit: ((event) async {
        safeSetState(() => _model.mouseRegionHovered = false);
        if (FFAppState().navOpen == true) {
          FFAppState().navOpen = false;
          safeSetState(() {});
        } else {
          FFAppState().navOpen = true;
          safeSetState(() {});
        }
      }),
    );
  }
}
