import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'prof_results_midterm_widget.dart' show ProfResultsMidtermWidget;
import 'package:flutter/material.dart';

class ProfResultsMidtermModel
    extends FlutterFlowModel<ProfResultsMidtermWidget> {
  ///  Local state fields for this page.

  bool? bottomOpen = false;

  bool? refresh = false;

  /// midterm supabase row 행
  List<MidtermResultsRow> midResults = [];
  void addToMidResults(MidtermResultsRow item) => midResults.add(item);
  void removeFromMidResults(MidtermResultsRow item) => midResults.remove(item);
  void removeAtIndexFromMidResults(int index) => midResults.removeAt(index);
  void insertAtIndexInMidResults(int index, MidtermResultsRow item) =>
      midResults.insert(index, item);
  void updateMidResultsAtIndex(
          int index, Function(MidtermResultsRow) updateFn) =>
      midResults[index] = updateFn(midResults[index]);

  int? selectedIndex = -1;

  /// 선정한 기말 결과물 상 목록
  List<MidtermResultsRow> midtermHigh = [];
  void addToMidtermHigh(MidtermResultsRow item) => midtermHigh.add(item);
  void removeFromMidtermHigh(MidtermResultsRow item) =>
      midtermHigh.remove(item);
  void removeAtIndexFromMidtermHigh(int index) => midtermHigh.removeAt(index);
  void insertAtIndexInMidtermHigh(int index, MidtermResultsRow item) =>
      midtermHigh.insert(index, item);
  void updateMidtermHighAtIndex(
          int index, Function(MidtermResultsRow) updateFn) =>
      midtermHigh[index] = updateFn(midtermHigh[index]);

  /// 선정한 기말 결과물 중 목록
  List<MidtermResultsRow> midtermMiddle = [];
  void addToMidtermMiddle(MidtermResultsRow item) => midtermMiddle.add(item);
  void removeFromMidtermMiddle(MidtermResultsRow item) =>
      midtermMiddle.remove(item);
  void removeAtIndexFromMidtermMiddle(int index) =>
      midtermMiddle.removeAt(index);
  void insertAtIndexInMidtermMiddle(int index, MidtermResultsRow item) =>
      midtermMiddle.insert(index, item);
  void updateMidtermMiddleAtIndex(
          int index, Function(MidtermResultsRow) updateFn) =>
      midtermMiddle[index] = updateFn(midtermMiddle[index]);

  /// 선정한 기말 결과물 하 목록
  List<MidtermResultsRow> midtermLow = [];
  void addToMidtermLow(MidtermResultsRow item) => midtermLow.add(item);
  void removeFromMidtermLow(MidtermResultsRow item) => midtermLow.remove(item);
  void removeAtIndexFromMidtermLow(int index) => midtermLow.removeAt(index);
  void insertAtIndexInMidtermLow(int index, MidtermResultsRow item) =>
      midtermLow.insert(index, item);
  void updateMidtermLowAtIndex(
          int index, Function(MidtermResultsRow) updateFn) =>
      midtermLow[index] = updateFn(midtermLow[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_ResultsMidterm widget.
  List<MidtermResultsRow>? midtermonload;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? draghigh;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? dragexit;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? dragmiddle;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? middledragexit;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? lowdragexit;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? draglow;
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
  List<MidtermResultsRow>? draghighMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? dragexitMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? dragmiddleMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? middledragexitMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? lowdragexitMobile;
  // Stores action output result for [Backend Call - Update Row(s)] action in DragTarget widget.
  List<MidtermResultsRow>? draglowMobile;
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
