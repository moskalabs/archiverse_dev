import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'attendance_delete_pop_up_widget.dart' show AttendanceDeletePopUpWidget;
import 'package:flutter/material.dart';

class AttendanceDeletePopUpModel
    extends FlutterFlowModel<AttendanceDeletePopUpWidget> {
  ///  Local state fields for this component.

  bool deleteSelected = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<AttendanceRow>? deletattendencerow;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
