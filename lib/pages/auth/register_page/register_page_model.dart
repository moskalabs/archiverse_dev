import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'register_page_widget.dart' show RegisterPageWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPageModel extends FlutterFlowModel<RegisterPageWidget> {
  ///  Local state fields for this page.

  bool termButtonClicked = false;

  bool privacyButtonClicked = false;

  int? foraction = -1;

  ProfessorValidationRow? validationquery;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // State field(s) for UniversityDropdown widget.
  String? universityDropdownValue;
  FormFieldController<String>? universityDropdownValueController;
  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // State field(s) for StudentIdTextField widget.
  FocusNode? studentIdTextFieldFocusNode1;
  TextEditingController? studentIdTextFieldTextController1;
  String? Function(BuildContext, String?)?
      studentIdTextFieldTextController1Validator;
  String? _studentIdTextFieldTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'zzc2h6me' /* 학번을 적어주세요 is required */,
      );
    }

    return null;
  }

  // State field(s) for StudentIdTextField widget.
  FocusNode? studentIdTextFieldFocusNode2;
  TextEditingController? studentIdTextFieldTextController2;
  late MaskTextInputFormatter studentIdTextFieldMask2;
  String? Function(BuildContext, String?)?
      studentIdTextFieldTextController2Validator;
  String? _studentIdTextFieldTextController2Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'srf9aklb' /* 핸드폰 번호를 입력해주세요 is required */,
      );
    }

    return null;
  }

  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode;
  TextEditingController? fullNameTextFieldTextController;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextControllerValidator;
  String? _fullNameTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'g5z08bth' /* Full Name is required */,
      );
    }

    return null;
  }

  // State field(s) for EmailTextField widget.
  FocusNode? emailTextFieldFocusNode;
  TextEditingController? emailTextFieldTextController;
  String? Function(BuildContext, String?)?
      emailTextFieldTextControllerValidator;
  String? _emailTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'rjhlu7c6' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        '754pmoxr' /* 이메일을 확인해주세요 */,
      );
    }
    return null;
  }

  // State field(s) for PasswordTextField widget.
  FocusNode? passwordTextFieldFocusNode;
  TextEditingController? passwordTextFieldTextController;
  late bool passwordTextFieldVisibility;
  String? Function(BuildContext, String?)?
      passwordTextFieldTextControllerValidator;
  String? _passwordTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'xftq4m1o' /* Field is required */,
      );
    }

    if (val.length < 8) {
      return FFLocalizations.of(context).getText(
        '20ttn93i' /* 최소 8자리 이상 입력해주세요 */,
      );
    }

    if (!RegExp('^(?=.*[A-Z])(?=.*[~!@#\$%^*+=-])(?=.*[a-zA-Z0-9]).{8,}\$')
        .hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'a58zrk2j' /* 최소 대문자 1개, 특수문자 1개 필요합니다. */,
      );
    }
    return null;
  }

  // State field(s) for PassVerifyField widget.
  FocusNode? passVerifyFieldFocusNode;
  TextEditingController? passVerifyFieldTextController;
  late bool passVerifyFieldVisibility;
  String? Function(BuildContext, String?)?
      passVerifyFieldTextControllerValidator;
  String? _passVerifyFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'q73pt39m' /* 비밀번호 확인 is required */,
      );
    }

    if (val.length < 8) {
      return FFLocalizations.of(context).getText(
        '5bd4txkp' /* 최소 8자리 이상 입력해주세요 */,
      );
    }

    if (!RegExp('^(?=.*[A-Z])(?=.*[~!@#\$%^*+=-])(?=.*[a-zA-Z0-9]).{8,}\$')
        .hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'm1zqkij4' /* 최소 대문자 1개, 특수문자 1개 필요합니다. */,
      );
    }
    return null;
  }

  // State field(s) for cb_terms widget.
  bool? cbTermsValue;
  // Stores action output result for [Backend Call - Query Rows] action in Button widget.
  List<ProfessorValidationRow>? pfrValidOutput;
  // Stores action output result for [Backend Call - Insert Row] action in Button widget.
  PostsRow? insertpfr;

  @override
  void initState(BuildContext context) {
    studentIdTextFieldTextController1Validator =
        _studentIdTextFieldTextController1Validator;
    studentIdTextFieldTextController2Validator =
        _studentIdTextFieldTextController2Validator;
    fullNameTextFieldTextControllerValidator =
        _fullNameTextFieldTextControllerValidator;
    emailTextFieldTextControllerValidator =
        _emailTextFieldTextControllerValidator;
    passwordTextFieldVisibility = false;
    passwordTextFieldTextControllerValidator =
        _passwordTextFieldTextControllerValidator;
    passVerifyFieldVisibility = false;
    passVerifyFieldTextControllerValidator =
        _passVerifyFieldTextControllerValidator;
  }

  @override
  void dispose() {
    studentIdTextFieldFocusNode1?.dispose();
    studentIdTextFieldTextController1?.dispose();

    studentIdTextFieldFocusNode2?.dispose();
    studentIdTextFieldTextController2?.dispose();

    fullNameTextFieldFocusNode?.dispose();
    fullNameTextFieldTextController?.dispose();

    emailTextFieldFocusNode?.dispose();
    emailTextFieldTextController?.dispose();

    passwordTextFieldFocusNode?.dispose();
    passwordTextFieldTextController?.dispose();

    passVerifyFieldFocusNode?.dispose();
    passVerifyFieldTextController?.dispose();
  }

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
