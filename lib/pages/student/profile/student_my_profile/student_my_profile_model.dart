import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/student_header/student_header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/student_left_widget/student_left_widget_widget.dart';
import '/components/default_layout/left_right/student_right_widget/student_right_widget_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar/student_navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar_mobile/student_navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'student_my_profile_widget.dart' show StudentMyProfileWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class StudentMyProfileModel extends FlutterFlowModel<StudentMyProfileWidget> {
  ///  Local state fields for this page.

  bool toggle1 = false;

  /// 학년 드롭다운에서 텍스트로 받은값
  String? gradeSelectedString = '1학년';

  /// 학년 선택에 따른 과목 정해진것
  String? courseSelectedByGrade;

  StudentPostRow? studentPostList;

  StudentMyprofileRow? studentMyprofileList;

  StudentMajorChangeRequestsRow? pendingChangeRequest;

  int? nextInMobile = -1;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in StudentMyProfile widget.
  List<StudentPostRow>? stuName;
  // Stores action output result for [Backend Call - Query Rows] action in StudentMyProfile widget.
  List<StudentMyprofileRow>? myProfileList;
  // Model for StudentNaviSidebar component.
  late StudentNaviSidebarModel studentNaviSidebarModel;
  // Model for StudentHeader component.
  late StudentHeaderModel studentHeaderModel;
  // Model for StudentLeftWidget component.
  late StudentLeftWidgetModel studentLeftWidgetModel;
  bool isDataUploading_uploadData1ti = false;
  FFUploadedFile uploadedLocalFile_uploadData1ti =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData1ti = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Container widget.
  List<StudentMyprofileRow>? studentUpdateImgeUrl;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode;
  TextEditingController? fullNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextControllerValidator;
  // State field(s) for PhonetextField widget.
  FocusNode? phonetextFieldFocusNode;
  TextEditingController? phonetextFieldTextController;
  late MaskTextInputFormatter phonetextFieldMask;
  String? Function(BuildContext, String?)?
      phonetextFieldTextControllerValidator;
  // State field(s) for BirthtextField widget.
  FocusNode? birthtextFieldFocusNode;
  TextEditingController? birthtextFieldTextController;
  String? Function(BuildContext, String?)?
      birthtextFieldTextControllerValidator;
  // State field(s) for EmailTextField widget.
  FocusNode? emailTextFieldFocusNode;
  TextEditingController? emailTextFieldTextController;
  late MaskTextInputFormatter emailTextFieldMask;
  String? Function(BuildContext, String?)?
      emailTextFieldTextControllerValidator;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController1;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController2;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // State field(s) for DropDown widget.
  String? dropDownValue3;
  FormFieldController<String>? dropDownValueController3;
  // State field(s) for DropDown widget.
  String? dropDownValue4;
  FormFieldController<String>? dropDownValueController4;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController4;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController5;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController5;
  String? Function(BuildContext, String?)? textController5Validator;
  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  List<String>? get choiceChipsValues => choiceChipsValueController?.value;
  set choiceChipsValues(List<String>? val) =>
      choiceChipsValueController?.value = val;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController6;
  String? Function(BuildContext, String?)? textController6Validator;
  // State field(s) for CertiTextField widget.
  FocusNode? certiTextFieldFocusNode;
  TextEditingController? certiTextFieldTextController;
  String? Function(BuildContext, String?)?
      certiTextFieldTextControllerValidator;
  // State field(s) for CompTextField widget.
  FocusNode? compTextFieldFocusNode;
  TextEditingController? compTextFieldTextController;
  String? Function(BuildContext, String?)? compTextFieldTextControllerValidator;
  // State field(s) for NetworkTextField widget.
  FocusNode? networkTextFieldFocusNode;
  TextEditingController? networkTextFieldTextController;
  String? Function(BuildContext, String?)?
      networkTextFieldTextControllerValidator;
  // State field(s) for SWTextField widget.
  FocusNode? sWTextFieldFocusNode;
  TextEditingController? sWTextFieldTextController;
  String? Function(BuildContext, String?)? sWTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<StudentMyprofileRow>? updaterow;
  // Model for StudentRightWidget component.
  late StudentRightWidgetModel studentRightWidgetModel;
  // Model for StudentHeader_Mobile component.
  late StudentHeaderMobileModel studentHeaderMobileModel;
  // Model for StudentNaviSidebar_Mobile component.
  late StudentNaviSidebarMobileModel studentNaviSidebarMobileModel;

  @override
  void initState(BuildContext context) {
    studentNaviSidebarModel =
        createModel(context, () => StudentNaviSidebarModel());
    studentHeaderModel = createModel(context, () => StudentHeaderModel());
    studentLeftWidgetModel =
        createModel(context, () => StudentLeftWidgetModel());
    studentRightWidgetModel =
        createModel(context, () => StudentRightWidgetModel());
    studentHeaderMobileModel =
        createModel(context, () => StudentHeaderMobileModel());
    studentNaviSidebarMobileModel =
        createModel(context, () => StudentNaviSidebarMobileModel());
  }

  @override
  void dispose() {
    studentNaviSidebarModel.dispose();
    studentHeaderModel.dispose();
    studentLeftWidgetModel.dispose();
    fullNameTextFieldFocusNode?.dispose();
    fullNameTextFieldTextController?.dispose();

    phonetextFieldFocusNode?.dispose();
    phonetextFieldTextController?.dispose();

    birthtextFieldFocusNode?.dispose();
    birthtextFieldTextController?.dispose();

    emailTextFieldFocusNode?.dispose();
    emailTextFieldTextController?.dispose();

    textFieldFocusNode1?.dispose();
    textController5?.dispose();

    textFieldFocusNode2?.dispose();
    textController6?.dispose();

    certiTextFieldFocusNode?.dispose();
    certiTextFieldTextController?.dispose();

    compTextFieldFocusNode?.dispose();
    compTextFieldTextController?.dispose();

    networkTextFieldFocusNode?.dispose();
    networkTextFieldTextController?.dispose();

    sWTextFieldFocusNode?.dispose();
    sWTextFieldTextController?.dispose();

    studentRightWidgetModel.dispose();
    studentHeaderMobileModel.dispose();
    studentNaviSidebarMobileModel.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue1 => radioButtonValueController1?.value;
  String? get radioButtonValue2 => radioButtonValueController2?.value;
  String? get radioButtonValue3 => radioButtonValueController3?.value;
  String? get radioButtonValue4 => radioButtonValueController4?.value;
  String? get radioButtonValue5 => radioButtonValueController5?.value;
}
