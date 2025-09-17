import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'file_upload_pop_up_widget.dart' show FileUploadPopUpWidget;
import 'package:flutter/material.dart';

class FileUploadPopUpModel extends FlutterFlowModel<FileUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? richtext;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<CourseplanRow>? courseplancheck;
  bool isDataUploading_uploadData940 = false;
  FFUploadedFile uploadedLocalFile_uploadData940 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData940 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<CourseplanRow>? courseplanoutput;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  CourseplanRow? emptyinsert;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
