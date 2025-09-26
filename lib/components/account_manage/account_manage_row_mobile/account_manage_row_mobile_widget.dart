import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'account_manage_row_mobile_model.dart';
export 'account_manage_row_mobile_model.dart';

class AccountManageRowMobileWidget extends StatefulWidget {
  const AccountManageRowMobileWidget({
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
  State<AccountManageRowMobileWidget> createState() =>
      _AccountManageRowMobileWidgetState();
}

class _AccountManageRowMobileWidgetState
    extends State<AccountManageRowMobileWidget> {
  late AccountManageRowMobileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AccountManageRowMobileModel());
    _initializeControllers();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  void _initializeControllers() {
    _model.nameTextController ??=
        TextEditingController(text: widget.post.name ?? '');
    _model.phoneTextController ??=
        TextEditingController(text: widget.post.phone ?? '');
    _model.dropDownValue1 = widget.post.position ?? '';
    _model.dropDownValueController1 =
        FormFieldController<String>(_model.dropDownValue1);
    final permissionLabel =
        _permissionLabelFromLevel(widget.post.permissionLevel ?? 1);
    _model.dropDownValue2 = permissionLabel;
    _model.dropDownValueController2 =
        FormFieldController<String>(_model.dropDownValue2);
  }

  @override
  void didUpdateWidget(AccountManageRowMobileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_model.isEditing) {
      _model.nameTextController?.text = widget.post.name ?? '';
      _model.phoneTextController?.text = widget.post.phone ?? '';
      _model.dropDownValue1 = widget.post.position ?? '';
      _model.dropDownValueController1?.value = _model.dropDownValue1;
      final permissionLabel =
          _permissionLabelFromLevel(widget.post.permissionLevel ?? 1);
      _model.dropDownValue2 = permissionLabel;
      _model.dropDownValueController2?.value = permissionLabel;
    }
  }

  String _permissionLabelFromLevel(int level) {
    return level >= 2
        ? FFLocalizations.of(context).getText('alvyj0rj' /* 마스터 */)
        : FFLocalizations.of(context).getText('qndnhdqy' /* 멤버 */);
  }

  int _permissionLevelFromLabel(String label) {
    final masterLabel = FFLocalizations.of(context).getText('alvyj0rj');
    return label == masterLabel ? 2 : 1;
  }

  void _enterEditMode() {
    _model.isEditing = true;
    _model.nameTextController?.text = widget.post.name ?? '';
    _model.phoneTextController?.text = widget.post.phone ?? '';
    _model.dropDownValue1 = widget.post.position ?? '';
    _model.dropDownValueController1?.value = _model.dropDownValue1;
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
    final newPosition = _model.dropDownValue1 ?? '';
    final newPermissionLabel =
        _model.dropDownValue2 ?? FFLocalizations.of(context).getText('qndnhdqy');
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
    if (newPosition.isNotEmpty &&
        newPosition != (widget.post.position ?? '')) {
      updatedData['position'] = newPosition;
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
      FFLocalizations.of(context).getText('mb3npfo1' /* PD교수 */),
      FFLocalizations.of(context).getText('0vhldvlp' /* 정교수 */),
      FFLocalizations.of(context).getText('3e1pixer' /* 부교수 */),
      FFLocalizations.of(context).getText('m0j5ogkh' /* 겸임교수 */),
      FFLocalizations.of(context).getText('dh76ex0t' /* 인증조교 */),
    ];
    final permissionOptions = [
      FFLocalizations.of(context).getText('qndnhdqy' /* 멤버 */),
      FFLocalizations.of(context).getText('alvyj0rj' /* 마스터 */),
    ];

    final textStyle = FlutterFlowTheme.of(context).bodyMedium.override(
          font: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
          ),
          color: const Color(0xFF4E4E4E),
          fontSize: 13.0,
          letterSpacing: 0.0,
          fontWeight: FontWeight.w500,
          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
        );

    return InkWell(
      onTap: _model.isEditing ? null : widget.onSelected,
      child: Container(
        padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: _model.isEditing
                        ? TextFormField(
                            controller: _model.nameTextController,
                            focusNode: _model.nameFocusNode,
                            decoration: const InputDecoration(
                              isDense: true,
                              border: UnderlineInputBorder(),
                            ),
                            style: textStyle,
                          )
                        : Text(
                            widget.post.name ?? '-',
                            style: textStyle,
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: _model.isEditing
                        ? FlutterFlowDropDown<String>(
                            controller: _model.dropDownValueController1 ??=
                                FormFieldController<String>(
                              _model.dropDownValue1 ?? widget.post.position,
                            ),
                            options: positionOptions,
                            onChanged: (val) =>
                                safeSetState(() => _model.dropDownValue1 = val),
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
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context)
                                .getText('z343ki7l' /* 직급 */),
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
                                12.0, 0.0, 12.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          )
                        : Text(
                            widget.post.position ??
                                FFLocalizations.of(context)
                                    .getText('z343ki7l'),
                            style: textStyle,
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: const AlignmentDirectional(0.0, 0.0),
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
                                  fontSize: 13.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                ),
                            hintText: FFLocalizations.of(context)
                                .getText('b6a4fzbx' /* 권한 */),
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
                                12.0, 0.0, 12.0, 0.0),
                            hidesUnderline: true,
                            isOverButton: false,
                            isSearchable: false,
                            isMultiSelect: false,
                          )
                        : Text(
                            _permissionLabelFromLevel(
                                widget.post.permissionLevel ?? 1),
                            style: textStyle,
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: _handleButtonPressed,
                      text: _model.isSaving
                          ? '저장중'
                          : (_model.isEditing
                              ? '완료'
                              : FFLocalizations.of(context)
                                  .getText('ndcle0l5' /* 수정 */)),
                      options: FFButtonOptions(
                        width: 75.0,
                        height: 30.0,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
