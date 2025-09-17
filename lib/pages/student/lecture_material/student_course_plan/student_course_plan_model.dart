import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/student_header/student_header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/student_left_widget/student_left_widget_widget.dart';
import '/components/default_layout/left_right/student_right_widget/student_right_widget_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar/student_navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar_mobile/student_navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'student_course_plan_widget.dart' show StudentCoursePlanWidget;
import 'package:flutter/material.dart';

class StudentCoursePlanModel extends FlutterFlowModel<StudentCoursePlanWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in StudentCoursePlan widget.
  List<CourseplanRow>? courseplanrow;
  // Model for StudentNaviSidebar component.
  late StudentNaviSidebarModel studentNaviSidebarModel;
  // Model for StudentHeader component.
  late StudentHeaderModel studentHeaderModel;
  // Model for StudentLeftWidget component.
  late StudentLeftWidgetModel studentLeftWidgetModel;
  // Model for StudentRightWidget component.
  late StudentRightWidgetModel studentRightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // Model for StudentNaviSidebar_Mobile component.
  late StudentNaviSidebarMobileModel studentNaviSidebarMobileModel;

  @override
  void initState(BuildContext context) {
    studentNaviSidebarModel =
        createModel(context, () => StudentNaviSidebarModel());
    studentHeaderModel = createModel(context, () => StudentHeaderModel());
    studentLeftWidgetModel =
        createModel(context, () => StudentLeftWidgetModel());
    studentRightWidgetModel =
        createModel(context, () => StudentRightWidgetModel());
    studentHeaderMobileModel =
        createModel(context, () => StudentHeaderMobileModel());
    studentNaviSidebarMobileModel =
        createModel(context, () => StudentNaviSidebarMobileModel());
  }

  @override
  void dispose() {
    studentNaviSidebarModel.dispose();
    studentHeaderModel.dispose();
    studentLeftWidgetModel.dispose();
    studentRightWidgetModel.dispose();
    studentHeaderMobileModel.dispose();
    studentNaviSidebarMobileModel.dispose();
  }
}
