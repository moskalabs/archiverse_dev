import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'student_dashboard_widget.dart' show StudentDashboardWidget;
import 'package:flutter/material.dart';

class StudentDashboardModel extends FlutterFlowModel<StudentDashboardWidget> {
  ///  Local state fields for this page.

  String? years = '2025';

  String? semester = '1학기';

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

  int? courseSelected = 99;

  ProfessorsRow? professorrowoutput;

  bool sectionClicked = false;

  /// 마이프로필에서 text로 받은, grade 정보 integer로 바꿔서 넣으려고 만듬
  int? gradeToInteger = -1;

  /// class 테이블에서, 소팅된 리스트 값 가져와
  List<ClassRow> classList = [];
  void addToClassList(ClassRow item) => classList.add(item);
  void removeFromClassList(ClassRow item) => classList.remove(item);
  void removeAtIndexFromClassList(int index) => classList.removeAt(index);
  void insertAtIndexInClassList(int index, ClassRow item) =>
      classList.insert(index, item);
  void updateClassListAtIndex(int index, Function(ClassRow) updateFn) =>
      classList[index] = updateFn(classList[index]);

  /// student subejct 주차별 제출한거 개수 가져오자
  int? progressSubject = 0;

  /// chart 데이터 들어갈 리스트
  List<int> chartDataParam = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  void addToChartDataParam(int item) => chartDataParam.add(item);
  void removeFromChartDataParam(int item) => chartDataParam.remove(item);
  void removeAtIndexFromChartDataParam(int index) =>
      chartDataParam.removeAt(index);
  void insertAtIndexInChartDataParam(int index, int item) =>
      chartDataParam.insert(index, item);
  void updateChartDataParamAtIndex(int index, Function(int) updateFn) =>
      chartDataParam[index] = updateFn(chartDataParam[index]);

  bool channelTalk = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in StudentDashboard widget.
  List<StudentMyprofileRow>? studentProfileOutput;
  // Stores action output result for [Backend Call - Query Rows] action in StudentDashboard widget.
  List<ClassRow>? studentClassOutput;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value1;
  FormFieldController<String>? dropDown1ValueController1;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value1;
  FormFieldController<String>? dropDown2ValueController1;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown2 widget.
  List<YearsRow>? yearoutput;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown2 widget.
  List<SemestersRow>? semesteroutput;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered3 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered4 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput1;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<SubjectportpolioRow>? progressoutput1ICON;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered5 = false;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value2;
  FormFieldController<String>? dropDown1ValueController2;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value2;
  FormFieldController<String>? dropDown2ValueController2;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown2 widget.
  List<YearsRow>? yearoutputA;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown2 widget.
  List<SemestersRow>? semesteroutputA;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered7 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered8 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered9 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput1A;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<SubjectportpolioRow>? progressoutput1ICONA;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered10 = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
