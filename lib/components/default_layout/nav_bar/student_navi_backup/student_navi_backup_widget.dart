import '/components/default_layout/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'student_navi_backup_model.dart';
export 'student_navi_backup_model.dart';

class StudentNaviBackupWidget extends StatefulWidget {
  const StudentNaviBackupWidget({
    super.key,
    required this.activePageName,
    bool? pageIsInSubMenu,
    this.subMenuName,
  }) : this.pageIsInSubMenu = pageIsInSubMenu ?? false;

  final String? activePageName;
  final bool pageIsInSubMenu;
  final String? subMenuName;

  @override
  State<StudentNaviBackupWidget> createState() =>
      _StudentNaviBackupWidgetState();
}

class _StudentNaviBackupWidgetState extends State<StudentNaviBackupWidget> {
  late StudentNaviBackupModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentNaviBackupModel());

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

    return Visibility(
      visible: true,
      child: Align(
        alignment: AlignmentDirectional(1.0, 0.0),
        child: MouseRegion(
          opaque: false,
          cursor: MouseCursor.defer,
          child: Visibility(
            visible: true,
            child: Align(
              alignment: AlignmentDirectional(1.0, -1.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 150),
                curve: Curves.easeInOut,
                width: FFAppState().studentNavbarMobile == true ? 230.0 : 65.0,
                height: FFAppState().studentNavbarMobile == true
                    ? double.infinity
                    : 60.0,
                constraints: BoxConstraints(
                  minWidth: 90.0,
                  maxWidth: 290.0,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF284E75),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: AlignmentDirectional(0.0, -1.0),
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
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  if (FFAppState()
                                                          .studentNavbarMobile ==
                                                      true) {
                                                    FFAppState()
                                                            .studentNavbarMobile =
                                                        false;
                                                    safeSetState(() {});
                                                  } else {
                                                    FFAppState()
                                                            .studentNavbarMobile =
                                                        true;
                                                    safeSetState(() {});
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.dehaze,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  size: 40.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 0.0),
                                                    child: Container(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/Rectangle_69.png',
                                                          width: 45.0,
                                                          height: 50.0,
                                                          fit: BoxFit.fill,
                                                          alignment: Alignment(
                                                              -1.0, 0.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                if (((FFAppState().navOpen ==
                                                            true) ||
                                                        (FFAppState()
                                                                .studentNavbarMobile ==
                                                            true)) &&
                                                    true)
                                                  Expanded(
                                                    flex: 1,
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    10.0,
                                                                    5.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: Container(
                                                          width: 150.0,
                                                          height: 50.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'dkj4mdo9' /* 순천향대학교 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
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
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '87jvxp2d' /* 건축학과 */,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
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
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 4.0)),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
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
                                          context.pushNamed(
                                            StudentHomeWidget.routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel1,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_Home',
                                            text: 'HOME',
                                            icon: Icon(
                                              Icons.home,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'Student_Home'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
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
                                            StudentMyProfileWidget.routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel2,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_MyProfile',
                                            text: '마이페이지',
                                            icon: Icon(
                                              Icons.person_outline,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'Student_MyProfile'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
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
                                              StudentCalenderWidget.routeName);
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_Calender',
                                            text: '캘린더',
                                            icon: Icon(
                                              Icons.calendar_month,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'Student_Calender'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
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
                                            StudentCoursePlanWidget.routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel4,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_CoursePlan',
                                            text: '수업계획서',
                                            icon: Icon(
                                              Icons.app_registration_outlined,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'coursePlan'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
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
                                            StudentLectureMaterialWidget
                                                .routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel5,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_LectureMaterial',
                                            text: '강의자료실',
                                            icon: Icon(
                                              Icons.folder_copy_outlined,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'Student_LectureMaterial'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
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
                                            StudentSubjectPortpolioWidget
                                                .routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel6,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_SubjectPortpolio',
                                            text: '주차별 설계진행표',
                                            icon: Icon(
                                              Icons.grid_view_rounded,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'SubjectPortpolio'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                              ),
                                              size: 24.0,
                                            ),
                                            hasNumberTag: false,
                                            tagColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
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
                                            StudentResultsMidtermWidget
                                                .routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel7,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_MidtermResults',
                                            text: '1차 결과물',
                                            icon: Icon(
                                              Icons.format_list_bulleted_sharp,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'MidtermResults'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
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
                                            StudentResultsFinalWidget.routeName,
                                            extra: <String, dynamic>{
                                              kTransitionInfoKey:
                                                  TransitionInfo(
                                                hasTransition: true,
                                                transitionType:
                                                    PageTransitionType.fade,
                                              ),
                                            },
                                          );
                                        },
                                        child: wrapWithModel(
                                          model: _model.menuItemModel8,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: MenuItemWidget(
                                            isActivePage:
                                                widget.activePageName ==
                                                    'Student_FinalResults',
                                            text: '2차 결과물',
                                            icon: Icon(
                                              Icons.filter_1_outlined,
                                              color: valueOrDefault<Color>(
                                                widget.activePageName ==
                                                        'FinalResults'
                                                    ? Color(0xFF284E75)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                FlutterFlowTheme.of(context)
                                                    .secondaryText,
                                              ),
                                              size: 24.0,
                                            ),
                                            hasNumberTag: false,
                                            tagColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            hasSubMenu: false,
                                            subMenuExpanded: false,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                          context.pushNamed(
                                              LoginPageWidget.routeName);
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 50.0,
                                          decoration: BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          15.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    width: 35.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Icon(
                                                        Icons.logout,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        size: 24.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              if (((FFAppState().navOpen ==
                                                          true) ||
                                                      (FFAppState()
                                                              .studentNavbarMobile ==
                                                          false)) &&
                                                  true)
                                                Expanded(
                                                  child: Container(
                                                    width: 200.0,
                                                    height: 50.0,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (((FFAppState()
                                                                        .navOpen ==
                                                                    true) ||
                                                                (FFAppState()
                                                                        .studentNavbarMobile ==
                                                                    false)) &&
                                                            true)
                                                          Flexible(
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'gypsxppc' /* Log out */,
                                                              ),
                                                              maxLines: 1,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
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
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiary,
                                                                    fontSize:
                                                                        () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointSmall) {
                                                                        return 10.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointMedium) {
                                                                        return 12.0;
                                                                      } else if (MediaQuery.sizeOf(context)
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
                                                                    fontStyle: FlutterFlowTheme.of(
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
                            ].divide(SizedBox(height: 8.0)),
                          ),
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
          onEnter: ((event) async {
            safeSetState(() => _model.mouseRegionHovered = true);
          }),
          onExit: ((event) async {
            safeSetState(() => _model.mouseRegionHovered = false);
          }),
        ),
      ),
    );
  }
}
