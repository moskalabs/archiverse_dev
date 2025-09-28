import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'week_chip_model.dart';
export 'week_chip_model.dart';

class WeekChipWidget extends StatefulWidget {
  const WeekChipWidget({
    super.key,
    required this.week,
    this.selectedWeek,
    required this.callbackWeek,
  });

  final String? week;
  final String? selectedWeek;
  final Future Function(String week)? callbackWeek;

  @override
  State<WeekChipWidget> createState() => _WeekChipWidgetState();
}

class _WeekChipWidgetState extends State<WeekChipWidget>
    with TickerProviderStateMixin {
  late WeekChipModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeekChipModel());

    animationsMap.addAll({
      'buttonOnActionTriggerAnimation': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 200.0.ms,
            color: Color(0x80FFFFFF),
            angle: 0.087,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: () async {
        await widget.callbackWeek?.call(
          widget.week!,
        );
      },
      text: widget.week!,
      options: FFButtonOptions(
        width: 110.0,
        height: 30.0,
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: widget.week == widget.selectedWeek
            ? FlutterFlowTheme.of(context).mainColor1
            : Color(0xFFEEF1F6),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.notoSansKr(
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: widget.week == widget.selectedWeek
                  ? Colors.white
                  : Color(0xFF666666),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
      ),
    ).animateOnActionTrigger(
      animationsMap['buttonOnActionTriggerAnimation']!,
    );
  }
}
