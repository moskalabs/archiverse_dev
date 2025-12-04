import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/components/class_change/check_submitted/check_submitted_widget.dart';
import '/components/class_change/check_submitted_mobile/check_submitted_mobile_widget.dart';
import '/components/dashboard/dashboard_class_container_m/dashboard_class_container_m_widget.dart';
import '/components/dashboard/progress_container_s/progress_container_s_widget.dart';
import '/components/default_layout/borderline/borderline_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/nav_bar/admin_navi_sidebar/admin_navi_sidebar_widget.dart';
import '/components/student_submit/progress_container_student_submit/progress_container_student_submit_widget.dart';
import '/components/student_submit/student_submit_button/student_submit_button_widget.dart';
import '/components/student_submit/student_submit_button_mobile/student_submit_button_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'admin_student_submit_widget.dart' show AdminStudentSubmitWidget;
import 'package:flutter/material.dart';

class AdminStudentSubmitModel
    extends FlutterFlowModel<AdminStudentSubmitWidget> {
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

  bool isDesign = true;

  String selectedGrade = '1학년';

  StudentSubmitViewType? viewType = StudentSubmitViewType.overview;

  /// ============================================================
  /// NEW STATE VARIABLES FOR ADMIN STUDENT SUBMIT FEATURES
  /// ============================================================

  /// Cached list of ALL students (loaded once on page init)
  List<StudentMyprofileRow> _allStudentsCache = [];
  bool _isStudentsCacheLoaded = false;

  /// List of students filtered by selected grade (computed from cache)
  List<StudentMyprofileRow> filteredStudents = [];
  void addToFilteredStudents(StudentMyprofileRow item) => filteredStudents.add(item);
  void removeFromFilteredStudents(StudentMyprofileRow item) =>
      filteredStudents.remove(item);
  void removeAtIndexFromFilteredStudents(int index) =>
      filteredStudents.removeAt(index);
  void clearFilteredStudents() => filteredStudents.clear();

  /// Currently selected student information
  String? selectedStudentName;
  int? selectedStudentId;
  int? selectedStudentGrade;

  /// List of subjects/courses for the selected student
  List<CourseStudentRow> studentSubjects = [];
  void addToStudentSubjects(CourseStudentRow item) => studentSubjects.add(item);
  void removeFromStudentSubjects(CourseStudentRow item) =>
      studentSubjects.remove(item);
  void removeAtIndexFromStudentSubjects(int index) =>
      studentSubjects.removeAt(index);
  void clearStudentSubjects() => studentSubjects.clear();

  /// Currently selected subject/course information
  String? selectedSubjectName;
  int? selectedClassId;
  String? selectedCourseType; // 'design' or 'theory'

  /// Overall submission progress for selected student (0.0 to 1.0)
  double overallProgress = 0.0;

  /// Assignment progress for selected subject (0.0 to 1.0)
  double assignmentProgress = 0.0;

  /// Weekly submission status for selected subject
  /// Map: week number (1-15) -> boolean (submitted or not)
  Map<int, bool> weeklySubmissionStatus = {};

  /// Midterm submission status for selected subject
  bool midtermSubmitted = false;

  /// Final submission status for selected subject
  bool finalSubmitted = false;

  /// Loading states
  bool isLoadingStudents = false;
  bool isLoadingProgress = false;
  bool isLoadingSubjects = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in AdminStudentSubmit widget.
  List<PostsRow>? prfoutput;
  // Stores action output result for [Backend Call - Query Rows] action in AdminStudentSubmit widget.
  List<ClassRow>? classSelectedOnload;
  // Model for AdminNaviSidebar component.
  late AdminNaviSidebarModel adminNaviSidebarModel;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value;
  FormFieldController<String>? dropDown1ValueController;
  // State field(s) for DropDown2 widget.
  String? dropDown2Value;
  FormFieldController<String>? dropDown2ValueController;
  // Model for ProgressContainer_studentSubmit component.
  late ProgressContainerStudentSubmitModel progressContainerStudentSubmitModel1;
  // Model for Borderline component.
  late BorderlineModel borderlineModel1;
  // Model for Borderline component.
  late BorderlineModel borderlineModel2;
  // Model for StudentSubmitButton component.
  late StudentSubmitButtonModel studentSubmitButtonModel;
  // Model for Borderline component.
  late BorderlineModel borderlineModel3;
  // Model for Borderline component.
  late BorderlineModel borderlineModel4;
  // Model for ProgressContainer_studentSubmit component.
  late ProgressContainerStudentSubmitModel progressContainerStudentSubmitModel2;
  // Model for Borderline component.
  late BorderlineModel borderlineModel5;
  // Model for Borderline component.
  late BorderlineModel borderlineModel6;
  // Model for dashboard_ClassContainerM component.
  late DashboardClassContainerMModel dashboardClassContainerMModel1;
  // Model for ProgressContainer_studentSubmit component.
  late ProgressContainerStudentSubmitModel progressContainerStudentSubmitModel3;
  // Model for CheckSubmitted component.
  late CheckSubmittedModel checkSubmittedModel;
  // Model for Borderline component.
  late BorderlineModel borderlineModel7;
  // Model for Borderline component.
  late BorderlineModel borderlineModel8;
  // Model for Header_Mobile component.
  late HeaderMobileModel headerMobileModel;
  // State field(s) for DropDown_Year widget.
  String? dropDownYearValue;
  FormFieldController<String>? dropDownYearValueController;
  // State field(s) for DropDown_Semester widget.
  String? dropDownSemesterValue;
  FormFieldController<String>? dropDownSemesterValueController;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel1;
  // Model for StudentSubmitButton_Mobile component.
  late StudentSubmitButtonMobileModel studentSubmitButtonMobileModel;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel2;
  // Model for dashboard_ClassContainerM component.
  late DashboardClassContainerMModel dashboardClassContainerMModel2;
  // Model for ProgressContainer_S component.
  late ProgressContainerSModel progressContainerSModel3;
  // Model for CheckSubmitted_Mobile component.
  late CheckSubmittedMobileModel checkSubmittedMobileModel;

  @override
  void initState(BuildContext context) {
    adminNaviSidebarModel = createModel(context, () => AdminNaviSidebarModel());
    progressContainerStudentSubmitModel1 =
        createModel(context, () => ProgressContainerStudentSubmitModel());
    borderlineModel1 = createModel(context, () => BorderlineModel());
    borderlineModel2 = createModel(context, () => BorderlineModel());
    studentSubmitButtonModel =
        createModel(context, () => StudentSubmitButtonModel());
    borderlineModel3 = createModel(context, () => BorderlineModel());
    borderlineModel4 = createModel(context, () => BorderlineModel());
    progressContainerStudentSubmitModel2 =
        createModel(context, () => ProgressContainerStudentSubmitModel());
    borderlineModel5 = createModel(context, () => BorderlineModel());
    borderlineModel6 = createModel(context, () => BorderlineModel());
    dashboardClassContainerMModel1 =
        createModel(context, () => DashboardClassContainerMModel());
    progressContainerStudentSubmitModel3 =
        createModel(context, () => ProgressContainerStudentSubmitModel());
    checkSubmittedModel = createModel(context, () => CheckSubmittedModel());
    borderlineModel7 = createModel(context, () => BorderlineModel());
    borderlineModel8 = createModel(context, () => BorderlineModel());
    headerMobileModel = createModel(context, () => HeaderMobileModel());
    progressContainerSModel1 =
        createModel(context, () => ProgressContainerSModel());
    studentSubmitButtonMobileModel =
        createModel(context, () => StudentSubmitButtonMobileModel());
    progressContainerSModel2 =
        createModel(context, () => ProgressContainerSModel());
    dashboardClassContainerMModel2 =
        createModel(context, () => DashboardClassContainerMModel());
    progressContainerSModel3 =
        createModel(context, () => ProgressContainerSModel());
    checkSubmittedMobileModel =
        createModel(context, () => CheckSubmittedMobileModel());
  }

  @override
  void dispose() {
    adminNaviSidebarModel.dispose();
    progressContainerStudentSubmitModel1.dispose();
    borderlineModel1.dispose();
    borderlineModel2.dispose();
    studentSubmitButtonModel.dispose();
    borderlineModel3.dispose();
    borderlineModel4.dispose();
    progressContainerStudentSubmitModel2.dispose();
    borderlineModel5.dispose();
    borderlineModel6.dispose();
    dashboardClassContainerMModel1.dispose();
    progressContainerStudentSubmitModel3.dispose();
    checkSubmittedModel.dispose();
    borderlineModel7.dispose();
    borderlineModel8.dispose();
    headerMobileModel.dispose();
    progressContainerSModel1.dispose();
    studentSubmitButtonMobileModel.dispose();
    progressContainerSModel2.dispose();
    dashboardClassContainerMModel2.dispose();
    progressContainerSModel3.dispose();
    checkSubmittedMobileModel.dispose();
  }

  /// Action blocks.

  /// ============================================================
  /// FEATURE 1: Filter students by selected grade
  /// Uses local caching - DB query only on first call, then filters from cache
  /// ============================================================
  Future filterStudentByGrade(BuildContext context) async {
    // selectedGrade is already in "1학년", "2학년" format - use directly for DB comparison
    print('DEBUG: filterStudentByGrade called for grade: $selectedGrade, cacheLoaded: $_isStudentsCacheLoaded');

    // If cache not loaded yet, load all students once
    if (!_isStudentsCacheLoaded) {
      isLoadingStudents = true;
      try {
        print('DEBUG: Loading ALL students into cache (one-time)');
        _allStudentsCache = await StudentMyprofileTable().queryRows(
          queryFn: (q) => q,
        );
        _isStudentsCacheLoaded = true;
        print('DEBUG: Cached ${_allStudentsCache.length} total students');

        // Debug: Print unique grade values to understand the data format
        final uniqueGrades = _allStudentsCache.map((s) => s.grade).toSet().toList();
        print('DEBUG: Unique grade values in DB: $uniqueGrades');
      } catch (e) {
        print('ERROR loading students cache: $e');
        isLoadingStudents = false;
        return;
      }
    }

    // Filter from cache (instant, no network call)
    // Compare directly with selectedGrade ("1학년", "2학년", etc.)
    clearFilteredStudents();
    filteredStudents = _allStudentsCache
        .where((student) => student.grade == selectedGrade)
        .toList();

    print('DEBUG: Filtered to ${filteredStudents.length} students for grade $selectedGrade (from cache)');
    isLoadingStudents = false;
  }

  /// ============================================================
  /// FEATURE 2: Calculate overall submission progress for selected student
  /// ============================================================
  Future calculateOverallProgress(BuildContext context) async {
    if (selectedStudentName == null) {
      print('DEBUG: No student selected for overall progress');
      return;
    }

    print('DEBUG: Calculating overall progress for: $selectedStudentName');
    isLoadingProgress = true;

    try {
      // Get all courses for this student in current year/semester
      final studentCourses = await CourseStudentTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('student_name', selectedStudentName)
            .eqOrNull('year', years)
            .eqOrNull('semester', semester),
      );

      print('DEBUG: Student has ${studentCourses.length} courses');

      int totalExpected = 0;
      int totalSubmitted = 0;

      // For each course, calculate submissions
      for (var course in studentCourses) {
        if (course.classid == null) continue;

        // Determine if design course by checking if course name contains "건축설계"
        bool isDesignCourse = course.courseName?.contains('건축설계') ?? false;

        // Design courses: 15 weeks + midterm + final = 17 items
        // Theory courses: midterm + final = 2 items
        if (isDesignCourse) {
          totalExpected += 17; // 15 weeks + 2 milestones

          // Count weekly submissions
          final weeklySubmissions = await SubjectportpolioTable().queryRows(
            queryFn: (q) => q
                .eqOrNull('class', course.classid)
                .eqOrNull('student_name', selectedStudentName),
          );
          totalSubmitted += weeklySubmissions.length;
          print('DEBUG: Course ${course.courseName} - Weekly: ${weeklySubmissions.length}/15');
        } else {
          totalExpected += 2; // Only midterm + final for theory
        }

        // Count midterm submission
        final midtermSubmissions = await MidtermResultsTable().queryRows(
          queryFn: (q) => q
              .eqOrNull('class', course.classid)
              .eqOrNull('student_name', selectedStudentName),
        );
        if (midtermSubmissions.isNotEmpty) {
          totalSubmitted += 1;
          print('DEBUG: Course ${course.courseName} - Midterm: submitted');
        }

        // Count final submission
        final finalSubmissions = await FinalResultsTable().queryRows(
          queryFn: (q) => q
              .eqOrNull('class', course.classid)
              .eqOrNull('student_name', selectedStudentName),
        );
        if (finalSubmissions.isNotEmpty) {
          totalSubmitted += 1;
          print('DEBUG: Course ${course.courseName} - Final: submitted');
        }
      }

      // Calculate overall progress percentage
      if (totalExpected > 0) {
        overallProgress = totalSubmitted / totalExpected;
      } else {
        overallProgress = 0.0;
      }

      print('DEBUG: Overall progress: ${(overallProgress * 100).toStringAsFixed(1)}% ($totalSubmitted/$totalExpected)');

    } catch (e) {
      print('ERROR in calculateOverallProgress: $e');
      overallProgress = 0.0;
    } finally {
      isLoadingProgress = false;
    }
  }

  /// ============================================================
  /// FEATURE 3: Load subjects for selected student
  /// ============================================================
  Future loadStudentSubjects(BuildContext context) async {
    if (selectedStudentName == null) {
      print('DEBUG: No student selected for loading subjects');
      return;
    }

    print('DEBUG: Loading subjects for: $selectedStudentName');
    isLoadingSubjects = true;
    clearStudentSubjects();

    try {
      // Query all courses for this student in current year/semester
      final subjects = await CourseStudentTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('student_name', selectedStudentName)
            .eqOrNull('year', years)
            .eqOrNull('semester', semester),
      );

      studentSubjects = subjects;
      print('DEBUG: Loaded ${studentSubjects.length} subjects');

      for (var subject in studentSubjects) {
        print('DEBUG: Subject: ${subject.courseName} (${subject.courseType})');
      }

    } catch (e) {
      print('ERROR in loadStudentSubjects: $e');
    } finally {
      isLoadingSubjects = false;
    }
  }

  /// ============================================================
  /// FEATURE 4: Calculate assignment progress for selected subject
  /// ============================================================
  Future calculateAssignmentProgress(BuildContext context) async {
    if (selectedClassId == null || selectedStudentName == null) {
      print('DEBUG: No subject/student selected for assignment progress');
      return;
    }

    print('DEBUG: Calculating assignment progress for class: $selectedClassId, student: $selectedStudentName');
    isLoadingProgress = true;

    try {
      // Determine if design course by checking if course name contains "건축설계"
      bool isDesignCourse = selectedSubjectName?.contains('건축설계') ?? false;

      int totalExpected = 0;
      int totalSubmitted = 0;

      if (isDesignCourse) {
        // Design course: 15 weeks + midterm + final
        totalExpected = 17;

        // Count weekly submissions
        final weeklySubmissions = await SubjectportpolioTable().queryRows(
          queryFn: (q) => q
              .eqOrNull('class', selectedClassId)
              .eqOrNull('student_name', selectedStudentName),
        );
        totalSubmitted += weeklySubmissions.length;
        print('DEBUG: Weekly submissions: ${weeklySubmissions.length}');
      } else {
        // Theory course: only midterm + final
        totalExpected = 2;
      }

      // Count midterm
      final midtermSubmissions = await MidtermResultsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('class', selectedClassId)
            .eqOrNull('student_name', selectedStudentName),
      );
      if (midtermSubmissions.isNotEmpty) {
        totalSubmitted += 1;
        print('DEBUG: Midterm: submitted');
      }

      // Count final
      final finalSubmissions = await FinalResultsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('class', selectedClassId)
            .eqOrNull('student_name', selectedStudentName),
      );
      if (finalSubmissions.isNotEmpty) {
        totalSubmitted += 1;
        print('DEBUG: Final: submitted');
      }

      // Calculate assignment progress
      if (totalExpected > 0) {
        assignmentProgress = totalSubmitted / totalExpected;
      } else {
        assignmentProgress = 0.0;
      }

      print('DEBUG: Assignment progress: ${(assignmentProgress * 100).toStringAsFixed(1)}% ($totalSubmitted/$totalExpected)');

    } catch (e) {
      print('ERROR in calculateAssignmentProgress: $e');
      assignmentProgress = 0.0;
    } finally {
      isLoadingProgress = false;
    }
  }

  /// ============================================================
  /// FEATURE 5: Load weekly progress and milestone status for selected subject
  /// ============================================================
  Future loadWeeklyProgressStatus(BuildContext context) async {
    if (selectedClassId == null || selectedStudentName == null) {
      print('DEBUG: No subject/student selected for weekly progress');
      return;
    }

    print('DEBUG: Loading weekly progress for class: $selectedClassId, student: $selectedStudentName');

    try {
      // Reset status
      weeklySubmissionStatus.clear();
      midtermSubmitted = false;
      finalSubmitted = false;

      // Initialize all weeks to false
      for (int i = 1; i <= 15; i++) {
        weeklySubmissionStatus[i] = false;
      }

      // Query weekly submissions
      final weeklySubmissions = await SubjectportpolioTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('class', selectedClassId)
            .eqOrNull('student_name', selectedStudentName),
      );

      print('DEBUG: Found ${weeklySubmissions.length} weekly submissions');

      // Mark submitted weeks
      for (var submission in weeklySubmissions) {
        if (submission.week != null) {
          // Parse week number (e.g., "1주차" -> 1)
          String weekStr = submission.week!.replaceAll(RegExp(r'[^0-9]'), '');
          if (weekStr.isNotEmpty) {
            int weekNum = int.parse(weekStr);
            if (weekNum >= 1 && weekNum <= 15) {
              weeklySubmissionStatus[weekNum] = true;
              print('DEBUG: Week $weekNum: submitted');
            }
          }
        }
      }

      // Check midterm submission
      final midtermSubmissions = await MidtermResultsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('class', selectedClassId)
            .eqOrNull('student_name', selectedStudentName),
      );
      midtermSubmitted = midtermSubmissions.isNotEmpty;
      print('DEBUG: Midterm submitted: $midtermSubmitted');

      // Check final submission
      final finalSubmissions = await FinalResultsTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('class', selectedClassId)
            .eqOrNull('student_name', selectedStudentName),
      );
      finalSubmitted = finalSubmissions.isNotEmpty;
      print('DEBUG: Final submitted: $finalSubmitted');

    } catch (e) {
      print('ERROR in loadWeeklyProgressStatus: $e');
    }
  }

  /// ============================================================
  /// Helper function: Select student
  /// ============================================================
  Future selectStudent(BuildContext context, String studentName, int studentId, int studentGrade) async {
    print('DEBUG: Selecting student: $studentName (ID: $studentId, Grade: $studentGrade)');

    selectedStudentName = studentName;
    selectedStudentId = studentId;
    selectedStudentGrade = studentGrade;

    // Clear previous subject selection
    selectedSubjectName = null;
    selectedClassId = null;
    selectedCourseType = null;
    clearStudentSubjects();

    // Load only subjects for fast response
    // Overall progress calculation removed for performance
    await loadStudentSubjects(context);
  }

  /// ============================================================
  /// Helper function: Select subject
  /// ============================================================
  Future selectSubject(BuildContext context, String subjectName, int classId, String courseType) async {
    print('DEBUG: Selecting subject: $subjectName (Class ID: $classId, Type: $courseType)');

    selectedSubjectName = subjectName;
    selectedClassId = classId;
    selectedCourseType = courseType;

    // Determine if design course by checking if course name contains "건축설계"
    isDesign = subjectName.contains('건축설계');

    // Load data for selected subject
    await Future.wait([
      calculateAssignmentProgress(context),
      loadWeeklyProgressStatus(context),
    ]);
  }
}
