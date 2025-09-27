import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/dashboard/dashboard_class_container/dashboard_class_container_widget.dart';
import '/components/dashboard/dashboard_class_container_m/dashboard_class_container_m_widget.dart';
import '/components/dashboard/lecture_material/lecture_material_widget.dart';
import '/components/dashboard/progress_container_detail/progress_container_detail_widget.dart';
import '/components/dashboard/progress_container_s/progress_container_s_widget.dart';
import '/components/dashboard/progress_container_weeks/progress_container_weeks_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/nav_bar/admin_navi_sidebar/admin_navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/random_data_util.dart' as random_data;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'admin_dash_model.dart';
export 'admin_dash_model.dart';

class AdminDashWidget extends StatefulWidget {
  const AdminDashWidget({
    super.key,
    required this.userType,
    required this.email,
  });

  final int? userType;
  final String? email;

  static String routeName = 'AdminDash';
  static String routePath = '/AdminDash';

  @override
  State<AdminDashWidget> createState() => _AdminDashWidgetState();
}

class _AdminDashWidgetState extends State<AdminDashWidget> {
  late AdminDashModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminDashModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.prfOutput = await PostsTable().queryRows(
        queryFn: (q) => q,
      );
      _model.professorName = valueOrDefault<String>(
        _model.prfOutput?.firstOrNull?.name,
        '교수 이름',
      );
      safeSetState(() {});
      _model.classSelectedOnLoad = await ClassTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'year',
              valueOrDefault<String>(
                _model.dropDownYearValue1,
                '2025',
              ),
            )
            .eqOrNull(
              'semester',
              valueOrDefault<String>(
                _model.dropDownSemesterValue1,
                '1학기',
              ),
            ),
      );
      _model.isDesignClass = true;
      _model.filteredClass = _model.classSelectedOnLoad!
          .where((e) => e.grade == 1)
          .toList()
          .toList()
          .cast<ClassRow>();
      safeSetState(() {});
      _model.allStudentsByYearSem = await CourseStudentTable().queryRows(
        queryFn: (q) => q
            .eqOrNull(
              'year',
              _model.dropDownYearValue1,
            )
            .eqOrNull(
              'semester',
              _model.dropDownSemesterValue1,
            ),
      );
      _model.allStudents =
          _model.allStudentsByYearSem!.toList().cast<CourseStudentRow>();
      safeSetState(() {});
      FFAppState().usertype = 0;
      safeSetState(() {});
    });

    _model.searchTextFieldTextController ??= TextEditingController();
    _model.searchTextFieldFocusNode ??= FocusNode();

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
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height,
              ),
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    wrapWithModel(
                      model: _model.adminNaviSidebarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: AdminNaviSidebarWidget(
                        activePageName: 'AdminRecent',
                        pageIsInSubMenu: false,
                      ),
                    ),
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEF1F6),
                              shape: BoxShape.rectangle,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                ))
                                  Flexible(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2.0,
                                                                  5.0,
                                                                  2.0,
                                                                  5.0),
                                                      child: FutureBuilder<
                                                          List<YearsRow>>(
                                                        future: YearsTable()
                                                            .queryRows(
                                                          queryFn: (q) => q,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    Color(
                                                                        0xFF284E75),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<YearsRow>
                                                              dropDownYearYearsRowList =
                                                              snapshot.data!;

                                                          return FlutterFlowDropDown<
                                                              String>(
                                                            controller: _model
                                                                    .dropDownYearValueController1 ??=
                                                                FormFieldController<
                                                                    String>(
                                                              _model.dropDownYearValue1 ??=
                                                                  valueOrDefault<
                                                                      String>(
                                                                dropDownYearYearsRowList
                                                                    .lastOrNull
                                                                    ?.year,
                                                                '2025',
                                                              ),
                                                            ),
                                                            options:
                                                                dropDownYearYearsRowList
                                                                    .map((e) =>
                                                                        e.year)
                                                                    .withoutNulls
                                                                    .toList(),
                                                            onChanged:
                                                                (val) async {
                                                              safeSetState(() =>
                                                                  _model.dropDownYearValue1 =
                                                                      val);
                                                              _model.years =
                                                                  valueOrDefault<
                                                                      String>(
                                                                _model
                                                                    .dropDownYearValue1,
                                                                '2025',
                                                              );
                                                              safeSetState(
                                                                  () {});
                                                              _model.semester =
                                                                  '1학기';
                                                              _model.buttonGrades =
                                                                  -1;
                                                              _model.semesterGradeOutput =
                                                                  [];
                                                              _model.yearsSemesterMapOutput =
                                                                  [];
                                                              _model.courseBySelectOutputVar =
                                                                  [];
                                                              _model.courseSectionOutputVar =
                                                                  [];
                                                              _model.classOnLoad = _model
                                                                  .classSelectedOnLoad!
                                                                  .where((e) =>
                                                                      (e.year ==
                                                                          _model
                                                                              .years) &&
                                                                      (e.semester ==
                                                                          _model
                                                                              .semester))
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              _model.classAfterGrade =
                                                                  [];
                                                              _model.buttonColor1 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor2 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor3 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor4 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor5 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.textColor1 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor2 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor3 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor4 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor5 =
                                                                  Color(
                                                                      4280831605);
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            width: 160.0,
                                                            height: 40.0,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .neutral500,
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointSmall) {
                                                                          return 6.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointMedium) {
                                                                          return 8.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointLarge) {
                                                                          return 10.0;
                                                                        } else {
                                                                          return 12.0;
                                                                        }
                                                                      }(),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                            hintText:
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                              'mmi81a4v' /* 년도 선택 */,
                                                            ),
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_sharp,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 16.0,
                                                            ),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            elevation: 0.0,
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .neutral200,
                                                            borderWidth: 1.0,
                                                            borderRadius: 8.0,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        14.0,
                                                                        4.0,
                                                                        10.0,
                                                                        4.0),
                                                            hidesUnderline:
                                                                true,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  2.0,
                                                                  5.0,
                                                                  2.0,
                                                                  5.0),
                                                      child: FutureBuilder<
                                                          List<SemestersRow>>(
                                                        future: SemestersTable()
                                                            .queryRows(
                                                          queryFn: (q) => q,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    Color(
                                                                        0xFF284E75),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          List<SemestersRow>
                                                              dropDownSemesterSemestersRowList =
                                                              snapshot.data!;

                                                          return FlutterFlowDropDown<
                                                              String>(
                                                            controller: _model
                                                                    .dropDownSemesterValueController1 ??=
                                                                FormFieldController<
                                                                    String>(
                                                              _model.dropDownSemesterValue1 ??=
                                                                  valueOrDefault<
                                                                      String>(
                                                                dropDownSemesterSemestersRowList
                                                                    .firstOrNull
                                                                    ?.semesterType,
                                                                '1학기',
                                                              ),
                                                            ),
                                                            options: dropDownSemesterSemestersRowList
                                                                .map((e) => e
                                                                    .semesterType)
                                                                .withoutNulls
                                                                .toList(),
                                                            onChanged:
                                                                (val) async {
                                                              safeSetState(() =>
                                                                  _model.dropDownSemesterValue1 =
                                                                      val);
                                                              _model.semester =
                                                                  valueOrDefault<
                                                                      String>(
                                                                _model
                                                                    .dropDownSemesterValue1,
                                                                '1학기',
                                                              );
                                                              _model.buttonGrades =
                                                                  -1;
                                                              _model.semesterGradeOutput =
                                                                  [];
                                                              _model.yearsSemesterMapOutput =
                                                                  [];
                                                              _model.courseBySelectOutputVar =
                                                                  [];
                                                              _model.courseSectionOutputVar =
                                                                  [];
                                                              _model.classOnLoad = _model
                                                                  .classSelectedOnLoad!
                                                                  .where((e) =>
                                                                      (e.year ==
                                                                          _model
                                                                              .years) &&
                                                                      (e.semester ==
                                                                          _model
                                                                              .semester))
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              _model.classAfterGrade =
                                                                  [];
                                                              _model.buttonColor1 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor2 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor3 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor4 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor5 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.textColor1 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor2 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor3 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor4 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor5 =
                                                                  Color(
                                                                      4280831605);
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            width: 160.0,
                                                            height: 40.0,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .neutral500,
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointSmall) {
                                                                          return 6.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointMedium) {
                                                                          return 8.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointLarge) {
                                                                          return 10.0;
                                                                        } else {
                                                                          return 12.0;
                                                                        }
                                                                      }(),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                            hintText:
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                              'g1xl8lax' /* 학기 선택 */,
                                                            ),
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_sharp,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              size: 16.0,
                                                            ),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            elevation: 0.0,
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .neutral200,
                                                            borderWidth: 1.0,
                                                            borderRadius: 8.0,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        14.0,
                                                                        4.0,
                                                                        10.0,
                                                                        4.0),
                                                            hidesUnderline:
                                                                true,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Material(
                                                color: Colors.transparent,
                                                elevation: 1.0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Container(
                                                  width: 120.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Flexible(
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: RichText(
                                                            textScaler:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .textScaler,
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    _model
                                                                        .years,
                                                                    '0000',
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFF284E75),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 10.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 10.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 10.0;
                                                                          } else {
                                                                            return 12.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'wdcfd0pn' /* 년 */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFF284E75),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 10.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 10.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 10.0;
                                                                          } else {
                                                                            return 12.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'ogeu7f7u' /*    */,
                                                                  ),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        color: Color(
                                                                            0xFF284E75),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 10.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 10.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 10.0;
                                                                          } else {
                                                                            return 12.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                ),
                                                                TextSpan(
                                                                  text: valueOrDefault<
                                                                      String>(
                                                                    _model
                                                                        .semester,
                                                                    '-학기',
                                                                  ),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    fontSize:
                                                                        () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointSmall) {
                                                                        return 10.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointMedium) {
                                                                        return 10.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointLarge) {
                                                                        return 10.0;
                                                                      } else {
                                                                        return 12.0;
                                                                      }
                                                                    }(),
                                                                  ),
                                                                )
                                                              ],
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    fontSize:
                                                                        () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointSmall) {
                                                                        return 10.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointMedium) {
                                                                        return 10.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointLarge) {
                                                                        return 10.0;
                                                                      } else {
                                                                        return 12.0;
                                                                      }
                                                                    }(),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
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
                                Flexible(
                                  flex: 4,
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.asset(
                                        'assets/images/_2.png',
                                        height: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Align(
                                    alignment: AlignmentDirectional(1.0, 0.0),
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEF1F6),
                                shape: BoxShape.rectangle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0.0),
                                      bottomRight: Radius.circular(0.0),
                                      topLeft: Radius.circular(0.0),
                                      topRight: Radius.circular(0.0),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Container(
                                                          width: 120.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.selectedGrade =
                                                                        1;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .filterDataByGrade(
                                                                            context);
                                                                  },
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'qb4j6zyl' /* 1학년 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF666666),
                                                                          fontSize:
                                                                              25.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .selectedGrade ==
                                                                  1)
                                                                Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .mainColor1,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Container(
                                                          width: 120.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.selectedGrade =
                                                                        2;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .filterDataByGrade(
                                                                            context);
                                                                  },
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '0awwxl6p' /* 2학년 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF666666),
                                                                          fontSize:
                                                                              25.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .selectedGrade ==
                                                                  2)
                                                                Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .mainColor1,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Container(
                                                          width: 120.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.selectedGrade =
                                                                        3;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .filterDataByGrade(
                                                                            context);
                                                                  },
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '0zeibr2h' /* 3학년 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF666666),
                                                                          fontSize:
                                                                              25.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .selectedGrade ==
                                                                  3)
                                                                Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .mainColor1,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Container(
                                                          width: 120.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.selectedGrade =
                                                                        4;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .filterDataByGrade(
                                                                            context);
                                                                  },
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      '1amovrsl' /* 4학년 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF666666),
                                                                          fontSize:
                                                                              25.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .selectedGrade ==
                                                                  4)
                                                                Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .mainColor1,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Container(
                                                          width: 120.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5.0),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    _model.selectedGrade =
                                                                        5;
                                                                    safeSetState(
                                                                        () {});
                                                                    await _model
                                                                        .filterDataByGrade(
                                                                            context);
                                                                  },
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'iogk6yhp' /* 5학년 */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF666666),
                                                                          fontSize:
                                                                              25.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (_model
                                                                      .selectedGrade ==
                                                                  5)
                                                                Divider(
                                                                  thickness:
                                                                      2.0,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .mainColor1,
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 400.0,
                                                  height: 35.0,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          width: 200.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      3.0),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      3.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      0.0),
                                                            ),
                                                            border: Border.all(
                                                              color: Color(
                                                                  0xFF666666),
                                                            ),
                                                          ),
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Container(
                                                              width: 300.0,
                                                              child:
                                                                  TextFormField(
                                                                controller: _model
                                                                    .searchTextFieldTextController,
                                                                focusNode: _model
                                                                    .searchTextFieldFocusNode,
                                                                onChanged: (_) =>
                                                                    EasyDebounce
                                                                        .debounce(
                                                                  '_model.searchTextFieldTextController',
                                                                  Duration(
                                                                      milliseconds:
                                                                          2000),
                                                                  () =>
                                                                      safeSetState(
                                                                          () {}),
                                                                ),
                                                                onFieldSubmitted:
                                                                    (_) async {
                                                                  _model.searchQuery =
                                                                      _model
                                                                          .searchTextFieldTextController
                                                                          .text;
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                autofocus:
                                                                    false,
                                                                textInputAction:
                                                                    TextInputAction
                                                                        .search,
                                                                obscureText:
                                                                    false,
                                                                decoration:
                                                                    InputDecoration(
                                                                  isDense: true,
                                                                  labelStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    '7fjkcg4c' /* 검색할 과목의 이름을 입력하세요 */,
                                                                  ),
                                                                  hintStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .labelMedium
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelMedium
                                                                              .fontStyle,
                                                                        ),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color(
                                                                          0x00000000),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  errorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  focusedErrorBorder:
                                                                      OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .error,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                  ),
                                                                  filled: true,
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  suffixIcon: _model
                                                                          .searchTextFieldTextController!
                                                                          .text
                                                                          .isNotEmpty
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            _model.searchTextFieldTextController?.clear();
                                                                            safeSetState(() {});
                                                                          },
                                                                          child:
                                                                              Icon(
                                                                            Icons.clear,
                                                                            size:
                                                                                22,
                                                                          ),
                                                                        )
                                                                      : null,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                cursorColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                validator: _model
                                                                    .searchTextFieldTextControllerValidator
                                                                    .asValidator(
                                                                        context),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          safeSetState(() {
                                                            _model.simpleSearchResults = TextSearch((_model
                                                                            .filteredClass
                                                                            .map((e) => e
                                                                                .course)
                                                                            .withoutNulls
                                                                            .toList()
                                                                        as List)
                                                                    .cast<
                                                                        String>()
                                                                    .map((str) =>
                                                                        TextSearchItem.fromTerms(
                                                                            str,
                                                                            [
                                                                              str
                                                                            ]))
                                                                    .toList())
                                                                .search(_model
                                                                    .searchTextFieldTextController
                                                                    .text)
                                                                .map((r) => r.object)
                                                                .toList();
                                                            ;
                                                          });
                                                          _model.isSearching =
                                                              true;
                                                          safeSetState(() {});
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '0zg0zry7' /* 과목 검색 */,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      16.0,
                                                                      0.0,
                                                                      16.0,
                                                                      0.0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .mainColor1,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .openSans(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleSmall
                                                                          .fontStyle,
                                                                    ),
                                                                    color: Colors
                                                                        .white,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                          elevation: 0.0,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    3.0),
                                                            topLeft:
                                                                Radius.circular(
                                                                    0.0),
                                                            topRight:
                                                                Radius.circular(
                                                                    3.0),
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
                                        Divider(
                                          thickness: 2.0,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Container(
                                            height: 130.0,
                                            decoration: BoxDecoration(),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .progressContainerWeeksModel1,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        ProgressContainerWeeksWidget(),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .progressContainerSModel1,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        ProgressContainerSWidget(
                                                      title: '학생 주차별 설계진행표 제출률',
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: wrapWithModel(
                                                    model: _model
                                                        .progressContainerSModel2,
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child:
                                                        ProgressContainerSWidget(
                                                      title: '포트폴리오 크리틱 진행률',
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 10.0)),
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 2.0,
                                          color: FlutterFlowTheme.of(context)
                                              .alternate,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                flex: 2,
                                                child: ClipRRect(
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight:
                                                          MediaQuery.sizeOf(
                                                                      context)
                                                                  .height *
                                                              0.65,
                                                    ),
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          if (!_model
                                                              .isSearching)
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          10.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color(
                                                                            0xFFE3E3E3),
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Flexible(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              width: 100.0,
                                                                              height: 100.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.isDesignClass = true;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: AnimatedDefaultTextStyle(
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: _model.isDesignClass ? FlutterFlowTheme.of(context).mainColor1 : Color(0xFF666666),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    duration: Duration(milliseconds: 300),
                                                                                    curve: Curves.easeIn,
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'y5qs2dqs' /* 설계 과목 */,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                30.0,
                                                                            child:
                                                                                VerticalDivider(
                                                                              thickness: 1.0,
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              width: 100.0,
                                                                              height: 100.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(8.0),
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    _model.isDesignClass = false;
                                                                                    safeSetState(() {});
                                                                                  },
                                                                                  child: AnimatedDefaultTextStyle(
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: !_model.isDesignClass ? FlutterFlowTheme.of(context).mainColor1 : Color(0xFF666666),
                                                                                          fontSize: 20.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                    duration: Duration(milliseconds: 300),
                                                                                    curve: Curves.easeIn,
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'qpdgmgv3' /* 이론 과목 */,
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
                                                                ),
                                                                Flexible(
                                                                  child:
                                                                      Container(
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      maxHeight:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.7,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final visibleClass = _model
                                                                            .filteredClass
                                                                            .where((e) =>
                                                                                e.sectionBool ==
                                                                                _model.isDesignClass)
                                                                            .toList();

                                                                        return ListView
                                                                            .separated(
                                                                          padding:
                                                                              EdgeInsets.zero,
                                                                          shrinkWrap:
                                                                              true,
                                                                          scrollDirection:
                                                                              Axis.vertical,
                                                                          itemCount:
                                                                              visibleClass.length,
                                                                          separatorBuilder: (_, __) =>
                                                                              SizedBox(height: 10.0),
                                                                          itemBuilder:
                                                                              (context, visibleClassIndex) {
                                                                            final visibleClassItem =
                                                                                visibleClass[visibleClassIndex];
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 0.0),
                                                                              child: DashboardClassContainerWidget(
                                                                                key: Key('Keyzj9_${visibleClassIndex}_of_${visibleClass.length}'),
                                                                                courseName: valueOrDefault<String>(
                                                                                  visibleClassItem.course,
                                                                                  '설계 과목',
                                                                                ),
                                                                                isDesign: visibleClassItem.sectionBool!,
                                                                                section: valueOrDefault<String>(
                                                                                  visibleClassItem.section,
                                                                                  '분반',
                                                                                ),
                                                                                professor: valueOrDefault<String>(
                                                                                  visibleClassItem.professor,
                                                                                  '이름',
                                                                                ),
                                                                                year: visibleClassItem.year,
                                                                                semester: visibleClassItem.semester,
                                                                                grade: visibleClassItem.grade,
                                                                                classID: visibleClassItem.id,
                                                                                currentlySelectedID: _model.selectedClassDetailID,
                                                                                getDetailClassID: (displayClassDetailID) async {
                                                                                  // setSelectedClassDetailID
                                                                                  _model.selectedClassDetailID = visibleClassItem.id;
                                                                                  safeSetState(() {});
                                                                                  FFAppState().classSelectedID = valueOrDefault<int>(
                                                                                    visibleClassItem.id,
                                                                                    1,
                                                                                  );
                                                                                  safeSetState(() {});
                                                                                  await _model.getClassDetail(context);
                                                                                  _model.attendingStudents = _model.studentsByGrade.where((e) => e.classid == displayClassDetailID).toList().cast<CourseStudentRow>();
                                                                                  safeSetState(() {});
                                                                                },
                                                                              ),
                                                                            );
                                                                          },
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          if (_model
                                                              .isSearching)
                                                            SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        50.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .only(
                                                                        bottomLeft:
                                                                            Radius.circular(0.0),
                                                                        bottomRight:
                                                                            Radius.circular(0.0),
                                                                        topLeft:
                                                                            Radius.circular(0.0),
                                                                        topRight:
                                                                            Radius.circular(5.0),
                                                                      ),
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: Color(
                                                                            0xFF666666),
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '1u5i39bg' /* 검색결과 */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: 20.0,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          FlutterFlowIconButton(
                                                                            borderRadius:
                                                                                8.0,
                                                                            buttonSize:
                                                                                40.0,
                                                                            fillColor:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            icon:
                                                                                Icon(
                                                                              Icons.close_rounded,
                                                                              color: FlutterFlowTheme.of(context).info,
                                                                              size: 24.0,
                                                                            ),
                                                                            onPressed:
                                                                                () async {
                                                                              _model.isSearching = false;
                                                                              safeSetState(() {});
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      final searchedResults = _model
                                                                          .filteredClass
                                                                          .where((e) => _model
                                                                              .simpleSearchResults
                                                                              .contains(e.course))
                                                                          .toList();

                                                                      return ListView
                                                                          .separated(
                                                                        padding:
                                                                            EdgeInsets.zero,
                                                                        shrinkWrap:
                                                                            true,
                                                                        scrollDirection:
                                                                            Axis.vertical,
                                                                        itemCount:
                                                                            searchedResults.length,
                                                                        separatorBuilder:
                                                                            (_, __) =>
                                                                                SizedBox(height: 10.0),
                                                                        itemBuilder:
                                                                            (context,
                                                                                searchedResultsIndex) {
                                                                          final searchedResultsItem =
                                                                              searchedResults[searchedResultsIndex];
                                                                          return DashboardClassContainerWidget(
                                                                            key:
                                                                                Key('Keyxum_${searchedResultsIndex}_of_${searchedResults.length}'),
                                                                            courseName:
                                                                                valueOrDefault<String>(
                                                                              searchedResultsItem.course,
                                                                              '수업명',
                                                                            ),
                                                                            isDesign:
                                                                                searchedResultsItem.sectionBool!,
                                                                            section:
                                                                                searchedResultsItem.section,
                                                                            professor:
                                                                                searchedResultsItem.professor!,
                                                                            year: searchedResultsItem.year,
                                                                            semester: searchedResultsItem.semester,
                                                                            grade: searchedResultsItem.grade,
                                                                            classID:
                                                                                searchedResultsItem.id,
                                                                            currentlySelectedID:
                                                                                FFAppState().classSelectedID,
                                                                            getDetailClassID:
                                                                                (displayClassDetailID) async {
                                                                              // setSelectedClassDetailID
                                                                              _model.selectedClassDetailID = searchedResultsItem.id;
                                                                              safeSetState(() {});
                                                                              FFAppState().classSelectedID = searchedResultsItem.id;
                                                                              safeSetState(() {});
                                                                              await _model.getClassDetail(context);
                                                                              _model.attendingStudents = _model.studentsByGrade.where((e) => e.classid == displayClassDetailID).toList().cast<CourseStudentRow>();
                                                                              safeSetState(() {});
                                                                            },
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        10.0)),
                                                              ),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 600.0,
                                                child: VerticalDivider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .alternate,
                                                ),
                                              ),
                                              if (_model
                                                      .selectedClassDetailID !=
                                                  null)
                                                Flexible(
                                                  flex: 5,
                                                  child: Container(
                                                    constraints: BoxConstraints(
                                                      maxHeight: 700.0,
                                                    ),
                                                    decoration: BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Container(
                                                          height: 130.0,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child:
                                                                wrapWithModel(
                                                              model: _model
                                                                  .progressContainerWeeksModel2,
                                                              updateCallback: () =>
                                                                  safeSetState(
                                                                      () {}),
                                                              child:
                                                                  ProgressContainerWeeksWidget(),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'f1kiuf8y' /* 교수님 업로드 현황 */,
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .openSans(
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: Color(
                                                                          0xFF666666),
                                                                      fontSize:
                                                                          20.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            10.0,
                                                                            5.0),
                                                                child:
                                                                    FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    context.pushNamed(
                                                                        ProfSubjectPortpolioWidget
                                                                            .routeName);
                                                                  },
                                                                  text: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    't0enfic7' /* 전공 홈 바로가기 ▶ */,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    width:
                                                                        160.0,
                                                                    height:
                                                                        35.0,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            0.0,
                                                                            16.0,
                                                                            0.0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .mainColor1,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Colors.white,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0.0,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      5.0,
                                                                      10.0,
                                                                      5.0),
                                                          child: Container(
                                                            width: 100.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.0),
                                                              border:
                                                                  Border.all(
                                                                color: Color(
                                                                    0xFFB3B3B3),
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10.0,
                                                                          5.0,
                                                                          10.0,
                                                                          5.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'niinzvb8' /* 포트폴리오 크리틱 진행률 */,
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
                                                                              Color(0xFF666666),
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
                                                                  Stack(
                                                                    children: [
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            120.0,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFEEF1F6),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            120.0,
                                                                        child: custom_widgets
                                                                            .ChartWidget(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              120.0,
                                                                          chartData: List.generate(
                                                                              random_data.randomInteger(15, 15),
                                                                              (index) => random_data.randomInteger(1, 5)),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 1800.0,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      wrapWithModel(
                                                                    model: _model
                                                                        .lectureMaterialModel1,
                                                                    updateCallback: () =>
                                                                        safeSetState(
                                                                            () {}),
                                                                    child:
                                                                        LectureMaterialWidget(
                                                                      type:
                                                                          '학부생 등록 여부',
                                                                      uploadAmount:
                                                                          0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          CourseplanRow>>(
                                                                    future: CourseplanTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'class',
                                                                        _model
                                                                            .selectedClassDetailID,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<CourseplanRow>
                                                                          lectureMaterialCourseplanRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return wrapWithModel(
                                                                        model: _model
                                                                            .lectureMaterialModel2,
                                                                        updateCallback:
                                                                            () =>
                                                                                safeSetState(() {}),
                                                                        child:
                                                                            LectureMaterialWidget(
                                                                          type:
                                                                              '수업계획서',
                                                                          uploadAmount:
                                                                              valueOrDefault<int>(
                                                                            lectureMaterialCourseplanRowList.length,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          LecturematerialRow>>(
                                                                    future: LecturematerialTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'class',
                                                                        _model
                                                                            .selectedClassDetailID,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<LecturematerialRow>
                                                                          lectureMaterialLecturematerialRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return wrapWithModel(
                                                                        model: _model
                                                                            .lectureMaterialModel3,
                                                                        updateCallback:
                                                                            () =>
                                                                                safeSetState(() {}),
                                                                        child:
                                                                            LectureMaterialWidget(
                                                                          type:
                                                                              '강의 자료실',
                                                                          uploadAmount:
                                                                              valueOrDefault<int>(
                                                                            lectureMaterialLecturematerialRowList.length,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          AttendanceRow>>(
                                                                    future: AttendanceTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'class',
                                                                        _model
                                                                            .selectedClassDetailID,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<AttendanceRow>
                                                                          lectureMaterialAttendanceRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return wrapWithModel(
                                                                        model: _model
                                                                            .lectureMaterialModel4,
                                                                        updateCallback:
                                                                            () =>
                                                                                safeSetState(() {}),
                                                                        child:
                                                                            LectureMaterialWidget(
                                                                          type:
                                                                              '출석부',
                                                                          uploadAmount:
                                                                              valueOrDefault<int>(
                                                                            lectureMaterialAttendanceRowList.length,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          GradesheetRow>>(
                                                                    future: GradesheetTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'class',
                                                                        _model
                                                                            .selectedClassDetailID,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<GradesheetRow>
                                                                          lectureMaterialGradesheetRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return wrapWithModel(
                                                                        model: _model
                                                                            .lectureMaterialModel5,
                                                                        updateCallback:
                                                                            () =>
                                                                                safeSetState(() {}),
                                                                        child:
                                                                            LectureMaterialWidget(
                                                                          type:
                                                                              '성적 기록표',
                                                                          uploadAmount:
                                                                              valueOrDefault<int>(
                                                                            lectureMaterialGradesheetRowList.length,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: FutureBuilder<
                                                                      List<
                                                                          WorkevalformRow>>(
                                                                    future: WorkevalformTable()
                                                                        .queryRows(
                                                                      queryFn:
                                                                          (q) =>
                                                                              q.eqOrNull(
                                                                        'class',
                                                                        _model
                                                                            .selectedClassDetailID,
                                                                      ),
                                                                    ),
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      // Customize what your widget looks like when it's loading.
                                                                      if (!snapshot
                                                                          .hasData) {
                                                                        return Center(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                50.0,
                                                                            height:
                                                                                50.0,
                                                                            child:
                                                                                CircularProgressIndicator(
                                                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                                                Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      List<WorkevalformRow>
                                                                          lectureMaterialWorkevalformRowList =
                                                                          snapshot
                                                                              .data!;

                                                                      return wrapWithModel(
                                                                        model: _model
                                                                            .lectureMaterialModel6,
                                                                        updateCallback:
                                                                            () =>
                                                                                safeSetState(() {}),
                                                                        child:
                                                                            LectureMaterialWidget(
                                                                          type:
                                                                              '학생작품 평가표',
                                                                          uploadAmount:
                                                                              valueOrDefault<int>(
                                                                            lectureMaterialWorkevalformRowList.length,
                                                                            0,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 10.0)),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Text(
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                              'q96f7cwh' /* 학생 업로드 현황 */,
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .openSans(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFF666666),
                                                                  fontSize:
                                                                      20.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Container(
                                                              height: 130.0,
                                                              constraints:
                                                                  BoxConstraints(
                                                                maxWidth:
                                                                    1800.0,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Flexible(
                                                                    child: FutureBuilder<
                                                                        List<
                                                                            SubjectportpolioRow>>(
                                                                      future: SubjectportpolioTable()
                                                                          .queryRows(
                                                                        queryFn:
                                                                            (q) =>
                                                                                q.eqOrNull(
                                                                          'class',
                                                                          _model
                                                                              .selectedClassDetailID,
                                                                        ),
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
                                                                              width: 50.0,
                                                                              height: 50.0,
                                                                              child: CircularProgressIndicator(
                                                                                valueColor: AlwaysStoppedAnimation<Color>(
                                                                                  Color(0xFF284E75),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        List<SubjectportpolioRow>
                                                                            progressContainerDetailSubjectportpolioRowList =
                                                                            snapshot.data!;

                                                                        return wrapWithModel(
                                                                          model:
                                                                              _model.progressContainerDetailModel1,
                                                                          updateCallback: () =>
                                                                              safeSetState(() {}),
                                                                          child:
                                                                              ProgressContainerDetailWidget(
                                                                            title:
                                                                                '주차별 설계진행표 제출률',
                                                                            percentageNumerator:
                                                                                valueOrDefault<int>(
                                                                              progressContainerDetailSubjectportpolioRowList.length,
                                                                              0,
                                                                            ),
                                                                            percentageDenominator:
                                                                                valueOrDefault<int>(
                                                                              _model.courseStudent.length * 15,
                                                                              100,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        wrapWithModel(
                                                                      model: _model
                                                                          .progressContainerDetailModel2,
                                                                      updateCallback:
                                                                          () =>
                                                                              safeSetState(() {}),
                                                                      child:
                                                                          ProgressContainerDetailWidget(
                                                                        title:
                                                                            '1차 - 2차 결과물 제출률',
                                                                        percentageNumerator:
                                                                            0,
                                                                        percentageDenominator:
                                                                            valueOrDefault<int>(
                                                                          _model.courseStudent.length *
                                                                              2,
                                                                          101,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    width:
                                                                        10.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ].divide(SizedBox(
                                                          height: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              if (_model
                                                      .selectedClassDetailID ==
                                                  null)
                                                Flexible(
                                                  flex: 5,
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: 100.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Text(
                                                              FFLocalizations.of(
                                                                      context)
                                                                  .getText(
                                                                'uhgsn50y' /* 과목의 “진행사항 조회”를 누를 시 통계를 확인하실 수... */,
                                                              ),
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
                                                                    color: Color(
                                                                        0xFFB3B3B3),
                                                                    fontSize:
                                                                        15.0,
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
            if (responsiveVisibility(
              context: context,
              tabletLandscape: false,
              desktop: false,
            ))
              SafeArea(
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                    child: SingleChildScrollView(
                      primary: false,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          wrapWithModel(
                            model: _model.headerMobileModel,
                            updateCallback: () => safeSetState(() {}),
                            child: HeaderMobileWidget(),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEF1F6),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 5.0, 2.0, 5.0),
                                      child: FutureBuilder<List<YearsRow>>(
                                        future: YearsTable().queryRows(
                                          queryFn: (q) => q,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    Color(0xFF284E75),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<YearsRow>
                                              dropDownYearYearsRowList =
                                              snapshot.data!;

                                          return FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownYearValueController2 ??=
                                                FormFieldController<String>(
                                              _model.dropDownYearValue2 ??=
                                                  valueOrDefault<String>(
                                                dropDownYearYearsRowList
                                                    .lastOrNull?.year,
                                                '2025',
                                              ),
                                            ),
                                            options: dropDownYearYearsRowList
                                                .map((e) => e.year)
                                                .withoutNulls
                                                .toList(),
                                            onChanged: (val) async {
                                              safeSetState(() => _model
                                                  .dropDownYearValue2 = val);
                                              _model.years =
                                                  valueOrDefault<String>(
                                                _model.dropDownYearValue2,
                                                '2025',
                                              );
                                              safeSetState(() {});
                                              _model.semester = '1학기';
                                              _model.buttonGrades = -1;
                                              _model.semesterGradeOutput = [];
                                              _model.yearsSemesterMapOutput =
                                                  [];
                                              _model.courseBySelectOutputVar =
                                                  [];
                                              _model.courseSectionOutputVar =
                                                  [];
                                              _model.classOnLoad = _model
                                                  .classSelectedOnLoad!
                                                  .where((e) =>
                                                      (e.year ==
                                                          _model.years) &&
                                                      (e.semester ==
                                                          _model.semester))
                                                  .toList()
                                                  .cast<ClassRow>();
                                              _model.classAfterGrade = [];
                                              _model.buttonColor1 =
                                                  Color(4294967295);
                                              _model.buttonColor2 =
                                                  Color(4294967295);
                                              _model.buttonColor3 =
                                                  Color(4294967295);
                                              _model.buttonColor4 =
                                                  Color(4294967295);
                                              _model.buttonColor5 =
                                                  Color(4294967295);
                                              _model.textColor1 =
                                                  Color(4280831605);
                                              _model.textColor2 =
                                                  Color(4280831605);
                                              _model.textColor3 =
                                                  Color(4280831605);
                                              _model.textColor4 =
                                                  Color(4280831605);
                                              _model.textColor5 =
                                                  Color(4280831605);
                                              safeSetState(() {});
                                            },
                                            width: double.infinity,
                                            height: 30.0,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .neutral500,
                                                  fontSize: () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width <
                                                        kBreakpointSmall) {
                                                      return 9.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointMedium) {
                                                      return 11.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointLarge) {
                                                      return 13.0;
                                                    } else {
                                                      return 15.0;
                                                    }
                                                  }(),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                            hintText:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'wp4yw4bi' /* 년도 선택 */,
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            elevation: 0.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .neutral200,
                                            borderWidth: 1.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    14.0, 4.0, 10.0, 4.0),
                                            hidesUnderline: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          2.0, 5.0, 2.0, 5.0),
                                      child: FutureBuilder<List<SemestersRow>>(
                                        future: SemestersTable().queryRows(
                                          queryFn: (q) => q,
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    Color(0xFF284E75),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<SemestersRow>
                                              dropDownSemesterSemestersRowList =
                                              snapshot.data!;

                                          return FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownSemesterValueController2 ??=
                                                FormFieldController<String>(
                                              _model.dropDownSemesterValue2 ??=
                                                  valueOrDefault<String>(
                                                dropDownSemesterSemestersRowList
                                                    .firstOrNull?.semesterType,
                                                '1학기',
                                              ),
                                            ),
                                            options:
                                                dropDownSemesterSemestersRowList
                                                    .map((e) => e.semesterType)
                                                    .withoutNulls
                                                    .toList(),
                                            onChanged: (val) async {
                                              safeSetState(() => _model
                                                      .dropDownSemesterValue2 =
                                                  val);
                                              _model.semester =
                                                  valueOrDefault<String>(
                                                _model.dropDownSemesterValue2,
                                                '1학기',
                                              );
                                              _model.buttonGrades = -1;
                                              _model.semesterGradeOutput = [];
                                              _model.yearsSemesterMapOutput =
                                                  [];
                                              _model.courseBySelectOutputVar =
                                                  [];
                                              _model.courseSectionOutputVar =
                                                  [];
                                              _model.classOnLoad = _model
                                                  .classSelectedOnLoad!
                                                  .where((e) =>
                                                      (e.year ==
                                                          _model.years) &&
                                                      (e.semester ==
                                                          _model.semester))
                                                  .toList()
                                                  .cast<ClassRow>();
                                              _model.classAfterGrade = [];
                                              _model.buttonColor1 =
                                                  Color(4294967295);
                                              _model.buttonColor2 =
                                                  Color(4294967295);
                                              _model.buttonColor3 =
                                                  Color(4294967295);
                                              _model.buttonColor4 =
                                                  Color(4294967295);
                                              _model.buttonColor5 =
                                                  Color(4294967295);
                                              _model.textColor1 =
                                                  Color(4280831605);
                                              _model.textColor2 =
                                                  Color(4280831605);
                                              _model.textColor3 =
                                                  Color(4280831605);
                                              _model.textColor4 =
                                                  Color(4280831605);
                                              _model.textColor5 =
                                                  Color(4280831605);
                                              safeSetState(() {});
                                            },
                                            width: double.infinity,
                                            height: 30.0,
                                            textStyle: FlutterFlowTheme.of(
                                                    context)
                                                .labelMedium
                                                .override(
                                                  font: GoogleFonts.openSans(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .labelMedium
                                                            .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .neutral500,
                                                  fontSize: () {
                                                    if (MediaQuery.sizeOf(
                                                                context)
                                                            .width <
                                                        kBreakpointSmall) {
                                                      return 9.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointMedium) {
                                                      return 11.0;
                                                    } else if (MediaQuery
                                                                .sizeOf(context)
                                                            .width <
                                                        kBreakpointLarge) {
                                                      return 13.0;
                                                    } else {
                                                      return 15.0;
                                                    }
                                                  }(),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .labelMedium
                                                          .fontStyle,
                                                ),
                                            hintText:
                                                FFLocalizations.of(context)
                                                    .getText(
                                              'wqq61wgn' /* 학기 선택 */,
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 16.0,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryBackground,
                                            elevation: 0.0,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .neutral200,
                                            borderWidth: 1.0,
                                            borderRadius: 8.0,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    14.0, 4.0, 10.0, 4.0),
                                            hidesUnderline: true,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(),
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Text(
                                      FFLocalizations.of(context).getText(
                                        'ii37oecg' /* 통계/대시보드 */,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: Color(0xFF666666),
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.bold,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 2.0,
                            color: FlutterFlowTheme.of(context).alternate,
                          ),
                          if (_model.dashboardViewType ==
                              DashboardViewType.dash_overview)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 78.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.selectedGrade = 1;
                                                    safeSetState(() {});
                                                    await _model
                                                        .filterDataByGrade(
                                                            context);
                                                  },
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '4lahxgrm' /* 1학년 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .notoSansKr(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF666666),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (_model.selectedGrade == 1)
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .mainColor1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 78.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.selectedGrade = 2;
                                                    safeSetState(() {});
                                                    await _model
                                                        .filterDataByGrade(
                                                            context);
                                                  },
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'duy1z83c' /* 2학년 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .notoSansKr(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF666666),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (_model.selectedGrade == 2)
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .mainColor1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 78.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.selectedGrade = 3;
                                                    safeSetState(() {});
                                                    await _model
                                                        .filterDataByGrade(
                                                            context);
                                                  },
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      '78p3fwwc' /* 3학년 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .notoSansKr(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF666666),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (_model.selectedGrade == 3)
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .mainColor1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 78.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.selectedGrade = 4;
                                                    safeSetState(() {});
                                                    await _model
                                                        .filterDataByGrade(
                                                            context);
                                                  },
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'yr6sxgdu' /* 4학년 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .notoSansKr(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF666666),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (_model.selectedGrade == 4)
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .mainColor1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width: 78.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model.selectedGrade = 5;
                                                    safeSetState(() {});
                                                    await _model
                                                        .filterDataByGrade(
                                                            context);
                                                  },
                                                  child: Text(
                                                    FFLocalizations.of(context)
                                                        .getText(
                                                      'b02axov3' /* 5학년 */,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .notoSansKr(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          color:
                                                              Color(0xFF666666),
                                                          fontSize: 15.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (_model.selectedGrade == 5)
                                                Divider(
                                                  thickness: 2.0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .mainColor1,
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  thickness: 2.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    height: 78.0,
                                    decoration: BoxDecoration(),
                                    child: wrapWithModel(
                                      model:
                                          _model.progressContainerWeeksModel3,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ProgressContainerWeeksWidget(),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    height: 78.0,
                                    decoration: BoxDecoration(),
                                    child: FutureBuilder<
                                        List<SubjectportpolioRow>>(
                                      future: SubjectportpolioTable().queryRows(
                                        queryFn: (q) => q.eqOrNull(
                                          'class',
                                          _model.selectedClassDetailID,
                                        ),
                                      ),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50.0,
                                              height: 50.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  Color(0xFF284E75),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        List<SubjectportpolioRow>
                                            progressContainerSSubjectportpolioRowList =
                                            snapshot.data!;

                                        return wrapWithModel(
                                          model:
                                              _model.progressContainerSModel3,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: ProgressContainerSWidget(
                                            title: '주차별 설계진행표 제출률',
                                            percentageNumerator:
                                                valueOrDefault<double>(
                                              progressContainerSSubjectportpolioRowList
                                                  .length
                                                  .toDouble(),
                                              0.0,
                                            ),
                                            percentageDenominator:
                                                valueOrDefault<double>(
                                              (_model.courseStudent.length * 15)
                                                  .toDouble(),
                                              100.0,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Container(
                                    width: 0.0,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Container(
                                    height: 78.0,
                                    decoration: BoxDecoration(),
                                    child: wrapWithModel(
                                      model: _model.progressContainerSModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ProgressContainerSWidget(
                                        title: '1차-2차 성과물 제출률',
                                        percentageNumerator: 5.0,
                                        percentageDenominator:
                                            valueOrDefault<double>(
                                          (_model.courseStudent.length * 2)
                                              .toDouble(),
                                          100.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.dashboardViewType =
                                          DashboardViewType.dash_classes;
                                      _model.isDesignClass = true;
                                      safeSetState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      'xm1jee0h' /* 설계 과목 조회 ▶ */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 35.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFFB3B3B3),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 0.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      _model.dashboardViewType =
                                          DashboardViewType.dash_classes;
                                      _model.isDesignClass = false;
                                      safeSetState(() {});
                                    },
                                    text: FFLocalizations.of(context).getText(
                                      '1lp9mfnh' /* 이론 과목 조회 ▶ */,
                                    ),
                                    options: FFButtonOptions(
                                      width: double.infinity,
                                      height: 35.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: Color(0xFFB3B3B3),
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 0.0,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          if (_model.dashboardViewType ==
                              DashboardViewType.dash_classes)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        icon: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Color(0xFF666666),
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          _model.dashboardViewType =
                                              DashboardViewType.dash_overview;
                                          safeSetState(() {});
                                        },
                                      ),
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: _model.isDesignClass
                                                  ? '설계 '
                                                  : '이론 ',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                'd32zdinj' /* 과목 조회 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF666666),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2.0,
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  Container(
                                    height: 70.0,
                                    child: wrapWithModel(
                                      model:
                                          _model.progressContainerWeeksModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ProgressContainerWeeksWidget(),
                                    ),
                                  ),
                                  Container(
                                    width: 0.0,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(),
                                    child: Builder(
                                      builder: (context) {
                                        final filteredClass2 = _model
                                            .filteredClass
                                            .where((e) =>
                                                e.sectionBool ==
                                                _model.isDesignClass)
                                            .toList();

                                        return ListView.separated(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: filteredClass2.length,
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 10.0),
                                          itemBuilder:
                                              (context, filteredClass2Index) {
                                            final filteredClass2Item =
                                                filteredClass2[
                                                    filteredClass2Index];
                                            return DashboardClassContainerMWidget(
                                              key: Key(
                                                  'Keyc42_${filteredClass2Index}_of_${filteredClass2.length}'),
                                              courseName:
                                                  filteredClass2Item.course!,
                                              isDesign: filteredClass2Item
                                                  .sectionBool!,
                                              section: valueOrDefault<String>(
                                                filteredClass2Item.section,
                                                '0분반',
                                              ),
                                              professor:
                                                  filteredClass2Item.professor!,
                                              classID: filteredClass2Item.id,
                                              currentlySelectedID:
                                                  _model.selectedClassDetailID,
                                              getDetailClassID:
                                                  (displayClassDetailID) async {
                                                _model.selectedClassDetailID =
                                                    filteredClass2Item.id;
                                                safeSetState(() {});
                                                FFAppState().classSelectedID =
                                                    displayClassDetailID;
                                                safeSetState(() {});
                                                await _model
                                                    .getClassDetail(context);
                                                _model.attendingStudents = _model
                                                    .studentsByGrade
                                                    .where((e) =>
                                                        e.classid ==
                                                        displayClassDetailID)
                                                    .toList()
                                                    .cast<CourseStudentRow>();
                                                _model.dashboardViewType =
                                                    DashboardViewType
                                                        .dash_detail;
                                                safeSetState(() {});
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_model.dashboardViewType ==
                              DashboardViewType.dash_detail)
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 0.0, 20.0, 0.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderRadius: 8.0,
                                        buttonSize: 40.0,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        icon: Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: Color(0xFF666666),
                                          size: 24.0,
                                        ),
                                        onPressed: () async {
                                          _model.dashboardViewType =
                                              DashboardViewType.dash_classes;
                                          safeSetState(() {});
                                        },
                                      ),
                                      RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: FFLocalizations.of(context)
                                                  .getText(
                                                '5opovg5u' /* 과목 조회 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            )
                                          ],
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: Color(0xFF666666),
                                                fontSize: 15.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        FFLocalizations.of(context).getText(
                                          'j0z4r9v9' /* 교수님 업로드 현황 */,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.openSans(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .mainColor1,
                                              fontSize: 15.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 10.0, 5.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            context.pushNamed(
                                                ProfSubjectPortpolioWidget
                                                    .routeName);
                                          },
                                          text: FFLocalizations.of(context)
                                              .getText(
                                            'ci09091w' /* 전공 홈 바로가기 ▶ */,
                                          ),
                                          options: FFButtonOptions(
                                            width: 155.0,
                                            height: 35.0,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: Color(0xFFB3B3B3),
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font:
                                                          GoogleFonts.openSans(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      fontSize: 15.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                            elevation: 0.0,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (_model.isDesignClass)
                                    Container(
                                      width: double.infinity,
                                      height: 114.0,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        border: Border.all(
                                          color: Color(0xFFB3B3B3),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 5.0, 10.0, 5.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              FFLocalizations.of(context)
                                                  .getText(
                                                '9dj3rhll' /* 포트폴리오 크리틱 진행률 */,
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: Color(0xFF666666),
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                            Stack(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  height: 80.0,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFEEF1F6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 80.0,
                                                  child: custom_widgets
                                                      .ChartWidget(
                                                    width: double.infinity,
                                                    height: 80.0,
                                                    chartData: List.generate(
                                                        random_data
                                                            .randomInteger(
                                                                15, 15),
                                                        (index) => random_data
                                                            .randomInteger(
                                                                1, 5)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  Container(
                                    width: double.infinity,
                                    height: 220.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: GridView(
                                      padding: EdgeInsets.zero,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5.0,
                                        mainAxisSpacing: 5.0,
                                        childAspectRatio: 2.5,
                                      ),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      children: [
                                        wrapWithModel(
                                          model: _model.lectureMaterialModel7,
                                          updateCallback: () =>
                                              safeSetState(() {}),
                                          child: LectureMaterialWidget(
                                            type: '학부생 등록 여부',
                                            uploadAmount: 0,
                                          ),
                                        ),
                                        FutureBuilder<List<CourseplanRow>>(
                                          future: CourseplanTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'class',
                                              _model.selectedClassDetailID,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF284E75),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<CourseplanRow>
                                                lectureMaterialCourseplanRowList =
                                                snapshot.data!;

                                            return wrapWithModel(
                                              model:
                                                  _model.lectureMaterialModel8,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: LectureMaterialWidget(
                                                type: '수업계획서',
                                                uploadAmount:
                                                    valueOrDefault<int>(
                                                  lectureMaterialCourseplanRowList
                                                      .length,
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        FutureBuilder<List<LecturematerialRow>>(
                                          future:
                                              LecturematerialTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'class',
                                              _model.selectedClassDetailID,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF284E75),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<LecturematerialRow>
                                                lectureMaterialLecturematerialRowList =
                                                snapshot.data!;

                                            return wrapWithModel(
                                              model:
                                                  _model.lectureMaterialModel9,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: LectureMaterialWidget(
                                                type: '강의 자료실',
                                                uploadAmount:
                                                    valueOrDefault<int>(
                                                  lectureMaterialLecturematerialRowList
                                                      .length,
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        FutureBuilder<List<AttendanceRow>>(
                                          future: AttendanceTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'class',
                                              _model.selectedClassDetailID,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF284E75),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<AttendanceRow>
                                                lectureMaterialAttendanceRowList =
                                                snapshot.data!;

                                            return wrapWithModel(
                                              model:
                                                  _model.lectureMaterialModel10,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: LectureMaterialWidget(
                                                type: '출석부',
                                                uploadAmount:
                                                    valueOrDefault<int>(
                                                  lectureMaterialAttendanceRowList
                                                      .length,
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        FutureBuilder<List<GradesheetRow>>(
                                          future: GradesheetTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'class',
                                              _model.selectedClassDetailID,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF284E75),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<GradesheetRow>
                                                lectureMaterialGradesheetRowList =
                                                snapshot.data!;

                                            return wrapWithModel(
                                              model:
                                                  _model.lectureMaterialModel11,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: LectureMaterialWidget(
                                                type: '성적 기록표',
                                                uploadAmount:
                                                    valueOrDefault<int>(
                                                  lectureMaterialGradesheetRowList
                                                      .length,
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        FutureBuilder<List<WorkevalformRow>>(
                                          future: WorkevalformTable().queryRows(
                                            queryFn: (q) => q.eqOrNull(
                                              'class',
                                              _model.selectedClassDetailID,
                                            ),
                                          ),
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color(0xFF284E75),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            List<WorkevalformRow>
                                                lectureMaterialWorkevalformRowList =
                                                snapshot.data!;

                                            return wrapWithModel(
                                              model:
                                                  _model.lectureMaterialModel12,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: LectureMaterialWidget(
                                                type: '학생작품 평가표',
                                                uploadAmount:
                                                    valueOrDefault<int>(
                                                  lectureMaterialWorkevalformRowList
                                                      .length,
                                                  0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 70.0,
                                    child: Visibility(
                                      visible: _model.isDesignClass,
                                      child: FutureBuilder<
                                          List<SubjectportpolioRow>>(
                                        future:
                                            SubjectportpolioTable().queryRows(
                                          queryFn: (q) => q.eqOrNull(
                                            'class',
                                            _model.selectedClassDetailID,
                                          ),
                                        ),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: SizedBox(
                                                width: 50.0,
                                                height: 50.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    Color(0xFF284E75),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          List<SubjectportpolioRow>
                                              progressContainerDetailSubjectportpolioRowList =
                                              snapshot.data!;

                                          return InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                  ProfSubjectPortpolioWidget
                                                      .routeName);
                                            },
                                            child: wrapWithModel(
                                              model: _model
                                                  .progressContainerDetailModel3,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child:
                                                  ProgressContainerDetailWidget(
                                                title: '주차별 설계진행표 제출률',
                                                percentageNumerator:
                                                    valueOrDefault<int>(
                                                  progressContainerDetailSubjectportpolioRowList
                                                      .length,
                                                  0,
                                                ),
                                                percentageDenominator:
                                                    valueOrDefault<int>(
                                                  _model.courseStudent.length *
                                                      15,
                                                  100,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 70.0,
                                    child: wrapWithModel(
                                      model:
                                          _model.progressContainerDetailModel4,
                                      updateCallback: () => safeSetState(() {}),
                                      child: ProgressContainerDetailWidget(
                                        title: '1차 - 2차 결과물 제출률',
                                        percentageNumerator: 0,
                                        percentageDenominator:
                                            valueOrDefault<int>(
                                          _model.courseStudent.length * 2,
                                          100,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 10.0)),
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
    );
  }
}
