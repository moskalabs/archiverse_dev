import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/student_header/student_header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/student_left_widget/student_left_widget_widget.dart';
import '/components/default_layout/left_right/student_right_widget/student_right_widget_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar/student_navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar_mobile/student_navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'student_home_widget.dart' show StudentHomeWidget;
import 'package:flutter/material.dart';

class StudentHomeModel extends FlutterFlowModel<StudentHomeWidget> {
  ///  Local state fields for this page.

  List<CourseStudentRow> studentsByCourse = [];
  void addToStudentsByCourse(CourseStudentRow item) =>
      studentsByCourse.add(item);
  void removeFromStudentsByCourse(CourseStudentRow item) =>
      studentsByCourse.remove(item);
  void removeAtIndexFromStudentsByCourse(int index) =>
      studentsByCourse.removeAt(index);
  void insertAtIndexInStudentsByCourse(int index, CourseStudentRow item) =>
      studentsByCourse.insert(index, item);
  void updateStudentsByCourseAtIndex(
          int index, Function(CourseStudentRow) updateFn) =>
      studentsByCourse[index] = updateFn(studentsByCourse[index]);

  List<String> studentOutputVar = [];
  void addToStudentOutputVar(String item) => studentOutputVar.add(item);
  void removeFromStudentOutputVar(String item) => studentOutputVar.remove(item);
  void removeAtIndexFromStudentOutputVar(int index) =>
      studentOutputVar.removeAt(index);
  void insertAtIndexInStudentOutputVar(int index, String item) =>
      studentOutputVar.insert(index, item);
  void updateStudentOutputVarAtIndex(int index, Function(String) updateFn) =>
      studentOutputVar[index] = updateFn(studentOutputVar[index]);

  int? imageLoadByWeeks;

  /// 주차별 설계진행표 list
  List<SubjectportpolioRow> subjectSubmitList = [];
  void addToSubjectSubmitList(SubjectportpolioRow item) =>
      subjectSubmitList.add(item);
  void removeFromSubjectSubmitList(SubjectportpolioRow item) =>
      subjectSubmitList.remove(item);
  void removeAtIndexFromSubjectSubmitList(int index) =>
      subjectSubmitList.removeAt(index);
  void insertAtIndexInSubjectSubmitList(int index, SubjectportpolioRow item) =>
      subjectSubmitList.insert(index, item);
  void updateSubjectSubmitListAtIndex(
          int index, Function(SubjectportpolioRow) updateFn) =>
      subjectSubmitList[index] = updateFn(subjectSubmitList[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in StudentHome widget.
  List<WeeksUploadRow>? weekAlloutput;
  // Stores action output result for [Backend Call - Query Rows] action in StudentHome widget.
  List<SubjectportpolioRow>? subjectOutputByStudent;
  // Stores action output result for [Backend Call - Query Rows] action in StudentHome widget.
  List<StudentPostRow>? studentemailoutput;
  // Stores action output result for [Backend Call - Query Rows] action in StudentHome widget.
  List<ClassRow>? classoutput;
  // Stores action output result for [Backend Call - Query Rows] action in StudentHome widget.
  List<StudentMyprofileRow>? studentmyprofileForImage;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for TabBar widget.
  TabController? tabBarController1;
  int get tabBarCurrentIndex1 =>
      tabBarController1 != null ? tabBarController1!.index : 0;
  int get tabBarPreviousIndex1 =>
      tabBarController1 != null ? tabBarController1!.previousIndex : 0;

  // Model for StudentNaviSidebar_Mobile component.
  late StudentNaviSidebarMobileModel studentNaviSidebarMobileModel;
  // Model for StudentNaviSidebar component.
  late StudentNaviSidebarModel studentNaviSidebarModel;
  // Model for StudentHeader component.
  late StudentHeaderModel studentHeaderModel;
  // Model for StudentLeftWidget component.
  late StudentLeftWidgetModel studentLeftWidgetModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController2;
  int get tabBarCurrentIndex2 =>
      tabBarController2 != null ? tabBarController2!.index : 0;
  int get tabBarPreviousIndex2 =>
      tabBarController2 != null ? tabBarController2!.previousIndex : 0;

  // Model for StudentRightWidget component.
  late StudentRightWidgetModel studentRightWidgetModel;

  @override
  void initState(BuildContext context) {
    studentHeaderMobileModel =
        createModel(context, () => StudentHeaderMobileModel());
    studentNaviSidebarMobileModel =
        createModel(context, () => StudentNaviSidebarMobileModel());
    studentNaviSidebarModel =
        createModel(context, () => StudentNaviSidebarModel());
    studentHeaderModel = createModel(context, () => StudentHeaderModel());
    studentLeftWidgetModel =
        createModel(context, () => StudentLeftWidgetModel());
    studentRightWidgetModel =
        createModel(context, () => StudentRightWidgetModel());
  }

  @override
  void dispose() {
    studentHeaderMobileModel.dispose();
    tabBarController1?.dispose();
    studentNaviSidebarMobileModel.dispose();
    studentNaviSidebarModel.dispose();
    studentHeaderModel.dispose();
    studentLeftWidgetModel.dispose();
    tabBarController2?.dispose();
    studentRightWidgetModel.dispose();
  }
}
