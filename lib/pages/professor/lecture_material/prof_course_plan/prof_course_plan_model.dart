import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prof_course_plan_widget.dart' show ProfCoursePlanWidget;
import 'package:flutter/material.dart';

class ProfCoursePlanModel extends FlutterFlowModel<ProfCoursePlanWidget> {
  ///  Local state fields for this page.

  bool? coursenameButtonClicked = false;

  bool? fileButtonClicked = false;

  bool? uploadClicked = false;

  bool deleteClicked = false;

  /// 수업계획서 리스트_슈퍼베이스에서
  CourseplanRow? planList;

  int? selectedClassid;

  String? uploadedFileExtractName;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_CoursePlan widget.
  List<CourseplanRow>? coursePlanRow;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  CourseplanRow? planListReturn;
  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered3 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered4 = false;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  CourseplanRow? planListReturnMobile;
  // Model for NaviSidebar_Mobile component.
  late NaviSidebarMobileModel naviSidebarMobileModel;

  @override
  void initState(BuildContext context) {
    naviSidebarModel = createModel(context, () => NaviSidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    leftWidgetModel = createModel(context, () => LeftWidgetModel());
    rightWidgetModel = createModel(context, () => RightWidgetModel());
    studentHeaderMobileModel =
        createModel(context, () => StudentHeaderMobileModel());
    naviSidebarMobileModel =
        createModel(context, () => NaviSidebarMobileModel());
  }

  @override
  void dispose() {
    naviSidebarModel.dispose();
    headerModel.dispose();
    leftWidgetModel.dispose();
    rightWidgetModel.dispose();
    studentHeaderMobileModel.dispose();
    naviSidebarMobileModel.dispose();
  }
}
