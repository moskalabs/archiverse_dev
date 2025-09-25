import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'student_submit_button_model.dart';
export 'student_submit_button_model.dart';

class StudentSubmitButtonWidget extends StatefulWidget {
  const StudentSubmitButtonWidget({
    super.key,
    this.student,
    bool? isSelected,
    this.selectedStudentID,
  }) : this.isSelected = isSelected ?? false;

  final StudentMyprofileRow? student;
  final bool isSelected;
  final Future Function(int studentID)? selectedStudentID;

  @override
  State<StudentSubmitButtonWidget> createState() =>
      _StudentSubmitButtonWidgetState();
}

class _StudentSubmitButtonWidgetState extends State<StudentSubmitButtonWidget> {
  late StudentSubmitButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentSubmitButtonModel());

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
      height: 45.0,
      decoration: BoxDecoration(
        color: widget.isSelected ? Color(0xFF666666) : Colors.white,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(
          color: Color(0x7F666666),
        ),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              valueOrDefault<String>(
                widget.student?.name,
                '홍길동',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color:
                        widget.isSelected ? Colors.white : Color(0xFF666666),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
            Text(
              valueOrDefault<String>(
                widget.student?.id.toString(),
                '12345678',
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.inter(
                      fontWeight: FontWeight.normal,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    color:
                        widget.isSelected ? Colors.white : Color(0xFF666666),
                    fontSize: 22.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
