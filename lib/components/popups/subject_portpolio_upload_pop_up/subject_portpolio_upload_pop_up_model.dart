import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'subject_portpolio_upload_pop_up_widget.dart'
    show SubjectPortpolioUploadPopUpWidget;
import 'package:flutter/material.dart';

class SubjectPortpolioUploadPopUpModel
    extends FlutterFlowModel<SubjectPortpolioUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? richtext;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<SubjectportpolioRow>? sPortpoliocheck;
  bool isDataUploading_uploadData952 = false;
  FFUploadedFile uploadedLocalFile_uploadData952 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData952 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  TempPortpolioRow? emptyinsert;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
