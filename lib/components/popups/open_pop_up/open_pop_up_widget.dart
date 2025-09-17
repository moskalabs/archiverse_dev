import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'open_pop_up_model.dart';
export 'open_pop_up_model.dart';

class OpenPopUpWidget extends StatefulWidget {
  const OpenPopUpWidget({
    super.key,
    required this.title,
  });

  /// 제목
  final String? title;

  @override
  State<OpenPopUpWidget> createState() => _OpenPopUpWidgetState();
}

class _OpenPopUpWidgetState extends State<OpenPopUpWidget> {
  late OpenPopUpModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OpenPopUpModel());

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
      width: 800.0,
      height: 1000.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 16.0,
            color: Color(0x1B080B1F),
            offset: Offset(
              0.0,
              6.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 8,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            'myzi4dgx' /* 서비스 오픈 안내 */,
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelLarge
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelLarge
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: () {
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
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .labelLarge
                                    .fontStyle,
                              ),
                        ),
                      ),
                    ),
                    FlutterFlowWebView(
                      content:
                          '<div style=\"font-family: \'Segoe UI\', sans-serif; line-height: 1.6; padding: 20px;\">\n  <h2>[건축학인증 시스템 \'아키버스\' 오픈안내]</h2>\n  <p><strong>일시 :</strong> 2025년 4월 14일(월) 오전 9시</p>\n  <p><strong>대상 :</strong> 순천향대학교 건축학과 교수님 및 학부생</p>\n\n  <h3>▣ 주요 기능</h3>\n  <ul>\n    <li>건축학 인증서류 자동화 및 페이퍼리스 제출</li>\n    <li>포트폴리오 온라인 관리</li>\n  </ul>\n\n  <h3>▣ 이용 방법</h3>\n  <ul>\n    <li><a href=\"https://archiverse.co.kr\" target=\"_blank\">Archiverse.co.kr</a> 접속</li>\n    <li>본인의 학습자료, 프로젝트 등을 업로드 및 관리</li>\n  </ul>\n\n  <h3>▣ 안내 사항</h3>\n  <p>아키버스 서비스는 현재 <strong>알파 버전</strong>으로 오픈되어, <br>일부 기능이 미완성 상태이거나 예기치 않은 오류 및 버그가 발생할 수 있습니다.</p>\n  <p>안정적인 서비스 제공을 위해 지속적으로 개선 작업을 진행하고 있으며, <br>이용 중 발생하는 불편에 대해 너그러운 양해를 부탁드립니다.</p>\n  <p>회원가입은 첨부드린 회원가입&로그인 가이드 라인을 참조하시기 바랍니다.</p>\n  <p>추가 메뉴얼은 사이트 내에 업로드 예정입니다.</p>\n  <p>서비스 이용 중 오류나 개선사항이 있으시면 아래 연락처로 문의 부탁드립니다.</p>\n\n  <h4>문의처:</h4>\n  <ul>\n    <li>전화: 041-533-5877</li>\n    <li>이메일: <a href=\"mailto:info@metalogy.co.kr\">info@metalogy.co.kr</a></li>\n    <li>온라인 채널: <a href=\"https://n9542.channel.io/home\" target=\"_blank\">https://n9542.channel.io/home</a></li>\n  </ul>\n\n  <p><strong>더 나은 서비스 제공을 위해 최선을 다하겠습니다.<br>감사합니다.</strong></p>\n</div>\n',
                      height: 600.0,
                      verticalScroll: false,
                      horizontalScroll: false,
                      html: true,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                child: MouseRegion(
                  opaque: false,
                  cursor: MouseCursor.defer ?? MouseCursor.defer,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Theme(
                                  data: ThemeData(
                                    checkboxTheme: CheckboxThemeData(
                                      visualDensity: VisualDensity.compact,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                    unselectedWidgetColor:
                                        FlutterFlowTheme.of(context).alternate,
                                  ),
                                  child: Checkbox(
                                    value: _model.checkboxValue ??= false,
                                    onChanged: (newValue) async {
                                      safeSetState(() =>
                                          _model.checkboxValue = newValue!);
                                      if (newValue!) {
                                        FFAppState().openPopupBool = false;
                                        safeSetState(() {});
                                      } else {
                                        FFAppState().openPopupBool = true;
                                        safeSetState(() {});
                                      }
                                    },
                                    side: (FlutterFlowTheme.of(context)
                                                .alternate !=
                                            null)
                                        ? BorderSide(
                                            width: 2,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          )
                                        : null,
                                    activeColor: Color(0xFF284E75),
                                    checkColor:
                                        FlutterFlowTheme.of(context).info,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    'cv8fra7m' /* 다시 보지 않기 */,
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
                                          if (MediaQuery.sizeOf(context).width <
                                              kBreakpointSmall) {
                                            return 10.0;
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
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 5.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              text: FFLocalizations.of(context).getText(
                                'bqibsdgs' /* 확인 */,
                              ),
                              options: FFButtonOptions(
                                width: 100.0,
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF284E75),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.openSans(
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
                              ),
                            ),
                          ),
                        ),
                      ],
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
            ),
          ],
        ),
      ),
    );
  }
}
