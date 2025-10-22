import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reset_password_model.dart';
export 'reset_password_model.dart';

class ResetPasswordWidget extends StatefulWidget {
  const ResetPasswordWidget({
    super.key,
    this.email,
  });

  final String? email;

  static String routeName = 'ResetPassword';
  static String routePath = '/resetPassword';

  @override
  State<ResetPasswordWidget> createState() => _ResetPasswordWidgetState();
}

class _ResetPasswordWidgetState extends State<ResetPasswordWidget> {
  late ResetPasswordModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ResetPasswordModel());

    _model.emailTextFieldTextController ??=
        TextEditingController(text: widget.email);
    _model.emailTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            '비밀번호 재설정',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.openSans(
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: 500.0,
              ),
              decoration: BoxDecoration(),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo or Icon
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 24.0),
                      child: Icon(
                        Icons.lock_reset,
                        color: Color(0xFF284E75),
                        size: 64.0,
                      ),
                    ),
                    // Title
                    Text(
                      '비밀번호를 잊으셨나요?',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                            ),
                            fontSize: 28.0,
                            letterSpacing: 0.0,
                          ),
                    ),
                    // Description
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 32.0),
                      child: Text(
                        '가입하신 이메일 주소를 입력해주세요.\n비밀번호 재설정 링크를 보내드립니다.',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.openSans(),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 15.0,
                              letterSpacing: 0.0,
                              lineHeight: 1.5,
                            ),
                      ),
                    ),
                    // Email Input Field
                    Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Email Label
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 8.0),
                            child: Text(
                              '이메일',
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ),
                          // Email TextField
                          TextFormField(
                            controller: _model.emailTextFieldTextController,
                            focusNode: _model.emailTextFieldFocusNode,
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'example@sch.ac.kr',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    font: GoogleFonts.openSans(),
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    letterSpacing: 0.0,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color:
                                      FlutterFlowTheme.of(context).neutral500,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF284E75),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              contentPadding: EdgeInsetsDirectional.fromSTEB(
                                  16.0, 16.0, 16.0, 16.0),
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyLarge
                                .override(
                                  font: GoogleFonts.openSans(),
                                  letterSpacing: 0.0,
                                ),
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                            validator: _model
                                .emailTextFieldTextControllerValidator
                                .asValidator(context),
                          ),
                          // Submit Button
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 24.0, 0.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: (_model.emailTextFieldTextController
                                              .text ==
                                          '')
                                  ? null
                                  : () async {
                                      // 폼 유효성 검사
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }

                                      final email =
                                          _model.emailTextFieldTextController.text;

                                      try {
                                        // Supabase 비밀번호 재설정 이메일 전송
                                        // 리다이렉트 URL은 새 비밀번호 입력 페이지로 설정
                                        await SupaFlow.client.auth
                                            .resetPasswordForEmail(
                                          email,
                                          redirectTo:
                                              'http://localhost:58791/newPassword',
                                        );

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '비밀번호 재설정 링크를 이메일로 전송했습니다.\n이메일을 확인해주세요.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor: Color(0xFF284E75),
                                            ),
                                          );

                                          // 잠시 후 로그인 페이지로 이동
                                          await Future.delayed(
                                              Duration(milliseconds: 2000));
                                          context.pop();
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '오류가 발생했습니다. 이메일 주소를 확인하고 다시 시도해주세요.',
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                              ),
                                              duration:
                                                  Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                            ),
                                          );
                                        }
                                      }
                                    },
                              text: '재설정 링크 전송',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 50.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: Color(0xFF284E75),
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      font: GoogleFonts.openSans(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(8.0),
                                disabledColor:
                                    FlutterFlowTheme.of(context).neutral500,
                                disabledTextColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Back to Login
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                      child: InkWell(
                        onTap: () {
                          context.pop();
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 16.0,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 0.0, 0.0),
                              child: Text(
                                '로그인으로 돌아가기',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.openSans(),
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
