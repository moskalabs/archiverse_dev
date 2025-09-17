import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/submit_searched/submit_searched_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'dahsboard_vice_model.dart';
export 'dahsboard_vice_model.dart';

class DahsboardViceWidget extends StatefulWidget {
  const DahsboardViceWidget({
    super.key,
    required this.userType,
    required this.email,
  });

  final int? userType;
  final String? email;

  static String routeName = 'Dahsboard_Vice';
  static String routePath = '/dashboard_vice';

  @override
  State<DahsboardViceWidget> createState() => _DahsboardViceWidgetState();
}

class _DahsboardViceWidgetState extends State<DahsboardViceWidget> {
  late DahsboardViceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DahsboardViceModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.professorRowoutput = await ProfessorsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'email',
          widget.email,
        ),
      );
      _model.professorrowoutput = _model.professorRowoutput?.firstOrNull;
      safeSetState(() {});
      FFAppState().usertype = widget.userType!;
      safeSetState(() {});
      _model.prfoutput = await PostsTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'user_email',
          currentUserEmail,
        ),
      );
      _model.profeesorName = valueOrDefault<String>(
        _model.prfoutput?.firstOrNull?.name,
        '교수님 이름',
      );
      safeSetState(() {});
      _model.classSelectedOnload = await ClassTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'professor',
          _model.profeesorName,
        ),
      );
      _model.classOnload = _model.classSelectedOnload!
          .where((e) =>
              (e.year == _model.years) && (e.semester == _model.semester))
          .toList()
          .toList()
          .cast<ClassRow>();
      safeSetState(() {});
      FFAppState().usertype = widget.userType!;
      safeSetState(() {});
    });

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

    return FutureBuilder<List<ProfessorsRow>>(
      future: ProfessorsTable().queryRows(
        queryFn: (q) => q,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xFF284E75),
                  ),
                ),
              ),
            ),
          );
        }
        List<ProfessorsRow> dahsboardViceProfessorsRowList = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
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
                              width: MediaQuery.sizeOf(context).width * 0.35,
                              constraints: BoxConstraints(
                                maxWidth: 500.0,
                              ),
                              decoration: BoxDecoration(),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2.0, 5.0, 2.0, 5.0),
                                            child:
                                                FutureBuilder<List<YearsRow>>(
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
                                                    dropDown1YearsRowList =
                                                    snapshot.data!;

                                                return FlutterFlowDropDown<
                                                    String>(
                                                  controller: _model
                                                          .dropDown1ValueController1 ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.dropDown1Value1 ??=
                                                        valueOrDefault<String>(
                                                      dropDown1YearsRowList
                                                          .lastOrNull?.year,
                                                      '2025',
                                                    ),
                                                  ),
                                                  options: dropDown1YearsRowList
                                                      .map((e) => e.year)
                                                      .withoutNulls
                                                      .toList(),
                                                  onChanged: (val) async {
                                                    safeSetState(() => _model
                                                        .dropDown1Value1 = val);
                                                    _model.years =
                                                        _model.dropDown1Value1;
                                                    safeSetState(() {});
                                                  },
                                                  width: 160.0,
                                                  height: 40.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .neutral500,
                                                        fontSize: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return 6.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return 8.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
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
                                                  hintText: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '5jzjngxi' /* 년도 선택 */,
                                                  ),
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  elevation: 0.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .neutral200,
                                                  borderWidth: 1.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
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
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    2.0, 5.0, 2.0, 5.0),
                                            child: FutureBuilder<
                                                List<SemestersRow>>(
                                              future:
                                                  SemestersTable().queryRows(
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
                                                    dropDown2SemestersRowList =
                                                    snapshot.data!;

                                                return FlutterFlowDropDown<
                                                    String>(
                                                  controller: _model
                                                          .dropDown2ValueController1 ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.dropDown2Value1 ??=
                                                        valueOrDefault<String>(
                                                      dropDown2SemestersRowList
                                                          .firstOrNull
                                                          ?.semesterType,
                                                      '1학기',
                                                    ),
                                                  ),
                                                  options:
                                                      dropDown2SemestersRowList
                                                          .map((e) =>
                                                              e.semesterType)
                                                          .withoutNulls
                                                          .toList(),
                                                  onChanged: (val) async {
                                                    safeSetState(() => _model
                                                        .dropDown2Value1 = val);
                                                    _model.semester =
                                                        _model.dropDown2Value1;
                                                    _model.buttonGrades = -1;
                                                    _model.semesterGradeOutput =
                                                        [];
                                                    _model.yearsSemesterMapOutput =
                                                        [];
                                                    _model.courseBySelectOutputVar =
                                                        [];
                                                    _model.courseSectionOutputVar =
                                                        [];
                                                    _model.classOnload = _model
                                                        .classSelectedOnload!
                                                        .where((e) =>
                                                            (e.year ==
                                                                _model.years) &&
                                                            (e.semester ==
                                                                _model
                                                                    .semester))
                                                        .toList()
                                                        .cast<ClassRow>();
                                                    safeSetState(() {});
                                                    _model.horizontaloutput =
                                                        await YearsSemesterMapTable()
                                                            .queryRows(
                                                      queryFn: (q) => q
                                                          .eqOrNull(
                                                            'year_text',
                                                            _model.years,
                                                          )
                                                          .eqOrNull(
                                                            'semester_type_text',
                                                            _model.semester,
                                                          ),
                                                    );

                                                    safeSetState(() {});
                                                  },
                                                  width: 160.0,
                                                  height: 40.0,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .labelMedium
                                                      .override(
                                                        font: GoogleFonts
                                                            .openSans(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .neutral500,
                                                        fontSize: () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return 6.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return 8.0;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
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
                                                  hintText: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    'zgs067dr' /* 학기 선택 */,
                                                  ),
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    size: 16.0,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground,
                                                  elevation: 0.0,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .neutral200,
                                                  borderWidth: 1.0,
                                                  borderRadius: 8.0,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(
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
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 0.0, 0.0),
                                    child: Material(
                                      color: Colors.transparent,
                                      elevation: 1.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Container(
                                        width: 120.0,
                                        height: 40.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: RichText(
                                                  textScaler:
                                                      MediaQuery.of(context)
                                                          .textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: valueOrDefault<
                                                            String>(
                                                          _model.years,
                                                          '0000',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  fontSize: () {
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
                                                      TextSpan(
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'cmnvwukz' /* 년 */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  fontSize: () {
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
                                                      TextSpan(
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'pzabwugj' /*    */,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                  fontSize: () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return 6.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return 8.0;
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
                                                      TextSpan(
                                                        text: valueOrDefault<
                                                            String>(
                                                          _model.semester,
                                                          '-학기',
                                                        ),
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF284E75),
                                                          fontSize: () {
                                                            if (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width <
                                                                kBreakpointSmall) {
                                                              return 10.0;
                                                            } else if (MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width <
                                                                kBreakpointMedium) {
                                                              return 10.0;
                                                            } else if (MediaQuery
                                                                        .sizeOf(
                                                                            context)
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
                                                    style:
                                                        FlutterFlowTheme.of(
                                                                context)
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
                                                              fontSize: () {
                                                                if (MediaQuery.sizeOf(
                                                                            context)
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
                                                              letterSpacing:
                                                                  0.0,
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
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: FlutterFlowIconButton(
                                borderRadius: 8.0,
                                buttonSize: 40.0,
                                fillColor: _model.channelTalk == false
                                    ? Color(0xFF284E75)
                                    : FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                hoverColor: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                hoverIconColor: Color(0xFF284E75),
                                icon: Icon(
                                  Icons.quora_rounded,
                                  color: valueOrDefault<Color>(
                                    _model.channelTalk == false
                                        ? FlutterFlowTheme.of(context)
                                            .primaryBackground
                                        : Color(0xFF284E75),
                                    FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  _model.channelTalk = !_model.channelTalk;
                                  safeSetState(() {});
                                },
                              ),
                            ),
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
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      shape: BoxShape.rectangle,
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Flexible(
                                flex: 2,
                                child: Align(
                                  alignment: AlignmentDirectional(-1.0, -1.0),
                                  child: SafeArea(
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.23,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Align(
                                              alignment: AlignmentDirectional(
                                                  0.0, -1.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0,
                                                        valueOrDefault<double>(
                                                          () {
                                                            if (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width <
                                                                kBreakpointSmall) {
                                                              return 8.0;
                                                            } else if (MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width <
                                                                kBreakpointMedium) {
                                                              return 10.0;
                                                            } else if (MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width <
                                                                kBreakpointLarge) {
                                                              return 13.0;
                                                            } else {
                                                              return 15.0;
                                                            }
                                                          }(),
                                                          0.0,
                                                        ),
                                                        10.0,
                                                        10.0),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.buttonGrades =
                                                                      1;
                                                                  _model.textColor1 =
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground;
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
                                                                  _model.buttonColor1 =
                                                                      Color(
                                                                          0xFF284E75);
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
                                                                  _model.courseSelected =
                                                                      -1;
                                                                  _model.classAfterCourse =
                                                                      [];
                                                                  _model.classAfterGrade =
                                                                      [];
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.classAfterGrade = _model
                                                                      .classOnload
                                                                      .sortedList(
                                                                          keyOf: (e) => e
                                                                              .grade!,
                                                                          desc:
                                                                              false)
                                                                      .where((e) =>
                                                                          e.grade ==
                                                                          _model
                                                                              .buttonGrades)
                                                                      .toList()
                                                                      .cast<
                                                                          ClassRow>();
                                                                  safeSetState(
                                                                      () {});
                                                                  FFAppState()
                                                                          .gradeSelected =
                                                                      _model
                                                                          .buttonGrades!;
                                                                  FFAppState()
                                                                          .sectionSelected =
                                                                      valueOrDefault<
                                                                          String>(
                                                                    _model
                                                                        .classAfterGrade
                                                                        .firstOrNull
                                                                        ?.section,
                                                                    '분반 정보',
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'uunm3g79' /* 1학년 담당과목 */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.35,
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model
                                                                        .buttonColor1,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor1,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  hoverColor: Color(
                                                                      0xFF284E75),
                                                                  hoverBorderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    width: 2.0,
                                                                  ),
                                                                  hoverTextColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.buttonGrades =
                                                                      2;
                                                                  _model.textColor1 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.textColor2 =
                                                                      Colors
                                                                          .white;
                                                                  _model.textColor3 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.textColor4 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.textColor5 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.buttonColor1 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.buttonColor2 =
                                                                      Color(
                                                                          0xFF284E75);
                                                                  _model.buttonColor3 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.buttonColor4 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.buttonColor5 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.courseSelected =
                                                                      -1;
                                                                  _model.classAfterCourse =
                                                                      [];
                                                                  _model.classAfterGrade =
                                                                      [];
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.classAfterGrade = _model
                                                                      .classOnload
                                                                      .sortedList(
                                                                          keyOf: (e) => e
                                                                              .grade!,
                                                                          desc:
                                                                              false)
                                                                      .where((e) =>
                                                                          e.grade ==
                                                                          _model
                                                                              .buttonGrades)
                                                                      .toList()
                                                                      .cast<
                                                                          ClassRow>();
                                                                  safeSetState(
                                                                      () {});
                                                                  FFAppState()
                                                                          .gradeSelected =
                                                                      _model
                                                                          .buttonGrades!;
                                                                  FFAppState()
                                                                          .sectionSelected =
                                                                      valueOrDefault<
                                                                          String>(
                                                                    _model
                                                                        .classAfterGrade
                                                                        .firstOrNull
                                                                        ?.section,
                                                                    '분반 정보',
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'pz0phfc5' /* 2학년 담당과목 */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.35,
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model
                                                                        .buttonColor2,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor2,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  hoverColor: Color(
                                                                      0xFF284E75),
                                                                  hoverBorderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    width: 2.0,
                                                                  ),
                                                                  hoverTextColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.buttonGrades =
                                                                      3;
                                                                  _model.textColor1 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.textColor2 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.textColor3 =
                                                                      Colors
                                                                          .white;
                                                                  _model.textColor4 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.textColor5 =
                                                                      Color(
                                                                          4280831605);
                                                                  _model.buttonColor1 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.buttonColor2 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.buttonColor3 =
                                                                      Color(
                                                                          0xFF284E75);
                                                                  _model.buttonColor4 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.buttonColor5 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.courseSelected =
                                                                      -1;
                                                                  _model.classAfterCourse =
                                                                      [];
                                                                  _model.classAfterGrade =
                                                                      [];
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.classAfterGrade = _model
                                                                      .classOnload
                                                                      .sortedList(
                                                                          keyOf: (e) => e
                                                                              .grade!,
                                                                          desc:
                                                                              false)
                                                                      .where((e) =>
                                                                          e.grade ==
                                                                          _model
                                                                              .buttonGrades)
                                                                      .toList()
                                                                      .cast<
                                                                          ClassRow>();
                                                                  safeSetState(
                                                                      () {});
                                                                  FFAppState()
                                                                          .gradeSelected =
                                                                      _model
                                                                          .buttonGrades!;
                                                                  FFAppState()
                                                                          .sectionSelected =
                                                                      valueOrDefault<
                                                                          String>(
                                                                    _model
                                                                        .classAfterGrade
                                                                        .firstOrNull
                                                                        ?.section,
                                                                    '분반 정보',
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'u0szcixn' /* 3학년 담당과목 */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.35,
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model
                                                                        .buttonColor3,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor3,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  hoverColor: Color(
                                                                      0xFF284E75),
                                                                  hoverBorderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    width: 2.0,
                                                                  ),
                                                                  hoverTextColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.buttonGrades =
                                                                      4;
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
                                                                      Colors
                                                                          .white;
                                                                  _model.textColor5 =
                                                                      Color(
                                                                          4280831605);
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
                                                                          0xFF284E75);
                                                                  _model.buttonColor5 =
                                                                      Color(
                                                                          4294967295);
                                                                  _model.courseSelected =
                                                                      -1;
                                                                  _model.classAfterGrade =
                                                                      [];
                                                                  _model.classAfterCourse =
                                                                      [];
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.classAfterGrade = _model
                                                                      .classOnload
                                                                      .sortedList(
                                                                          keyOf: (e) => e
                                                                              .grade!,
                                                                          desc:
                                                                              false)
                                                                      .where((e) =>
                                                                          e.grade ==
                                                                          _model
                                                                              .buttonGrades)
                                                                      .toList()
                                                                      .cast<
                                                                          ClassRow>();
                                                                  safeSetState(
                                                                      () {});
                                                                  FFAppState()
                                                                          .gradeSelected =
                                                                      _model
                                                                          .buttonGrades!;
                                                                  FFAppState()
                                                                          .sectionSelected =
                                                                      valueOrDefault<
                                                                          String>(
                                                                    _model
                                                                        .classAfterGrade
                                                                        .firstOrNull
                                                                        ?.section,
                                                                    '분반 정보',
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'sfuiwnvo' /* 4학년 담당과목 */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.35,
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model
                                                                        .buttonColor4,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor4,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  hoverColor: Color(
                                                                      0xFF284E75),
                                                                  hoverBorderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    width: 2.0,
                                                                  ),
                                                                  hoverTextColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          0.0,
                                                                          3.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.buttonGrades =
                                                                      5;
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
                                                                      Colors
                                                                          .white;
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
                                                                          0xFF284E75);
                                                                  _model.courseSelected =
                                                                      -1;
                                                                  _model.classAfterGrade =
                                                                      [];
                                                                  _model.classAfterCourse =
                                                                      [];
                                                                  safeSetState(
                                                                      () {});
                                                                  _model.classAfterGrade = _model
                                                                      .classOnload
                                                                      .sortedList(
                                                                          keyOf: (e) => e
                                                                              .grade!,
                                                                          desc:
                                                                              false)
                                                                      .where((e) =>
                                                                          e.grade ==
                                                                          _model
                                                                              .buttonGrades)
                                                                      .toList()
                                                                      .cast<
                                                                          ClassRow>();
                                                                  safeSetState(
                                                                      () {});
                                                                  FFAppState()
                                                                          .gradeSelected =
                                                                      _model
                                                                          .buttonGrades!;
                                                                  FFAppState()
                                                                          .sectionSelected =
                                                                      valueOrDefault<
                                                                          String>(
                                                                    _model
                                                                        .classAfterGrade
                                                                        .firstOrNull
                                                                        ?.section,
                                                                    '분반 정보',
                                                                  );
                                                                  safeSetState(
                                                                      () {});
                                                                },
                                                                text: FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'xv4d230o' /* 5학년 담당과목 */,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.35,
                                                                  height: 40.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    _model
                                                                        .buttonColor5,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor5,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                    width: 2.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  hoverColor: Color(
                                                                      0xFF284E75),
                                                                  hoverBorderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    width: 2.0,
                                                                  ),
                                                                  hoverTextColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
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
                                          Flexible(
                                            flex: 5,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (_model.classAfterGrade
                                                            .firstOrNull !=
                                                        null)
                                                      Expanded(
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              double.infinity,
                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            40.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: PageView(
                                                                  controller: _model
                                                                          .pageViewController1 ??=
                                                                      PageController(
                                                                          initialPage:
                                                                              0),
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.19,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.55,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        minHeight:
                                                                            MediaQuery.sizeOf(context).height *
                                                                                0.55,
                                                                        maxHeight:
                                                                            MediaQuery.sizeOf(context).height *
                                                                                0.55,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                () {
                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                return 240.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                return 240.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                return 450.0;
                                                                              } else {
                                                                                return 550.0;
                                                                              }
                                                                            }(),
                                                                            child:
                                                                                Divider(
                                                                              thickness: 5.0,
                                                                              color: Color(0xFF284E75),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.9,
                                                                              height: MediaQuery.sizeOf(context).height * 0.13,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      _model.classAfterGrade.firstOrNull?.course,
                                                                                      '전공 과목',
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFF284E75),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 16.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 18.0;
                                                                                            } else {
                                                                                              return 22.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: MouseRegion(
                                                                                      opaque: false,
                                                                                      cursor: MouseCursor.defer,
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              _model.courseSelected = 0;
                                                                                              _model.classAfterCourse = [];
                                                                                              safeSetState(() {});
                                                                                              _model.addToClassAfterCourse(_model.classAfterGrade.firstOrNull!);
                                                                                              safeSetState(() {});
                                                                                              _model.progressoutput1 = await SubjectportpolioTable().queryRows(
                                                                                                queryFn: (q) => q
                                                                                                    .eqOrNull(
                                                                                                      'professor_name',
                                                                                                      _model.profeesorName,
                                                                                                    )
                                                                                                    .eqOrNull(
                                                                                                      'class',
                                                                                                      _model.classAfterCourse.firstOrNull?.id,
                                                                                                    ),
                                                                                              );
                                                                                              _model.progressSubject = _model.progressoutput1?.length;
                                                                                              safeSetState(() {});

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            child: AnimatedDefaultTextStyle(
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: valueOrDefault<Color>(
                                                                                                      () {
                                                                                                        if (_model.mouseRegionHovered1) {
                                                                                                          return Color(0xFFFF0000);
                                                                                                        } else if (_model.courseSelected == 0) {
                                                                                                          return Color(0xFFFF0000);
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).secondaryText;
                                                                                                        }
                                                                                                      }(),
                                                                                                      FlutterFlowTheme.of(context).secondaryText,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 8.0;
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
                                                                                                    decoration: TextDecoration.underline,
                                                                                                  ),
                                                                                              duration: Duration(milliseconds: 200),
                                                                                              curve: Curves.easeIn,
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'dbo3qjx0' /* 진행사항 조회하기 */,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      onEnter: ((event) async {
                                                                                        safeSetState(() => _model.mouseRegionHovered1 = true);
                                                                                      }),
                                                                                      onExit: ((event) async {
                                                                                        safeSetState(() => _model.mouseRegionHovered1 = false);
                                                                                      }),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (_model.classAfterGrade.where((e) => e.sectionBool == true).toList().firstOrNull !=
                                                                              null)
                                                                            ListView(
                                                                              padding: EdgeInsets.zero,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                  child: Container(
                                                                                    width: 304.0,
                                                                                    height: 100.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFF284E75),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                _model.classAfterGrade.firstOrNull?.section,
                                                                                                '분반 정보',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 16.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 18.0;
                                                                                                      } else {
                                                                                                        return 22.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                  child: RichText(
                                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                                    text: TextSpan(
                                                                                                      children: [
                                                                                                        TextSpan(
                                                                                                          text: valueOrDefault<String>(
                                                                                                            _model.classAfterGrade.firstOrNull?.professor,
                                                                                                            '교수님1',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 8.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 12.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 14.0;
                                                                                                                  } else {
                                                                                                                    return 18.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                        TextSpan(
                                                                                                          text: FFLocalizations.of(context).getText(
                                                                                                            '4k1q3p46' /*  교수님 */,
                                                                                                          ),
                                                                                                          style: TextStyle(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 12.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 14.0;
                                                                                                              } else {
                                                                                                                return 18.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 12.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 14.0;
                                                                                                              } else {
                                                                                                                return 18.0;
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
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(100.0, 15.0, 0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                      _model.classAfterCourse.firstOrNull?.professor,
                                                                                                      '교수님 이름',
                                                                                                    );
                                                                                                    FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                      _model.classAfterCourse.firstOrNull?.course,
                                                                                                      '과목 이름',
                                                                                                    );
                                                                                                    FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                    FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                      _model.classAfterGrade.firstOrNull?.section,
                                                                                                      '분반 정보',
                                                                                                    );
                                                                                                    FFAppState().yearSelected = _model.years!;
                                                                                                    FFAppState().semesterSelected = _model.semester!;
                                                                                                    safeSetState(() {});

                                                                                                    context.pushNamed(HomeWidget.routeName);
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'u9d8l72o' /* 바로가기 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 6.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
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
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                      _model.classAfterCourse.firstOrNull?.professor,
                                                                                                      '교수님 이름',
                                                                                                    );
                                                                                                    FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                      _model.classAfterCourse.firstOrNull?.course,
                                                                                                      '과목 이름',
                                                                                                    );
                                                                                                    FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                    FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                      _model.classAfterGrade.firstOrNull?.section,
                                                                                                      '분반 정보',
                                                                                                    );
                                                                                                    FFAppState().yearSelected = _model.years!;
                                                                                                    FFAppState().semesterSelected = _model.semester!;
                                                                                                    safeSetState(() {});

                                                                                                    context.pushNamed(HomeWidget.routeName);
                                                                                                  },
                                                                                                  child: Icon(
                                                                                                    Icons.arrow_right_outlined,
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
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
                                                                    Visibility(
                                                                      visible: _model
                                                                              .classAfterGrade
                                                                              .elementAtOrNull(1) !=
                                                                          null,
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.19,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.55,
                                                                        constraints:
                                                                            BoxConstraints(
                                                                          minHeight:
                                                                              MediaQuery.sizeOf(context).height * 0.55,
                                                                          maxHeight:
                                                                              MediaQuery.sizeOf(context).height * 0.55,
                                                                        ),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: () {
                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                  return 240.0;
                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                  return 240.0;
                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                  return 450.0;
                                                                                } else {
                                                                                  return 550.0;
                                                                                }
                                                                              }(),
                                                                              child: Divider(
                                                                                thickness: 5.0,
                                                                                color: Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                height: MediaQuery.sizeOf(context).height * 0.13,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        _model.classAfterGrade.elementAtOrNull(1)?.course,
                                                                                        '전공 과목',
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      maxLines: 2,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: Color(0xFF284E75),
                                                                                            fontSize: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 12.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 16.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 18.0;
                                                                                              } else {
                                                                                                return 22.0;
                                                                                              }
                                                                                            }(),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: MouseRegion(
                                                                                        opaque: false,
                                                                                        cursor: MouseCursor.defer,
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                _model.courseSelected = 1;
                                                                                                _model.classAfterCourse = [];
                                                                                                safeSetState(() {});
                                                                                                _model.addToClassAfterCourse(_model.classAfterGrade.elementAtOrNull(1)!);
                                                                                                safeSetState(() {});
                                                                                                _model.progressoutput2 = await SubjectportpolioTable().queryRows(
                                                                                                  queryFn: (q) => q
                                                                                                      .eqOrNull(
                                                                                                        'professor_name',
                                                                                                        _model.profeesorName,
                                                                                                      )
                                                                                                      .eqOrNull(
                                                                                                        'class',
                                                                                                        _model.classAfterCourse.firstOrNull?.id,
                                                                                                      ),
                                                                                                );
                                                                                                _model.progressSubject = _model.progressoutput2?.length;
                                                                                                safeSetState(() {});

                                                                                                safeSetState(() {});
                                                                                              },
                                                                                              child: AnimatedDefaultTextStyle(
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: valueOrDefault<Color>(
                                                                                                        () {
                                                                                                          if (_model.mouseRegionHovered2) {
                                                                                                            return Color(0xFFFF0000);
                                                                                                          } else if (_model.courseSelected == 0) {
                                                                                                            return Color(0xFFFF0000);
                                                                                                          } else {
                                                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                                                          }
                                                                                                        }(),
                                                                                                        FlutterFlowTheme.of(context).secondaryText,
                                                                                                      ),
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 8.0;
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
                                                                                                      decoration: TextDecoration.underline,
                                                                                                    ),
                                                                                                duration: Duration(milliseconds: 200),
                                                                                                curve: Curves.easeIn,
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'q74q5i92' /* 진행사항 조회하기 */,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        onEnter: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered2 = true);
                                                                                        }),
                                                                                        onExit: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered2 = false);
                                                                                        }),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            if (_model.classAfterGrade.elementAtOrNull(1)?.sectionBool !=
                                                                                null)
                                                                              ListView(
                                                                                padding: EdgeInsets.zero,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                    child: Container(
                                                                                      width: 304.0,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFF284E75),
                                                                                      ),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 12.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                          return 16.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                          return 18.0;
                                                                                                        } else {
                                                                                                          return 22.0;
                                                                                                        }
                                                                                                      }(),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                child: Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                    child: RichText(
                                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                                      text: TextSpan(
                                                                                                        children: [
                                                                                                          TextSpan(
                                                                                                            text: valueOrDefault<String>(
                                                                                                              _model.classAfterGrade.firstOrNull?.professor,
                                                                                                              '교수님1',
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 8.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 12.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 14.0;
                                                                                                                    } else {
                                                                                                                      return 18.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                          TextSpan(
                                                                                                            text: FFLocalizations.of(context).getText(
                                                                                                              'in8gs77k' /*  교수님 */,
                                                                                                            ),
                                                                                                            style: TextStyle(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 12.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 14.0;
                                                                                                                } else {
                                                                                                                  return 18.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 12.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 14.0;
                                                                                                                } else {
                                                                                                                  return 18.0;
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
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(100.0, 15.0, 0.0, 0.0),
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      context.pushNamed(HomeWidget.routeName);
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        '29yf7ze3' /* 바로가기 */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 6.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 10.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 12.0;
                                                                                                              } else {
                                                                                                                return 16.0;
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
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                                                                                  child: Icon(
                                                                                                    Icons.arrow_right_outlined,
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
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
                                                                    Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.19,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.55,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        minHeight:
                                                                            MediaQuery.sizeOf(context).height *
                                                                                0.55,
                                                                        maxHeight:
                                                                            MediaQuery.sizeOf(context).height *
                                                                                0.55,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Visibility(
                                                                        visible:
                                                                            _model.classAfterGrade.elementAtOrNull(2) !=
                                                                                null,
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: () {
                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                  return 240.0;
                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                  return 240.0;
                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                  return 450.0;
                                                                                } else {
                                                                                  return 550.0;
                                                                                }
                                                                              }(),
                                                                              child: Divider(
                                                                                thickness: 5.0,
                                                                                color: Color(0xFF284E75),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                height: MediaQuery.sizeOf(context).height * 0.13,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        _model.classAfterGrade.elementAtOrNull(2)?.course,
                                                                                        '전공 과목',
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                      maxLines: 2,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            color: Color(0xFF284E75),
                                                                                            fontSize: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 12.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 16.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 18.0;
                                                                                              } else {
                                                                                                return 22.0;
                                                                                              }
                                                                                            }(),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: MouseRegion(
                                                                                        opaque: false,
                                                                                        cursor: MouseCursor.defer,
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                _model.courseSelected = 2;
                                                                                                _model.classAfterCourse = [];
                                                                                                safeSetState(() {});
                                                                                                _model.addToClassAfterCourse(_model.classAfterGrade.elementAtOrNull(2)!);
                                                                                                safeSetState(() {});
                                                                                                _model.progressoutput3 = await SubjectportpolioTable().queryRows(
                                                                                                  queryFn: (q) => q
                                                                                                      .eqOrNull(
                                                                                                        'professor_name',
                                                                                                        _model.profeesorName,
                                                                                                      )
                                                                                                      .eqOrNull(
                                                                                                        'class',
                                                                                                        _model.classAfterCourse.firstOrNull?.id,
                                                                                                      ),
                                                                                                );
                                                                                                _model.progressSubject = _model.progressoutput3?.length;
                                                                                                safeSetState(() {});

                                                                                                safeSetState(() {});
                                                                                              },
                                                                                              child: AnimatedDefaultTextStyle(
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: valueOrDefault<Color>(
                                                                                                        () {
                                                                                                          if (_model.mouseRegionHovered3) {
                                                                                                            return Color(0xFFFF0000);
                                                                                                          } else if (_model.courseSelected == 0) {
                                                                                                            return Color(0xFFFF0000);
                                                                                                          } else {
                                                                                                            return FlutterFlowTheme.of(context).secondaryText;
                                                                                                          }
                                                                                                        }(),
                                                                                                        FlutterFlowTheme.of(context).secondaryText,
                                                                                                      ),
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 8.0;
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
                                                                                                      decoration: TextDecoration.underline,
                                                                                                    ),
                                                                                                duration: Duration(milliseconds: 200),
                                                                                                curve: Curves.easeIn,
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'ndpdgr60' /* 진행사항 조회하기 */,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        onEnter: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered3 = true);
                                                                                        }),
                                                                                        onExit: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered3 = false);
                                                                                        }),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            if (_model.classAfterGrade.elementAtOrNull(2)?.sectionBool !=
                                                                                null)
                                                                              ListView(
                                                                                padding: EdgeInsets.zero,
                                                                                shrinkWrap: true,
                                                                                scrollDirection: Axis.vertical,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                    child: Container(
                                                                                      width: 304.0,
                                                                                      height: 100.0,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFF284E75),
                                                                                      ),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 12.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                          return 16.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                          return 18.0;
                                                                                                        } else {
                                                                                                          return 22.0;
                                                                                                        }
                                                                                                      }(),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                child: Align(
                                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                    child: RichText(
                                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                                      text: TextSpan(
                                                                                                        children: [
                                                                                                          TextSpan(
                                                                                                            text: valueOrDefault<String>(
                                                                                                              _model.classAfterGrade.firstOrNull?.professor,
                                                                                                              '교수님1',
                                                                                                            ),
                                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                  font: GoogleFonts.openSans(
                                                                                                                    fontWeight: FontWeight.w500,
                                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                  ),
                                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                  fontSize: () {
                                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                      return 8.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                      return 12.0;
                                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                      return 14.0;
                                                                                                                    } else {
                                                                                                                      return 18.0;
                                                                                                                    }
                                                                                                                  }(),
                                                                                                                  letterSpacing: 0.0,
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                          ),
                                                                                                          TextSpan(
                                                                                                            text: FFLocalizations.of(context).getText(
                                                                                                              'pae35jgr' /*  교수님 */,
                                                                                                            ),
                                                                                                            style: TextStyle(
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 12.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 14.0;
                                                                                                                } else {
                                                                                                                  return 18.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                            ),
                                                                                                          )
                                                                                                        ],
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 12.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 14.0;
                                                                                                                } else {
                                                                                                                  return 18.0;
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
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(100.0, 15.0, 0.0, 0.0),
                                                                                                  child: InkWell(
                                                                                                    splashColor: Colors.transparent,
                                                                                                    focusColor: Colors.transparent,
                                                                                                    hoverColor: Colors.transparent,
                                                                                                    highlightColor: Colors.transparent,
                                                                                                    onTap: () async {
                                                                                                      context.pushNamed(HomeWidget.routeName);
                                                                                                    },
                                                                                                    child: Text(
                                                                                                      FFLocalizations.of(context).getText(
                                                                                                        '807hu4ov' /* 바로가기 */,
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 6.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 10.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 12.0;
                                                                                                              } else {
                                                                                                                return 16.0;
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
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                                                                                  child: Icon(
                                                                                                    Icons.arrow_right_outlined,
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    size: 24.0,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
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
                                                                  ],
                                                                ),
                                                              ),
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0.0,
                                                                        -1.0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          16.0),
                                                                  child: smooth_page_indicator
                                                                      .SmoothPageIndicator(
                                                                    controller: _model
                                                                            .pageViewController1 ??=
                                                                        PageController(
                                                                            initialPage:
                                                                                0),
                                                                    count: 3,
                                                                    axisDirection:
                                                                        Axis.horizontal,
                                                                    onDotClicked:
                                                                        (i) async {
                                                                      await _model
                                                                          .pageViewController1!
                                                                          .animateToPage(
                                                                        i,
                                                                        duration:
                                                                            Duration(milliseconds: 500),
                                                                        curve: Curves
                                                                            .ease,
                                                                      );
                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    effect: smooth_page_indicator
                                                                        .SlideEffect(
                                                                      spacing:
                                                                          8.0,
                                                                      radius:
                                                                          8.0,
                                                                      dotWidth:
                                                                          8.0,
                                                                      dotHeight:
                                                                          8.0,
                                                                      dotColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .accent1,
                                                                      activeDotColor:
                                                                          Color(
                                                                              0xFF284E75),
                                                                      paintStyle:
                                                                          PaintingStyle
                                                                              .fill,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            if (MediaQuery.sizeOf(context).width >= 850.0
                                ? true
                                : false)
                              SizedBox(
                                height: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 400.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 650.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 700.0;
                                  } else {
                                    return 750.0;
                                  }
                                }(),
                                child: VerticalDivider(
                                  thickness: 3.0,
                                  indent: 0.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                            if (((_model.classAfterCourse.firstOrNull !=
                                        null) &&
                                    (_model.courseSelected! >= 0)) &&
                                responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                ))
                              SafeArea(
                                child: Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.76,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.93,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: SafeArea(
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.37,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.23,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      _model
                                                                          .classAfterCourse
                                                                          .firstOrNull
                                                                          ?.course,
                                                                      '전공 과목',
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
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF284E75),
                                                                          fontSize:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 12.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 16.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 18.0;
                                                                            } else {
                                                                              return 22.0;
                                                                            }
                                                                          }(),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  '9koigeu9' /* 총 진행사항 */,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          25.0,
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
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          5.0,
                                                                          0.0),
                                                              child:
                                                                  LinearPercentIndicator(
                                                                percent:
                                                                    valueOrDefault<
                                                                        double>(
                                                                  math.min(
                                                                      1.0,
                                                                      math.max(
                                                                          0.0,
                                                                          (((_model.progressSubject!)) /
                                                                              (8 * 15)))),
                                                                  0.0,
                                                                ),
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.35,
                                                                lineHeight:
                                                                    25.0,
                                                                animation: true,
                                                                animateFromLastPercent:
                                                                    true,
                                                                progressColor:
                                                                    Color(
                                                                        0xFF284E75),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                barRadius: Radius
                                                                    .circular(
                                                                        25.0),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.02,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'wha9i5x4' /* 0% */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                15.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'vr1u3g3d' /* 100% */,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                            ),
                                          ),
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.24,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.68,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.33,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.04,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      _model
                                                                          .classAfterGrade
                                                                          .firstOrNull
                                                                          ?.course,
                                                                      '전공 과목',
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
                                                                              Color(0xFF284E75),
                                                                          fontSize:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 12.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 16.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 18.0;
                                                                            } else {
                                                                              return 22.0;
                                                                            }
                                                                          }(),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          _model
                                                                              .classAfterGrade
                                                                              .firstOrNull
                                                                              ?.professor,
                                                                          '교수님',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF284E75),
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child:
                                                                            FFButtonWidget(
                                                                          onPressed:
                                                                              () async {
                                                                            FFAppState().professorNameSelected =
                                                                                valueOrDefault<String>(
                                                                              _model.classAfterCourse.firstOrNull?.professor,
                                                                              '교수님 이름',
                                                                            );
                                                                            FFAppState().courseNameSelected =
                                                                                valueOrDefault<String>(
                                                                              _model.classAfterCourse.firstOrNull?.course,
                                                                              '과목 이름',
                                                                            );
                                                                            FFAppState().classSelectedID =
                                                                                _model.classAfterCourse.firstOrNull!.id;
                                                                            FFAppState().sectionSelected =
                                                                                valueOrDefault<String>(
                                                                              _model.classAfterGrade.firstOrNull?.section,
                                                                              '분반 정보',
                                                                            );
                                                                            FFAppState().yearSelected =
                                                                                _model.years!;
                                                                            FFAppState().semesterSelected =
                                                                                _model.semester!;
                                                                            safeSetState(() {});

                                                                            context.pushNamed(HomeWidget.routeName);
                                                                          },
                                                                          text:
                                                                              FFLocalizations.of(context).getText(
                                                                            'boem1ns4' /* 바로가기  ▶ */,
                                                                          ),
                                                                          options:
                                                                              FFButtonOptions(
                                                                            height:
                                                                                35.0,
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                15.0,
                                                                                0.0,
                                                                                5.0,
                                                                                0.0),
                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            color:
                                                                                Color(0xFF284E75),
                                                                            textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: Colors.white,
                                                                                  fontSize: 15.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                            elevation:
                                                                                0.0,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.23,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.27,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'w2afxnnc' /* 교수님 업로드현황  */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                18.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              6.0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.22,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.23,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).alternate,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 2.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'ibo6902s' /* 포트폴리오 크리틱 */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: 16.0,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(1.0, 0.0),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(30.0, 2.0, 10.0, 0.0),
                                                                                    child: InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                          _model.classAfterCourse.firstOrNull?.professor,
                                                                                          '교수님 이름',
                                                                                        );
                                                                                        FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                          _model.classAfterCourse.firstOrNull?.course,
                                                                                          '과목 이름',
                                                                                        );
                                                                                        FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                        FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                          _model.classAfterGrade.firstOrNull?.section,
                                                                                          '분반 정보',
                                                                                        );
                                                                                        FFAppState().yearSelected = _model.years!;
                                                                                        FFAppState().semesterSelected = _model.semester!;
                                                                                        safeSetState(() {});

                                                                                        context.pushNamed(ProfSubjectPortpolioWidget.routeName);
                                                                                      },
                                                                                      child: AutoSizeText(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'jmuq45pc' /* 바로가기  ▶ */,
                                                                                        ),
                                                                                        textAlign: TextAlign.end,
                                                                                        minFontSize: 12.0,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Expanded(
                                                                              flex: 10,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                child: custom_widgets.ChartWidget(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  chartData: _model.chartDataParam,
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
                                                          Flexible(
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.24,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.17,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          0.0),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          0.0),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Flexible(
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '96n3wuxt' /* 학부생 등록여부 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'm5iz97tp' /* -- */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: 12.0,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'yv2w69z2' /* 파일이 없습니다. */,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '36ftlnzr' /* 수업계획서 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(ProfCoursePlanWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'bm7dyfhx' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'ub75cqis' /* 파일이 없습니다. */,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Flexible(
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '7m23d7q5' /* 강의 자료실 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(ProfLectureMaterialsWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'zkq8tq1r' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'q2npstxj' /* 파일이 없습니다. */,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'rqag96m2' /* 학생 작품 평가표 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(35.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(StudentWorkEvalFormWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'i8auhonn' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'hbr5t9cu' /* 파일이 없습니다. */,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Flexible(
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '8bhrle1n' /* 출석부 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(ProfAttendanceSheetWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'wfwt4wyi' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'pvt02el0' /* 파일이 없습니다. */,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.04,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'yboe97bp' /* 성적기록표 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 13.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(ProfGradeSheetWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'bqnrmkpt' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                    Flexible(
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '22sglu5j' /* 파일이 없습니다. */,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 10.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.24,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          'bqk8nxny' /* 학생 업로드현황  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 18.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Flexible(
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.12,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'utxta54n' /* 과목 포트폴리오 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(ProfSubjectPortpolioWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'lb49prlt' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 2.0, 0.0),
                                                                                    child: LinearPercentIndicator(
                                                                                      percent: valueOrDefault<double>(
                                                                                        math.min(1.0, math.max(0.0, (((_model.progressSubject!)) / (8 * 15)))),
                                                                                        0.0,
                                                                                      ),
                                                                                      width: MediaQuery.sizeOf(context).width * 0.085,
                                                                                      lineHeight: 20.0,
                                                                                      animation: true,
                                                                                      animateFromLastPercent: true,
                                                                                      progressColor: Color(0xFF284E75),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                      padding: EdgeInsets.zero,
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: MouseRegion(
                                                                                        opaque: false,
                                                                                        cursor: MouseCursor.defer,
                                                                                        child: Visibility(
                                                                                          visible: false,
                                                                                          child: Builder(
                                                                                            builder: (context) => Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  await showDialog(
                                                                                                    context: context,
                                                                                                    builder: (dialogContext) {
                                                                                                      return Dialog(
                                                                                                        elevation: 0,
                                                                                                        insetPadding: EdgeInsets.zero,
                                                                                                        backgroundColor: Colors.transparent,
                                                                                                        alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                        child: WebViewAware(
                                                                                                          child: GestureDetector(
                                                                                                            onTap: () {
                                                                                                              FocusScope.of(dialogContext).unfocus();
                                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                                            },
                                                                                                            child: SubmitSearchedWidget(),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    '72ycvpra' /* 미제출 조회 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: valueOrDefault<Color>(
                                                                                                          _model.mouseRegionHovered4 ? Color(0xFFFF0000) : FlutterFlowTheme.of(context).secondaryText,
                                                                                                          FlutterFlowTheme.of(context).secondaryText,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        onEnter: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered4 = true);
                                                                                        }),
                                                                                        onExit: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered4 = false);
                                                                                        }),
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
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                5.0,
                                                                                5.0,
                                                                                5.0),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.11,
                                                                              height: MediaQuery.sizeOf(context).height * 0.12,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                borderRadius: BorderRadius.circular(5.0),
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 5.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            '3d1zk7dw' /* 1차-2차 성과물 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 14.0,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(20.0, 1.0, 3.0, 0.0),
                                                                                            child: InkWell(
                                                                                              splashColor: Colors.transparent,
                                                                                              focusColor: Colors.transparent,
                                                                                              hoverColor: Colors.transparent,
                                                                                              highlightColor: Colors.transparent,
                                                                                              onTap: () async {
                                                                                                FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.professor,
                                                                                                  '교수님 이름',
                                                                                                );
                                                                                                FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterCourse.firstOrNull?.course,
                                                                                                  '과목 이름',
                                                                                                );
                                                                                                FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                FFAppState().sectionSelected = valueOrDefault<String>(
                                                                                                  _model.classAfterGrade.firstOrNull?.section,
                                                                                                  '분반 정보',
                                                                                                );
                                                                                                FFAppState().yearSelected = _model.years!;
                                                                                                FFAppState().semesterSelected = _model.semester!;
                                                                                                safeSetState(() {});

                                                                                                context.pushNamed(ProfResultsMidtermWidget.routeName);
                                                                                              },
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  '30ajolow' /*  ▶ */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5.0, 10.0, 2.0, 0.0),
                                                                                    child: LinearPercentIndicator(
                                                                                      percent: valueOrDefault<double>(
                                                                                        math.min(1.0, math.max(0.0, (((_model.progressSubject!)) / (8 * 15)))),
                                                                                        0.0,
                                                                                      ),
                                                                                      width: MediaQuery.sizeOf(context).width * 0.085,
                                                                                      lineHeight: 20.0,
                                                                                      animation: true,
                                                                                      animateFromLastPercent: true,
                                                                                      progressColor: Color(0xFF284E75),
                                                                                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                      padding: EdgeInsets.zero,
                                                                                    ),
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: MouseRegion(
                                                                                        opaque: false,
                                                                                        cursor: MouseCursor.defer,
                                                                                        child: Visibility(
                                                                                          visible: false,
                                                                                          child: Builder(
                                                                                            builder: (context) => Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  await showDialog(
                                                                                                    context: context,
                                                                                                    builder: (dialogContext) {
                                                                                                      return Dialog(
                                                                                                        elevation: 0,
                                                                                                        insetPadding: EdgeInsets.zero,
                                                                                                        backgroundColor: Colors.transparent,
                                                                                                        alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                        child: WebViewAware(
                                                                                                          child: GestureDetector(
                                                                                                            onTap: () {
                                                                                                              FocusScope.of(dialogContext).unfocus();
                                                                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                                                                            },
                                                                                                            child: SubmitSearchedWidget(),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  );
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    '8zbmvqpd' /* 미제출 조회 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: valueOrDefault<Color>(
                                                                                                          _model.mouseRegionHovered5 ? Color(0xFFFF0000) : FlutterFlowTheme.of(context).secondaryText,
                                                                                                          FlutterFlowTheme.of(context).secondaryText,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        onEnter: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered5 = true);
                                                                                        }),
                                                                                        onExit: ((event) async {
                                                                                          safeSetState(() => _model.mouseRegionHovered5 = false);
                                                                                        }),
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
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Stack(
                          children: [
                            if ((_model.courseSelected == -1) &&
                                responsiveVisibility(
                                  context: context,
                                  tabletLandscape: false,
                                  desktop: false,
                                ))
                              Align(
                                alignment: AlignmentDirectional(0.0, -1.0),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (responsiveVisibility(
                                        context: context,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5.0, 0.0, 0.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              constraints: BoxConstraints(
                                                maxWidth: 500.0,
                                              ),
                                              decoration: BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
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
                                                              future:
                                                                  YearsTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q,
                                                              ),
                                                              builder: (context,
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
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<YearsRow>
                                                                    dropDown1YearsRowList =
                                                                    snapshot
                                                                        .data!;

                                                                return FlutterFlowDropDown<
                                                                    String>(
                                                                  controller: _model
                                                                          .dropDown1ValueController2 ??=
                                                                      FormFieldController<
                                                                          String>(
                                                                    _model.dropDown1Value2 ??=
                                                                        valueOrDefault<
                                                                            String>(
                                                                      dropDown1YearsRowList
                                                                          .lastOrNull
                                                                          ?.year,
                                                                      '2025',
                                                                    ),
                                                                  ),
                                                                  options: dropDown1YearsRowList
                                                                      .map((e) =>
                                                                          e.year)
                                                                      .withoutNulls
                                                                      .toList(),
                                                                  onChanged:
                                                                      (val) async {
                                                                    safeSetState(() =>
                                                                        _model.dropDown1Value2 =
                                                                            val);
                                                                    _model.years =
                                                                        _model
                                                                            .dropDown1Value2;
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  width: 160.0,
                                                                  height: 40.0,
                                                                  textStyle: FlutterFlowTheme.of(
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .neutral500,
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
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'je7o06x1' /* 년도 선택 */,
                                                                  ),
                                                                  icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_sharp,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 16.0,
                                                                  ),
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  elevation:
                                                                      0.0,
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .neutral200,
                                                                  borderWidth:
                                                                      1.0,
                                                                  borderRadius:
                                                                      8.0,
                                                                  margin: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          14.0,
                                                                          4.0,
                                                                          10.0,
                                                                          4.0),
                                                                  hidesUnderline:
                                                                      true,
                                                                  isSearchable:
                                                                      false,
                                                                  isMultiSelect:
                                                                      false,
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        2.0,
                                                                        5.0,
                                                                        2.0,
                                                                        5.0),
                                                            child: FutureBuilder<
                                                                List<
                                                                    SemestersRow>>(
                                                              future:
                                                                  SemestersTable()
                                                                      .queryRows(
                                                                queryFn: (q) =>
                                                                    q,
                                                              ),
                                                              builder: (context,
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
                                                                        valueColor:
                                                                            AlwaysStoppedAnimation<Color>(
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                }
                                                                List<SemestersRow>
                                                                    dropDown2SemestersRowList =
                                                                    snapshot
                                                                        .data!;

                                                                return FlutterFlowDropDown<
                                                                    String>(
                                                                  controller: _model
                                                                          .dropDown2ValueController2 ??=
                                                                      FormFieldController<
                                                                          String>(
                                                                    _model.dropDown2Value2 ??=
                                                                        valueOrDefault<
                                                                            String>(
                                                                      dropDown2SemestersRowList
                                                                          .firstOrNull
                                                                          ?.semesterType,
                                                                      '1학기',
                                                                    ),
                                                                  ),
                                                                  options: dropDown2SemestersRowList
                                                                      .map((e) =>
                                                                          e.semesterType)
                                                                      .withoutNulls
                                                                      .toList(),
                                                                  onChanged:
                                                                      (val) async {
                                                                    safeSetState(() =>
                                                                        _model.dropDown2Value2 =
                                                                            val);
                                                                    _model.semester =
                                                                        _model
                                                                            .dropDown2Value2;
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
                                                                    _model.classOnload = _model
                                                                        .classSelectedOnload!
                                                                        .where((e) =>
                                                                            (e.year == _model.years) &&
                                                                            (e.semester ==
                                                                                _model.semester))
                                                                        .toList()
                                                                        .cast<ClassRow>();
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  width: 160.0,
                                                                  height: 40.0,
                                                                  textStyle: FlutterFlowTheme.of(
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
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .neutral500,
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
                                                                            .labelMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .labelMedium
                                                                            .fontStyle,
                                                                      ),
                                                                  hintText: FFLocalizations.of(
                                                                          context)
                                                                      .getText(
                                                                    'f80e65ji' /* 학기 선택 */,
                                                                  ),
                                                                  icon: Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down_sharp,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    size: 16.0,
                                                                  ),
                                                                  fillColor: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  elevation:
                                                                      0.0,
                                                                  borderColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .neutral200,
                                                                  borderWidth:
                                                                      1.0,
                                                                  borderRadius:
                                                                      8.0,
                                                                  margin: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          14.0,
                                                                          4.0,
                                                                          10.0,
                                                                          4.0),
                                                                  hidesUnderline:
                                                                      true,
                                                                  isSearchable:
                                                                      false,
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
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(5.0, 0.0,
                                                                0.0, 0.0),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 1.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Container(
                                                        width: 120.0,
                                                        height: 40.0,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                                        0.0,
                                                                        0.0),
                                                                child: RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          _model
                                                                              .years,
                                                                          '0000',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF284E75),
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
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          '8dj2h33y' /* 년 */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF284E75),
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
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: FFLocalizations.of(context)
                                                                            .getText(
                                                                          'dqzwr3qo' /*    */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF284E75),
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
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                          color:
                                                                              Color(0xFF284E75),
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
                                                                        ),
                                                                      )
                                                                    ],
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
                                                                              Color(0xFF284E75),
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
                                      Expanded(
                                        flex: 3,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, -1.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0,
                                                    valueOrDefault<double>(
                                                      () {
                                                        if (MediaQuery.sizeOf(
                                                                    context)
                                                                .width <
                                                            kBreakpointSmall) {
                                                          return 8.0;
                                                        } else if (MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width <
                                                            kBreakpointMedium) {
                                                          return 10.0;
                                                        } else if (MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width <
                                                            kBreakpointLarge) {
                                                          return 13.0;
                                                        } else {
                                                          return 15.0;
                                                        }
                                                      }(),
                                                      0.0,
                                                    ),
                                                    10.0,
                                                    10.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Flexible(
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      3.0,
                                                                      0.0,
                                                                      3.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.buttonGrades =
                                                                  1;
                                                              _model.textColor1 =
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground;
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
                                                              _model.buttonColor1 =
                                                                  Color(
                                                                      0xFF284E75);
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
                                                              _model.courseSelected =
                                                                  -1;
                                                              _model.classAfterCourse =
                                                                  [];
                                                              _model.classAfterGrade =
                                                                  [];
                                                              safeSetState(
                                                                  () {});
                                                              _model.classAfterGrade = _model
                                                                  .classOnload
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .grade!,
                                                                      desc:
                                                                          false)
                                                                  .where((e) =>
                                                                      e.grade ==
                                                                      _model
                                                                          .buttonGrades)
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '5atgqq1x' /* 1학년 담당과목 */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
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
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model
                                                                    .buttonColor1,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor1,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              hoverColor: Color(
                                                                  0xFF284E75),
                                                              hoverBorderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFF284E75),
                                                                width: 2.0,
                                                              ),
                                                              hoverTextColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      3.0,
                                                                      0.0,
                                                                      3.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.buttonGrades =
                                                                  2;
                                                              _model.textColor1 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor2 =
                                                                  Colors.white;
                                                              _model.textColor3 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor4 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor5 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.buttonColor1 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor2 =
                                                                  Color(
                                                                      0xFF284E75);
                                                              _model.buttonColor3 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor4 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor5 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.courseSelected =
                                                                  -1;
                                                              _model.classAfterCourse =
                                                                  [];
                                                              _model.classAfterGrade =
                                                                  [];
                                                              safeSetState(
                                                                  () {});
                                                              _model.classAfterGrade = _model
                                                                  .classOnload
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .grade!,
                                                                      desc:
                                                                          false)
                                                                  .where((e) =>
                                                                      e.grade ==
                                                                      _model
                                                                          .buttonGrades)
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'lijpst23' /* 2학년 담당과목 */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
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
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model
                                                                    .buttonColor2,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor2,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              hoverColor: Color(
                                                                  0xFF284E75),
                                                              hoverBorderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFF284E75),
                                                                width: 2.0,
                                                              ),
                                                              hoverTextColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      3.0,
                                                                      0.0,
                                                                      3.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.buttonGrades =
                                                                  3;
                                                              _model.textColor1 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor2 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor3 =
                                                                  Colors.white;
                                                              _model.textColor4 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.textColor5 =
                                                                  Color(
                                                                      4280831605);
                                                              _model.buttonColor1 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor2 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor3 =
                                                                  Color(
                                                                      0xFF284E75);
                                                              _model.buttonColor4 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.buttonColor5 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.courseSelected =
                                                                  -1;
                                                              _model.classAfterCourse =
                                                                  [];
                                                              _model.classAfterGrade =
                                                                  [];
                                                              safeSetState(
                                                                  () {});
                                                              _model.classAfterGrade = _model
                                                                  .classOnload
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .grade!,
                                                                      desc:
                                                                          false)
                                                                  .where((e) =>
                                                                      e.grade ==
                                                                      _model
                                                                          .buttonGrades)
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '7ghccm3v' /* 3학년 담당과목 */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
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
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model
                                                                    .buttonColor3,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor3,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              hoverColor: Color(
                                                                  0xFF284E75),
                                                              hoverBorderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFF284E75),
                                                                width: 2.0,
                                                              ),
                                                              hoverTextColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      3.0,
                                                                      0.0,
                                                                      3.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.buttonGrades =
                                                                  4;
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
                                                                  Colors.white;
                                                              _model.textColor5 =
                                                                  Color(
                                                                      4280831605);
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
                                                                      0xFF284E75);
                                                              _model.buttonColor5 =
                                                                  Color(
                                                                      4294967295);
                                                              _model.courseSelected =
                                                                  -1;
                                                              _model.classAfterGrade =
                                                                  [];
                                                              _model.classAfterCourse =
                                                                  [];
                                                              safeSetState(
                                                                  () {});
                                                              _model.classAfterGrade = _model
                                                                  .classOnload
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .grade!,
                                                                      desc:
                                                                          false)
                                                                  .where((e) =>
                                                                      e.grade ==
                                                                      _model
                                                                          .buttonGrades)
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              'cmtegg73' /* 4학년 담당과목 */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
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
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model
                                                                    .buttonColor4,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor4,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              hoverColor: Color(
                                                                  0xFF284E75),
                                                              hoverBorderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFF284E75),
                                                                width: 2.0,
                                                              ),
                                                              hoverTextColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      3.0,
                                                                      0.0,
                                                                      3.0),
                                                          child: FFButtonWidget(
                                                            onPressed:
                                                                () async {
                                                              _model.buttonGrades =
                                                                  5;
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
                                                                  Colors.white;
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
                                                                      0xFF284E75);
                                                              _model.courseSelected =
                                                                  -1;
                                                              _model.classAfterGrade =
                                                                  [];
                                                              _model.classAfterCourse =
                                                                  [];
                                                              safeSetState(
                                                                  () {});
                                                              _model.classAfterGrade = _model
                                                                  .classOnload
                                                                  .sortedList(
                                                                      keyOf: (e) => e
                                                                          .grade!,
                                                                      desc:
                                                                          false)
                                                                  .where((e) =>
                                                                      e.grade ==
                                                                      _model
                                                                          .buttonGrades)
                                                                  .toList()
                                                                  .cast<
                                                                      ClassRow>();
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            text: FFLocalizations
                                                                    .of(context)
                                                                .getText(
                                                              '9kcpk5n4' /* 5학년 담당과목 */,
                                                            ),
                                                            options:
                                                                FFButtonOptions(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
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
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model
                                                                    .buttonColor5,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                              textStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .openSans(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                        color: valueOrDefault<
                                                                            Color>(
                                                                          _model
                                                                              .textColor5,
                                                                          Color(
                                                                              0xFF284E75),
                                                                        ),
                                                                        fontSize:
                                                                            () {
                                                                          if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointSmall) {
                                                                            return 12.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointMedium) {
                                                                            return 16.0;
                                                                          } else if (MediaQuery.sizeOf(context).width <
                                                                              kBreakpointLarge) {
                                                                            return 18.0;
                                                                          } else {
                                                                            return 22.0;
                                                                          }
                                                                        }(),
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .fontStyle,
                                                                      ),
                                                              elevation: 0.0,
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 2.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              hoverColor: Color(
                                                                  0xFF284E75),
                                                              hoverBorderSide:
                                                                  BorderSide(
                                                                color: Color(
                                                                    0xFF284E75),
                                                                width: 2.0,
                                                              ),
                                                              hoverTextColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
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
                                      Expanded(
                                        flex: 5,
                                        child: Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (_model.classAfterGrade
                                                          .firstOrNull !=
                                                      null)
                                                    Expanded(
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          40.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: PageView(
                                                                controller: _model
                                                                        .pageViewController2 ??=
                                                                    PageController(
                                                                        initialPage:
                                                                            0),
                                                                scrollDirection:
                                                                    Axis.horizontal,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.19,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.55,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      minHeight:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.55,
                                                                      maxHeight:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.55,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 500.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 800.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 450.0;
                                                                            } else {
                                                                              return 550.0;
                                                                            }
                                                                          }(),
                                                                          child:
                                                                              Divider(
                                                                            thickness:
                                                                                5.0,
                                                                            color:
                                                                                Color(0xFF284E75),
                                                                          ),
                                                                        ),
                                                                        Flexible(
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.9,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.13,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  valueOrDefault<String>(
                                                                                    _model.classAfterGrade.firstOrNull?.course,
                                                                                    '전공 과목',
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                  maxLines: 2,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF284E75),
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 16.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 16.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 18.0;
                                                                                          } else {
                                                                                            return 22.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: MouseRegion(
                                                                                    opaque: false,
                                                                                    cursor: MouseCursor.defer,
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.0, 0.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                        child: InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          focusColor: Colors.transparent,
                                                                                          hoverColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () async {
                                                                                            _model.courseSelected = 0;
                                                                                            _model.classAfterCourse = [];
                                                                                            safeSetState(() {});
                                                                                            _model.addToClassAfterCourse(_model.classAfterGrade.firstOrNull!);
                                                                                            safeSetState(() {});
                                                                                            _model.progressoutput1A = await SubjectportpolioTable().queryRows(
                                                                                              queryFn: (q) => q
                                                                                                  .eqOrNull(
                                                                                                    'professor_name',
                                                                                                    _model.profeesorName,
                                                                                                  )
                                                                                                  .eqOrNull(
                                                                                                    'class',
                                                                                                    _model.classAfterCourse.firstOrNull?.id,
                                                                                                  ),
                                                                                            );
                                                                                            _model.progressSubject = _model.progressoutput1A?.length;
                                                                                            safeSetState(() {});

                                                                                            safeSetState(() {});
                                                                                          },
                                                                                          child: AnimatedDefaultTextStyle(
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: valueOrDefault<Color>(
                                                                                                    () {
                                                                                                      if (_model.mouseRegionHovered6) {
                                                                                                        return Color(0xFFFF0000);
                                                                                                      } else if (_model.courseSelected == 0) {
                                                                                                        return Color(0xFFFF0000);
                                                                                                      } else {
                                                                                                        return FlutterFlowTheme.of(context).secondaryText;
                                                                                                      }
                                                                                                    }(),
                                                                                                    FlutterFlowTheme.of(context).secondaryText,
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
                                                                                                  decoration: TextDecoration.underline,
                                                                                                ),
                                                                                            duration: Duration(milliseconds: 200),
                                                                                            curve: Curves.easeIn,
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                '7fwzxebh' /* 진행사항 조회하기 */,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onEnter: ((event) async {
                                                                                      safeSetState(() => _model.mouseRegionHovered6 = true);
                                                                                    }),
                                                                                    onExit: ((event) async {
                                                                                      safeSetState(() => _model.mouseRegionHovered6 = false);
                                                                                    }),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if (_model.classAfterGrade.where((e) => e.sectionBool == true).toList().firstOrNull !=
                                                                            null)
                                                                          ListView(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                child: Container(
                                                                                  width: 304.0,
                                                                                  height: 100.0,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Color(0xFF284E75),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(
                                                                                              _model.classAfterGrade.firstOrNull?.section,
                                                                                              '분반 정보',
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 16.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 16.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                child: RichText(
                                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                                  text: TextSpan(
                                                                                                    children: [
                                                                                                      TextSpan(
                                                                                                        text: valueOrDefault<String>(
                                                                                                          _model.classAfterGrade.firstOrNull?.professor,
                                                                                                          '교수님1',
                                                                                                        ),
                                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                              font: GoogleFonts.openSans(
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                              fontSize: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 8.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 12.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 14.0;
                                                                                                                } else {
                                                                                                                  return 18.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                      ),
                                                                                                      TextSpan(
                                                                                                        text: FFLocalizations.of(context).getText(
                                                                                                          'v0cdf0bc' /*  교수님 */,
                                                                                                        ),
                                                                                                        style: TextStyle(
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                          fontWeight: FontWeight.w500,
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 12.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 14.0;
                                                                                                            } else {
                                                                                                              return 18.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                        ),
                                                                                                      )
                                                                                                    ],
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                                          fontWeight: FontWeight.w500,
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
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(100.0, 15.0, 0.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  context.pushNamed(HomeWidget.routeName);
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'fue0bulz' /* 바로가기 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                                        fontWeight: FontWeight.normal,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                                                                              child: Icon(
                                                                                                Icons.arrow_right_outlined,
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                size: 24.0,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
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
                                                                  Visibility(
                                                                    visible: _model
                                                                            .classAfterGrade
                                                                            .elementAtOrNull(1) !=
                                                                        null,
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.19,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.55,
                                                                      constraints:
                                                                          BoxConstraints(
                                                                        minHeight:
                                                                            MediaQuery.sizeOf(context).height *
                                                                                0.55,
                                                                        maxHeight:
                                                                            MediaQuery.sizeOf(context).height *
                                                                                0.55,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                () {
                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                return 500.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                return 800.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                return 450.0;
                                                                              } else {
                                                                                return 550.0;
                                                                              }
                                                                            }(),
                                                                            child:
                                                                                Divider(
                                                                              thickness: 5.0,
                                                                              color: Color(0xFF284E75),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.9,
                                                                              height: MediaQuery.sizeOf(context).height * 0.13,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      _model.classAfterGrade.elementAtOrNull(1)?.course,
                                                                                      '전공 과목',
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFF284E75),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 16.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 16.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 18.0;
                                                                                            } else {
                                                                                              return 22.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: MouseRegion(
                                                                                      opaque: false,
                                                                                      cursor: MouseCursor.defer,
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              _model.courseSelected = 1;
                                                                                              _model.classAfterCourse = [];
                                                                                              safeSetState(() {});
                                                                                              _model.addToClassAfterCourse(_model.classAfterGrade.elementAtOrNull(1)!);
                                                                                              safeSetState(() {});
                                                                                              _model.progressoutput2A = await SubjectportpolioTable().queryRows(
                                                                                                queryFn: (q) => q
                                                                                                    .eqOrNull(
                                                                                                      'professor_name',
                                                                                                      _model.profeesorName,
                                                                                                    )
                                                                                                    .eqOrNull(
                                                                                                      'class',
                                                                                                      _model.classAfterCourse.firstOrNull?.id,
                                                                                                    ),
                                                                                              );
                                                                                              _model.progressSubject = _model.progressoutput2A?.length;
                                                                                              safeSetState(() {});

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            child: AnimatedDefaultTextStyle(
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: valueOrDefault<Color>(
                                                                                                      () {
                                                                                                        if (_model.mouseRegionHovered7) {
                                                                                                          return Color(0xFFFF0000);
                                                                                                        } else if (_model.courseSelected == 0) {
                                                                                                          return Color(0xFFFF0000);
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).secondaryText;
                                                                                                        }
                                                                                                      }(),
                                                                                                      FlutterFlowTheme.of(context).secondaryText,
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
                                                                                                    decoration: TextDecoration.underline,
                                                                                                  ),
                                                                                              duration: Duration(milliseconds: 200),
                                                                                              curve: Curves.easeIn,
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'ynug9oh7' /* 진행사항 조회하기 */,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      onEnter: ((event) async {
                                                                                        safeSetState(() => _model.mouseRegionHovered7 = true);
                                                                                      }),
                                                                                      onExit: ((event) async {
                                                                                        safeSetState(() => _model.mouseRegionHovered7 = false);
                                                                                      }),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (_model.classAfterGrade.elementAtOrNull(1)?.sectionBool !=
                                                                              null)
                                                                            ListView(
                                                                              padding: EdgeInsets.zero,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                  child: Container(
                                                                                    width: 304.0,
                                                                                    height: 100.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFF284E75),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                _model.classAfterGrade.firstOrNull?.section,
                                                                                                '분반 정보',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 16.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 16.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 18.0;
                                                                                                      } else {
                                                                                                        return 22.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                  child: RichText(
                                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                                    text: TextSpan(
                                                                                                      children: [
                                                                                                        TextSpan(
                                                                                                          text: valueOrDefault<String>(
                                                                                                            _model.classAfterGrade.firstOrNull?.professor,
                                                                                                            '교수님1',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 8.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 12.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 14.0;
                                                                                                                  } else {
                                                                                                                    return 18.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                        TextSpan(
                                                                                                          text: FFLocalizations.of(context).getText(
                                                                                                            'ylxqf39m' /*  교수님 */,
                                                                                                          ),
                                                                                                          style: TextStyle(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 12.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 14.0;
                                                                                                              } else {
                                                                                                                return 18.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                                            fontWeight: FontWeight.w500,
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
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(100.0, 15.0, 0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    context.pushNamed(HomeWidget.routeName);
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'd6nkosal' /* 바로가기 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                                                                                child: Icon(
                                                                                                  Icons.arrow_right_outlined,
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
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
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.19,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.55,
                                                                    constraints:
                                                                        BoxConstraints(
                                                                      minHeight:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.55,
                                                                      maxHeight:
                                                                          MediaQuery.sizeOf(context).height *
                                                                              0.55,
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Visibility(
                                                                      visible: _model
                                                                              .classAfterGrade
                                                                              .elementAtOrNull(2) !=
                                                                          null,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                () {
                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                return 500.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                return 800.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                return 450.0;
                                                                              } else {
                                                                                return 550.0;
                                                                              }
                                                                            }(),
                                                                            child:
                                                                                Divider(
                                                                              thickness: 5.0,
                                                                              color: Color(0xFF284E75),
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.9,
                                                                              height: MediaQuery.sizeOf(context).height * 0.13,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Text(
                                                                                    valueOrDefault<String>(
                                                                                      _model.classAfterGrade.elementAtOrNull(2)?.course,
                                                                                      '전공 과목',
                                                                                    ),
                                                                                    textAlign: TextAlign.center,
                                                                                    maxLines: 2,
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFF284E75),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 16.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 16.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 18.0;
                                                                                            } else {
                                                                                              return 22.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: MouseRegion(
                                                                                      opaque: false,
                                                                                      cursor: MouseCursor.defer,
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(0.0, 0.0),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              _model.courseSelected = 2;
                                                                                              _model.classAfterCourse = [];
                                                                                              safeSetState(() {});
                                                                                              _model.addToClassAfterCourse(_model.classAfterGrade.elementAtOrNull(2)!);
                                                                                              safeSetState(() {});
                                                                                              _model.progressoutput3A = await SubjectportpolioTable().queryRows(
                                                                                                queryFn: (q) => q
                                                                                                    .eqOrNull(
                                                                                                      'professor_name',
                                                                                                      _model.profeesorName,
                                                                                                    )
                                                                                                    .eqOrNull(
                                                                                                      'class',
                                                                                                      _model.classAfterCourse.firstOrNull?.id,
                                                                                                    ),
                                                                                              );
                                                                                              _model.progressSubject = _model.progressoutput3A?.length;
                                                                                              safeSetState(() {});

                                                                                              safeSetState(() {});
                                                                                            },
                                                                                            child: AnimatedDefaultTextStyle(
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: valueOrDefault<Color>(
                                                                                                      () {
                                                                                                        if (_model.mouseRegionHovered8) {
                                                                                                          return Color(0xFFFF0000);
                                                                                                        } else if (_model.courseSelected == 0) {
                                                                                                          return Color(0xFFFF0000);
                                                                                                        } else {
                                                                                                          return FlutterFlowTheme.of(context).secondaryText;
                                                                                                        }
                                                                                                      }(),
                                                                                                      FlutterFlowTheme.of(context).secondaryText,
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
                                                                                                    decoration: TextDecoration.underline,
                                                                                                  ),
                                                                                              duration: Duration(milliseconds: 200),
                                                                                              curve: Curves.easeIn,
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'k6biophl' /* 진행사항 조회하기 */,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      onEnter: ((event) async {
                                                                                        safeSetState(() => _model.mouseRegionHovered8 = true);
                                                                                      }),
                                                                                      onExit: ((event) async {
                                                                                        safeSetState(() => _model.mouseRegionHovered8 = false);
                                                                                      }),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          if (_model.classAfterGrade.elementAtOrNull(2)?.sectionBool !=
                                                                              null)
                                                                            ListView(
                                                                              padding: EdgeInsets.zero,
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.vertical,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 2.0, 0.0, 2.0),
                                                                                  child: Container(
                                                                                    width: 304.0,
                                                                                    height: 100.0,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFF284E75),
                                                                                    ),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                _model.classAfterGrade.firstOrNull?.section,
                                                                                                '분반 정보',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 16.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 16.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 18.0;
                                                                                                      } else {
                                                                                                        return 22.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                  child: RichText(
                                                                                                    textScaler: MediaQuery.of(context).textScaler,
                                                                                                    text: TextSpan(
                                                                                                      children: [
                                                                                                        TextSpan(
                                                                                                          text: valueOrDefault<String>(
                                                                                                            _model.classAfterGrade.firstOrNull?.professor,
                                                                                                            '교수님1',
                                                                                                          ),
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                font: GoogleFonts.openSans(
                                                                                                                  fontWeight: FontWeight.w500,
                                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                                ),
                                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                                fontSize: () {
                                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                    return 8.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                    return 12.0;
                                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                    return 14.0;
                                                                                                                  } else {
                                                                                                                    return 18.0;
                                                                                                                  }
                                                                                                                }(),
                                                                                                                letterSpacing: 0.0,
                                                                                                                fontWeight: FontWeight.w500,
                                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                              ),
                                                                                                        ),
                                                                                                        TextSpan(
                                                                                                          text: FFLocalizations.of(context).getText(
                                                                                                            'qxq08yfj' /*  교수님 */,
                                                                                                          ),
                                                                                                          style: TextStyle(
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                            fontWeight: FontWeight.w500,
                                                                                                            fontSize: () {
                                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                return 8.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                return 12.0;
                                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                return 14.0;
                                                                                                              } else {
                                                                                                                return 18.0;
                                                                                                              }
                                                                                                            }(),
                                                                                                          ),
                                                                                                        )
                                                                                                      ],
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            font: GoogleFonts.openSans(
                                                                                                              fontWeight: FontWeight.w500,
                                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                            ),
                                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                                            fontWeight: FontWeight.w500,
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
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(100.0, 15.0, 0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    context.pushNamed(HomeWidget.routeName);
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '6ff6h8qh' /* 바로가기 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FontWeight.normal,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
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
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(1.0, 0.0),
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                                                                                                child: Icon(
                                                                                                  Icons.arrow_right_outlined,
                                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
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
                                                                ],
                                                              ),
                                                            ),
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0,
                                                                      -1.0),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            16.0),
                                                                child: smooth_page_indicator
                                                                    .SmoothPageIndicator(
                                                                  controller: _model
                                                                          .pageViewController2 ??=
                                                                      PageController(
                                                                          initialPage:
                                                                              0),
                                                                  count: 3,
                                                                  axisDirection:
                                                                      Axis.horizontal,
                                                                  onDotClicked:
                                                                      (i) async {
                                                                    await _model
                                                                        .pageViewController2!
                                                                        .animateToPage(
                                                                      i,
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              500),
                                                                      curve: Curves
                                                                          .ease,
                                                                    );
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  effect: smooth_page_indicator
                                                                      .SlideEffect(
                                                                    spacing:
                                                                        8.0,
                                                                    radius: 8.0,
                                                                    dotWidth:
                                                                        8.0,
                                                                    dotHeight:
                                                                        8.0,
                                                                    dotColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent1,
                                                                    activeDotColor:
                                                                        Color(
                                                                            0xFF284E75),
                                                                    paintStyle:
                                                                        PaintingStyle
                                                                            .fill,
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
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (((_model.classAfterCourse.firstOrNull !=
                                        null) &&
                                    (_model.courseSelected! >= 0)) &&
                                responsiveVisibility(
                                  context: context,
                                  tabletLandscape: false,
                                  desktop: false,
                                ))
                              SafeArea(
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (responsiveVisibility(
                                        context: context,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Flexible(
                                          flex: 1,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 5.0, 5.0, 0.0),
                                              child: SafeArea(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      _model
                                                                          .classAfterCourse
                                                                          .firstOrNull
                                                                          ?.course,
                                                                      '전공 과목',
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
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              Color(0xFF284E75),
                                                                          fontSize:
                                                                              () {
                                                                            if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointSmall) {
                                                                              return 16.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointMedium) {
                                                                              return 16.0;
                                                                            } else if (MediaQuery.sizeOf(context).width <
                                                                                kBreakpointLarge) {
                                                                              return 18.0;
                                                                            } else {
                                                                              return 22.0;
                                                                            }
                                                                          }(),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          5.0),
                                                              child: Text(
                                                                FFLocalizations.of(
                                                                        context)
                                                                    .getText(
                                                                  'ahlgn39n' /* 총 진행사항 */,
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
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
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      fontSize:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointSmall) {
                                                                          return 20.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointMedium) {
                                                                          return 20.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointLarge) {
                                                                          return 22.0;
                                                                        } else {
                                                                          return 25.0;
                                                                        }
                                                                      }(),
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
                                                          ),
                                                          Flexible(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          3.0,
                                                                          5.0,
                                                                          0.0),
                                                              child:
                                                                  LinearPercentIndicator(
                                                                percent:
                                                                    valueOrDefault<
                                                                        double>(
                                                                  math.min(
                                                                      1.0,
                                                                      math.max(
                                                                          0.0,
                                                                          (((_model.progressSubject!)) /
                                                                              (8 * 15)))),
                                                                  0.0,
                                                                ),
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.9,
                                                                lineHeight:
                                                                    25.0,
                                                                animation: true,
                                                                animateFromLastPercent:
                                                                    true,
                                                                progressColor:
                                                                    Color(
                                                                        0xFF284E75),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate,
                                                                barRadius: Radius
                                                                    .circular(
                                                                        25.0),
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.02,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            3.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      FFLocalizations.of(
                                                                              context)
                                                                          .getText(
                                                                        'erxr3v80' /* 0% */,
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                () {
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
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '32fjkx4u' /* 100% */,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
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
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                            ),
                                          ),
                                        ),
                                      if (responsiveVisibility(
                                        context: context,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Expanded(
                                          flex: 3,
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Flexible(
                                                            flex: 1,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Text(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        _model
                                                                            .classAfterGrade
                                                                            .firstOrNull
                                                                            ?.course,
                                                                        '전공 과목',
                                                                      ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.openSans(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                Color(0xFF284E75),
                                                                            fontSize:
                                                                                () {
                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                return 16.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                return 16.0;
                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                return 18.0;
                                                                              } else {
                                                                                return 22.0;
                                                                              }
                                                                            }(),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            _model.classAfterGrade.firstOrNull?.professor,
                                                                            '교수님',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: Color(0xFF284E75),
                                                                                fontSize: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 12.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 16.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 18.0;
                                                                                  } else {
                                                                                    return 22.0;
                                                                                  }
                                                                                }(),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              5.0,
                                                                              0.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                _model.classAfterCourse.firstOrNull?.professor,
                                                                                '교수님 이름',
                                                                              );
                                                                              FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                _model.classAfterCourse.firstOrNull?.course,
                                                                                '과목 이름',
                                                                              );
                                                                              FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                              safeSetState(() {});

                                                                              context.pushNamed(HomeWidget.routeName);
                                                                            },
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'f0mfpsvp' /* 바로가기  ▶ */,
                                                                            ),
                                                                            options:
                                                                                FFButtonOptions(
                                                                              height: 35.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 5.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: Color(0xFF284E75),
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: Colors.white,
                                                                                    fontSize: () {
                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                        return 12.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                        return 12.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                        return 18.0;
                                                                                      } else {
                                                                                        return 22.0;
                                                                                      }
                                                                                    }(),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderRadius: BorderRadius.circular(8.0),
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
                                                            flex: 5,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '88u18zsu' /* 교수님 업로드현황  */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.bold,
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
                                                                                  return 22.0;
                                                                                }
                                                                              }(),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            EdgeInsets.all(6.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.23,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(5.0),
                                                                            border:
                                                                                Border.all(
                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(10.0, 2.0, 0.0, 0.0),
                                                                                    child: Text(
                                                                                      FFLocalizations.of(context).getText(
                                                                                        'j7jgg16o' /* 포트폴리오 크리틱 */,
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
                                                                                                return 22.0;
                                                                                              }
                                                                                            }(),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(1.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(30.0, 2.0, 10.0, 0.0),
                                                                                      child: AutoSizeText(
                                                                                        FFLocalizations.of(context).getText(
                                                                                          'snq6aqxp' /* 바로가기  ▶ */,
                                                                                        ),
                                                                                        textAlign: TextAlign.end,
                                                                                        minFontSize: 12.0,
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              font: GoogleFonts.openSans(
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              fontSize: () {
                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                  return 12.0;
                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                  return 16.0;
                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                  return 18.0;
                                                                                                } else {
                                                                                                  return 22.0;
                                                                                                }
                                                                                              }(),
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Expanded(
                                                                                flex: 10,
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  child: custom_widgets.ChartWidget(
                                                                                    width: double.infinity,
                                                                                    height: double.infinity,
                                                                                    chartData: _model.chartDataParam,
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
                                                          Flexible(
                                                            flex: 4,
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
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            0.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            0.0),
                                                                  ),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '37q5frr1' /* 학부생 등록여부 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'fhom8cl5' /* -- */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: 12.0,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'rbwat314' /* 파일이 없습니다. */,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'qk1g2kks' /* 수업계획서 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.professor,
                                                                                                    '교수님 이름',
                                                                                                  );
                                                                                                  FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.course,
                                                                                                    '과목 이름',
                                                                                                  );
                                                                                                  FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                  safeSetState(() {});

                                                                                                  context.pushNamed(ProfCoursePlanWidget.routeName);
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'zeiudwrq' /*  ▶ */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'yqgln2k1' /* 파일이 없습니다. */,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '8x4e2vhu' /* 강의 자료실 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.professor,
                                                                                                    '교수님 이름',
                                                                                                  );
                                                                                                  FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.course,
                                                                                                    '과목 이름',
                                                                                                  );
                                                                                                  FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                  safeSetState(() {});

                                                                                                  context.pushNamed(ProfLectureMaterialsWidget.routeName);
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'z9wntb7a' /*  ▶ */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '274gaj3c' /* 파일이 없습니다. */,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'h50mh691' /* 학생 작품 평가표 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.professor,
                                                                                                    '교수님 이름',
                                                                                                  );
                                                                                                  FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.course,
                                                                                                    '과목 이름',
                                                                                                  );
                                                                                                  FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                  safeSetState(() {});

                                                                                                  context.pushNamed(StudentWorkEvalFormWidget.routeName);
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'a4ywbbw0' /*  ▶ */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'bwhfga2u' /* 파일이 없습니다. */,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'q46iykah' /* 출석부 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.professor,
                                                                                                    '교수님 이름',
                                                                                                  );
                                                                                                  FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.course,
                                                                                                    '과목 이름',
                                                                                                  );
                                                                                                  FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                  safeSetState(() {});

                                                                                                  context.pushNamed(ProfAttendanceSheetWidget.routeName);
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'p3guzu78' /*  ▶ */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'wgwr13df' /* 파일이 없습니다. */,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '9hiepb6a' /* 성적기록표 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 18.0;
                                                                                                    } else {
                                                                                                      return 22.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(1.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(45.0, 1.0, 3.0, 0.0),
                                                                                              child: InkWell(
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  FFAppState().professorNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.professor,
                                                                                                    '교수님 이름',
                                                                                                  );
                                                                                                  FFAppState().courseNameSelected = valueOrDefault<String>(
                                                                                                    _model.classAfterCourse.firstOrNull?.course,
                                                                                                    '과목 이름',
                                                                                                  );
                                                                                                  FFAppState().classSelectedID = _model.classAfterCourse.firstOrNull!.id;
                                                                                                  safeSetState(() {});

                                                                                                  context.pushNamed(ProfGradeSheetWidget.routeName);
                                                                                                },
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'cwkhxzem' /*  ▶ */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: 12.0,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    if (MediaQuery.sizeOf(context).width >= 1440.0)
                                                                                      Flexible(
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 5.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'pxz9eule' /* 파일이 없습니다. */,
                                                                                            ),
                                                                                            textAlign: TextAlign.start,
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 10.0,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
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
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              -1.0,
                                                                              0.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'el90x0ex' /* 학생 업로드현황  */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.bold,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 18.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 5.0),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'jnxa9iyq' /* 과목 포트폴리오 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 18.0;
                                                                                                      } else {
                                                                                                        return 22.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 2.0, 0.0),
                                                                                        child: LinearPercentIndicator(
                                                                                          percent: valueOrDefault<double>(
                                                                                            math.min(1.0, math.max(0.0, (((_model.progressSubject!)) / (8 * 15)))),
                                                                                            0.0,
                                                                                          ),
                                                                                          width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                          lineHeight: 20.0,
                                                                                          animation: true,
                                                                                          animateFromLastPercent: true,
                                                                                          progressColor: Color(0xFF284E75),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                          padding: EdgeInsets.zero,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: MouseRegion(
                                                                                          opaque: false,
                                                                                          cursor: MouseCursor.defer
                                                                                          child: Visibility(
                                                                                            visible: false,
                                                                                            child: Builder(
                                                                                              builder: (context) => Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    await showDialog(
                                                                                                      context: context,
                                                                                                      builder: (dialogContext) {
                                                                                                        return Dialog(
                                                                                                          elevation: 0,
                                                                                                          insetPadding: EdgeInsets.zero,
                                                                                                          backgroundColor: Colors.transparent,
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                          child: WebViewAware(
                                                                                                            child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                              },
                                                                                                              child: SubmitSearchedWidget(),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    );
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'pz266oed' /* 미제출 조회 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: valueOrDefault<Color>(
                                                                                                            _model.mouseRegionHovered9 ? Color(0xFFFF0000) : FlutterFlowTheme.of(context).secondaryText,
                                                                                                            FlutterFlowTheme.of(context).secondaryText,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 12.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 12.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 18.0;
                                                                                                            } else {
                                                                                                              return 22.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          onEnter: ((event) async {
                                                                                            safeSetState(() => _model.mouseRegionHovered9 = true);
                                                                                          }),
                                                                                          onExit: ((event) async {
                                                                                            safeSetState(() => _model.mouseRegionHovered9 = false);
                                                                                          }),
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
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 5.0, 5.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: BorderRadius.circular(5.0),
                                                                                  border: Border.all(
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                  ),
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 5.0, 5.0),
                                                                                            child: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'wapo7nx0' /* 1차-2차 성과물 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 18.0;
                                                                                                      } else {
                                                                                                        return 22.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 2.0, 0.0),
                                                                                      child: LinearPercentIndicator(
                                                                                        percent: valueOrDefault<double>(
                                                                                          math.min(1.0, math.max(0.0, (((_model.progressSubject!)) / (8 * 15)))),
                                                                                          0.0,
                                                                                        ),
                                                                                        width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                        lineHeight: 20.0,
                                                                                        animation: true,
                                                                                        animateFromLastPercent: true,
                                                                                        progressColor: Color(0xFF284E75),
                                                                                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                                                        padding: EdgeInsets.zero,
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: MouseRegion(
                                                                                          opaque: false,
                                                                                          cursor: MouseCursor.defer,
                                                                                          child: Visibility(
                                                                                            visible: false,
                                                                                            child: Builder(
                                                                                              builder: (context) => Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 0.0),
                                                                                                child: InkWell(
                                                                                                  splashColor: Colors.transparent,
                                                                                                  focusColor: Colors.transparent,
                                                                                                  hoverColor: Colors.transparent,
                                                                                                  highlightColor: Colors.transparent,
                                                                                                  onTap: () async {
                                                                                                    await showDialog(
                                                                                                      context: context,
                                                                                                      builder: (dialogContext) {
                                                                                                        return Dialog(
                                                                                                          elevation: 0,
                                                                                                          insetPadding: EdgeInsets.zero,
                                                                                                          backgroundColor: Colors.transparent,
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                                          child: WebViewAware(
                                                                                                            child: GestureDetector(
                                                                                                              onTap: () {
                                                                                                                FocusScope.of(dialogContext).unfocus();
                                                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                                                              },
                                                                                                              child: SubmitSearchedWidget(),
                                                                                                            ),
                                                                                                          ),
                                                                                                        );
                                                                                                      },
                                                                                                    );
                                                                                                  },
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '5jbooc6h' /* 미제출 조회 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          color: valueOrDefault<Color>(
                                                                                                            _model.mouseRegionHovered10 ? Color(0xFFFF0000) : FlutterFlowTheme.of(context).secondaryText,
                                                                                                            FlutterFlowTheme.of(context).secondaryText,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 12.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 12.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 18.0;
                                                                                                            } else {
                                                                                                              return 22.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          onEnter: ((event) async {
                                                                                            safeSetState(() => _model.mouseRegionHovered10 = true);
                                                                                          }),
                                                                                          onExit: ((event) async {
                                                                                            safeSetState(() => _model.mouseRegionHovered10 = false);
                                                                                          }),
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
                        if (_model.courseSelected != -1)
                          Align(
                            alignment: AlignmentDirectional(1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 15.0, 15.0),
                              child: RichText(
                                textScaler: MediaQuery.of(context).textScaler,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: valueOrDefault<String>(
                                        _model.classAfterGrade.firstOrNull
                                            ?.professor,
                                        '교수님',
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: () {
                                              if (MediaQuery.sizeOf(context)
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
                                                return 14.0;
                                              } else {
                                                return 18.0;
                                              }
                                            }(),
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    TextSpan(
                                      text: FFLocalizations.of(context).getText(
                                        'ao46vj9q' /*  교수님 */,
                                      ),
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontWeight: FontWeight.w500,
                                        fontSize: () {
                                          if (MediaQuery.sizeOf(context).width <
                                              kBreakpointSmall) {
                                            return 8.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width <
                                              kBreakpointMedium) {
                                            return 12.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width <
                                              kBreakpointLarge) {
                                            return 14.0;
                                          } else {
                                            return 18.0;
                                          }
                                        }(),
                                      ),
                                    )
                                  ],
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        fontSize: () {
                                          if (MediaQuery.sizeOf(context).width <
                                              kBreakpointSmall) {
                                            return 12.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width <
                                              kBreakpointMedium) {
                                            return 12.0;
                                          } else if (MediaQuery.sizeOf(context)
                                                  .width <
                                              kBreakpointLarge) {
                                            return 14.0;
                                          } else {
                                            return 18.0;
                                          }
                                        }(),
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        if (_model.channelTalk == true)
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
                        if (MediaQuery.sizeOf(context).width >= 850.0
                            ? (_model.courseSelected == -1)
                            : (_model.buttonGrades == -1))
                          Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  valueOrDefault<double>(
                                    () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return 0.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return 0.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return 40.0;
                                      } else {
                                        return 40.0;
                                      }
                                    }(),
                                    0.0,
                                  ),
                                  0.0,
                                  0.0,
                                  0.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'jpwhodch' /* 과목 진행 상황을 조회 할 수 있습니다. */,
                                ),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: () {
                                        if (MediaQuery.sizeOf(context).width <
                                            kBreakpointSmall) {
                                          return 16.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointMedium) {
                                          return 16.0;
                                        } else if (MediaQuery.sizeOf(context)
                                                .width <
                                            kBreakpointLarge) {
                                          return 18.0;
                                        } else {
                                          return 22.0;
                                        }
                                      }(),
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
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
        );
      },
    );
  }
}
