import '/components/profile/address_row/address_row_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'property_card_widget.dart' show PropertyCardWidget;
import 'package:flutter/material.dart';

class PropertyCardModel extends FlutterFlowModel<PropertyCardWidget> {
  ///  Local state fields for this component.

  bool favoritedInside = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Model for AddressRow component.
  late AddressRowModel addressRowModel;

  @override
  void initState(BuildContext context) {
    addressRowModel = createModel(context, () => AddressRowModel());
  }

  @override
  void dispose() {
    addressRowModel.dispose();
  }
}
