import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'name_chip_model.dart';
export 'name_chip_model.dart';

class NameChipWidget extends StatefulWidget {
  const NameChipWidget({
    super.key,
    required this.studentId,
    this.selectedStudentId,
    required this.callbackStudentId,
    required this.studentName,
    required this.callbackStudentName,
  });

  final int? studentId;
  final int? selectedStudentId;
  final Future Function(int callbackStudentId)? callbackStudentId;
  final String? studentName;
  final Future Function(String callbackStudentName)? callbackStudentName;

  @override
  State<NameChipWidget> createState() => _NameChipWidgetState();
}

class _NameChipWidgetState extends State<NameChipWidget> {
  late NameChipModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NameChipModel());

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
        await widget.callbackStudentId?.call(
          widget.studentId!,
        );
        await widget.callbackStudentName?.call(
          widget.studentName!,
        );
      },
      text: widget.studentName!,
      options: FFButtonOptions(
        width: 110.0,
        height: 30.0,
        padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
        color: Color(0x00FFFFFF),
        textStyle: FlutterFlowTheme.of(context).titleSmall.override(
              font: GoogleFonts.notoSansKr(
                fontWeight: FontWeight.bold,
                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
              ),
              color: widget.studentId == widget.selectedStudentId
                  ? Color(0xFF0064A7)
                  : Color(0xFF666666),
              fontSize: 16.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.bold,
              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}
