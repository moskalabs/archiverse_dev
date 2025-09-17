import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/student_header/student_header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/student_left_widget/student_left_widget_widget.dart';
import '/components/default_layout/left_right/student_right_widget/student_right_widget_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar/student_navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar_mobile/student_navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'student_subject_portpolio_widget.dart'
    show StudentSubjectPortpolioWidget;
import 'package:flutter/material.dart';

class StudentSubjectPortpolioModel
    extends FlutterFlowModel<StudentSubjectPortpolioWidget> {
  ///  Local state fields for this page.

  bool openOrHideButton = false;

  bool buttonClicked2 = false;

  /// 임시
  bool buttonClicked3 = false;

  bool richEditorSelected = false;

  bool buttonDelete = false;

  bool buttonEdit = false;

  bool afterEditor = false;

  bool textClickedResult = false;

  /// 임시저장 html 받은거
  String? portpoliobystudenthtml;

  String? portpolioresult;

  /// 제출 버튼 conditional
  bool? submitbool = false;

  /// 1주차 제목-> 나중에 15주차니까 컴포넌트화 시켜서 해야한다 어차피.
  String? firsttitle;

  DateTime? firstcreateddate;

  bool? criticbool = false;

  String? critichtml;

  bool refresh = false;

  /// 학생 포트폴리오 올린 리스트 1개 나오겠지
  List<SubjectportpolioRow> sPortpolioList = [];
  void addToSPortpolioList(SubjectportpolioRow item) =>
      sPortpolioList.add(item);
  void removeFromSPortpolioList(SubjectportpolioRow item) =>
      sPortpolioList.remove(item);
  void removeAtIndexFromSPortpolioList(int index) =>
      sPortpolioList.removeAt(index);
  void insertAtIndexInSPortpolioList(int index, SubjectportpolioRow item) =>
      sPortpolioList.insert(index, item);
  void updateSPortpolioListAtIndex(
          int index, Function(SubjectportpolioRow) updateFn) =>
      sPortpolioList[index] = updateFn(sPortpolioList[index]);

  List<TempPortpolioRow> sPortpolioTempList = [];
  void addToSPortpolioTempList(TempPortpolioRow item) =>
      sPortpolioTempList.add(item);
  void removeFromSPortpolioTempList(TempPortpolioRow item) =>
      sPortpolioTempList.remove(item);
  void removeAtIndexFromSPortpolioTempList(int index) =>
      sPortpolioTempList.removeAt(index);
  void insertAtIndexInSPortpolioTempList(int index, TempPortpolioRow item) =>
      sPortpolioTempList.insert(index, item);
  void updateSPortpolioTempListAtIndex(
          int index, Function(TempPortpolioRow) updateFn) =>
      sPortpolioTempList[index] = updateFn(sPortpolioTempList[index]);

  /// 주차 string 으로 받자
  String? weeks = '1주차';

  /// supabase에 있는 값.
  List<WeeksUploadRow> weekUpload = [];
  void addToWeekUpload(WeeksUploadRow item) => weekUpload.add(item);
  void removeFromWeekUpload(WeeksUploadRow item) => weekUpload.remove(item);
  void removeAtIndexFromWeekUpload(int index) => weekUpload.removeAt(index);
  void insertAtIndexInWeekUpload(int index, WeeksUploadRow item) =>
      weekUpload.insert(index, item);
  void updateWeekUploadAtIndex(int index, Function(WeeksUploadRow) updateFn) =>
      weekUpload[index] = updateFn(weekUpload[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Student_SubjectPortpolio widget.
  List<TempPortpolioRow>? tempoutput;
  // Stores action output result for [Backend Call - Query Rows] action in Student_SubjectPortpolio widget.
  List<SubjectportpolioRow>? onloadportpoliooutput;
  // Model for StudentNaviSidebar component.
  late StudentNaviSidebarModel studentNaviSidebarModel;
  // Model for StudentHeader component.
  late StudentHeaderModel studentHeaderModel;
  // Model for StudentLeftWidget component.
  late StudentLeftWidgetModel studentLeftWidgetModel;
  // State field(s) for Slider widget.
  double? sliderValue1;
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
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<SubjectportpolioRow>? subjectdelete;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectportpolioRow>? afterdeletesplist;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  SubjectportpolioRow? insertportpolio;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<TempPortpolioRow>? tempdelete;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectportpolioRow>? aftersubmitPortpolioList;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TempPortpolioRow>? criticupdate;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  TempPortpolioRow? sPortpolioTempReturn;
  // Model for StudentRightWidget component.
  late StudentRightWidgetModel studentRightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // State field(s) for Slider widget.
  double? sliderValue2;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Icon widget.
  List<WeeksUploadRow>? weekoutputMobile;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered7 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered8 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered9 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered10 = false;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<SubjectportpolioRow>? subjectdeleteMobile;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectportpolioRow>? afterdeletesplistMobile;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  SubjectportpolioRow? insertportpolioMobile;
  // Stores action output result for [Backend Call - Delete Row(s)] action in Button widget.
  List<TempPortpolioRow>? tempdeleteMobile;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<SubjectportpolioRow>? aftersubmitportpoliotableoutputMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<TempPortpolioRow>? criticupdateMobile;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<TempPortpolioRow>? tempbeforesubmitoutputMobile;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Alert Dialog - Custom Dialog] action in Button widget.
  TempPortpolioRow? sPortpolioTempReturnMobile;
  // Model for StudentNaviSidebar_Mobile component.
  late StudentNaviSidebarMobileModel studentNaviSidebarMobileModel;

  @override
  void initState(BuildContext context) {
    studentNaviSidebarModel =
        createModel(context, () => StudentNaviSidebarModel());
    studentHeaderModel = createModel(context, () => StudentHeaderModel());
    studentLeftWidgetModel =
        createModel(context, () => StudentLeftWidgetModel());
    studentRightWidgetModel =
        createModel(context, () => StudentRightWidgetModel());
    studentHeaderMobileModel =
        createModel(context, () => StudentHeaderMobileModel());
    studentNaviSidebarMobileModel =
        createModel(context, () => StudentNaviSidebarMobileModel());
  }

  @override
  void dispose() {
    studentNaviSidebarModel.dispose();
    studentHeaderModel.dispose();
    studentLeftWidgetModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    studentRightWidgetModel.dispose();
    studentHeaderMobileModel.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    studentNaviSidebarMobileModel.dispose();
  }
}
