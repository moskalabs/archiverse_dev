import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'course_plan_delete_pop_up_widget.dart' show CoursePlanDeletePopUpWidget;
import 'package:flutter/material.dart';

class CoursePlanDeletePopUpModel
    extends FlutterFlowModel<CoursePlanDeletePopUpWidget> {
  ///  Local state fields for this component.

  bool deleteSelected = false;

  /// 삭제될 계획서의 DB Row
  CourseplanRow? coursePlanRow;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<CourseplanRow>? deletedPlanRow;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
