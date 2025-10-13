import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dahsboard_master_widget.dart' show DahsboardMasterWidget;
import 'package:flutter/material.dart';

class DahsboardMasterModel extends FlutterFlowModel<DahsboardMasterWidget> {
  ///  Local state fields for this page.

  List<String> isSelectSubject = ['1학년', '2학년', '3학년', '4학년', '5학년'];
  void addToIsSelectSubject(String item) => isSelectSubject.add(item);
  void removeFromIsSelectSubject(String item) => isSelectSubject.remove(item);
  void removeAtIndexFromIsSelectSubject(int index) =>
      isSelectSubject.removeAt(index);
  void insertAtIndexInIsSelectSubject(int index, String item) =>
      isSelectSubject.insert(index, item);
  void updateIsSelectSubjectAtIndex(int index, Function(String) updateFn) =>
      isSelectSubject[index] = updateFn(isSelectSubject[index]);

  List<String> isSelectProfessor = [
    '건축_1분반',
    '건축_2분반',
    '건축_3분반',
    '서양건축사',
    '건축 기획',
    '건축 구조'
  ];
  void addToIsSelectProfessor(String item) => isSelectProfessor.add(item);
  void removeFromIsSelectProfessor(String item) =>
      isSelectProfessor.remove(item);
  void removeAtIndexFromIsSelectProfessor(int index) =>
      isSelectProfessor.removeAt(index);
  void insertAtIndexInIsSelectProfessor(int index, String item) =>
      isSelectProfessor.insert(index, item);
  void updateIsSelectProfessorAtIndex(int index, Function(String) updateFn) =>
      isSelectProfessor[index] = updateFn(isSelectProfessor[index]);

  bool isButtonClicked = true;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown1 widget.
  String? dropDown1Value1;
  FormFieldController<String>? dropDown1ValueController1;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value1;
  FormFieldController<String>? dropDown2ValueController1;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value2;
  FormFieldController<String>? dropDown1ValueController2;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value2;
  FormFieldController<String>? dropDown2ValueController2;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value3;
  FormFieldController<String>? dropDown1ValueController3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
