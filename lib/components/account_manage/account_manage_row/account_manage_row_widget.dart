import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account_manage_row_model.dart';
export 'account_manage_row_model.dart';

class AccountManageRowWidget extends StatefulWidget {
  const AccountManageRowWidget({
    super.key,
    required this.post,
    this.confirmEdit,
    this.onSelected,
  });

  final PostsRow post;
  final Future<void> Function(bool confirm, Map<String, dynamic> updatedData)?
      confirmEdit;
  final VoidCallback? onSelected;

  @override
  State<AccountManageRowWidget> createState() => _AccountManageRowWidgetState();
}

class _AccountManageRowWidgetState extends State<AccountManageRowWidget> {
  late AccountManageRowModel _model;
  bool _hasInitializedLocalizedValues = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountManageRowModel());
    _model.nameTextController ??=
        TextEditingController(text: widget.post.name ?? '');
    _model.phoneTextController ??=
        TextEditingController(text: widget.post.phone ?? '');
    final initialUserTypeLabel = _userTypeLabel(widget.post.userType);
    _model.dropDownValue1 = initialUserTypeLabel;
    _model.dropDownValueController1 =
        FormFieldController<String>(initialUserTypeLabel);

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasInitializedLocalizedValues) {
      return;
    }
    final permissionLabel =
        _permissionLabelFromLevel(widget.post.permissionLevel ?? 1);
    _model.dropDownValue2 = permissionLabel;
    _model.dropDownValueController2 =
        FormFieldController<String>(permissionLabel);
    _hasInitializedLocalizedValues = true;
  }

  @override
  void didUpdateWidget(AccountManageRowWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_model.isEditing) {
      _model.nameTextController?.text = widget.post.name ?? '';
      _model.phoneTextController?.text = widget.post.phone ?? '';
      final userTypeLabel = _userTypeLabel(widget.post.userType);
      _model.dropDownValue1 = userTypeLabel;
      _model.dropDownValueController1?.value = userTypeLabel;
      final permissionLabel =
          _permissionLabelFromLevel(widget.post.permissionLevel ?? 1);
      _model.dropDownValue2 = permissionLabel;
      _model.dropDownValueController2?.value = permissionLabel;
      _hasInitializedLocalizedValues = true;
    }
  }

  String _permissionLabelFromLevel(int level) {
    return level >= 2
        ? FFLocalizations.of(context).getText('cvxeomw7' /* 마스터 */)
        : FFLocalizations.of(context).getText('1pk19gyt' /* 멤버 */);
  }

  String _userTypeLabel(int? userType) {
    switch (userType) {
      case 0:
        return '마스터';
      case 1:
        return '전임';
      case 2:
        return '겸임';
      case 4:
        return '조교';
      case 3:
      default:
        return '일반';
    }
  }

  int _userTypeValueFromLabel(String? label) {
    switch (label) {
      case '마스터':
        return 0;
      case '전임':
        return 1;
      case '겸임':
        return 2;
      case '조교':
        return 4;
      case '일반':
      default:
        return 3;
    }
  }

  int _permissionLevelFromLabel(String label) {
    final masterLabel = FFLocalizations.of(context).getText('cvxeomw7');
    return label == masterLabel ? 2 : 1;
  }

  void _enterEditMode() {
    _model.isEditing = true;
    _model.nameTextController?.text = widget.post.name ?? '';
    _model.phoneTextController?.text = widget.post.phone ?? '';
    final userTypeLabel = _userTypeLabel(widget.post.userType);
    _model.dropDownValue1 = userTypeLabel;
    _model.dropDownValueController1?.value = userTypeLabel;
    final permissionLabel =
        _permissionLabelFromLevel(widget.post.permissionLevel ?? 1);
    _model.dropDownValue2 = permissionLabel;
    _model.dropDownValueController2?.value = permissionLabel;
    safeSetState(() {});
  }

  Future<void> _saveChanges() async {
    final updatedData = <String, dynamic>{};
    final newName = _model.nameTextController?.text.trim() ?? '';
    final newPhone = _model.phoneTextController?.text.trim() ?? '';
    final newUserTypeLabel =
        _model.dropDownValue1 ?? _userTypeLabel(widget.post.userType);
    final newPermissionLabel = _model.dropDownValue2 ??
        FFLocalizations.of(context).getText('1pk19gyt');
    final newPermission = _permissionLevelFromLabel(newPermissionLabel);

    if (newName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이름을 입력해주세요.')),
      );
      return;
    }

    if (newName != (widget.post.name ?? '')) {
      updatedData['name'] = newName;
    }
    final newUserType = _userTypeValueFromLabel(newUserTypeLabel);
    if (widget.post.userType == null || widget.post.userType != newUserType) {
      updatedData['user_type'] = newUserType;
    }
    if (newUserTypeLabel != (widget.post.position ?? '')) {
      updatedData['position'] = newUserTypeLabel;
    }
    if (newPhone != (widget.post.phone ?? '')) {
      updatedData['phone'] = newPhone;
    }
    if (newPermission != (widget.post.permissionLevel ?? 1)) {
      updatedData['permission_level'] = newPermission;
    }

    if (updatedData.isEmpty) {
      _model.isEditing = false;
      safeSetState(() {});
      return;
    }

    try {
      _model.isSaving = true;
      safeSetState(() {});
      await PostsTable().update(
        data: updatedData,
        matchingRows: (rows) => rows.eq('id', widget.post.id),
      );
      _model.editedData = updatedData;
      await widget.confirmEdit?.call(true, updatedData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('정보가 저장되었습니다.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('저장에 실패했습니다: $e')),
      );
    } finally {
      _model.isSaving = false;
      _model.isEditing = false;
      safeSetState(() {});
    }
  }

  Future<void> _handleButtonPressed() async {
    if (_model.isSaving) {
      return;
    }
    if (!_model.isEditing) {
      _enterEditMode();
      return;
    }
    await _saveChanges();
  }

  @override
  Widget build(BuildContext context) {
    final positionOptions = [
      _userTypeLabel(0),
      _userTypeLabel(1),
      _userTypeLabel(2),
      _userTypeLabel(3),
      _userTypeLabel(4),
    ];
    final permissionOptions = [
      FFLocalizations.of(context).getText('1pk19gyt' /* 멤버 */),
      FFLocalizations.of(context).getText('cvxeomw7' /* 마스터 */),
    ];

    final nameStyle = FlutterFlowTheme.of(context).bodyMedium.override(
          font: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
          ),
          color: const Color(0xFF4E4E4E),
          fontSize: 20.0,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w500,
          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
        );

    return InkWell(
      onTap: _model.isEditing ? null : widget.onSelected,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0, 0.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: _model.isEditing
                    ? TextFormField(
                        controller: _model.nameTextController,
                        focusNode: _model.nameFocusNode,
                        autofocus: true,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: UnderlineInputBorder(),
                        ),
                        style: nameStyle,
                      )
                    : Text(
                        widget.post.name ?? '-',
                        style: nameStyle,
                      ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0, 0.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: _model.isEditing
                    ? FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController1 ??=
                            FormFieldController<String>(
                          _model.dropDownValue1 ??
                              _userTypeLabel(widget.post.userType),
                        ),
                        options: positionOptions,
                        onChanged: (val) =>
                            safeSetState(() => _model.dropDownValue1 = val),
                        width: double.infinity,
                        height: 40.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.openSans(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        hintText: FFLocalizations.of(context)
                            .getText('yt5tcduf' /* 직급 선택 */),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 0.0, 8.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      )
                    : Text(
                        _userTypeLabel(widget.post.userType),
                        style: nameStyle,
                      ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0, 0.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.post.email ?? '-',
                    style: nameStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0, 0.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: _model.isEditing
                      ? TextFormField(
                          controller: _model.phoneTextController,
                          focusNode: _model.phoneFocusNode,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: UnderlineInputBorder(),
                          ),
                          style: nameStyle,
                        )
                      : Text(
                          widget.post.phone ?? '-',
                          style: nameStyle,
                        ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0, 0.0, 8.0, 0.0),
                child: Align(
                  alignment: Alignment.center,
                  child: _model.isEditing
                    ? FlutterFlowDropDown<String>(
                        controller: _model.dropDownValueController2 ??=
                            FormFieldController<String>(
                          _model.dropDownValue2 ??
                              _permissionLabelFromLevel(
                                  widget.post.permissionLevel ?? 1),
                        ),
                        options: permissionOptions,
                        onChanged: (val) =>
                            safeSetState(() => _model.dropDownValue2 = val),
                        width: double.infinity,
                        height: 40.0,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              font: GoogleFonts.openSans(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                        hintText: FFLocalizations.of(context)
                            .getText('res31ula' /* 권한선택 */),
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor: Colors.transparent,
                        borderWidth: 0.0,
                        borderRadius: 8.0,
                        margin: const EdgeInsetsDirectional.fromSTEB(
                            8.0, 0.0, 8.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: false,
                      )
                    : Text(
                        _permissionLabelFromLevel(
                            widget.post.permissionLevel ?? 1),
                        style: nameStyle,
                      ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0, 0.0, 8.0, 0.0),
                child: SizedBox(
                  height: 36.0,
                  child: FFButtonWidget(
                    onPressed: _handleButtonPressed,
                    text: _model.isSaving
                        ? '저장중'
                        : (_model.isEditing
                            ? '완료'
                            : FFLocalizations.of(context)
                                .getText('ndcle0l5' /* 수정 */)),
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 36.0,
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      color: _model.isEditing
                          ? FlutterFlowTheme.of(context).mainColor1
                          : Colors.white,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: _model.isEditing
                                    ? Colors.white
                                    : const Color(0xFF666666),
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                      elevation: 0.0,
                      borderSide: const BorderSide(
                        color: Color(0xFF666666),
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
