import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'work_eval_upload_pop_up_widget.dart' show WorkEvalUploadPopUpWidget;
import 'package:flutter/material.dart';

class WorkEvalUploadPopUpModel
    extends FlutterFlowModel<WorkEvalUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? richtext;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<WorkevalformRow>? workevalcheck;
  bool isDataUploading_uploadData943 = false;
  FFUploadedFile uploadedLocalFile_uploadData943 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData943 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<WorkevalformRow>? workevaloutput;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  WorkevalformRow? emptyinsert;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
