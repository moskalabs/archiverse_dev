import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dahsboard_widget.dart' show DahsboardWidget;
import 'package:flutter/material.dart';

class DahsboardModel extends FlutterFlowModel<DahsboardWidget> {
  ///  Local state fields for this page.

  Color? buttonColor5 = Color(4294967295);

  Color? textColor5 = Color(4280831605);

  Color? buttonColor4 = Color(4294967295);

  Color? textColor4 = Color(4280831605);

  String? years = '2025';

  String? semester = '1학기';

  Color? buttonColor3 = Color(4294967295);

  Color? buttonColor2 = Color(4294967295);

  Color? buttonColor1 = Color(4294967295);

  Color? textColor3 = Color(4280831605);

  Color? textColor2 = Color(4280831605);

  Color? textColor1 = Color(4280831605);

  String? year;

  int? buttonGrades;

  bool? courseSelected1;

  bool? courseSelected2;

  bool? courseSelected3;

  bool? courseSelected4;

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

  List<GradesCoursesMapRow> courseBySelectOutputV = [];
  void addToCourseBySelectOutputV(GradesCoursesMapRow item) =>
      courseBySelectOutputV.add(item);
  void removeFromCourseBySelectOutputV(GradesCoursesMapRow item) =>
      courseBySelectOutputV.remove(item);
  void removeAtIndexFromCourseBySelectOutputV(int index) =>
      courseBySelectOutputV.removeAt(index);
  void insertAtIndexInCourseBySelectOutputV(
          int index, GradesCoursesMapRow item) =>
      courseBySelectOutputV.insert(index, item);
  void updateCourseBySelectOutputVAtIndex(
          int index, Function(GradesCoursesMapRow) updateFn) =>
      courseBySelectOutputV[index] = updateFn(courseBySelectOutputV[index]);

  List<CoursesSectionsMapRow> courseSectionOutputV = [];
  void addToCourseSectionOutputV(CoursesSectionsMapRow item) =>
      courseSectionOutputV.add(item);
  void removeFromCourseSectionOutputV(CoursesSectionsMapRow item) =>
      courseSectionOutputV.remove(item);
  void removeAtIndexFromCourseSectionOutputV(int index) =>
      courseSectionOutputV.removeAt(index);
  void insertAtIndexInCourseSectionOutputV(
          int index, CoursesSectionsMapRow item) =>
      courseSectionOutputV.insert(index, item);
  void updateCourseSectionOutputVAtIndex(
          int index, Function(CoursesSectionsMapRow) updateFn) =>
      courseSectionOutputV[index] = updateFn(courseSectionOutputV[index]);

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
  List<GradesCoursesMapRow>? courseBySelectOutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<CoursesSectionsMapRow>? courseSectionOutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<CoursesSectionsMapRow>? courseSectionOutput2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput3Copy;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<CoursesSectionsMapRow>? courseSectionOutput3Copy;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<CoursesSectionsMapRow>? courseSectionOutput4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<SemestersGradesMapRow>? semesterIdGradeoutput5;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<YearsSemesterMapRow>? semesteridMapidoutput5;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<GradesCoursesMapRow>? courseBySelectOutput5;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<CoursesSectionsMapRow>? courseSectionOutput5;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered3 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered4 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered5 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered7 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered8 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered9 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered10 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered11 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered12 = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
