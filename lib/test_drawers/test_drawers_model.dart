import '/components/default_layout/menu/menu_item/menu_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'test_drawers_widget.dart' show TestDrawersWidget;
import 'package:flutter/material.dart';

class TestDrawersModel extends FlutterFlowModel<TestDrawersWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for MenuItem component.
  late MenuItemModel menuItemModel1;
  // Model for MenuItem component.
  late MenuItemModel menuItemModel2;
  // Model for MenuItem component.
  late MenuItemModel menuItemModel3;
  // Model for MenuItem component.
  late MenuItemModel menuItemModel4;
  // Model for MenuItem component.
  late MenuItemModel menuItemModel5;
  // Model for MenuItem component.
  late MenuItemModel menuItemModel6;
  // Model for MenuItem component.
  late MenuItemModel menuItemModel7;

  @override
  void initState(BuildContext context) {
    menuItemModel1 = createModel(context, () => MenuItemModel());
    menuItemModel2 = createModel(context, () => MenuItemModel());
    menuItemModel3 = createModel(context, () => MenuItemModel());
    menuItemModel4 = createModel(context, () => MenuItemModel());
    menuItemModel5 = createModel(context, () => MenuItemModel());
    menuItemModel6 = createModel(context, () => MenuItemModel());
    menuItemModel7 = createModel(context, () => MenuItemModel());
  }

  @override
  void dispose() {
    menuItemModel1.dispose();
    menuItemModel2.dispose();
    menuItemModel3.dispose();
    menuItemModel4.dispose();
    menuItemModel5.dispose();
    menuItemModel6.dispose();
    menuItemModel7.dispose();
  }
}
