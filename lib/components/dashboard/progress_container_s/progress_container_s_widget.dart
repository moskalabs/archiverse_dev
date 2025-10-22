import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'progress_container_s_model.dart';
export 'progress_container_s_model.dart';

class ProgressContainerSWidget extends StatefulWidget {
  const ProgressContainerSWidget({
    super.key,
    String? title,
    double? percentageNumerator,
    double? percentageDenominator,
  })  : this.title = title ?? '무제',
        this.percentageNumerator = percentageNumerator ?? 100.0,
        this.percentageDenominator = percentageDenominator ?? 1.0;

  /// title
  final String title;

  /// 진행률 분모
  final double percentageNumerator;

  /// 진행률 분자
  final double percentageDenominator;

  @override
  State<ProgressContainerSWidget> createState() =>
      _ProgressContainerSWidgetState();
}

class _ProgressContainerSWidgetState extends State<ProgressContainerSWidget> {
  late ProgressContainerSModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProgressContainerSModel());

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
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Align(
        alignment: AlignmentDirectional(0.0, 0.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.title,
                      '무제',
                    ),
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: Color(0xFF284E75),
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
                          fontWeight: FontWeight.w600,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 5.0, 0.0),
                    child: LinearPercentIndicator(
                      percent: widget.percentageDenominator > 0
                          ? (widget.percentageNumerator /
                                  widget.percentageDenominator)
                              .clamp(0.0, 1.0)
                          : 0.0,
                      lineHeight: 25.0,
                      animation: true,
                      animateFromLastPercent: true,
                      progressColor: Color(0xFF284E75),
                      backgroundColor: FlutterFlowTheme.of(context).alternate,
                      barRadius: Radius.circular(25.0),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.02,
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 3.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.percentageNumerator.toInt()}/${widget.percentageDenominator.toInt()}',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 6.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 10.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 12.0;
                                  } else {
                                    return 16.0;
                                  }
                                }(),
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: Text(
                              widget.percentageDenominator > 0
                                  ? '${((widget.percentageNumerator / widget.percentageDenominator) * 100).toStringAsFixed(1)}%'
                                  : '0%',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: () {
                                      if (MediaQuery.sizeOf(context).width <
                                          kBreakpointSmall) {
                                        return 6.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointMedium) {
                                        return 10.0;
                                      } else if (MediaQuery.sizeOf(context)
                                              .width <
                                          kBreakpointLarge) {
                                        return 12.0;
                                      } else {
                                        return 16.0;
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
                      ],
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(height: 5.0)),
          ),
        ),
      ),
    );
  }
}
