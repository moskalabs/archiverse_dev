import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/dashboard/lecture_material/lecture_material_widget.dart';
import '/components/dashboard/progress_container_detail/progress_container_detail_widget.dart';
import '/components/dashboard/progress_container_s/progress_container_s_widget.dart';
import '/components/dashboard/progress_container_weeks/progress_container_weeks_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/nav_bar/admin_navi_sidebar/admin_navi_sidebar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'admin_dash_widget.dart' show AdminDashWidget;
import 'package:flutter/material.dart';

class AdminDashModel extends FlutterFlowModel<AdminDashWidget> {
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
  List<ClassRow> classOnLoad = [];
  void addToClassOnLoad(ClassRow item) => classOnLoad.add(item);
  void removeFromClassOnLoad(ClassRow item) => classOnLoad.remove(item);
  void removeAtIndexFromClassOnLoad(int index) => classOnLoad.removeAt(index);
  void insertAtIndexInClassOnLoad(int index, ClassRow item) =>
      classOnLoad.insert(index, item);
  void updateClassOnLoadAtIndex(int index, Function(ClassRow) updateFn) =>
      classOnLoad[index] = updateFn(classOnLoad[index]);

  /// 교수님 이름
  String? professorName;

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

  /// 설계과목 / 이론과목 탭 버튼
  bool isDesignClass = true;

  /// 탭 뷰에서 선택된 학년
  int selectedGrade = 1;

  /// 화면에 표시되는 수업들을 띄울 데이터 리스트
  List<ClassRow> filteredClass = [];
  void addToFilteredClass(ClassRow item) => filteredClass.add(item);
  void removeFromFilteredClass(ClassRow item) => filteredClass.remove(item);
  void removeAtIndexFromFilteredClass(int index) =>
      filteredClass.removeAt(index);
  void insertAtIndexInFilteredClass(int index, ClassRow item) =>
      filteredClass.insert(index, item);
  void updateFilteredClassAtIndex(int index, Function(ClassRow) updateFn) =>
      filteredClass[index] = updateFn(filteredClass[index]);

  /// 상세화면을 보여줄 선택된 수업의 ID 값
  int? selectedClassDetailID;

  List<CourseStudentRow> attendingStudents = [];
  void addToAttendingStudents(CourseStudentRow item) =>
      attendingStudents.add(item);
  void removeFromAttendingStudents(CourseStudentRow item) =>
      attendingStudents.remove(item);
  void removeAtIndexFromAttendingStudents(int index) =>
      attendingStudents.removeAt(index);
  void insertAtIndexInAttendingStudents(int index, CourseStudentRow item) =>
      attendingStudents.insert(index, item);
  void updateAttendingStudentsAtIndex(
          int index, Function(CourseStudentRow) updateFn) =>
      attendingStudents[index] = updateFn(attendingStudents[index]);

  List<CourseStudentRow> allStudents = [];
  void addToAllStudents(CourseStudentRow item) => allStudents.add(item);
  void removeFromAllStudents(CourseStudentRow item) => allStudents.remove(item);
  void removeAtIndexFromAllStudents(int index) => allStudents.removeAt(index);
  void insertAtIndexInAllStudents(int index, CourseStudentRow item) =>
      allStudents.insert(index, item);
  void updateAllStudentsAtIndex(
          int index, Function(CourseStudentRow) updateFn) =>
      allStudents[index] = updateFn(allStudents[index]);

  List<SubjectportpolioRow> portfolioPerGrade = [];
  void addToPortfolioPerGrade(SubjectportpolioRow item) =>
      portfolioPerGrade.add(item);
  void removeFromPortfolioPerGrade(SubjectportpolioRow item) =>
      portfolioPerGrade.remove(item);
  void removeAtIndexFromPortfolioPerGrade(int index) =>
      portfolioPerGrade.removeAt(index);
  void insertAtIndexInPortfolioPerGrade(int index, SubjectportpolioRow item) =>
      portfolioPerGrade.insert(index, item);
  void updatePortfolioPerGradeAtIndex(
          int index, Function(SubjectportpolioRow) updateFn) =>
      portfolioPerGrade[index] = updateFn(portfolioPerGrade[index]);

  List<CourseStudentRow> studentsByGrade = [];
  void addToStudentsByGrade(CourseStudentRow item) => studentsByGrade.add(item);
  void removeFromStudentsByGrade(CourseStudentRow item) =>
      studentsByGrade.remove(item);
  void removeAtIndexFromStudentsByGrade(int index) =>
      studentsByGrade.removeAt(index);
  void insertAtIndexInStudentsByGrade(int index, CourseStudentRow item) =>
      studentsByGrade.insert(index, item);
  void updateStudentsByGradeAtIndex(
          int index, Function(CourseStudentRow) updateFn) =>
      studentsByGrade[index] = updateFn(studentsByGrade[index]);

  List<CourseStudentRow> filteredStudents = [];
  void addToFilteredStudents(CourseStudentRow item) =>
      filteredStudents.add(item);
  void removeFromFilteredStudents(CourseStudentRow item) =>
      filteredStudents.remove(item);
  void removeAtIndexFromFilteredStudents(int index) =>
      filteredStudents.removeAt(index);
  void insertAtIndexInFilteredStudents(int index, CourseStudentRow item) =>
      filteredStudents.insert(index, item);
  void updateFilteredStudentsAtIndex(
          int index, Function(CourseStudentRow) updateFn) =>
      filteredStudents[index] = updateFn(filteredStudents[index]);

  List<SubjectportpolioRow> allPortfolio = [];
  void addToAllPortfolio(SubjectportpolioRow item) => allPortfolio.add(item);
  void removeFromAllPortfolio(SubjectportpolioRow item) =>
      allPortfolio.remove(item);
  void removeAtIndexFromAllPortfolio(int index) => allPortfolio.removeAt(index);
  void insertAtIndexInAllPortfolio(int index, SubjectportpolioRow item) =>
      allPortfolio.insert(index, item);
  void updateAllPortfolioAtIndex(
          int index, Function(SubjectportpolioRow) updateFn) =>
      allPortfolio[index] = updateFn(allPortfolio[index]);

  DashboardViewType? dashboardViewType = DashboardViewType.dash_overview;

  List<CourseStudentRow> courseStudent = [];
  void addToCourseStudent(CourseStudentRow item) => courseStudent.add(item);
  void removeFromCourseStudent(CourseStudentRow item) =>
      courseStudent.remove(item);
  void removeAtIndexFromCourseStudent(int index) =>
      courseStudent.removeAt(index);
  void insertAtIndexInCourseStudent(int index, CourseStudentRow item) =>
      courseStudent.insert(index, item);
  void updateCourseStudentAtIndex(
          int index, Function(CourseStudentRow) updateFn) =>
      courseStudent[index] = updateFn(courseStudent[index]);

  String? searchQuery;

  bool isSearching = false;

  List<ClassRow> searchResults = [];
  void addToSearchResults(ClassRow item) => searchResults.add(item);
  void removeFromSearchResults(ClassRow item) => searchResults.remove(item);
  void removeAtIndexFromSearchResults(int index) =>
      searchResults.removeAt(index);
  void insertAtIndexInSearchResults(int index, ClassRow item) =>
      searchResults.insert(index, item);
  void updateSearchResultsAtIndex(int index, Function(ClassRow) updateFn) =>
      searchResults[index] = updateFn(searchResults[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in AdminDash widget.
  List<PostsRow>? prfOutput;
  // Stores action output result for [Backend Call - Query Rows] action in AdminDash widget.
  List<ClassRow>? classSelectedOnLoad;
  // Stores action output result for [Backend Call - Query Rows] action in AdminDash widget.
  List<CourseStudentRow>? allStudentsByYearSem;
  // Model for AdminNaviSidebar component.
  late AdminNaviSidebarModel adminNaviSidebarModel;
  // State field(s) for DropDown_Year widget.
  String? dropDownYearValue1;
  FormFieldController<String>? dropDownYearValueController1;
  // State field(s) for DropDown_Semester widget.
  String? dropDownSemesterValue1;
  FormFieldController<String>? dropDownSemesterValueController1;
  // State field(s) for SearchTextField widget.
  FocusNode? searchTextFieldFocusNode;
  TextEditingController? searchTextFieldTextController;
  String? Function(BuildContext, String?)?
      searchTextFieldTextControllerValidator;
  List<String> simpleSearchResults = [];
  // Model for ProgressContainer_Weeks component.
  late ProgressContainerWeeksModel progressContainerWeeksModel1;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel1;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel2;
  // Model for ProgressContainer_Weeks component.
  late ProgressContainerWeeksModel progressContainerWeeksModel2;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel1;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel2;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel3;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel4;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel5;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel6;
  // Model for ProgressContainer_detail component.
  late ProgressContainerDetailModel progressContainerDetailModel1;
  // Model for ProgressContainer_detail component.
  late ProgressContainerDetailModel progressContainerDetailModel2;
  // Model for Header_Mobile component.
  late HeaderMobileModel headerMobileModel;
  // State field(s) for DropDown_Year widget.
  String? dropDownYearValue2;
  FormFieldController<String>? dropDownYearValueController2;
  // State field(s) for DropDown_Semester widget.
  String? dropDownSemesterValue2;
  FormFieldController<String>? dropDownSemesterValueController2;
  // Model for ProgressContainer_Weeks component.
  late ProgressContainerWeeksModel progressContainerWeeksModel3;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel3;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel4;
  // Model for ProgressContainer_Weeks component.
  late ProgressContainerWeeksModel progressContainerWeeksModel4;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel7;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel8;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel9;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel10;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel11;
  // Model for lectureMaterial component.
  late LectureMaterialModel lectureMaterialModel12;
  // Model for ProgressContainer_detail component.
  late ProgressContainerDetailModel progressContainerDetailModel3;
  // Model for ProgressContainer_detail component.
  late ProgressContainerDetailModel progressContainerDetailModel4;

  @override
  void initState(BuildContext context) {
    adminNaviSidebarModel = createModel(context, () => AdminNaviSidebarModel());
    progressContainerWeeksModel1 =
        createModel(context, () => ProgressContainerWeeksModel());
    progressContainerSModel1 =
        createModel(context, () => ProgressContainerSModel());
    progressContainerSModel2 =
        createModel(context, () => ProgressContainerSModel());
    progressContainerWeeksModel2 =
        createModel(context, () => ProgressContainerWeeksModel());
    lectureMaterialModel1 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel2 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel3 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel4 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel5 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel6 = createModel(context, () => LectureMaterialModel());
    progressContainerDetailModel1 =
        createModel(context, () => ProgressContainerDetailModel());
    progressContainerDetailModel2 =
        createModel(context, () => ProgressContainerDetailModel());
    headerMobileModel = createModel(context, () => HeaderMobileModel());
    progressContainerWeeksModel3 =
        createModel(context, () => ProgressContainerWeeksModel());
    progressContainerSModel3 =
        createModel(context, () => ProgressContainerSModel());
    progressContainerSModel4 =
        createModel(context, () => ProgressContainerSModel());
    progressContainerWeeksModel4 =
        createModel(context, () => ProgressContainerWeeksModel());
    lectureMaterialModel7 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel8 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel9 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel10 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel11 = createModel(context, () => LectureMaterialModel());
    lectureMaterialModel12 = createModel(context, () => LectureMaterialModel());
    progressContainerDetailModel3 =
        createModel(context, () => ProgressContainerDetailModel());
    progressContainerDetailModel4 =
        createModel(context, () => ProgressContainerDetailModel());
  }

  @override
  void dispose() {
    adminNaviSidebarModel.dispose();
    searchTextFieldFocusNode?.dispose();
    searchTextFieldTextController?.dispose();

    progressContainerWeeksModel1.dispose();
    progressContainerSModel1.dispose();
    progressContainerSModel2.dispose();
    progressContainerWeeksModel2.dispose();
    lectureMaterialModel1.dispose();
    lectureMaterialModel2.dispose();
    lectureMaterialModel3.dispose();
    lectureMaterialModel4.dispose();
    lectureMaterialModel5.dispose();
    lectureMaterialModel6.dispose();
    progressContainerDetailModel1.dispose();
    progressContainerDetailModel2.dispose();
    headerMobileModel.dispose();
    progressContainerWeeksModel3.dispose();
    progressContainerSModel3.dispose();
    progressContainerSModel4.dispose();
    progressContainerWeeksModel4.dispose();
    lectureMaterialModel7.dispose();
    lectureMaterialModel8.dispose();
    lectureMaterialModel9.dispose();
    lectureMaterialModel10.dispose();
    lectureMaterialModel11.dispose();
    lectureMaterialModel12.dispose();
    progressContainerDetailModel3.dispose();
    progressContainerDetailModel4.dispose();
  }

  /// Action blocks.
  Future filterDataByGrade(BuildContext context) async {
    // filter_class_by_grade
    filteredClass = classSelectedOnLoad!
        .where((e) => e.grade == selectedGrade)
        .toList()
        .toList()
        .cast<ClassRow>();
    studentsByGrade = allStudents
        .where((e) => e.grade == selectedGrade)
        .toList()
        .toList()
        .cast<CourseStudentRow>();
  }

  Future getClassDetail(BuildContext context) async {
    List<CourseStudentRow>? getAttendingStudents;

    getAttendingStudents = await CourseStudentTable().queryRows(
      queryFn: (q) => q.eqOrNull(
        'classid',
        selectedClassDetailID,
      ),
    );
    courseStudent = getAttendingStudents.toList().cast<CourseStudentRow>();
  }
}
