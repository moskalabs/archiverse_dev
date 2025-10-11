import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:convert';
import 'dart:ui';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'prof_my_profile_model.dart';
export 'prof_my_profile_model.dart';

/// make a profile page, with name, email, university, carreer,
class ProfMyProfileWidget extends StatefulWidget {
  const ProfMyProfileWidget({super.key});

  static String routeName = 'Prof_MyProfile';
  static String routePath = '/profMyProfile';

  @override
  State<ProfMyProfileWidget> createState() => _ProfMyProfileWidgetState();
}

class _ProfMyProfileWidgetState extends State<ProfMyProfileWidget> {
  late ProfMyProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  static const List<String> _academicFieldKeys = [
    'getDate',
    'university',
    'major',
    'degree',
  ];

  static const List<String> _teachingFieldKeys = [
    'period',
    'schoolDepartment',
    'subject',
    'creditsHours',
  ];

  Map<String, dynamic> _emptyRecord(List<String> fields) => {
        for (final field in fields) field: '',
      };

  Map<String, dynamic> _normalizeRecord(
    dynamic record,
    List<String> fields,
  ) {
    if (record == null) {
      return _emptyRecord(fields);
    }

    Map<String, dynamic> map;
    if (record is Map) {
      map = record.map(
        (key, value) => MapEntry(key.toString(), value),
      );
    } else if (record is String && record.trim().isNotEmpty) {
      try {
        final decoded = jsonDecode(record);
        if (decoded is Map) {
          map = decoded.map(
            (key, value) => MapEntry(key.toString(), value),
          );
        } else {
          map = <String, dynamic>{};
        }
      } catch (_) {
        map = <String, dynamic>{};
      }
    } else {
      map = <String, dynamic>{};
    }

    if (map.isEmpty) {
      for (final field in fields) {
        final value = getJsonField(record, "\$.${field}");
        if (value != null) {
          map[field] = value;
        }
      }
    }

    return {
      for (final field in fields) field: map[field]?.toString() ?? '',
    };
  }

  Iterable<dynamic> _recordsToIterable(dynamic records) {
    if (records == null) {
      return const [];
    }
    if (records is Iterable) {
      return records;
    }
    if (records is String) {
      final trimmed = records.trim();
      if (trimmed.isEmpty) {
        return const [];
      }
      try {
        final decoded = jsonDecode(trimmed);
        if (decoded is Iterable) {
          return decoded;
        }
        if (decoded is Map) {
          return [decoded];
        }
      } catch (_) {
        return const [];
      }
    }
    if (records is Map) {
      return [records];
    }
    return const [];
  }

  List<Map<String, dynamic>> _normalizeRecords(
    dynamic records,
    List<String> fields,
    int maxLength,
  ) {
    final normalized = <Map<String, dynamic>>[];
    for (final record in _recordsToIterable(records)) {
      if (normalized.length >= maxLength) {
        break;
      }
      normalized.add(_normalizeRecord(record, fields));
    }
    if (normalized.isEmpty) {
      normalized.add(_emptyRecord(fields));
    }
    return normalized;
  }

  void _setAcademicRecords(
    List<Map<String, dynamic>> records, {
    bool syncAppState = true,
    bool rebuild = true,
  }) {
    final sanitized = records.isEmpty
        ? <Map<String, dynamic>>[_emptyRecord(_academicFieldKeys)]
        : records
            .take(3)
            .map((record) => {
                  for (final field in _academicFieldKeys)
                    field: record[field]?.toString() ?? '',
                })
            .toList();

    void assign() {
      _model.academicRecords = sanitized
          .map((record) => Map<String, dynamic>.from(record))
          .toList();
      _model.resetAcademicControllersWithRecords(_model.academicRecords);
    }

    if (rebuild) {
      safeSetState(assign);
    } else {
      assign();
    }

    if (syncAppState) {
      FFAppState().mypageAcademicRecords =
          List<dynamic>.from(_model.academicRecords.take(3));
    }
  }

  void _setTeachingRecords(
    List<Map<String, dynamic>> records, {
    bool syncAppState = true,
    bool rebuild = true,
  }) {
    final sanitized = records.isEmpty
        ? <Map<String, dynamic>>[_emptyRecord(_teachingFieldKeys)]
        : records
            .take(4)
            .map((record) => {
                  for (final field in _teachingFieldKeys)
                    field: record[field]?.toString() ?? '',
                })
            .toList();

    void assign() {
      _model.teachingRecords = sanitized
          .map((record) => Map<String, dynamic>.from(record))
          .toList();
      _model.resetTeachingControllersWithRecords(_model.teachingRecords);
    }

    if (rebuild) {
      safeSetState(assign);
    } else {
      assign();
    }

    if (syncAppState) {
      FFAppState().mypageTeachingRecords =
          List<dynamic>.from(_model.teachingRecords.take(4));
    }
  }

  @override
  void initState() {
    super.initState();
    
    // 인증 체크
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!loggedIn) {
        context.goNamedAuth('LoginPage', context.mounted);
        return;
      }
    });
    
    _model = createModel(context, () => ProfMyProfileModel());

    final initialAcademicRecords = _normalizeRecords(
      FFAppState().mypageAcademicRecords,
      _academicFieldKeys,
      3,
    );
    final initialTeachingRecords = _normalizeRecords(
      FFAppState().mypageTeachingRecords,
      _teachingFieldKeys,
      4,
    );
    _setAcademicRecords(
      initialAcademicRecords,
      syncAppState: true,
      rebuild: false,
    );
    _setTeachingRecords(
      initialTeachingRecords,
      syncAppState: true,
      rebuild: false,
    );

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // 추가 인증 체크
      if (!loggedIn) {
        context.goNamedAuth('LoginPage', context.mounted);
        return;
      }
      
      print('🔍 교수 내 정보 로딩 시작');
      print('🔍 professorNameSelected: ${FFAppState().professorNameSelected}');
      
      _model.pfrValList = await ProfessorValidationTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'name',
          FFAppState().professorNameSelected,
        ),
      );
      _model.prfValList = _model.pfrValList?.firstOrNull;
      print('🔍 ProfessorValidation 조회 결과: ${_model.pfrValList?.length ?? 0}건');
      safeSetState(() {});
      safeSetState(() {
        _model.phoneTextFieldTextController?.text = valueOrDefault<String>(
          _model.prfValList?.phoneNum,
          '010-0000-0000',
        );
        _model.phoneTextFieldMask.updateMask(
          newValue: TextEditingValue(
            text: _model.phoneTextFieldTextController!.text,
          ),
        );
      });
      _model.querybyname = await ProfessorMyprofileTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'professor_name',
          FFAppState().professorNameSelected,
        ),
      );
      _model.myProfileList = _model.querybyname?.firstOrNull;
      safeSetState(() {});
      FFAppState().archix = getJsonField(
        _model.querybyname!.firstOrNull!.pfrLicensed!,
        r'''$.archix''',
      );
      FFAppState().archikr = getJsonField(
        _model.querybyname!.firstOrNull!.pfrLicensed!,
        r'''$.archikr''',
      );
      FFAppState().archiabroad = getJsonField(
        _model.querybyname!.firstOrNull!.pfrLicensed!,
        r'''$.archiabroad''',
      );
      FFAppState().technicx = getJsonField(
        _model.querybyname!.firstOrNull!.pfrLicensed!,
        r'''$.technicx''',
      );
      FFAppState().technickr = getJsonField(
        _model.querybyname!.firstOrNull!.pfrLicensed!,
        r'''$.technickr''',
      );
      FFAppState().technicabroad = getJsonField(
        _model.querybyname!.firstOrNull!.pfrLicensed!,
        r'''$.technicabroad''',
      );
      FFAppState().design = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.design''',
      );
      FFAppState().other = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.other''',
      );
      FFAppState().scape = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.scape''',
      );
      FFAppState().structural = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.structural''',
      );
      FFAppState().digital = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.digital''',
      );
      FFAppState().environment = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.environment''',
      );
      FFAppState().consturction = getJsonField(
        _model.querybyname!.firstOrNull!.pfrSpeciality!,
        r'''$.consturction''',
      );
      FFAppState().mypagePhoneNumber =
          _model.querybyname!.firstOrNull!.pfrPhonenumber!;
      FFAppState().mypageBirth = _model.querybyname!.firstOrNull!.pfrBirth!;
      FFAppState().mypagePosition =
          _model.querybyname!.firstOrNull!.prfPositon!;
      FFAppState().mypageProject = _model.querybyname!.firstOrNull!.pfrProject!;
      FFAppState().mypageImageUrl = valueOrDefault<String>(
        _model.myProfileList?.pfrImageurl,
        'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/profileimage/myprofile/1739097345656000.jpg',
      );
      safeSetState(() {});
      if (_model.myProfileList != null) {
        await Future.delayed(
          Duration(
            milliseconds: 500,
          ),
        );
        final supabaseAcademicRecords = _normalizeRecords(
          _model.querybyname!.firstOrNull!.degreeList,
          _academicFieldKeys,
          3,
        );
        final supabaseTeachingRecords = _normalizeRecords(
          _model.querybyname!.firstOrNull!.lecExperience,
          _teachingFieldKeys,
          4,
        );
        _setAcademicRecords(supabaseAcademicRecords);
        _setTeachingRecords(supabaseTeachingRecords);
        safeSetState(() {
          _model.archiAbroadTextFieldTextController?.text = getJsonField(
            _model.myProfileList!.pfrLicensed!,
            r'''$.archiabroaddetail''',
          ).toString();
        });
        safeSetState(() {
          _model.technicAboardTextFieldTextController?.text = getJsonField(
            _model.myProfileList!.pfrLicensed!,
            r'''$.technicabroaddetail''',
          ).toString();
        });
        safeSetState(() {
          _model.otherTextFieldTextController?.text = getJsonField(
            _model.myProfileList!.pfrSpeciality!,
            r'''$.otherdetail''',
          ).toString();
        });
        safeSetState(() {
          _model.birthTextFieldTextController?.text = valueOrDefault<String>(
            _model.myProfileList?.pfrBirth,
            '0000.00',
          );
        });
        safeSetState(() {
          _model.positionTextFieldTextController?.text =
              _model.myProfileList!.prfPositon!;
        });
        safeSetState(() {
          _model.projectTextFieldTextController?.text =
              _model.myProfileList!.pfrProject!;
        });
      } else {
        _setAcademicRecords(
          _normalizeRecords(const [], _academicFieldKeys, 3),
        );
        _setTeachingRecords(
          _normalizeRecords(const [], _teachingFieldKeys, 4),
        );
      }
    });

    _model.fullNameTextFieldTextController1 ??= TextEditingController(
        text: valueOrDefault<String>(
      FFAppState().professorNameSelected,
      '교수님',
    ));
    _model.fullNameTextFieldFocusNode1 ??= FocusNode();

    _model.phoneTextFieldTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      _model.prfValList?.phoneNum,
      '010-0000-0000',
    ));
    _model.phoneTextFieldFocusNode ??= FocusNode();

    _model.phoneTextFieldMask = MaskTextInputFormatter(mask: '###-####-####');
    _model.birthTextFieldTextController ??=
        TextEditingController(text: _model.myProfileList?.pfrBirth);
    _model.birthTextFieldFocusNode ??= FocusNode();

    _model.fullNameTextFieldTextController2 ??= TextEditingController(
        text: valueOrDefault<String>(
      currentUserEmail,
      'abc@abcd.com',
    ));
    _model.fullNameTextFieldFocusNode2 ??= FocusNode();

    _model.fullNameTextFieldTextController3 ??= TextEditingController();
    _model.fullNameTextFieldFocusNode3 ??= FocusNode();

    _model.positionTextFieldTextController ??=
        TextEditingController(text: _model.myProfileList?.prfPositon);
    _model.positionTextFieldFocusNode ??= FocusNode();

    _model.archiAbroadTextFieldTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      getJsonField(
        _model.myProfileList?.pfrLicensed,
        r'''$.archiabroaddetail''',
      )?.toString(),
      '건축사 취득 국가',
    ));
    _model.archiAbroadTextFieldFocusNode ??= FocusNode();

    _model.technicAboardTextFieldTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      getJsonField(
        _model.myProfileList?.pfrLicensed,
        r'''$.technicabroaddetail''',
      )?.toString(),
      '기술사 취득 국가',
    ));
    _model.technicAboardTextFieldFocusNode ??= FocusNode();

    _model.otherTextFieldTextController ??= TextEditingController(
        text: valueOrDefault<String>(
      getJsonField(
        _model.myProfileList?.pfrSpeciality,
        r'''$.otherdetail''',
      )?.toString(),
      '기타 전문 분야',
    ));
    _model.otherTextFieldFocusNode ??= FocusNode();

    _model.projectTextFieldTextController ??=
        TextEditingController(text: _model.myProfileList?.pfrProject);
    _model.projectTextFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {
          _model.fullNameTextFieldTextController3?.text =
              FFLocalizations.of(context).getText(
            '3dsb8u04' /* 순천향대학교 건축학과 */,
          );
        }));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  InputDecoration _recordInputDecoration(
    BuildContext context,
    String hint,
  ) {
    final theme = FlutterFlowTheme.of(context);
    return InputDecoration(
      isDense: true,
      labelStyle: theme.labelMedium.override(
        font: GoogleFonts.openSans(
          fontWeight: theme.labelMedium.fontWeight,
          fontStyle: theme.labelMedium.fontStyle,
        ),
        letterSpacing: 0.0,
      ),
      hintText: hint,
      hintStyle: theme.labelMedium.override(
        font: GoogleFonts.openSans(
          fontWeight: theme.labelMedium.fontWeight,
          fontStyle: theme.labelMedium.fontStyle,
        ),
        letterSpacing: 0.0,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: theme.error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: theme.error,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      filled: true,
      fillColor: theme.secondaryBackground,
    );
  }

    TextStyle _recordTextStyle(BuildContext context) {
      final theme = FlutterFlowTheme.of(context);
      return theme.labelMedium.override(
        font: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontStyle: theme.labelMedium.fontStyle,
        ),
        color: theme.secondaryText,
        fontSize: () {
          final width = MediaQuery.sizeOf(context).width;
          if (width < kBreakpointSmall) {
            return 10.0;
          } else if (width < kBreakpointMedium) {
            return 12.0;
          } else if (width < kBreakpointLarge) {
            return 12.0;
          }
          return 12.0;
        }(),
        letterSpacing: 0.0,
        fontWeight: FontWeight.w600,
      );
    }

    double _sectionTitleFontSize(BuildContext context) {
      final width = MediaQuery.sizeOf(context).width;
      if (width < kBreakpointSmall) {
        return 10.0;
      } else if (width < kBreakpointMedium) {
        return 12.0;
      } else if (width < kBreakpointLarge) {
        return 14.0;
      }
      return 14.0; // 오른쪽 위젯과 동일하게
    }

    double _recordButtonHeight(BuildContext context) {
      final width = MediaQuery.sizeOf(context).width;
      if (width < kBreakpointSmall) {
        return 16.0;
      } else if (width < kBreakpointMedium) {
        return 18.0;
      } else if (width < kBreakpointLarge) {
        return 20.0;
      }
      return 24.0;
    }

    double _recordButtonFontSize(BuildContext context) {
      final width = MediaQuery.sizeOf(context).width;
      if (width < kBreakpointSmall) {
        return 6.0;
      } else if (width < kBreakpointMedium) {
        return 8.0;
      } else if (width < kBreakpointLarge) {
        return 10.0;
      }
      return 12.0;
    }

    Widget _buildSectionTitle(BuildContext context, String label) {
      final theme = FlutterFlowTheme.of(context);
      return Container(
        height: 40.0,
        decoration: BoxDecoration(
          color: theme.primaryBackground,
        ),
        child: Align(
          alignment: const AlignmentDirectional(-1.0, -1.0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
            child: Text(
              label,
              style: theme.bodyMedium.override(
                font: GoogleFonts.openSans(
                  fontWeight: FontWeight.w600,
                  fontStyle: theme.bodyMedium.fontStyle,
                ),
                fontSize: _sectionTitleFontSize(context),
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: theme.bodyMedium.fontStyle,
              ),
            ),
          ),
        ),
      );
    }

    Widget _buildRecordActionRow({
      required BuildContext context,
      required bool canAdd,
      required VoidCallback onAdd,
      required String addLabel,
      required bool canRemove,
      required VoidCallback onRemove,
      required String removeLabel,
    }) {
      final theme = FlutterFlowTheme.of(context);
      if (!canAdd && !canRemove) {
        return const SizedBox.shrink();
      }
      return Container(
        color: theme.primaryBackground,
        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
        child: Row(
          children: [
            if (canAdd)
              FFButtonWidget(
                onPressed: onAdd,
                text: addLabel,
                icon: const Icon(
                  Icons.add_to_photos_outlined,
                  size: 12.0,
                ),
                options: FFButtonOptions(
                  height: _recordButtonHeight(context),
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0,
                    0.0,
                    8.0,
                    0.0,
                  ),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                  ),
                  iconColor: theme.primaryBackground,
                  color: const Color(0xFFA6B6C3),
                  textStyle: theme.titleSmall.override(
                    font: GoogleFonts.openSans(
                      fontWeight: theme.titleSmall.fontWeight,
                      fontStyle: theme.titleSmall.fontStyle,
                    ),
                    color: Colors.white,
                    fontSize: _recordButtonFontSize(context),
                    letterSpacing: 0.0,
                    fontWeight: theme.titleSmall.fontWeight,
                    fontStyle: theme.titleSmall.fontStyle,
                  ),
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            const Spacer(),
            if (canRemove)
              FFButtonWidget(
                onPressed: onRemove,
                text: removeLabel,
                icon: const Icon(
                  Icons.delete_forever,
                  size: 12.0,
                ),
                options: FFButtonOptions(
                  height: _recordButtonHeight(context),
                  padding: const EdgeInsetsDirectional.fromSTEB(
                    8.0,
                    0.0,
                    8.0,
                    0.0,
                  ),
                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                    0.0,
                    0.0,
                    0.0,
                    0.0,
                  ),
                  iconColor: theme.primaryBackground,
                  color: theme.secondaryText,
                  textStyle: theme.titleSmall.override(
                    font: GoogleFonts.openSans(
                      fontWeight: theme.titleSmall.fontWeight,
                      fontStyle: theme.titleSmall.fontStyle,
                    ),
                    color: Colors.white,
                    fontSize: _recordButtonFontSize(context),
                    letterSpacing: 0.0,
                    fontWeight: theme.titleSmall.fontWeight,
                    fontStyle: theme.titleSmall.fontStyle,
                  ),
                  elevation: 0.0,
                  borderSide: BorderSide(
                    color: theme.secondaryText,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
          ],
        ),
      );
    }

  Widget _buildRecordHeaderRow(
    BuildContext context,
    List<String> labels,
  ) {
    final theme = FlutterFlowTheme.of(context);
    final headerStyle = theme.labelMedium.override(
      font: GoogleFonts.openSans(
        fontWeight: FontWeight.w600,
        fontStyle: theme.labelMedium.fontStyle,
      ),
      color: theme.secondaryText,
      fontSize: () {
        final width = MediaQuery.sizeOf(context).width;
        if (width < kBreakpointSmall) {
          return 10.0;
        } else if (width < kBreakpointMedium) {
          return 12.0;
        } else if (width < kBreakpointLarge) {
          return 12.0;
        }
        return 12.0;
      }(),
      letterSpacing: 0.0,
      fontWeight: FontWeight.w600,
      fontStyle: theme.labelMedium.fontStyle,
    );

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        for (int i = 0; i < labels.length; i++) ...[
          Expanded(
            child: Text(
              labels[i],
              style: headerStyle,
            ),
          ),
          if (i < labels.length - 1) SizedBox(width: 8.0),
        ],
      ],
    );
  }

  void _handleAcademicFieldChanged(int index) {
    if (index >= _model.academicGetDateTextControllers.length) {
      return;
    }
    final record = <String, dynamic>{
      'getDate': _model.academicGetDateTextControllers[index].text,
      'university': _model.academicUniversityTextControllers[index].text,
      'major': _model.academicMajorTextControllers[index].text,
      'degree': _model.academicDegreeTextControllers[index].text,
    };
    if (index < FFAppState().mypageAcademicRecords.length) {
      FFAppState().updateMypageAcademicRecordsAtIndex(
        index,
        (_) => record,
      );
    } else {
      FFAppState().addToMypageAcademicRecords(record);
    }
    while (_model.academicRecords.length <= index) {
      _model.addToAcademicRecords(<String, dynamic>{});
    }
    _model.updateAcademicRecordsAtIndex(index, (_) => record);
  }

    void _handleTeachingFieldChanged(int index) {
      if (index >= _model.teachingPeriodTextControllers.length) {
        return;
      }
      final record = <String, dynamic>{
        'period': _model.teachingPeriodTextControllers[index].text,
        'schoolDepartment':
            _model.teachingSchoolTextControllers[index].text,
        'subject': _model.teachingSubjectTextControllers[index].text,
        'creditsHours': _model.teachingCreditTextControllers[index].text,
      };
      if (index < FFAppState().mypageTeachingRecords.length) {
        FFAppState().updateMypageTeachingRecordsAtIndex(
          index,
          (_) => record,
        );
      } else {
        FFAppState().addToMypageTeachingRecords(record);
      }
      while (_model.teachingRecords.length <= index) {
        _model.addToTeachingRecords(<String, dynamic>{});
      }
      _model.updateTeachingRecordsAtIndex(index, (_) => record);
    }

    Widget _buildAcademicSection(BuildContext context) {
      final recordCount = _model.academicGetDateTextControllers.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle(
            context,
            FFLocalizations.of(context).getText('ib59489c' /* [학력 설정] */),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                5.0,
                0.0,
                5.0,
                8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRecordHeaderRow(
                      context,
                      const [
                        '취득일',
                        '학교',
                        '전공',
                        '학위',
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            recordCount,
                            (academicIndex) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller:
                                          _model.academicGetDateTextControllers[
                                              academicIndex],
                                      focusNode:
                                          _model.academicGetDateFocusNodes[
                                              academicIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        'YYYY.MM',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleAcademicFieldChanged(
                                              academicIndex),
                                      autofocus: false,
                                      obscureText: false,
                                      keyboardType: TextInputType.datetime,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .academicUniversityTextControllers[
                                          academicIndex],
                                      focusNode: _model
                                              .academicUniversityFocusNodes[
                                          academicIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        'OO대학교',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleAcademicFieldChanged(
                                              academicIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .academicMajorTextControllers[
                                          academicIndex],
                                      focusNode: _model
                                              .academicMajorFocusNodes[
                                          academicIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        '건축학과',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleAcademicFieldChanged(
                                              academicIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .academicDegreeTextControllers[
                                          academicIndex],
                                      focusNode: _model
                                              .academicDegreeFocusNodes[
                                          academicIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        '학위',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleAcademicFieldChanged(
                                              academicIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _buildRecordActionRow(
                      context: context,
                      canAdd: _model.academicRecords.length < 3,
                      onAdd: () async {
                        if (_model.academicRecords.length < 3) {
                          final newRecord = <String, dynamic>{
                            'getDate': '',
                            'university': '',
                            'major': '',
                            'degree': '',
                          };
                          FFAppState().addToMypageAcademicRecords(newRecord);
                          _model.addToAcademicRecords(newRecord);
                          _model.addAcademicRecordControllers(
                            getDate: '',
                            university: '',
                            major: '',
                            degree: '',
                          );
                          safeSetState(() {});
                        }
                      },
                      addLabel: FFLocalizations.of(context)
                          .getText('wbc1rycr' /* 추가 + */),
                      canRemove: _model.academicRecords.length > 1,
                      onRemove: () async {
                        if (_model.academicRecords.length > 1) {
                          final removeIndex =
                              _model.academicRecords.length - 1;
                          FFAppState().removeAtIndexFromMypageAcademicRecords(
                            removeIndex,
                          );
                          if (_model.academicRecords.length > removeIndex) {
                            _model.removeAtIndexFromAcademicRecords(
                              removeIndex,
                            );
                          }
                          if (_model.academicGetDateTextControllers.length >
                              removeIndex) {
                            _model.removeAcademicRecordControllers(
                              removeIndex,
                            );
                          }
                          safeSetState(() {});
                        }
                      },
                      removeLabel: FFLocalizations.of(context)
                          .getText('adyemods' /* 삭제 - */),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildTeachingSection(BuildContext context) {
      final recordCount = _model.teachingPeriodTextControllers.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle(
            context,
            FFLocalizations.of(context).getText('bagrzgyr' /* [강사 경력] */),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                5.0,
                0.0,
                5.0,
                8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildRecordHeaderRow(
                      context,
                      const [
                        '기간',
                        '학교/학과',
                        '과목명',
                        '학점/시간',
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            recordCount,
                            (teachingIndex) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .teachingPeriodTextControllers[
                                          teachingIndex],
                                      focusNode: _model
                                              .teachingPeriodFocusNodes[
                                          teachingIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        '기간',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleTeachingFieldChanged(
                                              teachingIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .teachingSchoolTextControllers[
                                          teachingIndex],
                                      focusNode: _model
                                              .teachingSchoolFocusNodes[
                                          teachingIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        'OO대학교/OO과',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleTeachingFieldChanged(
                                              teachingIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .teachingSubjectTextControllers[
                                          teachingIndex],
                                      focusNode: _model
                                              .teachingSubjectFocusNodes[
                                          teachingIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        '강의과목',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleTeachingFieldChanged(
                                              teachingIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: TextFormField(
                                      controller: _model
                                              .teachingCreditTextControllers[
                                          teachingIndex],
                                      focusNode: _model
                                              .teachingCreditFocusNodes[
                                          teachingIndex],
                                      decoration: _recordInputDecoration(
                                        context,
                                        '학점/시간',
                                      ),
                                      style: _recordTextStyle(context),
                                      onChanged: (_) =>
                                          _handleTeachingFieldChanged(
                                              teachingIndex),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _buildRecordActionRow(
                      context: context,
                      canAdd: _model.teachingRecords.length < 4,
                      onAdd: () async {
                        if (_model.teachingRecords.length < 4) {
                          final newRecord = <String, dynamic>{
                            'period': '',
                            'schoolDepartment': '',
                            'subject': '',
                            'creditsHours': '',
                          };
                          FFAppState().addToMypageTeachingRecords(newRecord);
                          _model.addToTeachingRecords(newRecord);
                          _model.addTeachingRecordControllers(
                            period: '',
                            schoolDepartment: '',
                            subject: '',
                            creditsHours: '',
                          );
                          safeSetState(() {});
                        }
                      },
                      addLabel: FFLocalizations.of(context)
                          .getText('0ci94j6j' /* 추가 + */),
                      canRemove: _model.teachingRecords.length > 1,
                      onRemove: () async {
                        if (_model.teachingRecords.length > 1) {
                          final removeIndex =
                              _model.teachingRecords.length - 1;
                          FFAppState().removeAtIndexFromMypageTeachingRecords(
                            removeIndex,
                          );
                          if (_model.teachingRecords.length > removeIndex) {
                            _model.removeAtIndexFromTeachingRecords(
                              removeIndex,
                            );
                          }
                          if (_model.teachingPeriodTextControllers.length >
                              removeIndex) {
                            _model.removeTeachingRecordControllers(
                              removeIndex,
                            );
                          }
                          safeSetState(() {});
                        }
                      },
                      removeLabel: FFLocalizations.of(context)
                          .getText('d31dksav' /* 삭제 - */),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildProjectSection(BuildContext context) {
      final theme = FlutterFlowTheme.of(context);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSectionTitle(
            context,
            FFLocalizations.of(context)
                .getText('tshfg401' /* [주요성과 및 프로젝트] */),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                5.0,
                0.0,
                5.0,
                8.0,
              ),
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.primaryBackground,
                  ),
                  child: TextFormField(
                    controller: _model.projectTextFieldTextController,
                    focusNode: _model.projectTextFieldFocusNode,
                    autofocus: true,
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle: theme.labelMedium.override(
                        font: GoogleFonts.openSans(
                          fontWeight: theme.labelMedium.fontWeight,
                          fontStyle: theme.labelMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: theme.labelMedium.fontWeight,
                        fontStyle: theme.labelMedium.fontStyle,
                      ),
                      hintText: FFLocalizations.of(context)
                          .getText('bbx9df2u' /* 논문. 프로젝트 등 경력사항 */),
                      hintStyle: theme.labelMedium.override(
                        font: GoogleFonts.openSans(
                          fontWeight: theme.labelMedium.fontWeight,
                          fontStyle: theme.labelMedium.fontStyle,
                        ),
                        fontSize: () {
                          final width = MediaQuery.sizeOf(context).width;
                          if (width < kBreakpointSmall) {
                            return 6.0;
                          } else if (width < kBreakpointMedium) {
                            return 8.0;
                          } else if (width < kBreakpointLarge) {
                            return 10.0;
                          }
                          return 12.0;
                        }(),
                        letterSpacing: 0.0,
                        fontWeight: theme.labelMedium.fontWeight,
                        fontStyle: theme.labelMedium.fontStyle,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: theme.error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: theme.secondaryBackground,
                    ),
                    style: theme.bodyMedium.override(
                      font: GoogleFonts.openSans(
                        fontWeight: theme.bodyMedium.fontWeight,
                        fontStyle: theme.bodyMedium.fontStyle,
                      ),
                      fontSize: () {
                        final width = MediaQuery.sizeOf(context).width;
                        if (width < kBreakpointSmall) {
                          return 6.0;
                        } else if (width < kBreakpointMedium) {
                          return 8.0;
                        } else if (width < kBreakpointLarge) {
                          return 10.0;
                        }
                        return 12.0;
                      }(),
                      letterSpacing: 0.0,
                      fontWeight: theme.bodyMedium.fontWeight,
                      fontStyle: theme.bodyMedium.fontStyle,
                    ),
                    maxLines: null,
                    minLines: 8,
                    maxLength: 500,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    cursorColor: theme.primaryText,
                    validator: _model.projectTextFieldTextControllerValidator
                        .asValidator(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

  List<Map<String, dynamic>> _collectAcademicRecords() {
    final records = <Map<String, dynamic>>[];
    for (var i = 0; i < _model.academicGetDateTextControllers.length; i++) {
      final record = <String, dynamic>{
        'getDate': _model.academicGetDateTextControllers[i].text,
        'university': _model.academicUniversityTextControllers[i].text,
        'major': _model.academicMajorTextControllers[i].text,
        'degree': _model.academicDegreeTextControllers[i].text,
      };
      final hasContent = record.values.any(
        (value) => value is String ? value.trim().isNotEmpty : value != null,
      );
      if (hasContent) {
        records.add(record);
      }
    }
    return records;
  }

  List<Map<String, dynamic>> _collectTeachingRecords() {
    final records = <Map<String, dynamic>>[];
    for (var i = 0; i < _model.teachingPeriodTextControllers.length; i++) {
      final record = <String, dynamic>{
        'period': _model.teachingPeriodTextControllers[i].text,
        'schoolDepartment':
            _model.teachingSchoolTextControllers[i].text,
        'subject': _model.teachingSubjectTextControllers[i].text,
        'creditsHours': _model.teachingCreditTextControllers[i].text,
      };
      final hasContent = record.values.any(
        (value) => value is String ? value.trim().isNotEmpty : value != null,
      );
      if (hasContent) {
        records.add(record);
      }
    }
    return records;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFEEF1F6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      wrapWithModel(
                        model: _model.naviSidebarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: NaviSidebarWidget(
                          activePageName: 'Myprofile',
                          pageIsInSubMenu: false,
                        ),
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                            wrapWithModel(
                              model: _model.headerModel,
                              updateCallback: () => safeSetState(() {}),
                              updateOnChange: true,
                              child: HeaderWidget(
                                years: '',
                              ),
                            ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEF1F6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Flexible(
                                      flex: 3,
                                      child: wrapWithModel(
                                        model: _model.leftWidgetModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: LeftWidgetWidget(),
                                      ),
                                    ),
                                  Flexible(
                                    flex: 16,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Stack(
                                        children: [
                                          if (_model.boolForRender == true)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: Container(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.98,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    if (true) // 데스크톱 부분 항상 표시
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          height: 680.0, // 원래 높이로 복구
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                              Flexible(
                                                                flex: 2, // 1에서 2로 늘리면서 상단 공간 확보
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        40.0, // 원래대로 복구
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                    child: Align(
                                                                      alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                      child: Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0), // 원래대로 복구
                                                                        child:
                                                                          Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            '3uadb3vu' /* [기본 설정] */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                fontSize: _sectionTitleFontSize(context),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 2, // 3에서 2로 더 줄여서 사진 영역 최소화
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            5.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height:
                                                                          () {
                                                                        if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointSmall) {
                                                                          return 150.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointMedium) {
                                                                          return 200.0;
                                                                        } else if (MediaQuery.sizeOf(context).width <
                                                                            kBreakpointLarge) {
                                                                          return 200.0;
                                                                        } else {
                                                                          return 230.0;
                                                                        }
                                                                      }(),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(16.0),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).alternate,
                                                                          width:
                                                                              2.0,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          Stack(
                                                                        children: [
                                                                          ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(16.0),
                                                                            child:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                FFAppState().mypageImageUrl,
                                                                                'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/profileimage/myprofile/1739097345656000.jpg',
                                                                              ),
                                                                              width: double.infinity,
                                                                              height: double.infinity,
                                                                              fit: BoxFit.cover,
                                                                              alignment: Alignment(0.0, 0.0),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 1,
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height: double
                                                                        .infinity,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment:
                                                                          AlignmentDirectional(
                                                                              0.0,
                                                                              0.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(0.0),
                                                                        child:
                                                                            BackdropFilter(
                                                                          filter:
                                                                              ImageFilter.blur(
                                                                            sigmaX:
                                                                                2.0,
                                                                            sigmaY:
                                                                                2.0,
                                                                          ),
                                                                          child:
                                                                              Visibility(
                                                                            visible:
                                                                                _model.myProfileList != null,
                                                                            child:
                                                                                InkWell(
                                                                              splashColor: Colors.transparent,
                                                                              focusColor: Colors.transparent,
                                                                              hoverColor: Colors.transparent,
                                                                              highlightColor: Colors.transparent,
                                                                              onTap: () async {
                                                                                FFAppState().mypageImageUrl = '';
                                                                                safeSetState(() {});
                                                                                await deleteSupabaseFileFromPublicUrl(FFAppState().mypageImageUrl);
                                                                                final selectedMedia = await selectMediaWithSourceBottomSheet(
                                                                                  context: context,
                                                                                  storageFolderPath: 'myprofile',
                                                                                  maxWidth: 1200.00,
                                                                                  maxHeight: 1200.00,
                                                                                  allowPhoto: true,
                                                                                );
                                                                                if (selectedMedia != null && selectedMedia.every((m) => validateFileFormat(m.storagePath, context))) {
                                                                                  safeSetState(() => _model.isDataUploading_uploadData = true);
                                                                                  var selectedUploadedFiles = <FFUploadedFile>[];

                                                                                  var downloadUrls = <String>[];
                                                                                  try {
                                                                                    showUploadMessage(
                                                                                      context,
                                                                                      'Uploading file...',
                                                                                      showLoading: true,
                                                                                    );
                                                                                    selectedUploadedFiles = selectedMedia
                                                                                        .map((m) => FFUploadedFile(
                                                                                              name: m.storagePath.split('/').last,
                                                                                              bytes: m.bytes,
                                                                                              height: m.dimensions?.height,
                                                                                              width: m.dimensions?.width,
                                                                                              blurHash: m.blurHash,
                                                                                            ))
                                                                                        .toList();

                                                                                    downloadUrls = await uploadSupabaseStorageFiles(
                                                                                      bucketName: 'profileimage',
                                                                                      selectedFiles: selectedMedia,
                                                                                    );
                                                                                  } finally {
                                                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                                                    _model.isDataUploading_uploadData = false;
                                                                                  }
                                                                                  if (selectedUploadedFiles.length == selectedMedia.length && downloadUrls.length == selectedMedia.length) {
                                                                                    safeSetState(() {
                                                                                      _model.uploadedLocalFile_uploadData = selectedUploadedFiles.first;
                                                                                      _model.uploadedFileUrl_uploadData = downloadUrls.first;
                                                                                    });
                                                                                    showUploadMessage(context, 'Success!');
                                                                                  } else {
                                                                                    safeSetState(() {});
                                                                                    showUploadMessage(context, 'Failed to upload data');
                                                                                    return;
                                                                                  }
                                                                                }

                                                                                FFAppState().mypageImageUrl = _model.uploadedFileUrl_uploadData;
                                                                                safeSetState(() {});
                                                                                if (_model.myProfileList?.pfrImageurl != null && _model.myProfileList?.pfrImageurl != '') {
                                                                                  await ProfessorMyprofileTable().update(
                                                                                    data: {
                                                                                      'pfr_imageurl': FFAppState().mypageImageUrl,
                                                                                    },
                                                                                    matchingRows: (rows) => rows.eqOrNull(
                                                                                      'pfr_email',
                                                                                      currentUserEmail,
                                                                                    ),
                                                                                  );
                                                                                  safeSetState(() {
                                                                                    _model.isDataUploading_uploadData = false;
                                                                                    _model.uploadedLocalFile_uploadData = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                    _model.uploadedFileUrl_uploadData = '';
                                                                                  });
                                                                                } else {
                                                                                  if (FFAppState().mypageImageUrl != '') {
                                                                                    await ProfessorMyprofileTable().insert({
                                                                                      'pfr_imageurl': FFAppState().mypageImageUrl,
                                                                                      'professor_name': FFAppState().professorNameSelected,
                                                                                    });
                                                                                    safeSetState(() {
                                                                                      _model.isDataUploading_uploadData = false;
                                                                                      _model.uploadedLocalFile_uploadData = FFUploadedFile(bytes: Uint8List.fromList([]));
                                                                                      _model.uploadedFileUrl_uploadData = '';
                                                                                    });
                                                                                  } else {
                                                                                    await showDialog(
                                                                                      context: context,
                                                                                      builder: (alertDialogContext) {
                                                                                        return WebViewAware(
                                                                                          child: AlertDialog(
                                                                                            title: Text('업로드 취소'),
                                                                                            content: Text('이미지 업로드가 취소되었습니다.'),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: Text('Ok'),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        );
                                                                                      },
                                                                                    );
                                                                                  }
                                                                                }

                                                                                safeSetState(() {});
                                                                              },
                                                                              child: Container(
                                                                                width: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 60.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 80.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 90.0;
                                                                                  } else {
                                                                                    return 120.0;
                                                                                  }
                                                                                }(),
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: Color(0xFFA6B6C3),
                                                                                  borderRadius: BorderRadius.circular(8.0),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.all(6.0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Flexible(
                                                                                        flex: 1,
                                                                                        child: Align(
                                                                                          alignment: AlignmentDirectional(0.0, 0.0),
                                                                                          child: Icon(
                                                                                            Icons.camera_alt_rounded,
                                                                                            color: FlutterFlowTheme.of(context).white0,
                                                                                            size: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 18.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 20.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 22.0;
                                                                                              } else {
                                                                                                return 24.0;
                                                                                              }
                                                                                            }(),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Flexible(
                                                                                        flex: 2,
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'ew8xcbuw' /* 업로드 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 6.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 8.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 12.0;
                                                                                                  } else {
                                                                                                    return 16.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 12.0)),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 10, // 13에서 10으로 줄여서 균형 맞춤
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    if (() {
                                                      if (MediaQuery.sizeOf(
                                                                  context)
                                                              .width >
                                                          600.0) {
                                                        return true;
                                                      } else if (_model
                                                              .nextInMobile ==
                                                          -1) {
                                                        return true;
                                                      } else {
                                                        return false;
                                                      }
                                                    }())
                                                      Flexible(
                                                        flex: 3,
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  0.0, 0.0),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.86,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Flexible(
                                                                    flex: 3, // 2에서 3으로 늘림
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          5.0, // 10.0에서 5.0으로 조정
                                                                          5.0,
                                                                          0.0),
                                                                      child:










































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































           
