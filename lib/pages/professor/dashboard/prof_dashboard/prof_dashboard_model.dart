import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'prof_dashboard_widget.dart' show ProfDashboardWidget;
import 'package:flutter/material.dart';

class ProfDashboardModel extends FlutterFlowModel<ProfDashboardWidget> {
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

  int? courseSelected = -1;

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

  /// 학년 선택 하고 나서, 분반 교수님들과 분반의 정보를 알기위한 변수 설정
  List<ClassRow> classAfterGradeByCourseForSection = [];
  void addToClassAfterGradeByCourseForSection(ClassRow item) =>
      classAfterGradeByCourseForSection.add(item);
  void removeFromClassAfterGradeByCourseForSection(ClassRow item) =>
      classAfterGradeByCourseForSection.remove(item);
  void removeAtIndexFromClassAfterGradeByCourseForSection(int index) =>
      classAfterGradeByCourseForSection.removeAt(index);
  void insertAtIndexInClassAfterGradeByCourseForSection(
          int index, ClassRow item) =>
      classAfterGradeByCourseForSection.insert(index, item);
  void updateClassAfterGradeByCourseForSectionAtIndex(
          int index, Function(ClassRow) updateFn) =>
      classAfterGradeByCourseForSection[index] =
          updateFn(classAfterGradeByCourseForSection[index]);

  /// 학년까지 선택하고, 전임교수가 담당하고 있는 과목들과 같은, 다른 교수들의 row 가져오기 위한, 전임 교수 담당 과목 제목들
  List<String> courseNameForOtherPfr = [];
  void addToCourseNameForOtherPfr(String item) =>
      courseNameForOtherPfr.add(item);
  void removeFromCourseNameForOtherPfr(String item) =>
      courseNameForOtherPfr.remove(item);
  void removeAtIndexFromCourseNameForOtherPfr(int index) =>
      courseNameForOtherPfr.removeAt(index);
  void insertAtIndexInCourseNameForOtherPfr(int index, String item) =>
      courseNameForOtherPfr.insert(index, item);
  void updateCourseNameForOtherPfrAtIndex(
          int index, Function(String) updateFn) =>
      courseNameForOtherPfr[index] = updateFn(courseNameForOtherPfr[index]);

  /// 진행바 비율 계산시 사용_클래스에서 분반 별 8명 기준, 낸 횟수 여기에 저장.
  ///
  /// 여기 숫자는, 1,2,3반 모두 낸거 주차별 상관없이 모두 들어온다
  int progressSubject = 0;

  /// 차트 데이터 파라미터에 들어갈 리스트 값
  List<int> chartDataParam = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  void addToChartDataParam(int item) => chartDataParam.add(item);
  void removeFromChartDataParam(int item) => chartDataParam.remove(item);
  void removeAtIndexFromChartDataParam(int index) =>
      chartDataParam.removeAt(index);
  void insertAtIndexInChartDataParam(int index, int item) =>
      chartDataParam.insert(index, item);
  void updateChartDataParamAtIndex(int index, Function(int) updateFn) =>
      chartDataParam[index] = updateFn(chartDataParam[index]);

  /// 과목 포트폴리오 제출 수
  int progressSubjectPortfolio = 0;

  /// 1차 성과물 (중간) 제출 수
  int progressMidterm = 0;

  /// 2차 성과물 (기말) 제출 수
  int progressFinal = 0;

  /// 분반별 학생 수
  int studentCount = 0;

  bool channelTalk = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_Dashboard widget.
  List<PostsRow>? prfoutput;
  // Stores action output result for [Backend Call - Query Rows] action in Prof_Dashboard widget.
  List<ClassRow>? classSelectedOnload;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value1;
  FormFieldController<String>? dropDown1ValueController1;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value1;
  FormFieldController<String>? dropDown2ValueController1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<ClassRow>? forSectionPrfname1;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<ClassRow>? forSectionPrfname2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<ClassRow>? forSectionPrfname3;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<ClassRow>? forSectionPrfname4;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<ClassRow>? forSectionPrfname5;
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
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered7 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered8 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered9 = false;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value2;
  FormFieldController<String>? dropDown1ValueController2;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value2;
  FormFieldController<String>? dropDown2ValueController2;
  // Stores action output result for [Backend Call - Query Rows] action in Button_1 widget.
  List<ClassRow>? forSectionPrfname11;
  // Stores action output result for [Backend Call - Query Rows] action in Button_2 widget.
  List<ClassRow>? forSectionPrfname21;
  // Stores action output result for [Backend Call - Query Rows] action in Button_3 widget.
  List<ClassRow>? forSectionPrfname31;
  // Stores action output result for [Backend Call - Query Rows] action in Button_4 widget.
  List<ClassRow>? forSectionPrfname41;
  // Stores action output result for [Backend Call - Query Rows] action in Button_5 widget.
  List<ClassRow>? forSectionPrfname51;
  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered10 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput1A;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered11 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput2A;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered12 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Text widget.
  List<SubjectportpolioRow>? progressoutput3A;
  // State field(s) for PageView widget.
  PageController? pageViewController3;

  int get pageViewCurrentIndex3 => pageViewController3 != null &&
          pageViewController3!.hasClients &&
          pageViewController3!.page != null
      ? pageViewController3!.page!.round()
      : 0;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered13 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered14 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered15 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered16 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered17 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered18 = false;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
