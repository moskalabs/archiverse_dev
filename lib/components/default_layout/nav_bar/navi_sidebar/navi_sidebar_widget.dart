import '/components/default_layout/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'navi_sidebar_model.dart';
export 'navi_sidebar_model.dart';

class NaviSidebarWidget extends StatefulWidget {
  const NaviSidebarWidget({
    super.key,
    required this.activePageName,
    bool? pageIsInSubMenu,
    this.subMenuName,
  }) : this.pageIsInSubMenu = pageIsInSubMenu ?? false;

  final String? activePageName;
  final bool pageIsInSubMenu;
  final String? subMenuName;

  @override
  State<NaviSidebarWidget> createState() => _NaviSidebarWidgetState();
}

class _NaviSidebarWidgetState extends State<NaviSidebarWidget> {
  late NaviSidebarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NaviSidebarModel());

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
      cursor: MouseCursor.defer,
      child: Visibility(
        visible: responsiveVisibility(
          context: context,
          phone: false,
        ),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeInOut,
          width: FFAppState().navOpen == true ? 230.0 : 90.0,
          height: double.infinity,
          constraints: BoxConstraints(
            minWidth: 90.0,
            maxWidth: 230.0,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF284E75),
          ),
          clipBehavior: Clip.hardEdge,
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
                                flex: 1,
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
                                                            'f634q456' /* 순천향대학교 */,
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
                                                            'x2haqn0l' /* 건축학과 */,
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
                                                                fontSize: 16.0,
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
                                      context.pushNamed(HomeWidget.routeName);
                                    },
                                    child: wrapWithModel(
                                      model: _model.menuItemModel1,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage:
                                            widget.activePageName == 'Home',
                                        text: 'HOME',
                                        icon: Icon(
                                          Icons.home,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName == 'Home'
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
                                      context.goNamed(
                                        ProfMyProfileWidget.routeName,
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
                                            'Myprofile',
                                        text: '내 정보',
                                        icon: Icon(
                                          Icons.person_outlined,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'Myprofile'
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
                                      context.goNamed(
                                        CalendarWidget.routeName,
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
                                      model: _model.menuItemModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'Calender',
                                        text: '캘린더',
                                        icon: Icon(
                                          Icons.calendar_month,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName == 'Calender'
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
                                      context.goNamed(
                                        ProfCoursePlanWidget.routeName,
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
                                            'coursePlan',
                                        text: '수업계획서',
                                        icon: Icon(
                                          Icons.app_registration_outlined,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'coursePlan'
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
                                      context.goNamed(
                                        ProfAttendanceSheetWidget.routeName,
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
                                      model: _model.menuItemModel5,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'AttendanceSheet',
                                        text: '출석부',
                                        icon: Icon(
                                          Icons.assignment_outlined,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'AttendanceSheet'
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
                                      context.goNamed(
                                        ProfGradeSheetWidget.routeName,
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
                                            'GradeSheet',
                                        text: '성적기록표',
                                        icon: Icon(
                                          Icons.abc_rounded,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'GradeSheet'
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
                                            .primary,
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
                                      context.goNamed(
                                        ProfLectureMaterialsWidget.routeName,
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
                                      model: _model.menuItemModel7,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'LectureMaterials',
                                        text: '강의자료실',
                                        icon: Icon(
                                          Icons.folder_copy_outlined,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'LectureMaterials'
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
                                            .primary,
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
                                      context.goNamed(
                                        ProfSubjectPortpolioWidget.routeName,
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
                                      model: _model.menuItemModel8,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'SubjectPortpolio',
                                        text: '과목 포트폴리오',
                                        icon: Icon(
                                          Icons.grid_view_rounded,
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
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      context.goNamed(
                                        StudentWorkEvalFormWidget.routeName,
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
                                      model: _model.menuItemModel9,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'StudentWorkEvalForm',
                                        text: '학생작품 평가표',
                                        icon: Icon(
                                          Icons
                                              .drive_file_rename_outline_outlined,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'StudentWorkEvalForm'
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
                                      context.goNamed(
                                        ProfResultsMidtermWidget.routeName,
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
                                      model: _model.menuItemModel10,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'MidtermResults',
                                        text: '중간 결과물',
                                        icon: Icon(
                                          Icons.format_list_bulleted_sharp,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'MidtermResults'
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
                                      context.goNamed(
                                        ProfResultsFinalWidget.routeName,
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
                                      model: _model.menuItemModel11,
                                      updateCallback: () => safeSetState(() {}),
                                      child: MenuItemWidget(
                                        isActivePage: widget.activePageName ==
                                            'FinalResults',
                                        text: '기말 결과물',
                                        icon: Icon(
                                          Icons.filter_1_outlined,
                                          color: valueOrDefault<Color>(
                                            widget.activePageName ==
                                                    'FinalResults'
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
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        context.goNamed(
                                          StudentRegistrationWidget.routeName,
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
                                        model: _model.menuItemModel12,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: MenuItemWidget(
                                          isActivePage:
                                              widget.activePageName ==
                                                  'StudentRegistration',
                                          text: '학부생 등록',
                                          icon: Icon(
                                            Icons.settings_sharp,
                                            color: valueOrDefault<Color>(
                                              widget.activePageName ==
                                                      'StudentRegistration'
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
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(LoginPageWidget.routeName);
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
                                                      '4cndz8ve' /* Log out */,
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
