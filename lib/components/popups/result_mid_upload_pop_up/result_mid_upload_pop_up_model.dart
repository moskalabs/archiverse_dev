import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'result_mid_upload_pop_up_widget.dart' show ResultMidUploadPopUpWidget;
import 'package:flutter/material.dart';

class ResultMidUploadPopUpModel
    extends FlutterFlowModel<ResultMidUploadPopUpWidget> {
  ///  Local state fields for this component.

  bool fileUpload = false;

  bool fileFinalUpload = false;

  String? richtext;

  /// 처음인지 두번째들어오는건지
  bool insertBool = true;

  ///  State fields for stateful widgets in this component.

  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered1 = false;
  bool isDataUploading_uploadData945 = false;
  FFUploadedFile uploadedLocalFile_uploadData945 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData945 = '';

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered2 = false;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  MidtermResultsRow? emptyinsert;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<MidtermResultsRow>? updateoutput;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
