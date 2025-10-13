import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
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

  String? imageLoadByWeeks;

  /// 주차별 설계진행표 LIST
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

  /// 테이터 테이블에서, 학생 이름선택한거 따로 담아서 미리보기에 쓰자
  String? datatableNameSelect;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<WeeksUploadRow>? weekAlloutput;
  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<UploadByStudentAndWeeksRow>? studentNameOutputRow;
  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<ClassRow>? classoutput;
  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<SubjectportpolioRow>? subjectOutput;
  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<ProfessorMyprofileRow>? professorForImage;
  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<MidtermResultsRow>? midtermResults;
  // Stores action output result for [Backend Call - Query Rows] action in Home widget.
  List<FinalResultsRow>? finalResults;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController1 =
      FlutterFlowDataTableController<String>();
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;
  // Model for Header_Mobile component.
  late HeaderMobileModel headerMobileModel;
  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController2 =
      FlutterFlowDataTableController<String>();
  // Model for NaviSidebar_Mobile component.
  late NaviSidebarMobileModel naviSidebarMobileModel;

  @override
  void initState(BuildContext context) {
    naviSidebarModel = createModel(context, () => NaviSidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    leftWidgetModel = createModel(context, () => LeftWidgetModel());
    rightWidgetModel = createModel(context, () => RightWidgetModel());
    headerMobileModel = createModel(context, () => HeaderMobileModel());
    naviSidebarMobileModel =
        createModel(context, () => NaviSidebarMobileModel());
  }

  @override
  void dispose() {
    naviSidebarModel.dispose();
    headerModel.dispose();
    leftWidgetModel.dispose();
    paginatedDataTableController1.dispose();
    tabBarController?.dispose();
    rightWidgetModel.dispose();
    headerMobileModel.dispose();
    paginatedDataTableController2.dispose();
    naviSidebarMobileModel.dispose();
  }
}
