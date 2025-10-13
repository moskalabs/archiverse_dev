import '/components/default_layout/divider/divider_widget.dart';
import '/components/not_used_comps/message_item/message_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'rightwidget_copy_widget.dart' show RightwidgetCopyWidget;
import 'package:flutter/material.dart';

class RightwidgetCopyModel extends FlutterFlowModel<RightwidgetCopyWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for Divider component.
  late DividerModel dividerModel1;
  // Model for MessageItem component.
  late MessageItemModel messageItemModel;
  // Model for Divider component.
  late DividerModel dividerModel2;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    dividerModel1 = createModel(context, () => DividerModel());
    messageItemModel = createModel(context, () => MessageItemModel());
    dividerModel2 = createModel(context, () => DividerModel());
  }

  @override
  void dispose() {
    dividerModel1.dispose();
    messageItemModel.dispose();
    dividerModel2.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
