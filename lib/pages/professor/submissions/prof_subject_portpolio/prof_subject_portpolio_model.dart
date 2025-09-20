import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prof_subject_portpolio_widget.dart' show ProfSubjectPortpolioWidget;
import 'package:flutter/material.dart';

class ProfSubjectPortpolioModel
    extends FlutterFlowModel<ProfSubjectPortpolioWidget> {
  ///  Local state fields for this page.

  bool? chatVar;

  bool openOrHideButton = false;

  bool buttonClicked2 = false;

  int? nameClickednum = -1;

  bool imageClicked = false;

  String? nameselectforquery;

  String? weeks = '1주차';

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

  void clearSPortfolioLists() {
    sPortpolioList.clear();
    nameselectforquery = null;
    nameClickednum = -1;
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_SubjectPortpolio widget.
  List<TempPortpolioRow>? tempoutput;
  // Stores action output result for [Backend Call - Query Rows] action in Prof_SubjectPortpolio widget.
  List<SubjectportpolioRow>? subjectoutput;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
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
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered6 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered7 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered8 = false;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<SubjectportpolioRow>? updatecriticbyprf;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // State field(s) for Slider widget.
  double? sliderValue2;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered9 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered10 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered11 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered12 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered13 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered14 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered15 = false;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered16 = false;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<SubjectportpolioRow>? updatecriticbyprfMobile;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Model for NaviSidebar_Mobile component.
  late NaviSidebarMobileModel naviSidebarMobileModel;

  @override
  void initState(BuildContext context) {
    naviSidebarModel = createModel(context, () => NaviSidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    leftWidgetModel = createModel(context, () => LeftWidgetModel());
    rightWidgetModel = createModel(context, () => RightWidgetModel());
    studentHeaderMobileModel =
        createModel(context, () => StudentHeaderMobileModel());
    naviSidebarMobileModel =
        createModel(context, () => NaviSidebarMobileModel());
  }

  @override
  void dispose() {
    naviSidebarModel.dispose();
    headerModel.dispose();
    leftWidgetModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    rightWidgetModel.dispose();
    studentHeaderMobileModel.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    naviSidebarMobileModel.dispose();
  }
}
