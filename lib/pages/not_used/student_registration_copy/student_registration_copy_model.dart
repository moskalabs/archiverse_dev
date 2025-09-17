import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'student_registration_copy_widget.dart'
    show StudentRegistrationCopyWidget;
import 'package:flutter/material.dart';

class StudentRegistrationCopyModel
    extends FlutterFlowModel<StudentRegistrationCopyWidget> {
  ///  Local state fields for this page.

  bool? refresh = false;

  ///  State fields for stateful widgets in this page.

  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;

  @override
  void initState(BuildContext context) {
    naviSidebarModel = createModel(context, () => NaviSidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    leftWidgetModel = createModel(context, () => LeftWidgetModel());
    rightWidgetModel = createModel(context, () => RightWidgetModel());
  }

  @override
  void dispose() {
    naviSidebarModel.dispose();
    headerModel.dispose();
    leftWidgetModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    rightWidgetModel.dispose();
  }
}
