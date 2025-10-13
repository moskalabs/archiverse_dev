import '/components/default_layout/divider/divider_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'review_card_widget.dart' show ReviewCardWidget;
import 'package:flutter/material.dart';

class ReviewCardModel extends FlutterFlowModel<ReviewCardWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for RatingBar widget.
  double? ratingBarValue;
  // Model for Divider component.
  late DividerModel dividerModel;

  @override
  void initState(BuildContext context) {
    dividerModel = createModel(context, () => DividerModel());
  }

  @override
  void dispose() {
    dividerModel.dispose();
  }
}
