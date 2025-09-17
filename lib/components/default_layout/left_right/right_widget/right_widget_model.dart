import '/components/default_layout/divider/divider_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'right_widget_widget.dart' show RightWidgetWidget;
import 'package:flutter/material.dart';

class RightWidgetModel extends FlutterFlowModel<RightWidgetWidget> {
  ///  Local state fields for this component.

  bool buttonClicked = false;

  ///  State fields for stateful widgets in this component.

  // Model for Divider component.
  late DividerModel dividerModel1;
  // Model for Divider component.
  late DividerModel dividerModel2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;

  @override
  void initState(BuildContext context) {
    dividerModel1 = createModel(context, () => DividerModel());
    dividerModel2 = createModel(context, () => DividerModel());
  }

  @override
  void dispose() {
    dividerModel1.dispose();
    dividerModel2.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
