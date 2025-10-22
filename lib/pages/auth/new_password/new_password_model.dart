import '/flutter_flow/flutter_flow_util.dart';
import 'new_password_widget.dart' show NewPasswordWidget;
import 'package:flutter/material.dart';

class NewPasswordModel extends FlutterFlowModel<NewPasswordWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();

  // State field(s) for NewPassword widget.
  FocusNode? newPasswordFocusNode;
  TextEditingController? newPasswordTextController;
  late bool newPasswordVisibility;
  String? Function(BuildContext, String?)? newPasswordTextControllerValidator;
  String? _newPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '새 비밀번호를 입력해주세요.';
    }

    if (val.length < 6) {
      return '비밀번호는 최소 6자 이상이어야 합니다.';
    }

    return null;
  }

  // State field(s) for ConfirmPassword widget.
  FocusNode? confirmPasswordFocusNode;
  TextEditingController? confirmPasswordTextController;
  late bool confirmPasswordVisibility;
  String? Function(BuildContext, String?)?
      confirmPasswordTextControllerValidator;
  String? _confirmPasswordTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return '비밀번호 확인을 입력해주세요.';
    }

    if (val != newPasswordTextController.text) {
      return '비밀번호가 일치하지 않습니다.';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    newPasswordVisibility = false;
    newPasswordTextControllerValidator =
        _newPasswordTextControllerValidator;
    confirmPasswordVisibility = false;
    confirmPasswordTextControllerValidator =
        _confirmPasswordTextControllerValidator;
  }

  @override
  void dispose() {
    newPasswordFocusNode?.dispose();
    newPasswordTextController?.dispose();

    confirmPasswordFocusNode?.dispose();
    confirmPasswordTextController?.dispose();
  }
}
