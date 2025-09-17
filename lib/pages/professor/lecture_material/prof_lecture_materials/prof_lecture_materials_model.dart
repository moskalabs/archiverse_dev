import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prof_lecture_materials_widget.dart' show ProfLectureMaterialsWidget;
import 'package:flutter/material.dart';

class ProfLectureMaterialsModel
    extends FlutterFlowModel<ProfLectureMaterialsWidget> {
  ///  Local state fields for this page.

  bool fileButtonClicked = false;

  bool? uploadClicked = false;

  bool deleteClicked = false;

  List<LecturematerialRow> lecturematerialList = [];
  void addToLecturematerialList(LecturematerialRow item) =>
      lecturematerialList.add(item);
  void removeFromLecturematerialList(LecturematerialRow item) =>
      lecturematerialList.remove(item);
  void removeAtIndexFromLecturematerialList(int index) =>
      lecturematerialList.removeAt(index);
  void insertAtIndexInLecturematerialList(int index, LecturematerialRow item) =>
      lecturematerialList.insert(index, item);
  void updateLecturematerialListAtIndex(
          int index, Function(LecturematerialRow) updateFn) =>
      lecturematerialList[index] = updateFn(lecturematerialList[index]);

  /// 컴포넌트 구별
  int? selectedIndex = -1;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_LectureMaterials widget.
  List<LecturematerialRow>? lecturematerialrow;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  LecturematerialRow? lectureListReturn;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<LecturematerialRow>? afterdelete;
  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  LecturematerialRow? lectureListReturnMobile;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<LecturematerialRow>? afterdeleteMobile;
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
