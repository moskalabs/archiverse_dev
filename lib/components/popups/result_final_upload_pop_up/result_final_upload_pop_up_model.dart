import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'result_final_upload_pop_up_widget.dart'
    show ResultFinalUploadPopUpWidget;
import 'package:flutter/material.dart';

class ResultFinalUploadPopUpModel
    extends FlutterFlowModel<ResultFinalUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? richtext;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  bool isDataUploading_uploadData942 = false;
  FFUploadedFile uploadedLocalFile_uploadData942 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData942 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<FinalResultsRow>? finallistoutput;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  FinalResultsRow? emptyinsert;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<FinalResultsRow>? updateoutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
