import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'borderline_model.dart';
export 'borderline_model.dart';

class BorderlineWidget extends StatefulWidget {
  const BorderlineWidget({super.key});

  @override
  State<BorderlineWidget> createState() => _BorderlineWidgetState();
}

class _BorderlineWidgetState extends State<BorderlineWidget> {
  late BorderlineModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BorderlineModel());

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
      height: 0.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(
          color: Color(0xFF666666),
          width: 1.0,
        ),
      ),
    );
  }
}
