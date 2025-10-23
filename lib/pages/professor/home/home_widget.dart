import '/auth/supabase_auth/auth_util.dart';
import '/components/layout/responsive_layout_wrapper/responsive_layout_wrapper_widget.dart';
import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/components/dashboard/weekly_progress_table/weekly_progress_table_widget.dart';
import '/components/dashboard/midterm_final_results_table/midterm_final_results_table_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'home_model.dart';
export 'home_model.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  static String routeName = 'Home';
  static String routePath = '/home';

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with TickerProviderStateMixin {
  late HomeModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Get unique student names from subject submit list
  List<String> _getUniqueStudentNames() {
    final realStudents = _model.subjectSubmitList
        .map((e) => e.studentName)
        .withoutNulls
        .toSet()
        .toList();

    return realStudents;
  }

  // Helper functions for midterm/final results
  String _getMidtermSubmitStatus(String studentName) {
    try {
      final submission = _model.midtermResults?.firstWhere(
        (e) => e.studentName == studentName,
      );

      if (submission != null && submission.url != null && submission.url!.isNotEmpty) {
        return '제출';
      }
    } catch (e) {
      // No submission found for this student
    }
    return '-';
  }

  String _getMidtermGrade(String studentName) {
    // Always show '-' for grades (no score data)
    return '-';
  }

  String _getFinalSubmitStatus(String studentName) {
    try {
      final submission = _model.finalResults?.firstWhere(
        (e) => e.studentName == studentName,
      );

      if (submission != null && submission.url != null && submission.url!.isNotEmpty) {
        return '제출';
      }
    } catch (e) {
      // No submission found for this student
    }
    return '-';
  }

  String _getFinalGrade(String studentName) {
    // Always show '-' for grades (no score data)
    return '-';
  }

  // Helper function for weekly submit status
  String _getWeekSubmitStatus(String studentName, int week) {
    // Check if student submitted for this week
    // Week format in database: "1주차", "2주차", etc.
    final weekString = '${week}주차';

    try {
      final submission = _model.subjectSubmitList.firstWhere(
        (e) => e.studentName == studentName && e.week == weekString,
      );

      if (submission.url != null && submission.url!.isNotEmpty) {
        return '제출';
      }
    } catch (e) {
      // No submission found for this student/week
    }
    return '-';
  }

  // Helper method to get preview URL based on selection
  String? _getPreviewUrl() {
    if (_model.datatableNameSelect == null || _model.imageLoadByWeeks == null) {
      return null;
    }

    // Handle midterm submissions
    if (_model.imageLoadByWeeks == '중간') {
      try {
        final submission = _model.midtermResults?.firstWhere(
          (e) => e.studentName == _model.datatableNameSelect,
        );
        return submission?.url;
      } catch (e) {
        return null;
      }
    }

    // Handle final submissions
    if (_model.imageLoadByWeeks == '기말') {
      try {
        final submission = _model.finalResults?.firstWhere(
          (e) => e.studentName == _model.datatableNameSelect,
        );
        return submission?.url;
      } catch (e) {
        return null;
      }
    }

    // Handle weekly submissions
    try {
      final submission = _model.subjectSubmitList.firstWhere(
        (e) => e.studentName == _model.datatableNameSelect &&
               e.week == _model.imageLoadByWeeks,
      );
      return submission.url;
    } catch (e) {
      return null;
    }
  }

  // Callback handlers for table cell clicks
  void _onWeekCellTap(String studentName, int week) {
    final weekString = '${week}주차';
    setState(() {
      _model.datatableNameSelect = studentName;
      _model.imageLoadByWeeks = weekString;
    });
  }

  void _onMidtermTap(String studentName) {
    setState(() {
      _model.datatableNameSelect = studentName;
      _model.imageLoadByWeeks = '중간';
    });
  }

  void _onFinalTap(String studentName) {
    setState(() {
      _model.datatableNameSelect = studentName;
      _model.imageLoadByWeeks = '기말';
    });
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomeModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.weekAlloutput = await WeeksUploadTable().queryRows(
        queryFn: (q) => q.order('id'),
      );
      _model.studentNameOutputRow =
          await UploadByStudentAndWeeksTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'professor_name',
              FFAppState().professorNameSelected,
            )
            .order('id', ascending: true),
      );
      _model.studentOutputVar = _model.studentNameOutputRow!
          .map((e) => e.studentName)
          .withoutNulls
          .toList()
          .toList()
          .cast<String>();
      safeSetState(() {});
      _model.classoutput = await ClassTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'professor',
              FFAppState().professorNameSelected,
            )
            .eqOrNull(
              'course',
              FFAppState().courseNameSelected,
            )
            .eqOrNull(
              'year',
              FFAppState().yearSelected,
            )
            .eqOrNull(
              'semester',
              FFAppState().semesterSelected,
            )
            .eqOrNull(
              'section',
              FFAppState().sectionSelected,
            ),
      );
      FFAppState().studentOutputVar =
          _model.studentOutputVar.toList().cast<String>();
      safeSetState(() {});
      FFAppState().classSelectedID = _model.classoutput!.firstOrNull!.id;
      safeSetState(() {});
      _model.subjectOutput = await SubjectportpolioTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'class',
              FFAppState().classSelectedID,
            )
            .eqOrNull(
              'professor_name',
              FFAppState().professorNameSelected,
            )
            .eqOrNull(
              'section',
              FFAppState().sectionSelected,
            ),
      );
      _model.subjectSubmitList =
          _model.subjectOutput!.toList().cast<SubjectportpolioRow>();
      safeSetState(() {});
      _model.professorForImage = await ProfessorMyprofileTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'pfr_email',
          currentUserEmail,
        ),
      );
      FFAppState().mypageImageUrl = valueOrDefault<String>(
        _model.professorForImage?.firstOrNull?.pfrImageurl,
        'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/profileimage/myprofile/1739097345656000.jpg',
      );
      safeSetState(() {});

      // Load midterm and final results
      _model.midtermResults = await MidtermResultsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'professor_name',
              FFAppState().professorNameSelected,
            )
            .eqOrNull(
              'class',
              FFAppState().classSelectedID,
            ),
      );
      _model.finalResults = await FinalResultsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'professor_name',
              FFAppState().professorNameSelected,
            )
            .eqOrNull(
              'class',
              FFAppState().classSelectedID,
            ),
      );
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: ResponsiveLayoutWrapperWidget(
          child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFEEF1F6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    wrapWithModel(
                      model: _model.naviSidebarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NaviSidebarWidget(
                        activePageName: 'Home',
                        pageIsInSubMenu: false,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: wrapWithModel(
                                  model: _model.headerModel,
                                  updateCallback: () => safeSetState(() {}),
                                  updateOnChange: true,
                                  child: HeaderWidget(
                                    years: valueOrDefault<String>(
                                      _model.studentNameOutputRow?.firstOrNull
                                          ?.year,
                                      '0000년',
                                    ),
                                    semesterType: valueOrDefault<String>(
                                      _model.studentNameOutputRow?.firstOrNull
                                          ?.semesterType,
                                      '-학기',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color(0xFFEEF1F6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Flexible(
                                      flex: 3,
                                      child: wrapWithModel(
                                        model: _model.leftWidgetModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: LeftWidgetWidget(),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 16,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        5.0, 0.0, 5.0, 0.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.98,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        flex: 6,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              flex: 2,
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.38,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.61,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 5.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '73u92s8o' /* 주차별 설계 진행표 업로드여부 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: () {
                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                          return 12.0;
                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                          return 12.0;
                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                          return 14.0;
                                                                                        } else {
                                                                                          return 18.0;
                                                                                        }
                                                                                      }(),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                    ))
                                                                      Expanded(
                                                                        flex: 6,
                                                                        child:
                                                                            WeeklyProgressTableWidget(
                                                                              studentNames: _getUniqueStudentNames(),
                                                                              getWeekStatus: _getWeekSubmitStatus,
                                                                              onCellTap: _onWeekCellTap,
                                                                            ),
                                                                      ),
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              280.0,
                                                                          height:
                                                                              45.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '7vnoqdn0' /* 중간기말 결과물 업로드 여부 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: () {
                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                          return 12.0;
                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                          return 12.0;
                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                          return 14.0;
                                                                                        } else {
                                                                                          return 18.0;
                                                                                        }
                                                                                      }(),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    if (responsiveVisibility(
                                                                      context:
                                                                          context,
                                                                      phone:
                                                                          false,
                                                                      tablet:
                                                                          false,
                                                                    ))
                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            MidtermFinalResultsTableWidget(
                                                                              studentNames: _getUniqueStudentNames(),
                                                                              getMidtermStatus: _getMidtermSubmitStatus,
                                                                              getFinalStatus: _getFinalSubmitStatus,
                                                                              onMidtermTap: _onMidtermTap,
                                                                              onFinalTap: _onFinalTap,
                                                                            ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Container(
                                                                width: 413.0,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.61,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child:
                                                                      SafeArea(
                                                                    child:
                                                                        AnimatedContainer(
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              130),
                                                                      curve: Curves
                                                                          .bounceOut,
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.37,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.704,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(6.0),
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              3.0,
                                                                        ),
                                                                      ),
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          Stack(
                                                                            children: [
                                                                              if (_model.imageLoadByWeeks == null || _model.imageLoadByWeeks == '')
                                                                                Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'gb2mmy5c' /* 미리 보기 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 16.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 16.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 18.0;
                                                                                          } else {
                                                                                            return 20.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                            ],
                                                                          ),
                                                                          if (_model.imageLoadByWeeks != null &&
                                                                              _model.imageLoadByWeeks != '')
                                                                            FlutterFlowPdfViewer(
                                                                              networkPath: valueOrDefault<String>(
                                                                                _getPreviewUrl(),
                                                                                'd',
                                                                              ),
                                                                              width: double.infinity,
                                                                              height: double.infinity,
                                                                              horizontalScroll: false,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Flexible(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '101w6tzk' /* 업로드 최근 글 */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      fontSize: () {
                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                          return 12.0;
                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                          return 12.0;
                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                          return 14.0;
                                                                                        } else {
                                                                                          return 18.0;
                                                                                        }
                                                                                      }(),
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(1.0, 0.0),
                                                                              child: Container(
                                                                                width: 62.0,
                                                                                height: 33.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(1.0, 0.0),
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          safeSetState(() {
                                                                                            _model.tabBarController!.animateTo(
                                                                                              max(0, _model.tabBarController!.index - 1),
                                                                                              duration: Duration(milliseconds: 300),
                                                                                              curve: Curves.ease,
                                                                                            );
                                                                                          });
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.arrow_back_ios_new,
                                                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                                                          size: 24.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(1.0, 0.0),
                                                                                        child: InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            safeSetState(() {
                                                                                              _model.tabBarController!.animateTo(
                                                                                                min(_model.tabBarController!.length - 1, _model.tabBarController!.index + 1),
                                                                                                duration: Duration(milliseconds: 300),
                                                                                                curve: Curves.ease,
                                                                                              );
                                                                                            });
                                                                                          },
                                                                                          child: Icon(
                                                                                            Icons.arrow_forward_ios,
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            size: 24.0,
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
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
                                                              if (responsiveVisibility(
                                                                context:
                                                                    context,
                                                                phone: false,
                                                                tablet: false,
                                                              ))
                                                                Flexible(
                                                                  flex: 6,
                                                                  child: Column(
                                                                    children: [
                                                                      Align(
                                                                        alignment: Alignment(
                                                                            -1.0,
                                                                            0),
                                                                        child:
                                                                            TabBar(
                                                                          isScrollable:
                                                                              true,
                                                                          labelColor:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          unselectedLabelColor:
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          labelStyle: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                ),
                                                                                fontSize: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 12.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 12.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 14.0;
                                                                                  } else {
                                                                                    return 16.0;
                                                                                  }
                                                                                }(),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).titleMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleMedium.fontStyle,
                                                                                lineHeight: 1.0,
                                                                              ),
                                                                          unselectedLabelStyle:
                                                                              TextStyle(),
                                                                          indicatorColor:
                                                                              Color(0xFF284E75),
                                                                          tabs: [
                                                                            Tab(
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'c71s3swn' /* 전체 */,
                                                                              ),
                                                                            ),
                                                                            Tab(
                                                                              text: FFLocalizations.of(context).getText(
                                                                                '3d8oh6hx' /* 일정 알림 */,
                                                                              ),
                                                                            ),
                                                                            Tab(
                                                                              text: FFLocalizations.of(context).getText(
                                                                                'ys4cqpme' /* 업로드알림 */,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                          controller:
                                                                              _model.tabBarController,
                                                                          onTap:
                                                                              (i) async {
                                                                            [
                                                                              () async {},
                                                                              () async {},
                                                                              () async {}
                                                                            ][i]();
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            TabBarView(
                                                                          controller:
                                                                              _model.tabBarController,
                                                                          children: [
                                                                            KeepAliveWidgetWrapper(
                                                                              builder: (context) => Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            flex: 1,
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'jfrw3pc7' /* [건축학인증 시스템 '아키버스' 오픈안내] */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: 129.0,
                                                                                                      height: 25.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'jpugse31' /* 2025-04-14 03:52 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 10.0;
                                                                                                                  } else {
                                                                                                                    return 12.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: 90.0,
                                                                                                      height: 25.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            '6q4xe1zx' /* 관리자 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 10.0;
                                                                                                                  } else {
                                                                                                                    return 12.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: 131.0,
                                                                                                      height: 25.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'gpn2x2ad' /* 공지사항 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 10.0;
                                                                                                                  } else {
                                                                                                                    return 12.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                      child: Visibility(
                                                                                        visible: false,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'ssevp6ug' /* 1주차_연희동 구조 시안 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 129.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'aj8gguji' /* 2024-05-12 12:22 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 90.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'nofzxjxx' /* 김건우 학생 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 131.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'h62qab58' /* 강의자료 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            KeepAliveWidgetWrapper(
                                                                              builder: (context) => Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Expanded(
                                                                                            flex: 1,
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'vv2jcemn' /* [건축학인증 시스템 '아키버스' 오픈안내] */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                            child: Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: 129.0,
                                                                                                      height: 25.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'lxbktmld' /* 2025-04-14 03:52 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 10.0;
                                                                                                                  } else {
                                                                                                                    return 12.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: 90.0,
                                                                                                      height: 25.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'pi4jd35i' /* 관리자 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 10.0;
                                                                                                                  } else {
                                                                                                                    return 12.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                    child: Container(
                                                                                                      width: 131.0,
                                                                                                      height: 25.0,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      ),
                                                                                                      child: Align(
                                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                        child: Text(
                                                                                                          FFLocalizations.of(context).getText(
                                                                                                            'skgi0xuk' /* 공지사항 */,
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 10.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 10.0;
                                                                                                                  } else {
                                                                                                                    return 12.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.normal,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            KeepAliveWidgetWrapper(
                                                                              builder: (context) => Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                      child: Visibility(
                                                                                        visible: false,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'lf8aa4je' /* 2주차_천안아산시 컨셉 선정 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 129.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'l7mt4i6q' /* 2024-08-28 16:22 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 90.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              '1hlfjw6k' /* 나영석 학생 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 131.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'c3d3jeau' /* 과목 포트폴리오 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                      child: Visibility(
                                                                                        visible: false,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'osvnczz1' /* 3주차 과제 제출 등록 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 129.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'm9k95qzs' /* 2024-08-04 11:55 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 90.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'hcfac1kz' /* 김승 교수 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 131.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'xhqf5fda' /* 캘린더 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Flexible(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.69,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      ),
                                                                                      child: Visibility(
                                                                                        visible: false,
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'cryg7k1y' /* 1주차_연희동 구조 시안 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w600,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(2.0, 0.0, 0.0, 0.0),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(35.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 129.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'zd5p9dj9' /* 2024-05-12 12:22 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 90.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'v5jpavzx' /* 김건우 학생 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 10.0;
                                                                                                                    } else {
                                                                                                                      return 12.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Align(
                                                                                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                    child: Padding(
                                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                                      child: Container(
                                                                                                        width: 131.0,
                                                                                                        height: 25.0,
                                                                                                        decoration: BoxDecoration(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                        ),
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                          child: Text(
                                                                                                            FFLocalizations.of(context).getText(
                                                                                                              'ht8rbp52' /* 강의자료 */,
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.normal,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 10.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 13.0;
                                                                                                                    } else {
                                                                                                                      return 15.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.normal,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
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
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: wrapWithModel(
                                        model: _model.rightWidgetModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: RightWidgetWidget(),
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
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF1F6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: wrapWithModel(
                              model: _model.headerMobileModel,
                              updateCallback: () => safeSetState(() {}),
                              child: HeaderMobileWidget(),
                            ),
                          ),
                        ],
                      ),
                      if (responsiveVisibility(
                        context: context,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEF1F6),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ))
                                      Flexible(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFEEF1F6),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Flexible(
                                                flex: 16,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: Stack(
                                                    children: [
                                                      if ((_model.imageLoadByWeeks ==
                                                                  null ||
                                                              _model.imageLoadByWeeks ==
                                                                  '') &&
                                                          responsiveVisibility(
                                                            context: context,
                                                            tabletLandscape:
                                                                false,
                                                          ))
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, -1.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        5.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.88,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Flexible(
                                                                    flex: 6,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                              shape: BoxShape.rectangle,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                if (responsiveVisibility(
                                                                                  context: context,
                                                                                  tabletLandscape: false,
                                                                                  desktop: false,
                                                                                ))
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 280.0,
                                                                                        height: 45.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          borderRadius: BorderRadius.circular(16.0),
                                                                                        ),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '9zy4vv6a' /* 주차별 설계진행표 업로드 여부 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 14.0;
                                                                                                      } else {
                                                                                                        return 18.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (responsiveVisibility(
                                                                                  context: context,
                                                                                  tabletLandscape: false,
                                                                                  desktop: false,
                                                                                ))
                                                                                  Flexible(
                                                                                    flex: 4,
                                                                                    child: Container(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      constraints: BoxConstraints(
                                                                                        maxWidth: 1270.0,
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                        border: Border.all(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                      ),
                                                                                      child: Visibility(
                                                                                        visible: responsiveVisibility(
                                                                                          context: context,
                                                                                          tabletLandscape: false,
                                                                                          desktop: false,
                                                                                        ),
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            final subjecSubmittByStudent = _model.subjectSubmitList.map((e) => e.studentName).withoutNulls.toSet().toList();

                                                                                            return FlutterFlowDataTable<String>(
                                                                                              controller: _model.paginatedDataTableController2,
                                                                                              data: subjecSubmittByStudent,
                                                                                              columnsBuilder: (onSortChanged) => [
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        's15ih3xt' /* 명단 */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        'vm22jfhg' /* 1주차 */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        _model.imageLoadByWeeks = '1';
                                                                                                        safeSetState(() {});
                                                                                                      },
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'ylwptjpr' /* 2주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        _model.imageLoadByWeeks = '2';
                                                                                                        safeSetState(() {});
                                                                                                      },
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'cvo0p2d0' /* 3주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        _model.imageLoadByWeeks = '3';
                                                                                                        safeSetState(() {});
                                                                                                      },
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'mv4l8lxn' /* 4주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        _model.imageLoadByWeeks = '4';
                                                                                                        safeSetState(() {});
                                                                                                      },
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'bpvebbcz' /* 5주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () async {
                                                                                                        _model.imageLoadByWeeks = '5';
                                                                                                        safeSetState(() {});
                                                                                                      },
                                                                                                      child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          '3bapsbhi' /* 6주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'pb0nc64x' /* 7주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'e5s3qu03' /* 8주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'jccz0hvd' /* 9주차 */,
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          '4geys6t2' /* 10주차 */,
                                                                                                        ),
                                                                                                        maxLines: 1,
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'sekec2y8' /* 11주차 */,
                                                                                                        ),
                                                                                                        maxLines: 1,
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'ba4gsnay' /* 12주차 */,
                                                                                                        ),
                                                                                                        maxLines: 1,
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'c4j3dkt6' /* 13주차 */,
                                                                                                        ),
                                                                                                        maxLines: 1,
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          'ynt3cb95' /* 14주차 */,
                                                                                                        ),
                                                                                                        maxLines: 1,
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                DataColumn2(
                                                                                                  label: DefaultTextStyle.merge(
                                                                                                    softWrap: true,
                                                                                                    child: InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      focusColor: Colors.transparent,
                                                                                                      hoverColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: null, // Disabled
                                                                                          child: Text(
                                                                                                        FFLocalizations.of(context).getText(
                                                                                                          '0tg9xhdf' /* 15주차 */,
                                                                                                        ),
                                                                                                        maxLines: 1,
                                                                                                        style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                              ),
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 10.0;
                                                                                                                } else {
                                                                                                                  return 12.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ],
                                                                                              dataRowBuilder: (subjecSubmittByStudentItem, subjecSubmittByStudentIndex, selected, onSelectChanged) => DataRow(
                                                                                                color: WidgetStateProperty.all(
                                                                                                  subjecSubmittByStudentIndex % 2 == 0 ? FlutterFlowTheme.of(context).secondaryBackground : FlutterFlowTheme.of(context).primaryBackground,
                                                                                                ),
                                                                                                cells: [
                                                                                                  Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      subjecSubmittByStudentItem,
                                                                                                      '강초희',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 10.0;
                                                                                                            } else {
                                                                                                              return 12.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '1주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '1주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '1주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '2주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '2주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '2주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '3주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '3주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '3주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '4주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '4주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '4주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '5주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '5주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '5주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '6주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '6주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '6주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '7주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '7주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '7주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '8주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '8주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '8주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '9주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '9주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '9주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '10주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '10주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '10주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '11주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '11주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '11주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '12주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '12주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '12주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '13주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '13주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '13주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '14주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '14주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '14주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      _model.imageLoadByWeeks = '15주차';
                                                                                                      _model.datatableNameSelect = valueOrDefault<String>(
                                                                                                        subjecSubmittByStudentItem,
                                                                                                        '강초희',
                                                                                                      );
                                                                                                      safeSetState(() {});
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '15주차')).toList().elementAtOrNull(0)?.week != null && _model.subjectSubmitList.where((e) => (e.studentName == subjecSubmittByStudentItem) && (e.week == '15주차')).toList().elementAtOrNull(0)?.week != '' ? '0' : '-',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 10.0;
                                                                                                              } else {
                                                                                                                return 12.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                            letterSpacing: 0.0,
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ].map((c) => DataCell(c)).toList(),
                                                                                              ),
                                                                                              onPageChanged: (currentRowIndex) async {
                                                                                                _model.studentOutputVar = subjecSubmittByStudent.toList().cast<String>();
                                                                                                safeSetState(() {});
                                                                                              },
                                                                                              paginated: true,
                                                                                              selectable: false,
                                                                                              hidePaginator: false,
                                                                                              showFirstLastButtons: true,
                                                                                              headingRowHeight: 40.0,
                                                                                              dataRowHeight: 40.0,
                                                                                              columnSpacing: 10.0,
                                                                                              headingRowColor: FlutterFlowTheme.of(context).alternate,
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                              addHorizontalDivider: true,
                                                                                              addTopAndBottomDivider: false,
                                                                                              hideDefaultHorizontalDivider: true,
                                                                                              horizontalDividerColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              horizontalDividerThickness: 1.0,
                                                                                              addVerticalDivider: true,
                                                                                              verticalDividerColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              verticalDividerThickness: 1.0,
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (responsiveVisibility(
                                                                                  context: context,
                                                                                  tabletLandscape: false,
                                                                                  desktop: false,
                                                                                ))
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Container(
                                                                                        width: 280.0,
                                                                                        height: 45.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                          borderRadius: BorderRadius.circular(16.0),
                                                                                        ),
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'q2deez27' /* 중간기말 결과물 업로드 여부 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 14.0;
                                                                                                      } else {
                                                                                                        return 18.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                if (responsiveVisibility(
                                                                                  context: context,
                                                                                  tabletLandscape: false,
                                                                                  desktop: false,
                                                                                ))
                                                                                  Expanded(
                                                                                    flex: 2,
                                                                                    child: Container(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      constraints: BoxConstraints(
                                                                                        maxWidth: 1270.0,
                                                                                      ),
                                                                                      decoration: BoxDecoration(
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        borderRadius: BorderRadius.circular(8.0),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsets.all(5.0),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              tabletLandscape: false,
                                                                                              desktop: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 1,
                                                                                                child: Container(
                                                                                                  width: double.infinity,
                                                                                                  height: double.infinity,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        flex: 1,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 1,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Expanded(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: double.infinity,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Visibility(
                                                                                                              visible: responsiveVisibility(
                                                                                                                context: context,
                                                                                                                tabletLandscape: false,
                                                                                                                desktop: false,
                                                                                                              ),
                                                                                                              child: Align(
                                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                child: Text(
                                                                                                                  valueOrDefault<String>(
                                                                                                                    _getUniqueStudentNames().elementAtOrNull(0),
                                                                                                                    '학생',
                                                                                                                  ),
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.openSans(
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: () {
                                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                            return 10.0;
                                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                            return 10.0;
                                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                            return 10.0;
                                                                                                                          } else {
                                                                                                                            return 12.0;
                                                                                                                          }
                                                                                                                        }(),
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                valueOrDefault<String>(
                                                                                                                  _getUniqueStudentNames().elementAtOrNull(1),
                                                                                                                  '학생',
                                                                                                                ),
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: () {
                                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                          return 10.0;
                                                                                                                        } else {
                                                                                                                          return 12.0;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '-',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: () {
                                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                          return 10.0;
                                                                                                                        } else {
                                                                                                                          return 12.0;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '-',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: () {
                                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                          return 10.0;
                                                                                                                        } else {
                                                                                                                          return 12.0;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            borderRadius: BorderRadius.only(
                                                                                                              bottomLeft: Radius.circular(0.0),
                                                                                                              bottomRight: Radius.circular(0.0),
                                                                                                              topLeft: Radius.circular(0.0),
                                                                                                              topRight: Radius.circular(0.0),
                                                                                                            ),
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '-',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: () {
                                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                          return 10.0;
                                                                                                                        } else {
                                                                                                                          return 12.0;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '-',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: () {
                                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                          return 10.0;
                                                                                                                        } else {
                                                                                                                          return 12.0;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Container(
                                                                                                            width: 60.0,
                                                                                                            height: 100.0,
                                                                                                            decoration: BoxDecoration(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            ),
                                                                                                            child: Align(
                                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                              child: Text(
                                                                                                                '-',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                      fontSize: () {
                                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                          return 10.0;
                                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                          return 10.0;
                                                                                                                        } else {
                                                                                                                          return 12.0;
                                                                                                                        }
                                                                                                                      }(),
                                                                                                                      letterSpacing: 0.0,
                                                                                                                      fontWeight: FontWeight.w500,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Container(
                                                                                                              width: 60.0,
                                                                                                              height: 100.0,
                                                                                                              decoration: BoxDecoration(
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              ),
                                                                                                              child: Align(
                                                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                child: Text(
                                                                                                                  valueOrDefault<String>(
                                                                                                    _getUniqueStudentNames().elementAtOrNull(1),
                                                                                                    '학생',
                                                                                                  ),
                                                                                                                  textAlign: TextAlign.center,
                                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                        font: GoogleFonts.openSans(
                                                                                                                          fontWeight: FontWeight.w500,
                                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                        ),
                                                                                                                        fontSize: () {
                                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                            return 10.0;
                                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                            return 10.0;
                                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                            return 10.0;
                                                                                                                          } else {
                                                                                                                            return 12.0;
                                                                                                                          }
                                                                                                                        }(),
                                                                                                                        letterSpacing: 0.0,
                                                                                                                        fontWeight: FontWeight.w500,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                      ),
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              tabletLandscape: false,
                                                                                              desktop: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 4,
                                                                                                child: Container(
                                                                                                  width: double.infinity,
                                                                                                  height: double.infinity,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        flex: 1,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'c2qfo6un' /* 중간
결과물 */
                                                                                                                ,
                                                                                                              ),
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: () {
                                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                        return 10.0;
                                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                        return 10.0;
                                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                        return 10.0;
                                                                                                                      } else {
                                                                                                                        return 12.0;
                                                                                                                      }
                                                                                                                    }(),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 1,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 50.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                    border: Border.all(
                                                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                                                      width: 1.0,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                    border: Border.all(
                                                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                                                      width: 1.0,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      FFLocalizations.of(context).getText(
                                                                                                                        'oxgqdf9v' /* 점수 */,
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      _getMidtermSubmitStatus(_getUniqueStudentNames().elementAtOrNull(1) ?? '학생'),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      _getMidtermGrade(_getUniqueStudentNames().elementAtOrNull(1) ?? '학생'),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      _getFinalSubmitStatus(_getUniqueStudentNames().elementAtOrNull(1) ?? '학생'),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      _getFinalGrade(_getUniqueStudentNames().elementAtOrNull(1) ?? '학생'),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                            if (responsiveVisibility(
                                                                                              context: context,
                                                                                              tabletLandscape: false,
                                                                                              desktop: false,
                                                                                            ))
                                                                                              Expanded(
                                                                                                flex: 4,
                                                                                                child: Container(
                                                                                                  width: double.infinity,
                                                                                                  height: 100.0,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        flex: 1,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                'dv5jhwh7' /* 기말 
결과물 */
                                                                                                                ,
                                                                                                              ),
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                    font: GoogleFonts.openSans(
                                                                                                                      fontWeight: FontWeight.w600,
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                    ),
                                                                                                                    fontSize: () {
                                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                        return 10.0;
                                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                        return 10.0;
                                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                        return 10.0;
                                                                                                                      } else {
                                                                                                                        return 12.0;
                                                                                                                      }
                                                                                                                    }(),
                                                                                                                    letterSpacing: 0.0,
                                                                                                                    fontWeight: FontWeight.w600,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                      Flexible(
                                                                                                        flex: 1,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                    border: Border.all(
                                                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                                                      width: 1.0,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                    border: Border.all(
                                                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                                                      width: 1.0,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      FFLocalizations.of(context).getText(
                                                                                                                        'i2lamrd6' /* 점수 */,
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      '-',
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      FFLocalizations.of(context).getText(
                                                                                                                        'eub78i1h' /* - */,
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      FFLocalizations.of(context).getText(
                                                                                                                        '5ttldwa1' /* - */,
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                                        flex: 2,
                                                                                                        child: Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.05,
                                                                                                          height: 100.0,
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            border: Border.all(
                                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                                              width: 1.0,
                                                                                                            ),
                                                                                                          ),
                                                                                                          child: Column(
                                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                                            children: [
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      FFLocalizations.of(context).getText(
                                                                                                                        'qpwanx7w' /* - */,
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                          ),
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ),
                                                                                                              ),
                                                                                                              Expanded(
                                                                                                                flex: 1,
                                                                                                                child: Container(
                                                                                                                  width: 50.0,
                                                                                                                  height: 30.0,
                                                                                                                  decoration: BoxDecoration(
                                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  ),
                                                                                                                  child: Align(
                                                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                                    child: Text(
                                                                                                                      FFLocalizations.of(context).getText(
                                                                                                                        'y8trob95' /* - */,
                                                                                                                      ),
                                                                                                                      textAlign: TextAlign.center,
                                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                            font: GoogleFonts.openSans(
                                                                                                                              fontWeight: FontWeight.w500,
                                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                            ),
                                                                                                                            fontSize: () {
                                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                                return 10.0;
                                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                                return 10.0;
                                                                                                                              } else {
                                                                                                                                return 12.0;
                                                                                                                              }
                                                                                                                            }(),
                                                                                                                            letterSpacing: 0.0,
                                                                                                                            fontWeight: FontWeight.w500,
                                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                          ],
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      if ((_model.imageLoadByWeeks !=
                                                                  null &&
                                                              _model.imageLoadByWeeks !=
                                                                  '') &&
                                                          responsiveVisibility(
                                                            context: context,
                                                            tabletLandscape:
                                                                false,
                                                            desktop: false,
                                                          ))
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: SafeArea(
                                                              child:
                                                                  AnimatedContainer(
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        130),
                                                                curve: Curves
                                                                    .bounceOut,
                                                                width: double
                                                                    .infinity,
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6.0),
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 3.0,
                                                                  ),
                                                                ),
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              16.0),
                                                                  child: Stack(
                                                                    children: [
                                                                      if ((_model.imageLoadByWeeks != null &&
                                                                              _model.imageLoadByWeeks != '') &&
                                                                          responsiveVisibility(
                                                                            context:
                                                                                context,
                                                                            tabletLandscape:
                                                                                false,
                                                                            desktop:
                                                                                false,
                                                                          ))
                                                                        FlutterFlowPdfViewer(
                                                                          networkPath:
                                                                              valueOrDefault<String>(
                                                                            _getPreviewUrl(),
                                                                            'd',
                                                                          ),
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              double.infinity,
                                                                          horizontalScroll:
                                                                              false,
                                                                        ),
                                                                      if (responsiveVisibility(
                                                                        context:
                                                                            context,
                                                                        tabletLandscape:
                                                                            false,
                                                                        desktop:
                                                                            false,
                                                                      ))
                                                                        FlutterFlowIconButton(
                                                                          borderRadius:
                                                                              8.0,
                                                                          buttonSize:
                                                                              40.0,
                                                                          fillColor:
                                                                              Color(0xFF284E75),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.arrow_back,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            context.safePop();
                                                                          },
                                                                        ),
                                                                    ],
                                                                  ),
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
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.naviSidebarMobileModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NaviSidebarMobileWidget(
                                      activePageName: 'Home',
                                      pageIsInSubMenu: false,
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
              if (FFAppState().channelTalk == true)
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: FlutterFlowWebView(
                    content:
                        '<script>\n  (function(){var w=window;if(w.ChannelIO){return w.console.error(\"ChannelIO script included twice.\");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement(\"script\");s.type=\"text/javascript\";s.async=true;s.src=\"https://cdn.channel.io/plugin/ch-plugin-web.js\";var x=document.getElementsByTagName(\"script\")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState===\"complete\"){l();}else{w.addEventListener(\"DOMContentLoaded\",l);w.addEventListener(\"load\",l);}})();\n\n  ChannelIO(\'boot\', {\n    \"pluginKey\": \"4f440600-f8b3-494e-b133-5476520fcf8a\"\n  });\n</script>',
                    width: 550.0,
                    height: 680.0,
                    verticalScroll: false,
                    horizontalScroll: false,
                    html: true,
                  ),
                ),
            ],
          ),
        ),
      ),
        ),
    );
  }
}
