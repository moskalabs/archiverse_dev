import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'delete_pop_up_copy_widget.dart' show DeletePopUpCopyWidget;
import 'package:flutter/material.dart';

class DeletePopUpCopyModel extends FlutterFlowModel<DeletePopUpCopyWidget> {
  ///  Local state fields for this component.

  bool deleteSelected = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<CourseplanRow>? deletecourseplanrow;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
