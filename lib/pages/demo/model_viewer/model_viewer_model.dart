import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'model_viewer_widget.dart' show ModelViewerWidget;
import 'package:flutter/material.dart';

class ModelViewerModel extends FlutterFlowModel<ModelViewerWidget> {
  /// State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile = FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
