import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prof_results_final_widget.dart' show ProfResultsFinalWidget;
import 'package:flutter/material.dart';

class ProfResultsFinalModel extends FlutterFlowModel<ProfResultsFinalWidget> {
  ///  Local state fields for this page.

  bool? bottomOpen = false;

  bool? refresh = false;

  bool button1 = false;

  /// finalresult supabase row 행
  List<FinalResultsRow> finalResults = [];
  void addToFinalResults(FinalResultsRow item) => finalResults.add(item);
  void removeFromFinalResults(FinalResultsRow item) =>
      finalResults.remove(item);
  void removeAtIndexFromFinalResults(int index) => finalResults.removeAt(index);
  void insertAtIndexInFinalResults(int index, FinalResultsRow item) =>
      finalResults.insert(index, item);
  void updateFinalResultsAtIndex(
          int index, Function(FinalResultsRow) updateFn) =>
      finalResults[index] = updateFn(finalResults[index]);

  int? selectedIndex = -1;

  /// 선정한 기말 결과물 상 목록
  List<FinalResultsRow> finalHigh = [];
  void addToFinalHigh(FinalResultsRow item) => finalHigh.add(item);
  void removeFromFinalHigh(FinalResultsRow item) => finalHigh.remove(item);
  void removeAtIndexFromFinalHigh(int index) => finalHigh.removeAt(index);
  void insertAtIndexInFinalHigh(int index, FinalResultsRow item) =>
      finalHigh.insert(index, item);
  void updateFinalHighAtIndex(int index, Function(FinalResultsRow) updateFn) =>
      finalHigh[index] = updateFn(finalHigh[index]);

  /// 선정한 기말 결과물 중 목록
  List<FinalResultsRow> finalMiddle = [];
  void addToFinalMiddle(FinalResultsRow item) => finalMiddle.add(item);
  void removeFromFinalMiddle(FinalResultsRow item) => finalMiddle.remove(item);
  void removeAtIndexFromFinalMiddle(int index) => finalMiddle.removeAt(index);
  void insertAtIndexInFinalMiddle(int index, FinalResultsRow item) =>
      finalMiddle.insert(index, item);
  void updateFinalMiddleAtIndex(
          int index, Function(FinalResultsRow) updateFn) =>
      finalMiddle[index] = updateFn(finalMiddle[index]);

  /// 선정한 기말 결과물 하 목록
  List<FinalResultsRow> finalLow = [];
  void addToFinalLow(FinalResultsRow item) => finalLow.add(item);
  void removeFromFinalLow(FinalResultsRow item) => finalLow.remove(item);
  void removeAtIndexFromFinalLow(int index) => finalLow.removeAt(index);
  void insertAtIndexInFinalLow(int index, FinalResultsRow item) =>
      finalLow.insert(index, item);
  void updateFinalLowAtIndex(int index, Function(FinalResultsRow) updateFn) =>
      finalLow[index] = updateFn(finalLow[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_ResultsFinal widget.
  List<FinalResultsRow>? finalonloadrow;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? draghigh;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? dragexit;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? dragmiddle;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? middledragexit;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? draglow;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? lowdragexit;
  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? draghighMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? dragexitMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? dragmiddleMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? middledragexitMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? draglowMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<FinalResultsRow>? lowdragexitMobile;
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
    rightWidgetModel.dispose();
    studentHeaderMobileModel.dispose();
    naviSidebarMobileModel.dispose();
  }
}
