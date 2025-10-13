import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'lecture_file_upload_pop_up_widget.dart'
    show LectureFileUploadPopUpWidget;
import 'package:flutter/material.dart';

class LectureFileUploadPopUpModel
    extends FlutterFlowModel<LectureFileUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? richtext;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<LecturematerialRow>? lecturecheck;
  bool isDataUploading_uploadData944 = false;
  FFUploadedFile uploadedLocalFile_uploadData944 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData944 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<LecturematerialRow>? lectureoutput;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  LecturematerialRow? emptyinsert;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
