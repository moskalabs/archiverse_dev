import '/components/not_used_comps/order_status/order_status_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'order_items_widget.dart' show OrderItemsWidget;
import 'package:flutter/material.dart';

class OrderItemsModel extends FlutterFlowModel<OrderItemsWidget> {
  ///  Local state fields for this component.

  bool favoritedInside = false;

  ///  State fields for stateful widgets in this component.

  // Model for OrderStatus component.
  late OrderStatusModel orderStatusModel;

  @override
  void initState(BuildContext context) {
    orderStatusModel = createModel(context, () => OrderStatusModel());
  }

  @override
  void dispose() {
    orderStatusModel.dispose();
  }
}
