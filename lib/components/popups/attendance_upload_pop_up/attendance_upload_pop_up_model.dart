import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'attendance_upload_pop_up_widget.dart' show AttendanceUploadPopUpWidget;
import 'package:flutter/material.dart';

class AttendanceUploadPopUpModel
    extends FlutterFlowModel<AttendanceUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? fileName;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Container widget.
  List<AttendanceRow>? attendancecheck;
  bool isDataUploading_uploadData941 = false;
  FFUploadedFile uploadedLocalFile_uploadData941 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData941 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<AttendanceRow>? attendanceoutput;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  AttendanceRow? emptyinsert;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
