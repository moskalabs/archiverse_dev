import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'calendar_detail_simple.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'calendar_detail_model.dart';
export 'calendar_detail_model.dart';

class CalendarDetailWidget extends StatefulWidget {
  const CalendarDetailWidget({
    super.key,
    this.date,
  });
  
  final String? date;

  static String routeName = 'CalendarDetail';
  static String routePath = '/CalendarDetail';

  @override
  State<CalendarDetailWidget> createState() => _CalendarDetailWidgetState();
}

class _CalendarDetailWidgetState extends State<CalendarDetailWidget> {
  late CalendarDetailModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalendarDetailModel());

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
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFEEF1F6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 네비게이션 사이드바
              wrapWithModel(
                model: _model.naviSidebarModel,
                updateCallback: () => safeSetState(() {}),
                child: NaviSidebarWidget(
                  activePageName: 'Calendar',
                  pageIsInSubMenu: false,
                ),
              ),
              // 메인 컨텐츠 영역
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // 헤더
                    wrapWithModel(
                      model: _model.headerModel,
                      updateCallback: () => safeSetState(() {}),
                      child: HeaderWidget(),
                    ),
                    // 컨텐츠 영역
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              // 제목 영역
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_task,
                                      color: Color(0xFFA9B4CD),
                                      size: 36.0,
                                    ),
                                    SizedBox(width: 15.0),
                                    Text(
                                      '일정 등록',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.openSans(
                                              fontWeight: FontWeight.w600,
                                            ),
                                            color: Color(0xFF284E75),
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                thickness: 2.0,
                                color: FlutterFlowTheme.of(context).alternate,
                              ),
                              // 캘린더 디테일 컨텐츠
                              Expanded(
                                child: CalendarDetailSimple(
                                  selectedDate: widget.date != null 
                                      ? DateTime.tryParse(widget.date!) 
                                      : null,
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
    );
  }
}
