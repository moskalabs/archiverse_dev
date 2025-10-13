import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'account_manage_row_mobile_widget.dart'
    show AccountManageRowMobileWidget;
import 'package:flutter/material.dart';

class AccountManageRowMobileModel
    extends FlutterFlowModel<AccountManageRowMobileWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  bool isEditing = false;

  Map<String, dynamic> editedData = {};

  FocusNode? nameFocusNode;

  TextEditingController? nameTextController;

  FocusNode? phoneFocusNode;

  TextEditingController? phoneTextController;

  bool isSaving = false;

  @override
  void initState(BuildContext context) {
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
    phoneFocusNode?.dispose();
    phoneTextController?.dispose();
  }
}
