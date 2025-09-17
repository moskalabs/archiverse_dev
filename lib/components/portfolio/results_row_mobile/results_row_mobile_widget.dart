import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'results_row_mobile_model.dart';
export 'results_row_mobile_model.dart';

class ResultsRowMobileWidget extends StatefulWidget {
  const ResultsRowMobileWidget({
    super.key,
    required this.studentName,
    required this.resultTitle,
    this.evaluation,
    this.currEval,
    this.moveToDetail,
  });

  /// 학생 이름
  final String? studentName;

  /// 작품명
  final String? resultTitle;

  /// 클릭 시 결과물의 평가 값 변경, DB 연결 이후 Required로 변경
  final Future Function(String portfolioResult)? evaluation;

  /// 서버에서 불러온 값을 기준(nullable)
  final String? currEval;

  /// 작품명 클릭 시 이동할 액션
  final Future Function(int selectedResultID)? moveToDetail;

  @override
  State<ResultsRowMobileWidget> createState() => _ResultsRowMobileWidgetState();
}

class _ResultsRowMobileWidgetState extends State<ResultsRowMobileWidget> {
  late ResultsRowMobileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResultsRowMobileModel());

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
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Text(
              valueOrDefault<String>(
                widget.studentName,
                '홍길동',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color: Color(0xFF4E4E4E),
                    fontSize: 13.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ),
          Flexible(
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await widget.moveToDetail?.call(
                  1,
                );
              },
              child: Text(
                valueOrDefault<String>(
                  widget.resultTitle,
                  '작품명',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: Color(0xFF4E4E4E),
                      fontSize: 13.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await widget.evaluation?.call(
                        '하',
                      );
                    },
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Visibility(
                        visible: widget.currEval == '하',
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF666666),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await widget.evaluation?.call(
                        '중',
                      );
                    },
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Visibility(
                        visible: widget.currEval == '중',
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF666666),
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await widget.evaluation?.call(
                        '상',
                      );
                    },
                    child: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.0,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Visibility(
                        visible: widget.currEval == '상',
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                            width: 25.0,
                            height: 25.0,
                            decoration: BoxDecoration(
                              color: Color(0xFF666666),
                              borderRadius: BorderRadius.circular(3.0),
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
    );
  }
}
