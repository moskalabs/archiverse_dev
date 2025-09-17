import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dahsboard_vice_widget.dart' show DahsboardViceWidget;
import 'package:flutter/material.dart';

class DahsboardViceModel extends FlutterFlowModel<DahsboardViceWidget> {
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

  int? buttonGrades = -1;

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

  int? courseSelected = -1;

  ProfessorsRow? professorrowoutput;

  CoursesSectionsMapRow? courseSectionNameoutput;

  /// 클래스 테이블 시작시
  List<ClassRow> classOnload = [];
  void addToClassOnload(ClassRow item) => classOnload.add(item);
  void removeFromClassOnload(ClassRow item) => classOnload.remove(item);
  void removeAtIndexFromClassOnload(int index) => classOnload.removeAt(index);
  void insertAtIndexInClassOnload(int index, ClassRow item) =>
      classOnload.insert(index, item);
  void updateClassOnloadAtIndex(int index, Function(ClassRow) updateFn) =>
      classOnload[index] = updateFn(classOnload[index]);

  /// 교수님 이름
  String? profeesorName;

  /// 학년 클릭 후, row
  List<ClassRow> classAfterGrade = [];
  void addToClassAfterGrade(ClassRow item) => classAfterGrade.add(item);
  void removeFromClassAfterGrade(ClassRow item) => classAfterGrade.remove(item);
  void removeAtIndexFromClassAfterGrade(int index) =>
      classAfterGrade.removeAt(index);
  void insertAtIndexInClassAfterGrade(int index, ClassRow item) =>
      classAfterGrade.insert(index, item);
  void updateClassAfterGradeAtIndex(int index, Function(ClassRow) updateFn) =>
      classAfterGrade[index] = updateFn(classAfterGrade[index]);

  /// 과목 클릭 후, row
  List<ClassRow> classAfterCourse = [];
  void addToClassAfterCourse(ClassRow item) => classAfterCourse.add(item);
  void removeFromClassAfterCourse(ClassRow item) =>
      classAfterCourse.remove(item);
  void removeAtIndexFromClassAfterCourse(int index) =>
      classAfterCourse.removeAt(index);
  void insertAtIndexInClassAfterCourse(int index, ClassRow item) =>
      classAfterCourse.insert(index, item);
  void updateClassAfterCourseAtIndex(int index, Function(ClassRow) updateFn) =>
      classAfterCourse[index] = updateFn(classAfterCourse[index]);

  /// 진행바 비율 계산시 사용_클래스에서 분반 별 8명 기준, 낸 횟수 여기에 저장.
  int? progressSubject = 0;

  List<int> chartDataParam = [0, 0, 0, 0, 0, 0, 0, 0];
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

  // Stores action output result for [Backend Call - Query Rows] action in Dahsboard_Vice widget.
  List<ProfessorsRow>? professorRowoutput;
  // Stores action output result for [Backend Call - Query Rows] action in Dahsboard_Vice widget.
  List<PostsRow>? prfoutput;
  // Stores action output result for [Backend Call - Query Rows] action in Dahsboard_Vice widget.
  List<ClassRow>? classSelectedOnload;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value1;
  FormFieldController<String>? dropDown1ValueController1;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value1;
  FormFieldController<String>? dropDown2ValueController1;
  // Stores action output result for [Backend Call - Query Rows] action in DropDown2 widget.
  List<YearsSemesterMapRow>? horizontaloutput;
  // State field(s) for PageView widget.
  PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
          pageViewController1!.hasClients &&
          pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput1;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput2;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered3 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput3;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered4 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered5 = false;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value2;
  FormFieldController<String>? dropDown1ValueController2;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value2;
  FormFieldController<String>? dropDown2ValueController2;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput1A;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered7 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput2A;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered8 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput3A;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered9 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered10 = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
