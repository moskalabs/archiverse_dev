import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lecture_delete_pop_up_widget.dart' show LectureDeletePopUpWidget;
import 'package:flutter/material.dart';

class LectureDeletePopUpModel
    extends FlutterFlowModel<LectureDeletePopUpWidget> {
  ///  Local state fields for this component.

  bool deleteSelected = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<LecturematerialRow>? lectureselectedrow;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<LecturematerialRow>? deletelecturerow;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
