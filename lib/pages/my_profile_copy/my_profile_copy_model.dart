import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'my_profile_copy_widget.dart' show MyProfileCopyWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyProfileCopyModel extends FlutterFlowModel<MyProfileCopyWidget> {
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
  late MaskTextInputFormatter fullNameTextFieldMask2;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController2Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode3;
  TextEditingController? fullNameTextFieldTextController3;
  late MaskTextInputFormatter fullNameTextFieldMask3;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController3Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode4;
  TextEditingController? fullNameTextFieldTextController4;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController4Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode5;
  TextEditingController? fullNameTextFieldTextController5;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController5Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode6;
  TextEditingController? fullNameTextFieldTextController6;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController6Validator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue3;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue4;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue5;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue6;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue7;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue8;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController7;
  String? Function(BuildContext, String?)? textController7Validator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue9;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue10;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue11;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController8;
  String? Function(BuildContext, String?)? textController8Validator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue12;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue13;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue14;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue15;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController9;
  String? Function(BuildContext, String?)? textController9Validator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue16;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue17;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue18;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController10;
  String? Function(BuildContext, String?)? textController10Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode5;
  TextEditingController? textController11;
  String? Function(BuildContext, String?)? textController11Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode6;
  TextEditingController? textController12;
  String? Function(BuildContext, String?)? textController12Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode7;
  TextEditingController? textController13;
  String? Function(BuildContext, String?)? textController13Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode8;
  TextEditingController? textController14;
  String? Function(BuildContext, String?)? textController14Validator;
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
    fullNameTextFieldFocusNode1?.dispose();
    fullNameTextFieldTextController1?.dispose();

    fullNameTextFieldFocusNode2?.dispose();
    fullNameTextFieldTextController2?.dispose();

    fullNameTextFieldFocusNode3?.dispose();
    fullNameTextFieldTextController3?.dispose();

    fullNameTextFieldFocusNode4?.dispose();
    fullNameTextFieldTextController4?.dispose();

    fullNameTextFieldFocusNode5?.dispose();
    fullNameTextFieldTextController5?.dispose();

    fullNameTextFieldFocusNode6?.dispose();
    fullNameTextFieldTextController6?.dispose();

    textFieldFocusNode1?.dispose();
    textController7?.dispose();

    textFieldFocusNode2?.dispose();
    textController8?.dispose();

    textFieldFocusNode3?.dispose();
    textController9?.dispose();

    textFieldFocusNode4?.dispose();
    textController10?.dispose();

    textFieldFocusNode5?.dispose();
    textController11?.dispose();

    textFieldFocusNode6?.dispose();
    textController12?.dispose();

    textFieldFocusNode7?.dispose();
    textController13?.dispose();

    textFieldFocusNode8?.dispose();
    textController14?.dispose();

    rightWidgetModel.dispose();
  }
}
