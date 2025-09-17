import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/student_header/student_header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/student_left_widget/student_left_widget_widget.dart';
import '/components/default_layout/left_right/student_right_widget/student_right_widget_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar/student_navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar_mobile/student_navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'student_results_midterm_widget.dart' show StudentResultsMidtermWidget;
import 'package:flutter/material.dart';

class StudentResultsMidtermModel
    extends FlutterFlowModel<StudentResultsMidtermWidget> {
  ///  Local state fields for this page.

  bool refresh = false;

  bool resultsClicked = false;

  /// 중간결과물 row 올린거
  MidtermResultsRow? midResult;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in StudentResults_Midterm widget.
  List<MidtermResultsRow>? midtermrow;
  // Model for StudentNaviSidebar component.
  late StudentNaviSidebarModel studentNaviSidebarModel;
  // Model for StudentHeader component.
  late StudentHeaderModel studentHeaderModel;
  // Model for StudentLeftWidget component.
  late StudentLeftWidgetModel studentLeftWidgetModel;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  MidtermResultsRow? midListReturn;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  MidtermResultsRow? midowriteListReturn;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<MidtermResultsRow>? midlistoutput;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  MidtermResultsRow? midListReturn2;
  // Model for StudentRightWidget component.
  late StudentRightWidgetModel studentRightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  MidtermResultsRow? midListReturnMobile;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  MidtermResultsRow? midowriteListReturnMobile;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<MidtermResultsRow>? midlistoutputMobile;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  MidtermResultsRow? midListReturn2Mobile;
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
