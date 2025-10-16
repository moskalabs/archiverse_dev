import '/backend/supabase/supabase.dart';
import '/components/class_change/class_change_row/class_change_row_widget.dart';
import '/components/class_change/class_change_row_mobile/class_change_row_mobile_widget.dart';
import '/components/default_layout/borderline/borderline_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/nav_bar/admin_navi_sidebar/admin_navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'admin_class_change_widget.dart' show AdminClassChangeWidget;
import 'package:flutter/material.dart';

class AdminClassChangeModel extends FlutterFlowModel<AdminClassChangeWidget> {
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
  List<int> chartDataParam = [];
  void addToChartDataParam(int item) => chartDataParam.add(item);
  void removeFromChartDataParam(int item) => chartDataParam.remove(item);
  void removeAtIndexFromChartDataParam(int index) =>
      chartDataParam.removeAt(index);
  void insertAtIndexInChartDataParam(int index, int item) =>
      chartDataParam.insert(index, item);
  void updateChartDataParamAtIndex(int index, Function(int) updateFn) =>
      chartDataParam[index] = updateFn(chartDataParam[index]);

  bool channelTalk = false;

  /// 학년 선택에 따른 과목 정해진것
  String? courseSelectedByGrade;

  bool isSearching = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in AdminClassChange widget.
  List<PostsRow>? prfoutput;
  // Stores action output result for [Backend Call - Query Rows] action in AdminClassChange widget.
  List<ClassRow>? classSelectedOnload;
  // 학생 전공/분반 변경 요청 목록
  List<StudentMajorChangeRequestsRow>? changeRequests;
  // Model for AdminNaviSidebar component.
  late AdminNaviSidebarModel adminNaviSidebarModel;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value;
  FormFieldController<String>? dropDown1ValueController;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value;
  FormFieldController<String>? dropDown2ValueController;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for SearchTextField widget.
  FocusNode? searchTextFieldFocusNode;
  TextEditingController? searchTextFieldTextController;
  String? Function(BuildContext, String?)?
      searchTextFieldTextControllerValidator;
  // Model for Borderline component.
  late BorderlineModel borderlineModel1;
  // Model for Borderline component.
  late BorderlineModel borderlineModel2;
  // Model for ClassChangeRow component.
  late ClassChangeRowModel classChangeRowModel;
  // Model for Borderline component.
  late BorderlineModel borderlineModel3;
  // Model for Borderline component.
  late BorderlineModel borderlineModel4;
  // Model for Header_Mobile component.
  late HeaderMobileModel headerMobileModel;
  // State field(s) for DropDown_Year widget.
  String? dropDownYearValue;
  FormFieldController<String>? dropDownYearValueController;
  // State field(s) for DropDown_Semester widget.
  String? dropDownSemesterValue;
  FormFieldController<String>? dropDownSemesterValueController;
  // Model for Borderline component.
  late BorderlineModel borderlineModel5;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for Borderline component.
  late BorderlineModel borderlineModel6;
  // Model for Borderline component.
  late BorderlineModel borderlineModel7;
  // Model for ClassChangeRow_Mobile component.
  late ClassChangeRowMobileModel classChangeRowMobileModel;
  // Model for Borderline component.
  late BorderlineModel borderlineModel8;
  // Model for Borderline component.
  late BorderlineModel borderlineModel9;

  @override
  void initState(BuildContext context) {
    adminNaviSidebarModel = createModel(context, () => AdminNaviSidebarModel());
    borderlineModel1 = createModel(context, () => BorderlineModel());
    borderlineModel2 = createModel(context, () => BorderlineModel());
    classChangeRowModel = createModel(context, () => ClassChangeRowModel());
    borderlineModel3 = createModel(context, () => BorderlineModel());
    borderlineModel4 = createModel(context, () => BorderlineModel());
    headerMobileModel = createModel(context, () => HeaderMobileModel());
    borderlineModel5 = createModel(context, () => BorderlineModel());
    borderlineModel6 = createModel(context, () => BorderlineModel());
    borderlineModel7 = createModel(context, () => BorderlineModel());
    classChangeRowMobileModel =
        createModel(context, () => ClassChangeRowMobileModel());
    borderlineModel8 = createModel(context, () => BorderlineModel());
    borderlineModel9 = createModel(context, () => BorderlineModel());
  }

  @override
  void dispose() {
    adminNaviSidebarModel.dispose();
    searchTextFieldFocusNode?.dispose();
    searchTextFieldTextController?.dispose();

    borderlineModel1.dispose();
    borderlineModel2.dispose();
    classChangeRowModel.dispose();
    borderlineModel3.dispose();
    borderlineModel4.dispose();
    headerMobileModel.dispose();
    borderlineModel5.dispose();
    textFieldFocusNode?.dispose();
    textController2?.dispose();

    borderlineModel6.dispose();
    borderlineModel7.dispose();
    classChangeRowMobileModel.dispose();
    borderlineModel8.dispose();
    borderlineModel9.dispose();
  }
}
