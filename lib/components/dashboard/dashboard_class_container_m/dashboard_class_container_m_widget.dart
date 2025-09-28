import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dashboard_class_container_m_model.dart';
export 'dashboard_class_container_m_model.dart';

class DashboardClassContainerMWidget extends StatefulWidget {
  const DashboardClassContainerMWidget({
    super.key,
    required this.courseName,
    required this.isDesign,
    String? section,
    required this.professor,
    required this.getDetailClassID,
    required this.classID,
    int? currentlySelectedID,
  })  : this.section = section ?? '0분반',
        this.currentlySelectedID = currentlySelectedID ?? 0;

  /// 수업명
  final String? courseName;

  /// 설계 과목 유무
  final bool? isDesign;

  /// 분반
  final String section;

  /// 교수님
  final String? professor;

  /// 수업 진행사항 컴포넌트에 필요한 정보를 읽어오고 'displayClassDetail'과 같은 boolean을 토대로 화면에 띄울지
  /// 말지 결정
  final Future Function(int displayClassDetailID)? getDetailClassID;

  final int? classID;
  final int currentlySelectedID;

  @override
  State<DashboardClassContainerMWidget> createState() =>
      _DashboardClassContainerMWidgetState();
}

class _DashboardClassContainerMWidgetState
    extends State<DashboardClassContainerMWidget> {
  late DashboardClassContainerMModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardClassContainerMModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.0,
      constraints: BoxConstraints(
        minWidth: 450.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFEEF1F6),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  minWidth: 200.0,
                ),
                decoration: BoxDecoration(),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 0.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        widget.courseName!,
                        maxLines: 1,
                        minFontSize: 12.0,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).mainColor1,
                              fontSize: 20.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                      Container(
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            RichText(
                              textScaler: MediaQuery.of(context).textScaler,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.professor!,
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
                                  TextSpan(
                                    text: FFLocalizations.of(context).getText(
                                      'r7cgd8ez' /*  교수님 */,
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
                                  )
                                ],
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: Color(0xFF666666),
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              maxLines: 1,
                            ),
                            if (widget.isDesign ?? true)
                              SizedBox(
                                height: 10.0,
                                child: VerticalDivider(
                                  thickness: 2.0,
                                  color: FlutterFlowTheme.of(context).alternate,
                                ),
                              ),
                            AutoSizeText(
                              widget.isDesign! ? widget.section : '',
                              maxLines: 1,
                              minFontSize: 12.0,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: Color(0xFF666666),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ].divide(SizedBox(height: 10.0)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FFButtonWidget(
                      onPressed: () async {
                        await widget.getDetailClassID?.call(
                          widget.classID!,
                        );
                      },
                      text: FFLocalizations.of(context).getText(
                        'uo3v6o9b' /* 진행사항 조회 ▶ */,
                      ),
                      options: FFButtonOptions(
                        width: 150.0,
                        height: 35.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: widget.currentlySelectedID == widget.classID
                            ? FlutterFlowTheme.of(context).mainColor1
                            : Color(0xFFB3B3B3),
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                        hoverColor: FlutterFlowTheme.of(context).mainColor1,
                      ),
                    ),
                  ].divide(SizedBox(height: 10.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
