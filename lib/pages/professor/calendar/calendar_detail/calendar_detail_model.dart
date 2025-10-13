import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'calendar_detail_widget.dart' show CalendarDetailWidget;
import 'package:flutter/material.dart';

class CalendarDetailModel extends FlutterFlowModel<CalendarDetailWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode1;
  TextEditingController? fullNameTextFieldTextController1;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController1Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode2;
  TextEditingController? fullNameTextFieldTextController2;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController2Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode3;
  TextEditingController? fullNameTextFieldTextController3;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController3Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode4;
  TextEditingController? fullNameTextFieldTextController4;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController4Validator;

  @override
  void initState(BuildContext context) {
    naviSidebarModel = createModel(context, () => NaviSidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    leftWidgetModel = createModel(context, () => LeftWidgetModel());
  }

  @override
  void dispose() {
    naviSidebarModel.dispose();
    headerModel.dispose();
    leftWidgetModel.dispose();
    fullNameTextFieldFocusNode1?.dispose();
    fullNameTextFieldTextController1?.dispose();

    fullNameTextFieldFocusNode2?.dispose();
    fullNameTextFieldTextController2?.dispose();

    fullNameTextFieldFocusNode3?.dispose();
    fullNameTextFieldTextController3?.dispose();

    fullNameTextFieldFocusNode4?.dispose();
    fullNameTextFieldTextController4?.dispose();
  }
}
