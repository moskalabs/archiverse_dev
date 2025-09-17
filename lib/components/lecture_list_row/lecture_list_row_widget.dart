import '/backend/supabase/supabase.dart';
import '/components/popups/download_pop_up/download_pop_up_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'lecture_list_row_model.dart';
export 'lecture_list_row_model.dart';

class LectureListRowWidget extends StatefulWidget {
  const LectureListRowWidget({
    super.key,
    required this.lectureList,
    int? selectedLectureId,
    required this.isSelectedAction,
  }) : this.selectedLectureId = selectedLectureId ?? -1;

  final LecturematerialRow? lectureList;

  /// 선택한 고유행
  final int selectedLectureId;

  final Future Function(

      /// row id
      int lectureId)? isSelectedAction;

  @override
  State<LectureListRowWidget> createState() => _LectureListRowWidgetState();
}

class _LectureListRowWidgetState extends State<LectureListRowWidget> {
  late LectureListRowModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LectureListRowModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 7,
          child: MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer ?? MouseCursor.defer,
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                await widget.isSelectedAction?.call(
                  widget.lectureList!.id,
                );
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height * 0.04,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 0.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      widget.lectureList?.title,
                      '강의자료',
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: valueOrDefault<Color>(
                            () {
                              if (_model.mouseRegionHovered1) {
                                return Color(0xFF284E75);
                              } else if (widget.selectedLectureId ==
                                  widget.lectureList?.id) {
                                return Color(0xFF284E75);
                              } else {
                                return FlutterFlowTheme.of(context)
                                    .secondaryText;
                              }
                            }(),
                            FlutterFlowTheme.of(context).secondaryText,
                          ),
                          fontSize: () {
                            if (MediaQuery.sizeOf(context).width <
                                kBreakpointSmall) {
                              return 8.0;
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
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
        Flexible(
          flex: 3,
          child: Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.04,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
              child: Text(
                valueOrDefault<String>(
                  dateTimeFormat(
                    "y-MM-dd HH시 mm분",
                    widget.lectureList?.createdDate,
                    locale: FFLocalizations.of(context).languageCode,
                  ),
                  'create time',
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.openSans(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: valueOrDefault<Color>(
                        () {
                          if (_model.mouseRegionHovered1) {
                            return Color(0xFF284E75);
                          } else if (widget.selectedLectureId ==
                              widget.lectureList?.id) {
                            return Color(0xFF284E75);
                          } else {
                            return FlutterFlowTheme.of(context).secondaryText;
                          }
                        }(),
                        FlutterFlowTheme.of(context).secondaryText,
                      ),
                      fontSize: () {
                        if (MediaQuery.sizeOf(context).width <
                            kBreakpointSmall) {
                          return 8.0;
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
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: MouseRegion(
            opaque: false,
            cursor: MouseCursor.defer ?? MouseCursor.defer,
            child: Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height * 0.04,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: Builder(
                builder: (context) => Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
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
                            alignment: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            child: WebViewAware(
                              child: DownloadPopUpWidget(
                                downloadType: '강의자료실',
                                titleName: valueOrDefault<String>(
                                  widget.lectureList?.title,
                                  '강의자료실 제목',
                                ),
                                url: valueOrDefault<String>(
                                  widget.lectureList?.url,
                                  'd',
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      FFLocalizations.of(context).getText(
                        'cacgnogz' /* 다운로드[받기] */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: valueOrDefault<Color>(
                              () {
                                if (_model.mouseRegionHovered2) {
                                  return Color(0xFF284E75);
                                } else if (widget.selectedLectureId ==
                                    widget.lectureList?.id) {
                                  return Color(0xFF284E75);
                                } else {
                                  return FlutterFlowTheme.of(context)
                                      .secondaryText;
                                }
                              }(),
                              FlutterFlowTheme.of(context).secondaryText,
                            ),
                            fontSize: () {
                              if (MediaQuery.sizeOf(context).width <
                                  kBreakpointSmall) {
                                return 8.0;
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
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
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
    );
  }
}
