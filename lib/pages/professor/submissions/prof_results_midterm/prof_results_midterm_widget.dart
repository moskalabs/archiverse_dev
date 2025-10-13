import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/components/grid_view_midterm/grid_view_midterm_widget.dart';
import '/flutter_flow/flutter_flow_pdf_viewer.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'prof_results_midterm_model.dart';
export 'prof_results_midterm_model.dart';

class ProfResultsMidtermWidget extends StatefulWidget {
  const ProfResultsMidtermWidget({super.key});

  static String routeName = 'Prof_ResultsMidterm';
  static String routePath = '/Results_Midterm';

  @override
  State<ProfResultsMidtermWidget> createState() =>
      _ProfResultsMidtermWidgetState();
}

class _ProfResultsMidtermWidgetState extends State<ProfResultsMidtermWidget> {
  late ProfResultsMidtermModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfResultsMidtermModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.midtermonload = await MidtermResultsTable().queryRows(
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
      _model.midResults =
          _model.midtermonload!.toList().cast<MidtermResultsRow>();
      _model.midtermHigh = _model.midtermonload!
          .where((e) => e.portpolioresult == '상')
          .toList()
          .toList()
          .cast<MidtermResultsRow>();
      _model.midtermMiddle = _model.midtermonload!
          .where((e) => e.portpolioresult == '중')
          .toList()
          .toList()
          .cast<MidtermResultsRow>();
      _model.midtermLow = _model.midtermonload!
          .where((e) => e.portpolioresult == '하')
          .toList()
          .toList()
          .cast<MidtermResultsRow>();
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEEF1F6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (responsiveVisibility(
                    context: context,
                    phone: false,
                    tablet: false,
                  ))
                    wrapWithModel(
                      model: _model.naviSidebarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: NaviSidebarWidget(
                        activePageName: 'MidtermResults',
                        pageIsInSubMenu: false,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        wrapWithModel(
                          model: _model.headerModel,
                          updateCallback: () => safeSetState(() {}),
                          updateOnChange: true,
                          child: HeaderWidget(),
                        ),
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
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                ))
                                  Flexible(
                                    flex: 3,
                                    child: wrapWithModel(
                                      model: _model.leftWidgetModel,
                                      updateCallback: () => safeSetState(() {}),
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
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 5.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.93,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        width: double.infinity,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.93,
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
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.134,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.format_list_bulleted,
                                                                                color: Color(0xFF284E75),
                                                                                size: 36.0,
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'm7hs4xfu' /* 중간 결과물 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF284E75),
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 10.0;
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
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Stack(
                                                                children: [
                                                                  SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        if (valueOrDefault<bool>(
                                                                              _model.midResults.firstOrNull != null,
                                                                              true,
                                                                            ) ==
                                                                            true)
                                                                          Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.76,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(0.0, -1.0),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final midgridview = _model.midResults.map((e) => e).toList();

                                                                                  return GridView.builder(
                                                                                    padding: EdgeInsets.zero,
                                                                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                      crossAxisCount: 3,
                                                                                      crossAxisSpacing: 1.0,
                                                                                      mainAxisSpacing: 1.0,
                                                                                      childAspectRatio: 1.2,
                                                                                    ),
                                                                                    shrinkWrap: true,
                                                                                    scrollDirection: Axis.vertical,
                                                                                    itemCount: midgridview.length,
                                                                                    itemBuilder: (context, midgridviewIndex) {
                                                                                      final midgridviewItem = midgridview[midgridviewIndex];
                                                                                      return Align(
                                                                                        alignment: AlignmentDirectional(0.0, -1.0),
                                                                                        child: GridViewMidtermWidget(
                                                                                          key: Key('Keytrm_${midgridviewIndex}_of_${midgridview.length}'),
                                                                                          selectedMidId: _model.selectedIndex!,
                                                                                          midList: midgridviewItem,
                                                                                          isSelectedAction: (midId) async {
                                                                                            _model.selectedIndex = midId;
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
                                                                  ),
                                                                  if (valueOrDefault<
                                                                          bool>(
                                                                        _model.midResults.firstOrNull ==
                                                                            null,
                                                                        false,
                                                                      ) ==
                                                                      true)
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.75,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              100.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Material(
                                                                            color:
                                                                                Colors.transparent,
                                                                            elevation:
                                                                                1.0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                            ),
                                                                            child:
                                                                                Container(
                                                                              width: 500.0,
                                                                              height: 300.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                borderRadius: BorderRadius.circular(16.0),
                                                                                shape: BoxShape.rectangle,
                                                                                border: Border.all(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  width: 3.0,
                                                                                ),
                                                                              ),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(0.0, 0.0),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: Icon(
                                                                                                Icons.note_add_sharp,
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                size: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 30.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 35.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 45.0;
                                                                                                  } else {
                                                                                                    return 55.0;
                                                                                                  }
                                                                                                }(),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                    child: Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Flexible(
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  'n83ht5dk' /* 아직 제출된 파일이 없습니다. */,
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w500,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 8.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                          return 10.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                          return 12.0;
                                                                                                        } else {
                                                                                                          return 16.0;
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
                                                                                  Expanded(
                                                                                    child: Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        children: [
                                                                                          Flexible(
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                                              child: FFButtonWidget(
                                                                                                onPressed: () async {
                                                                                                  if (_model.refresh == true) {
                                                                                                    _model.refresh = false;
                                                                                                    safeSetState(() {});
                                                                                                  } else {
                                                                                                    _model.refresh = true;
                                                                                                    safeSetState(() {});
                                                                                                  }
                                                                                                },
                                                                                                text: FFLocalizations.of(context).getText(
                                                                                                  'sg16goxr' /* 새로고침 */,
                                                                                                ),
                                                                                                options: FFButtonOptions(
                                                                                                  width: 250.0,
                                                                                                  height: 45.0,
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                  color: Color(0xFFA6B6C3),
                                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FontWeight.w600,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                        ),
                                                                                                        color: Colors.white,
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 10.0;
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
                                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                      ),
                                                                                                  elevation: 0.0,
                                                                                                  borderRadius: BorderRadius.circular(8.0),
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
                                                                    ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 700.0,
                                                      child: VerticalDivider(
                                                        thickness: 2.0,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
                                                    if (valueOrDefault<bool>(
                                                          _model.midResults
                                                                  .firstOrNull !=
                                                              null,
                                                          false,
                                                        ) ==
                                                        true)
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          width:
                                                              double.infinity,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.93,
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
                                                          child: Stack(
                                                            children: [
                                                              if (valueOrDefault<
                                                                  bool>(
                                                                (_model.midResults
                                                                            .firstOrNull ==
                                                                        null) &&
                                                                    valueOrDefault<
                                                                        bool>(
                                                                      _model.selectedIndex ==
                                                                          -1,
                                                                      false,
                                                                    ),
                                                                true,
                                                              ))
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'arha1910' /* 미리 보기 */,
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
                                                                              FlutterFlowTheme.of(context).secondaryText,
                                                                          fontSize:
                                                                              20.0,
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
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  if (valueOrDefault<
                                                                      bool>(
                                                                    _model.selectedIndex! >
                                                                        0,
                                                                    false,
                                                                  ))
                                                                    FlutterFlowPdfViewer(
                                                                      networkPath:
                                                                          valueOrDefault<
                                                                              String>(
                                                                        _model
                                                                            .midResults
                                                                            .where((e) =>
                                                                                e.id ==
                                                                                _model.selectedIndex)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.url,
                                                                        'd',
                                                                      ),
                                                                      width: double
                                                                          .infinity,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.48,
                                                                      horizontalScroll:
                                                                          true,
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
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                        ))
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: valueOrDefault<double>(
                                                  () {
                                                    if (_model.bottomOpen! &&
                                                        () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return false;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return false;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointLarge) {
                                                            return true;
                                                          } else {
                                                            return false;
                                                          }
                                                        }()) {
                                                      return 260.0;
                                                    } else if (_model
                                                            .bottomOpen! &&
                                                        () {
                                                          if (MediaQuery.sizeOf(
                                                                      context)
                                                                  .width <
                                                              kBreakpointSmall) {
                                                            return false;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointMedium) {
                                                            return false;
                                                          } else if (MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width <
                                                              kBreakpointLarge) {
                                                            return false;
                                                          } else {
                                                            return true;
                                                          }
                                                        }()) {
                                                      return 320.0;
                                                    } else {
                                                      return 100.0;
                                                    }
                                                  }(),
                                                  340.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 12.0,
                                                      color: Color(0xFFBBBBBB),
                                                      offset: Offset(
                                                        0.0,
                                                        -10.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  border: Border.all(
                                                    color: Color(0xFFBBBBBB),
                                                  ),
                                                ),
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          20.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 240.0,
                                                                height: 50.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .format_list_bulleted,
                                                                      color: Color(
                                                                          0xFFA9B4CD),
                                                                      size:
                                                                          36.0,
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          15.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Text(
                                                                        FFLocalizations.of(context)
                                                                            .getText(
                                                                          '22up2u1i' /* 선정한 중간 결과물 */,
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF284E75),
                                                                              fontSize: () {
                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                  return 10.0;
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
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      1.0, 0.0),
                                                              child: Container(
                                                                width: 100.0,
                                                                height: 100.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
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
                                                                    if (_model
                                                                            .bottomOpen ==
                                                                        true) {
                                                                      _model.bottomOpen =
                                                                          false;
                                                                      safeSetState(
                                                                          () {});
                                                                    } else {
                                                                      _model.bottomOpen =
                                                                          true;
                                                                      safeSetState(
                                                                          () {});
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .file_open_outlined,
                                                                    color: Color(
                                                                        0xFF284E75),
                                                                    size: () {
                                                                      if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointSmall) {
                                                                        return 30.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointMedium) {
                                                                        return 35.0;
                                                                      } else if (MediaQuery.sizeOf(context)
                                                                              .width <
                                                                          kBreakpointLarge) {
                                                                        return 40.0;
                                                                      } else {
                                                                        return 50.0;
                                                                      }
                                                                    }(),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (_model.bottomOpen ==
                                                        true)
                                                      Expanded(
                                                        flex: 7,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                flex: 3,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'iwad84ds' /* 중간 결과물[상] */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.bold,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                          color: Color(0xFF999999),
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
                                                                                          fontWeight: FontWeight.bold,
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
                                                                    Expanded(
                                                                      flex: 9,
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child: DragTarget<
                                                                            MidtermResultsRow>(
                                                                          onAcceptWithDetails:
                                                                              (details) async {
                                                                            if ((_model.midtermHigh.where((e) => e.id == details.data.id).toList().firstOrNull == null) &&
                                                                                (_model.midtermMiddle.where((e) => e.id == details.data.id).toList().firstOrNull == null) &&
                                                                                (_model.midtermLow.where((e) => e.id == details.data.id).toList().firstOrNull == null)) {
                                                                              _model.draghigh = await MidtermResultsTable().update(
                                                                                data: {
                                                                                  'portpolioresult': '상',
                                                                                },
                                                                                matchingRows: (rows) => rows.eqOrNull(
                                                                                  'id',
                                                                                  details.data.id,
                                                                                ),
                                                                                returnRows: true,
                                                                              );
                                                                              _model.addToMidtermHigh(_model.draghigh!.firstOrNull!);
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              await showDialog(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return WebViewAware(
                                                                                    child: AlertDialog(
                                                                                      title: Text('이미 평가를 끝낸 결과물입니다.'),
                                                                                      content: Text('다시 선정하시려면 선택 후 , 드래그해서 위로 뺴주세요.'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                          child: Text('Ok'),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            }

                                                                            safeSetState(() {});
                                                                          },
                                                                          onLeave:
                                                                              (data) async {
                                                                            _model.dragexit =
                                                                                await MidtermResultsTable().update(
                                                                              data: {
                                                                                'portpolioresult': '',
                                                                              },
                                                                              matchingRows: (rows) => rows.eqOrNull(
                                                                                'id',
                                                                                data?.id,
                                                                              ),
                                                                              returnRows: true,
                                                                            );
                                                                            _model.removeFromMidtermHigh(data!);
                                                                            safeSetState(() {});

                                                                            safeSetState(() {});
                                                                          },
                                                                          builder: (context,
                                                                              _,
                                                                              __) {
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                  0.0,
                                                                                  valueOrDefault<double>(
                                                                                    () {
                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                        return 5.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                        return 5.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                        return 10.0;
                                                                                      } else {
                                                                                        return 15.0;
                                                                                      }
                                                                                    }(),
                                                                                    15.0,
                                                                                  ),
                                                                                  0.0,
                                                                                  0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final highmidtermselected = _model.midtermHigh.map((e) => e).toList();
                                                                                          if (highmidtermselected.isEmpty) {
                                                                                            return Center(
                                                                                              child: Image.network(
                                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/real-estate-dashboard-u-i-kit-58jztv/assets/ym7qo84cuib3/Group_281.png',
                                                                                                width: double.infinity,
                                                                                                height: double.infinity,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                            );
                                                                                          }

                                                                                          return GridView.builder(
                                                                                            padding: EdgeInsets.zero,
                                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                              crossAxisCount: 1,
                                                                                              crossAxisSpacing: 1.0,
                                                                                              mainAxisSpacing: 1.0,
                                                                                              childAspectRatio: 1.2,
                                                                                            ),
                                                                                            shrinkWrap: true,
                                                                                            scrollDirection: Axis.horizontal,
                                                                                            itemCount: highmidtermselected.length,
                                                                                            itemBuilder: (context, highmidtermselectedIndex) {
                                                                                              final highmidtermselectedItem = highmidtermselected[highmidtermselectedIndex];
                                                                                              return GridViewMidtermWidget(
                                                                                                key: Key('Keydpu_${highmidtermselectedIndex}_of_${highmidtermselected.length}'),
                                                                                                midList: highmidtermselectedItem,
                                                                                                isSelectedAction: (midId) async {},
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'w19epvok' /* 중간 결과물[중] */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF999999),
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
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 9,
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child: DragTarget<
                                                                            MidtermResultsRow>(
                                                                          onAcceptWithDetails:
                                                                              (details) async {
                                                                            if ((_model.midtermHigh.where((e) => e.id == details.data.id).toList().firstOrNull == null) &&
                                                                                (_model.midtermMiddle.where((e) => e.id == details.data.id).toList().firstOrNull == null) &&
                                                                                (_model.midtermLow.where((e) => e.id == details.data.id).toList().firstOrNull == null)) {
                                                                              _model.dragmiddle = await MidtermResultsTable().update(
                                                                                data: {
                                                                                  'portpolioresult': '상',
                                                                                },
                                                                                matchingRows: (rows) => rows.eqOrNull(
                                                                                  'id',
                                                                                  details.data.id,
                                                                                ),
                                                                                returnRows: true,
                                                                              );
                                                                              _model.addToMidtermMiddle(_model.dragmiddle!.firstOrNull!);
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              await showDialog(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return WebViewAware(
                                                                                    child: AlertDialog(
                                                                                      title: Text('이미 평가를 끝낸 결과물입니다.'),
                                                                                      content: Text('다시 선정하시려면 선택 후 , 드래그해서 위로 뺴주세요.'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                          child: Text('Ok'),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            }

                                                                            safeSetState(() {});
                                                                          },
                                                                          onLeave:
                                                                              (data) async {
                                                                            _model.middledragexit =
                                                                                await MidtermResultsTable().update(
                                                                              data: {
                                                                                'portpolioresult': '',
                                                                              },
                                                                              matchingRows: (rows) => rows.eqOrNull(
                                                                                'id',
                                                                                data?.id,
                                                                              ),
                                                                              returnRows: true,
                                                                            );
                                                                            _model.removeFromMidtermMiddle(data!);
                                                                            safeSetState(() {});

                                                                            safeSetState(() {});
                                                                          },
                                                                          builder: (context,
                                                                              _,
                                                                              __) {
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                  0.0,
                                                                                  valueOrDefault<double>(
                                                                                    () {
                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                        return 5.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                        return 5.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                        return 10.0;
                                                                                      } else {
                                                                                        return 15.0;
                                                                                      }
                                                                                    }(),
                                                                                    15.0,
                                                                                  ),
                                                                                  0.0,
                                                                                  0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final middlemidtermselected = _model.midtermMiddle.map((e) => e).toList();
                                                                                          if (middlemidtermselected.isEmpty) {
                                                                                            return Center(
                                                                                              child: Image.network(
                                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/real-estate-dashboard-u-i-kit-58jztv/assets/ym7qo84cuib3/Group_281.png',
                                                                                                width: double.infinity,
                                                                                                height: double.infinity,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                            );
                                                                                          }

                                                                                          return GridView.builder(
                                                                                            padding: EdgeInsets.zero,
                                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                              crossAxisCount: 1,
                                                                                              crossAxisSpacing: 1.0,
                                                                                              mainAxisSpacing: 1.0,
                                                                                              childAspectRatio: 1.2,
                                                                                            ),
                                                                                            shrinkWrap: true,
                                                                                            scrollDirection: Axis.horizontal,
                                                                                            itemCount: middlemidtermselected.length,
                                                                                            itemBuilder: (context, middlemidtermselectedIndex) {
                                                                                              final middlemidtermselectedItem = middlemidtermselected[middlemidtermselectedIndex];
                                                                                              return GridViewMidtermWidget(
                                                                                                key: Key('Key6hc_${middlemidtermselectedIndex}_of_${middlemidtermselected.length}'),
                                                                                                midList: middlemidtermselectedItem,
                                                                                                isSelectedAction: (midId) async {},
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 3,
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Container(
                                                                              width: 100.0,
                                                                              height: 100.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'jtx7bbb8' /* 중간 결과물[하] */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: Color(0xFF999999),
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
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      flex: 9,
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child: DragTarget<
                                                                            MidtermResultsRow>(
                                                                          onAcceptWithDetails:
                                                                              (details) async {
                                                                            if ((_model.midtermHigh.where((e) => e.id == details.data.id).toList().firstOrNull == null) &&
                                                                                (_model.midtermMiddle.where((e) => e.id == details.data.id).toList().firstOrNull == null) &&
                                                                                (_model.midtermLow.where((e) => e.id == details.data.id).toList().firstOrNull == null)) {
                                                                              _model.draglow = await MidtermResultsTable().update(
                                                                                data: {
                                                                                  'portpolioresult': '하',
                                                                                },
                                                                                matchingRows: (rows) => rows.eqOrNull(
                                                                                  'id',
                                                                                  details.data.id,
                                                                                ),
                                                                                returnRows: true,
                                                                              );
                                                                              _model.addToMidtermLow(_model.draglow!.firstOrNull!);
                                                                              safeSetState(() {});
                                                                            } else {
                                                                              await showDialog(
                                                                                context: context,
                                                                                builder: (alertDialogContext) {
                                                                                  return WebViewAware(
                                                                                    child: AlertDialog(
                                                                                      title: Text('이미 평가를 끝낸 결과물입니다.'),
                                                                                      content: Text('다시 선정하시려면 선택 후 , 드래그해서 위로 뺴주세요.'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext),
                                                                                          child: Text('Ok'),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              );
                                                                            }

                                                                            safeSetState(() {});
                                                                          },
                                                                          onLeave:
                                                                              (data) async {
                                                                            _model.lowdragexit =
                                                                                await MidtermResultsTable().update(
                                                                              data: {
                                                                                'portpolioresult': '',
                                                                              },
                                                                              matchingRows: (rows) => rows.eqOrNull(
                                                                                'id',
                                                                                data?.id,
                                                                              ),
                                                                              returnRows: true,
                                                                            );
                                                                            _model.removeFromMidtermLow(data!);
                                                                            safeSetState(() {});

                                                                            safeSetState(() {});
                                                                          },
                                                                          builder: (context,
                                                                              _,
                                                                              __) {
                                                                            return Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(
                                                                                  0.0,
                                                                                  valueOrDefault<double>(
                                                                                    () {
                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                        return 5.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                        return 5.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                        return 10.0;
                                                                                      } else {
                                                                                        return 15.0;
                                                                                      }
                                                                                    }(),
                                                                                    15.0,
                                                                                  ),
                                                                                  0.0,
                                                                                  0.0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Expanded(
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                      child: Builder(
                                                                                        builder: (context) {
                                                                                          final lowmidtermselected = _model.midtermLow.map((e) => e).toList();
                                                                                          if (lowmidtermselected.isEmpty) {
                                                                                            return Center(
                                                                                              child: Image.network(
                                                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/real-estate-dashboard-u-i-kit-58jztv/assets/ym7qo84cuib3/Group_281.png',
                                                                                                width: double.infinity,
                                                                                                height: double.infinity,
                                                                                                fit: BoxFit.contain,
                                                                                              ),
                                                                                            );
                                                                                          }

                                                                                          return GridView.builder(
                                                                                            padding: EdgeInsets.zero,
                                                                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                              crossAxisCount: 1,
                                                                                              crossAxisSpacing: 1.0,
                                                                                              mainAxisSpacing: 1.0,
                                                                                              childAspectRatio: 1.2,
                                                                                            ),
                                                                                            shrinkWrap: true,
                                                                                            scrollDirection: Axis.horizontal,
                                                                                            itemCount: lowmidtermselected.length,
                                                                                            itemBuilder: (context, lowmidtermselectedIndex) {
                                                                                              final lowmidtermselectedItem = lowmidtermselected[lowmidtermselectedIndex];
                                                                                              return GridViewMidtermWidget(
                                                                                                key: Key('Keykop_${lowmidtermselectedIndex}_of_${lowmidtermselected.length}'),
                                                                                                midList: lowmidtermselectedItem,
                                                                                                isSelectedAction: (midId) async {},
                                                                                              );
                                                                                            },
                                                                                          );
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
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
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (responsiveVisibility(
                                  context: context,
                                  phone: false,
                                  tablet: false,
                                ))
                                  Expanded(
                                    flex: 3,
                                    child: wrapWithModel(
                                      model: _model.rightWidgetModel,
                                      updateCallback: () => safeSetState(() {}),
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
                width: double.infinity,
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
                            model: _model.studentHeaderMobileModel,
                            updateCallback: () => safeSetState(() {}),
                            child: StudentHeaderMobileWidget(),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
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
                              flex: 18,
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Stack(
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ))
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, -1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 5.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
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
                                                                    .pageViewController ??=
                                                                PageController(
                                                                    initialPage:
                                                                        0),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            children: [
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.93,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                      ),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                                                                                      child: Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.33,
                                                                                        height: 100.0,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.format_list_bulleted,
                                                                                              color: Color(0xFF284E75),
                                                                                              size: 36.0,
                                                                                            ),
                                                                                            Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 0.0, 0.0),
                                                                                              child: Text(
                                                                                                FFLocalizations.of(context).getText(
                                                                                                  '3g1kugbg' /* 중간 결과물 */,
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                      color: Color(0xFF284E75),
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 10.0;
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
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Stack(
                                                                              children: [
                                                                                SingleChildScrollView(
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      if (valueOrDefault<bool>(
                                                                                            _model.midResults.firstOrNull != null,
                                                                                            true,
                                                                                          ) ==
                                                                                          true)
                                                                                        Container(
                                                                                          width: double.infinity,
                                                                                          height: MediaQuery.sizeOf(context).height * 0.76,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0.0, -1.0),
                                                                                            child: Builder(
                                                                                              builder: (context) {
                                                                                                final midgridview = _model.midResults.map((e) => e).toList();

                                                                                                return GridView.builder(
                                                                                                  padding: EdgeInsets.zero,
                                                                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                                    crossAxisCount: 3,
                                                                                                    crossAxisSpacing: 1.0,
                                                                                                    mainAxisSpacing: 1.0,
                                                                                                    childAspectRatio: 1.2,
                                                                                                  ),
                                                                                                  shrinkWrap: true,
                                                                                                  scrollDirection: Axis.vertical,
                                                                                                  itemCount: midgridview.length,
                                                                                                  itemBuilder: (context, midgridviewIndex) {
                                                                                                    final midgridviewItem = midgridview[midgridviewIndex];
                                                                                                    return Align(
                                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                                      child: GridViewMidtermWidget(
                                                                                                        key: Key('Keyt4t_${midgridviewIndex}_of_${midgridview.length}'),
                                                                                                        selectedMidId: _model.selectedIndex!,
                                                                                                        midList: midgridviewItem,
                                                                                                        isSelectedAction: (midId) async {
                                                                                                          _model.selectedIndex = midId;
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
                                                                                ),
                                                                                if (valueOrDefault<bool>(
                                                                                      _model.midResults.firstOrNull == null,
                                                                                      false,
                                                                                    ) ==
                                                                                    true)
                                                                                  Container(
                                                                                    width: double.infinity,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.75,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0.0, -1.0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                                                                                        child: Material(
                                                                                          color: Colors.transparent,
                                                                                          elevation: 1.0,
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(16.0),
                                                                                          ),
                                                                                          child: Container(
                                                                                            width: 500.0,
                                                                                            height: 300.0,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                              borderRadius: BorderRadius.circular(16.0),
                                                                                              shape: BoxShape.rectangle,
                                                                                              border: Border.all(
                                                                                                color: FlutterFlowTheme.of(context).alternate,
                                                                                                width: 3.0,
                                                                                              ),
                                                                                            ),
                                                                                            child: Column(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              children: [
                                                                                                Align(
                                                                                                  alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Flexible(
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: Icon(
                                                                                                              Icons.note_add_sharp,
                                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                              size: () {
                                                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                                  return 35.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                                  return 35.0;
                                                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                                  return 45.0;
                                                                                                                } else {
                                                                                                                  return 55.0;
                                                                                                                }
                                                                                                              }(),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                                  child: Row(
                                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                                    children: [
                                                                                                      Flexible(
                                                                                                        child: Align(
                                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                          child: Padding(
                                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                                            child: Text(
                                                                                                              FFLocalizations.of(context).getText(
                                                                                                                '68wiarft' /* 아직 제출된 파일이 없습니다. */,
                                                                                                              ),
                                                                                                              textAlign: TextAlign.center,
                                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                                                                                                                        return 12.0;
                                                                                                                      } else {
                                                                                                                        return 16.0;
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
                                                                                                Expanded(
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      children: [
                                                                                                        Flexible(
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0.0, 0.0),
                                                                                                            child: FFButtonWidget(
                                                                                                              onPressed: () async {
                                                                                                                if (_model.refresh == true) {
                                                                                                                  _model.refresh = false;
                                                                                                                  safeSetState(() {});
                                                                                                                } else {
                                                                                                                  _model.refresh = true;
                                                                                                                  safeSetState(() {});
                                                                                                                }
                                                                                                              },
                                                                                                              text: FFLocalizations.of(context).getText(
                                                                                                                'pcnq6upy' /* 새로고침 */,
                                                                                                              ),
                                                                                                              options: FFButtonOptions(
                                                                                                                width: 250.0,
                                                                                                                height: 45.0,
                                                                                                                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                                                color: Color(0xFFA6B6C3),
                                                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                                                      font: GoogleFonts.openSans(
                                                                                                                        fontWeight: FontWeight.w600,
                                                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                      ),
                                                                                                                      color: Colors.white,
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
                                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                                                    ),
                                                                                                                elevation: 0.0,
                                                                                                                borderRadius: BorderRadius.circular(8.0),
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
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  if (valueOrDefault<
                                                                          bool>(
                                                                        _model.midResults.firstOrNull !=
                                                                            null,
                                                                        false,
                                                                      ) ==
                                                                      true)
                                                                    Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.93,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                        ),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            if (valueOrDefault<bool>(
                                                                              (_model.midResults.firstOrNull == null) &&
                                                                                  valueOrDefault<bool>(
                                                                                    _model.selectedIndex == -1,
                                                                                    false,
                                                                                  ),
                                                                              true,
                                                                            ))
                                                                              Align(
                                                                                alignment: AlignmentDirectional(0.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '1zihs320' /* 미리 보기 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 18.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 18.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 20.0;
                                                                                          } else {
                                                                                            return 20.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                if (valueOrDefault<bool>(
                                                                                  _model.selectedIndex! > 0,
                                                                                  false,
                                                                                ))
                                                                                  FlutterFlowPdfViewer(
                                                                                    networkPath: valueOrDefault<String>(
                                                                                      _model.midResults.where((e) => e.id == _model.selectedIndex).toList().firstOrNull?.url,
                                                                                      'd',
                                                                                    ),
                                                                                    width: double.infinity,
                                                                                    height: MediaQuery.sizeOf(context).height * 0.8,
                                                                                    horizontalScroll: true,
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
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, -1.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        16.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: smooth_page_indicator
                                                                .SmoothPageIndicator(
                                                              controller: _model
                                                                      .pageViewController ??=
                                                                  PageController(
                                                                      initialPage:
                                                                          0),
                                                              count: 2,
                                                              axisDirection: Axis
                                                                  .horizontal,
                                                              onDotClicked:
                                                                  (i) async {
                                                                await _model
                                                                    .pageViewController!
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
                                                              effect:
                                                                  smooth_page_indicator
                                                                      .SlideEffect(
                                                                spacing: 8.0,
                                                                radius: 8.0,
                                                                dotWidth: 8.0,
                                                                dotHeight: 8.0,
                                                                dotColor:
                                                                    FlutterFlowTheme.of(
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
                                    if (responsiveVisibility(
                                      context: context,
                                      tabletLandscape: false,
                                      desktop: false,
                                    ))
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 0.0, 5.0, 0.0),
                                          child: Container(
                                            width: double.infinity,
                                            height: valueOrDefault<double>(
                                              () {
                                                if (_model.bottomOpen! &&
                                                    () {
                                                      if (MediaQuery.sizeOf(
                                                                  context)
                                                              .width <
                                                          kBreakpointSmall) {
                                                        return true;
                                                      } else if (MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width <
                                                          kBreakpointMedium) {
                                                        return false;
                                                      } else if (MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width <
                                                          kBreakpointLarge) {
                                                        return false;
                                                      } else {
                                                        return false;
                                                      }
                                                    }()) {
                                                  return 260.0;
                                                } else if (_model.bottomOpen! &&
                                                    () {
                                                      if (MediaQuery.sizeOf(
                                                                  context)
                                                              .width <
                                                          kBreakpointSmall) {
                                                        return false;
                                                      } else if (MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width <
                                                          kBreakpointMedium) {
                                                        return true;
                                                      } else if (MediaQuery
                                                                  .sizeOf(
                                                                      context)
                                                              .width <
                                                          kBreakpointLarge) {
                                                        return false;
                                                      } else {
                                                        return false;
                                                      }
                                                    }()) {
                                                  return 320.0;
                                                } else {
                                                  return 100.0;
                                                }
                                              }(),
                                              340.0,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 12.0,
                                                  color: Color(0xFFBBBBBB),
                                                  offset: Offset(
                                                    0.0,
                                                    -10.0,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              border: Border.all(
                                                color: Color(0xFFBBBBBB),
                                              ),
                                            ),
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (responsiveVisibility(
                                                  context: context,
                                                  tabletLandscape: false,
                                                  desktop: false,
                                                ))
                                                  Expanded(
                                                    flex: 2,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            child: Container(
                                                              width: 240.0,
                                                              height: 50.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .format_list_bulleted,
                                                                    color: Color(
                                                                        0xFFA9B4CD),
                                                                    size: 36.0,
                                                                  ),
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
                                                                        'ygiae8hc' /* 선정한 중간 결과물 */,
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
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            child: Container(
                                                              width: 100.0,
                                                              height: 100.0,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            16.0),
                                                              ),
                                                              child: InkWell(
                                                                splashColor: Colors
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
                                                                  if (_model
                                                                          .bottomOpen ==
                                                                      true) {
                                                                    _model.bottomOpen =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                  } else {
                                                                    _model.bottomOpen =
                                                                        true;
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .file_open_outlined,
                                                                  color: Color(
                                                                      0xFF284E75),
                                                                  size: () {
                                                                    if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointSmall) {
                                                                      return 30.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointMedium) {
                                                                      return 35.0;
                                                                    } else if (MediaQuery.sizeOf(context)
                                                                            .width <
                                                                        kBreakpointLarge) {
                                                                      return 40.0;
                                                                    } else {
                                                                      return 50.0;
                                                                    }
                                                                  }(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                if ((_model.bottomOpen ==
                                                        true) &&
                                                    responsiveVisibility(
                                                      context: context,
                                                      tabletLandscape: false,
                                                      desktop: false,
                                                    ))
                                                  Expanded(
                                                    flex: 7,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Flexible(
                                                                        child:
                                                                            Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                double.infinity,
                                                                            height:
                                                                                double.infinity,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(0.0, 0.0),
                                                                              child: Text(
                                                                                FFLocalizations.of(context).getText(
                                                                                  '7bvr0y7l' /* 중간 결과물[상] */,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      font: GoogleFonts.openSans(
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                      ),
                                                                                      color: Color(0xFF999999),
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
                                                                                      fontWeight: FontWeight.bold,
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
                                                                Expanded(
                                                                  flex: 9,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: DragTarget<
                                                                        MidtermResultsRow>(
                                                                      onAcceptWithDetails:
                                                                          (details) async {
                                                                        _model.draghighMobile =
                                                                            await MidtermResultsTable().update(
                                                                          data: {
                                                                            'portpolioresult':
                                                                                '상',
                                                                          },
                                                                          matchingRows: (rows) =>
                                                                              rows.eqOrNull(
                                                                            'id',
                                                                            details.data.id,
                                                                          ),
                                                                          returnRows:
                                                                              true,
                                                                        );
                                                                        _model.addToMidtermHigh(_model
                                                                            .draghighMobile!
                                                                            .firstOrNull!);
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      onLeave:
                                                                          (data) async {
                                                                        _model.dragexitMobile =
                                                                            await MidtermResultsTable().update(
                                                                          data: {
                                                                            'portpolioresult':
                                                                                '',
                                                                          },
                                                                          matchingRows: (rows) =>
                                                                              rows.eqOrNull(
                                                                            'id',
                                                                            data?.id,
                                                                          ),
                                                                          returnRows:
                                                                              true,
                                                                        );
                                                                        _model.removeFromMidtermHigh(
                                                                            data!);
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      builder:
                                                                          (context,
                                                                              _,
                                                                              __) {
                                                                        return Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              valueOrDefault<double>(
                                                                                () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 5.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 5.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 10.0;
                                                                                  } else {
                                                                                    return 15.0;
                                                                                  }
                                                                                }(),
                                                                                15.0,
                                                                              ),
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Builder(
                                                                                    builder: (context) {
                                                                                      final highmidtermselected = _model.midtermHigh.map((e) => e).toList();
                                                                                      if (highmidtermselected.isEmpty) {
                                                                                        return Center(
                                                                                          child: Image.network(
                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/real-estate-dashboard-u-i-kit-58jztv/assets/ym7qo84cuib3/Group_281.png',
                                                                                            width: double.infinity,
                                                                                            height: double.infinity,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                        );
                                                                                      }

                                                                                      return GridView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                          crossAxisCount: 1,
                                                                                          crossAxisSpacing: 1.0,
                                                                                          mainAxisSpacing: 1.0,
                                                                                          childAspectRatio: 1.2,
                                                                                        ),
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        itemCount: highmidtermselected.length,
                                                                                        itemBuilder: (context, highmidtermselectedIndex) {
                                                                                          final highmidtermselectedItem = highmidtermselected[highmidtermselectedIndex];
                                                                                          return GridViewMidtermWidget(
                                                                                            key: Key('Keyzau_${highmidtermselectedIndex}_of_${highmidtermselected.length}'),
                                                                                            midList: highmidtermselectedItem,
                                                                                            isSelectedAction: (midId) async {},
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              double.infinity,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                '0f9y7jz8' /* 중간 결과물[중] */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: Color(0xFF999999),
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
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 9,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: DragTarget<
                                                                        MidtermResultsRow>(
                                                                      onAcceptWithDetails:
                                                                          (details) async {
                                                                        _model.dragmiddleMobile =
                                                                            await MidtermResultsTable().update(
                                                                          data: {
                                                                            'portpolioresult':
                                                                                '상',
                                                                          },
                                                                          matchingRows: (rows) =>
                                                                              rows.eqOrNull(
                                                                            'id',
                                                                            details.data.id,
                                                                          ),
                                                                          returnRows:
                                                                              true,
                                                                        );
                                                                        _model.addToMidtermMiddle(_model
                                                                            .dragmiddleMobile!
                                                                            .firstOrNull!);
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      onLeave:
                                                                          (data) async {
                                                                        _model.middledragexitMobile =
                                                                            await MidtermResultsTable().update(
                                                                          data: {
                                                                            'portpolioresult':
                                                                                '',
                                                                          },
                                                                          matchingRows: (rows) =>
                                                                              rows.eqOrNull(
                                                                            'id',
                                                                            data?.id,
                                                                          ),
                                                                          returnRows:
                                                                              true,
                                                                        );
                                                                        _model.removeFromMidtermMiddle(
                                                                            data!);
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      builder:
                                                                          (context,
                                                                              _,
                                                                              __) {
                                                                        return Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              valueOrDefault<double>(
                                                                                () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 5.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 5.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 10.0;
                                                                                  } else {
                                                                                    return 15.0;
                                                                                  }
                                                                                }(),
                                                                                15.0,
                                                                              ),
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Builder(
                                                                                    builder: (context) {
                                                                                      final middlemidtermselected = _model.midtermMiddle.map((e) => e).toList();
                                                                                      if (middlemidtermselected.isEmpty) {
                                                                                        return Center(
                                                                                          child: Image.network(
                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/real-estate-dashboard-u-i-kit-58jztv/assets/ym7qo84cuib3/Group_281.png',
                                                                                            width: double.infinity,
                                                                                            height: double.infinity,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                        );
                                                                                      }

                                                                                      return GridView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                          crossAxisCount: 1,
                                                                                          crossAxisSpacing: 1.0,
                                                                                          mainAxisSpacing: 1.0,
                                                                                          childAspectRatio: 1.2,
                                                                                        ),
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        itemCount: middlemidtermselected.length,
                                                                                        itemBuilder: (context, middlemidtermselectedIndex) {
                                                                                          final middlemidtermselectedItem = middlemidtermselected[middlemidtermselectedIndex];
                                                                                          return GridViewMidtermWidget(
                                                                                            key: Key('Keyx8k_${middlemidtermselectedIndex}_of_${middlemidtermselected.length}'),
                                                                                            midList: middlemidtermselectedItem,
                                                                                            isSelectedAction: (midId) async {},
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 3,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Expanded(
                                                                  flex: 1,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              100.0,
                                                                          height:
                                                                              100.0,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'rroaq8gq' /* 중간 결과물[하] */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FontWeight.bold,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: Color(0xFF999999),
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
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  flex: 9,
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: DragTarget<
                                                                        MidtermResultsRow>(
                                                                      onAcceptWithDetails:
                                                                          (details) async {
                                                                        _model.draglowMobile =
                                                                            await MidtermResultsTable().update(
                                                                          data: {
                                                                            'portpolioresult':
                                                                                '하',
                                                                          },
                                                                          matchingRows: (rows) =>
                                                                              rows.eqOrNull(
                                                                            'id',
                                                                            details.data.id,
                                                                          ),
                                                                          returnRows:
                                                                              true,
                                                                        );
                                                                        _model.addToMidtermLow(_model
                                                                            .draglowMobile!
                                                                            .firstOrNull!);
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      onLeave:
                                                                          (data) async {
                                                                        _model.lowdragexitMobile =
                                                                            await MidtermResultsTable().update(
                                                                          data: {
                                                                            'portpolioresult':
                                                                                '',
                                                                          },
                                                                          matchingRows: (rows) =>
                                                                              rows.eqOrNull(
                                                                            'id',
                                                                            data?.id,
                                                                          ),
                                                                          returnRows:
                                                                              true,
                                                                        );
                                                                        _model.removeFromMidtermLow(
                                                                            data!);
                                                                        safeSetState(
                                                                            () {});

                                                                        safeSetState(
                                                                            () {});
                                                                      },
                                                                      builder:
                                                                          (context,
                                                                              _,
                                                                              __) {
                                                                        return Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              valueOrDefault<double>(
                                                                                () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 5.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 5.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 10.0;
                                                                                  } else {
                                                                                    return 15.0;
                                                                                  }
                                                                                }(),
                                                                                15.0,
                                                                              ),
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Builder(
                                                                                    builder: (context) {
                                                                                      final lowmidtermselected = _model.midtermLow.map((e) => e).toList();
                                                                                      if (lowmidtermselected.isEmpty) {
                                                                                        return Center(
                                                                                          child: Image.network(
                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/real-estate-dashboard-u-i-kit-58jztv/assets/ym7qo84cuib3/Group_281.png',
                                                                                            width: double.infinity,
                                                                                            height: double.infinity,
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                        );
                                                                                      }

                                                                                      return GridView.builder(
                                                                                        padding: EdgeInsets.zero,
                                                                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                                                          crossAxisCount: 1,
                                                                                          crossAxisSpacing: 1.0,
                                                                                          mainAxisSpacing: 1.0,
                                                                                          childAspectRatio: 1.2,
                                                                                        ),
                                                                                        shrinkWrap: true,
                                                                                        scrollDirection: Axis.horizontal,
                                                                                        itemCount: lowmidtermselected.length,
                                                                                        itemBuilder: (context, lowmidtermselectedIndex) {
                                                                                          final lowmidtermselectedItem = lowmidtermselected[lowmidtermselectedIndex];
                                                                                          return GridViewMidtermWidget(
                                                                                            key: Key('Key5hx_${lowmidtermselectedIndex}_of_${lowmidtermselected.length}'),
                                                                                            midList: lowmidtermselectedItem,
                                                                                            isSelectedAction: (midId) async {},
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
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
                                      ),
                                    wrapWithModel(
                                      model: _model.naviSidebarMobileModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: NaviSidebarMobileWidget(
                                        activePageName: 'MidtermResults',
                                        pageIsInSubMenu: false,
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
    );
  }
}
