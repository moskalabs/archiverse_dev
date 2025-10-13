import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dahsboard_general_widget.dart' show DahsboardGeneralWidget;
import 'package:flutter/material.dart';

class DahsboardGeneralModel extends FlutterFlowModel<DahsboardGeneralWidget> {
  ///  Local state fields for this page.

  String? years = '2025';

  String? semester = '1학기';

  Color? buttonColor1 = Color(4294967295);

  Color? buttonColor2 = Color(4294967295);

  Color? buttonColor3 = Color(4294967295);

  Color? buttonColor4 = Color(4294967295);

  Color? buttonColor5 = Color(4294967295);

  Color? textColor1 = Color(4280831605);

  Color? textColor2 = Color(4280831605);

  Color? textColor3 = Color(4280831605);

  Color? textColor4 = Color(4280831605);

  Color? textColor5 = Color(4280831605);

  int? buttonGrades;

  List<SemestersGradesMapRow> semesterGradeOutput = [];
  void addToSemesterGradeOutput(SemestersGradesMapRow item) =>
      semesterGradeOutput.add(item);
  void removeFromSemesterGradeOutput(SemestersGradesMapRow item) =>
      semesterGradeOutput.remove(item);
  void removeAtIndexFromSemesterGradeOutput(int index) =>
      semesterGradeOutput.removeAt(index);
  void insertAtIndexInSemesterGradeOutput(
          int index, SemestersGradesMapRow item) =>
      semesterGradeOutput.insert(index, item);
  void updateSemesterGradeOutputAtIndex(
          int index, Function(SemestersGradesMapRow) updateFn) =>
      semesterGradeOutput[index] = updateFn(semesterGradeOutput[index]);

  List<YearsSemesterMapRow> yearsSemesterMapOutput = [];
  void addToYearsSemesterMapOutput(YearsSemesterMapRow item) =>
      yearsSemesterMapOutput.add(item);
  void removeFromYearsSemesterMapOutput(YearsSemesterMapRow item) =>
      yearsSemesterMapOutput.remove(item);
  void removeAtIndexFromYearsSemesterMapOutput(int index) =>
      yearsSemesterMapOutput.removeAt(index);
  void insertAtIndexInYearsSemesterMapOutput(
          int index, YearsSemesterMapRow item) =>
      yearsSemesterMapOutput.insert(index, item);
  void updateYearsSemesterMapOutputAtIndex(
          int index, Function(YearsSemesterMapRow) updateFn) =>
      yearsSemesterMapOutput[index] = updateFn(yearsSemesterMapOutput[index]);

  List<GradesCoursesMapRow> courseBySelectOutputVar = [];
  void addToCourseBySelectOutputVar(GradesCoursesMapRow item) =>
      courseBySelectOutputVar.add(item);
  void removeFromCourseBySelectOutputVar(GradesCoursesMapRow item) =>
      courseBySelectOutputVar.remove(item);
  void removeAtIndexFromCourseBySelectOutputVar(int index) =>
      courseBySelectOutputVar.removeAt(index);
  void insertAtIndexInCourseBySelectOutputVar(
          int index, GradesCoursesMapRow item) =>
      courseBySelectOutputVar.insert(index, item);
  void updateCourseBySelectOutputVarAtIndex(
          int index, Function(GradesCoursesMapRow) updateFn) =>
      courseBySelectOutputVar[index] = updateFn(courseBySelectOutputVar[index]);

  List<CoursesSectionsMapRow> courseSectionOutputVar = [];
  void addToCourseSectionOutputVar(CoursesSectionsMapRow item) =>
      courseSectionOutputVar.add(item);
  void removeFromCourseSectionOutputVar(CoursesSectionsMapRow item) =>
      courseSectionOutputVar.remove(item);
  void removeAtIndexFromCourseSectionOutputVar(int index) =>
      courseSectionOutputVar.removeAt(index);
  void insertAtIndexInCourseSectionOutputVar(
          int index, CoursesSectionsMapRow item) =>
      courseSectionOutputVar.insert(index, item);
  void updateCourseSectionOutputVarAtIndex(
          int index, Function(CoursesSectionsMapRow) updateFn) =>
      courseSectionOutputVar[index] = updateFn(courseSectionOutputVar[index]);

  bool courseSelected1 = false;

  ProfessorsRow? professorrowoutput;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown1 widget.
  String? dropDown1Value;
  FormFieldController<String>? dropDown1ValueController;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value;
  FormFieldController<String>? dropDown2ValueController;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown2 widget.
  List<YearsSemesterMapRow>? horizontaloutput;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<ProfessorsRow>? professornamerowoutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<ProfessorsRow>? professornamerowoutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<ProfessorsRow>? professornamerowoutput3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<ProfessorsRow>? professornamerowoutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput5;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput5;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<ProfessorsRow>? professornamerowoutput5;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput5;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
