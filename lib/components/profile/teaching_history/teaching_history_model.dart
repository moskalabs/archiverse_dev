import '/flutter_flow/flutter_flow_util.dart';
import 'teaching_history_widget.dart' show TeachingHistoryWidget;
import 'package:flutter/material.dart';

class TeachingHistoryModel extends FlutterFlowModel<TeachingHistoryWidget> {
  ///  Local state fields for this component.
  /// 기간
  String? period;

  /// 기간_끝나는
  String? period2;

  List<dynamic> teachinglist = [];
  void addToTeachinglist(dynamic item) => teachinglist.add(item);
  void removeFromTeachinglist(dynamic item) => teachinglist.remove(item);
  void removeAtIndexFromTeachinglist(int index) => teachinglist.removeAt(index);
  void insertAtIndexInTeachinglist(int index, dynamic item) =>
      teachinglist.insert(index, item);
  void updateTeachinglistAtIndex(int index, Function(dynamic) updateFn) =>
      teachinglist[index] = updateFn(teachinglist[index]);

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  DateTime? datePicked1;
  DateTime? datePicked2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode4;
  TextEditingController? textController4;
  String? Function(BuildContext, String?)? textController4Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    textFieldFocusNode3?.dispose();
    textController3?.dispose();

    textFieldFocusNode4?.dispose();
    textController4?.dispose();
  }
}
