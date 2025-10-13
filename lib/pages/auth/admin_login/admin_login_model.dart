import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'admin_login_widget.dart' show AdminLoginWidget;
import 'package:flutter/material.dart';

class AdminLoginModel extends FlutterFlowModel<AdminLoginWidget> {
  ///  Local state fields for this page.

  Color? buttonColorSelected = Color(4280831605);

  Color? professorButtonTextColor = Color(4294967295);

  Color? buttonColorSelectStudent;

  Color? studentButtonTextColor;

  String? emailField;

  int? professorUserType = 2;

  bool channelTalk = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for EmailTextField widget.
  FocusNode? emailTextFieldFocusNode;
  TextEditingController? emailTextFieldTextController;
  String? Function(BuildContext, String?)?
      emailTextFieldTextControllerValidator;
  String? _emailTextFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'gau0lo1g' /* 아이디를 입력해주세요. */,
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
        't37qbqzf' /* 비밀번호를 입력해주세요 */,
      );
    }

    return null;
  }

  // Stores action output result for [Backend Call - Query Rows] action in btn_login widget.
  List<AdminPostRow>? adminUserTypeOutput;

  @override
  void initState(BuildContext context) {
    emailTextFieldTextControllerValidator =
        _emailTextFieldTextControllerValidator;
    passwordTextFieldVisibility = false;
    passwordTextFieldTextControllerValidator =
        _passwordTextFieldTextControllerValidator;
  }

  @override
  void dispose() {
    emailTextFieldFocusNode?.dispose();
    emailTextFieldTextController?.dispose();

    passwordTextFieldFocusNode?.dispose();
    passwordTextFieldTextController?.dispose();
  }
}
