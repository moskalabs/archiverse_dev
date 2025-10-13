import '/flutter_flow/flutter_flow_util.dart';
import 'degree_input_widget.dart' show DegreeInputWidget;
import 'package:flutter/material.dart';

class DegreeInputModel extends FlutterFlowModel<DegreeInputWidget> {
  ///  Local state fields for this component.

  dynamic degreeList;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField1 widget.
  FocusNode? textField1FocusNode;
  TextEditingController? textField1TextController;
  String? Function(BuildContext, String?)? textField1TextControllerValidator;
  DateTime? datePicked;
  // State field(s) for TextField2 widget.
  FocusNode? textField2FocusNode;
  TextEditingController? textField2TextController;
  String? Function(BuildContext, String?)? textField2TextControllerValidator;
  // State field(s) for TextField3 widget.
  FocusNode? textField3FocusNode;
  TextEditingController? textField3TextController;
  String? Function(BuildContext, String?)? textField3TextControllerValidator;
  // State field(s) for TextField4 widget.
  FocusNode? textField4FocusNode;
  TextEditingController? textField4TextController;
  String? Function(BuildContext, String?)? textField4TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textField1FocusNode?.dispose();
    textField1TextController?.dispose();

    textField2FocusNode?.dispose();
    textField2TextController?.dispose();

    textField3FocusNode?.dispose();
    textField3TextController?.dispose();

    textField4FocusNode?.dispose();
    textField4TextController?.dispose();
  }
}
