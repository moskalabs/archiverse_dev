import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'chat_message_options_model.dart';
export 'chat_message_options_model.dart';

class ChatMessageOptionsWidget extends StatefulWidget {
  const ChatMessageOptionsWidget({super.key});

  @override
  State<ChatMessageOptionsWidget> createState() =>
      _ChatMessageOptionsWidgetState();
}

class _ChatMessageOptionsWidgetState extends State<ChatMessageOptionsWidget>
    with TickerProviderStateMixin {
  late ChatMessageOptionsModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatMessageOptionsModel());

    animationsMap.addAll({
      'iconButtonOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 0.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'iconButtonOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 150.ms),
          ScaleEffect(
            curve: Curves.elasticOut,
            delay: 150.0.ms,
            duration: 500.0.ms,
            begin: Offset(0.0, 0.0),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
    });

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(10.0, 4.0, 10.0, 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlutterFlowIconButton(
              borderColor: FlutterFlowTheme.of(context).neutral200,
              borderRadius: 100.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.delete,
                color: FlutterFlowTheme.of(context).neutral300,
                size: 20.0,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ).animateOnPageLoad(
                animationsMap['iconButtonOnPageLoadAnimation1']!),
            FlutterFlowIconButton(
              borderColor: FlutterFlowTheme.of(context).neutral200,
              borderRadius: 100.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              icon: Icon(
                Icons.edit,
                color: FlutterFlowTheme.of(context).neutral300,
                size: 20.0,
              ),
              onPressed: () async {
                Navigator.pop(context);
              },
            ).animateOnPageLoad(
                animationsMap['iconButtonOnPageLoadAnimation2']!),
          ].divide(SizedBox(width: 10.0)),
        ),
      ),
    );
  }
}
