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
      _model.pfrValList = await ProfessorValidationTable().queryRows(
        queryFn: (q) => q.eqOrNull(
          'name',
          FFAppState().professorNameSelected,
        ),
      );
      _model.prfValList = _model.pfrValList?.firstOrNull;
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
    return theme.bodyMedium.override(
      font: GoogleFonts.openSans(
        fontWeight: theme.bodyMedium.fontWeight,
        fontStyle: theme.bodyMedium.fontStyle,
      ),
      letterSpacing: 0.0,
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

  double _sectionTitleFontSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < kBreakpointSmall) {
      return 10.0;
    }
    if (width < kBreakpointMedium) {
      return 12.0;
    }
    if (width < kBreakpointLarge) {
      return 18.0;
    }
    return 22.0;
  }

  Widget _buildSectionTitle(BuildContext context, String localizationKey) {
    return Container(
      height: 40.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      alignment: const AlignmentDirectional(-1.0, -1.0),
      padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
      child: Text(
        FFLocalizations.of(context).getText(localizationKey),
        style: FlutterFlowTheme.of(context).bodyMedium.override(
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
    );
  }

  double _sectionButtonHeight(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < kBreakpointSmall) {
      return 20.0;
    }
    if (width < kBreakpointMedium) {
      return 25.0;
    }
    if (width < kBreakpointLarge) {
      return 30.0;
    }
    return 35.0;
  }

  double _sectionButtonFontSize(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < kBreakpointSmall) {
      return 8.0;
    }
    if (width < kBreakpointMedium) {
      return 10.0;
    }
    if (width < kBreakpointLarge) {
      return 12.0;
    }
    return 16.0;
  }

  Widget _buildAcademicSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 7.0, 0.0, 0.0),
          child: _buildSectionTitle(context, 'ib59489c' /* [학력 설정] */),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
            child: _buildAcademicList(context),
          ),
        ),
        _buildAcademicActions(context),
      ],
    );
  }

  Widget _buildAcademicList(BuildContext context) {
    final recordCount = _model.academicGetDateTextControllers.length;
    return Column(
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
          child: Scrollbar(
            thumbVisibility: recordCount > 2,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: recordCount,
              itemBuilder: (context, academicIndex) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.academicGetDateTextControllers[academicIndex],
                        focusNode:
                            _model.academicGetDateFocusNodes[academicIndex],
                        decoration: _recordInputDecoration(
                          context,
                          'YYYY.MM',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleAcademicFieldChanged(academicIndex),
                        autofocus: false,
                        obscureText: false,
                        keyboardType: TextInputType.datetime,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller: _model
                            .academicUniversityTextControllers[academicIndex],
                        focusNode:
                            _model.academicUniversityFocusNodes[academicIndex],
                        decoration: _recordInputDecoration(
                          context,
                          'OO대학교',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleAcademicFieldChanged(academicIndex),
                        autofocus: false,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.academicMajorTextControllers[academicIndex],
                        focusNode:
                            _model.academicMajorFocusNodes[academicIndex],
                        decoration: _recordInputDecoration(
                          context,
                          '건축학과',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleAcademicFieldChanged(academicIndex),
                        autofocus: false,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.academicDegreeTextControllers[academicIndex],
                        focusNode:
                            _model.academicDegreeFocusNodes[academicIndex],
                        decoration: _recordInputDecoration(
                          context,
                          '학위',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleAcademicFieldChanged(academicIndex),
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
      ],
    );
  }

  Widget _buildAcademicActions(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 25.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (_model.academicRecords.length < 3)
            Flexible(
              child: Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5.0, 0.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
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
                    text: FFLocalizations.of(context).getText(
                      'wbc1rycr' /* 추가 + */,
                    ),
                    icon: const Icon(
                      Icons.add_to_photos_outlined,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      height: _sectionButtonHeight(context),
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      color: const Color(0xFFA6B6C3),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            font: GoogleFonts.openSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: _sectionButtonFontSize(context),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(color: Color(0x00000000)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          if (_model.academicRecords.length > 1)
            Flexible(
              child: Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 0.0, 5.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (_model.academicRecords.length > 1) {
                        final removeIndex =
                            _model.academicRecords.length - 1;
                        FFAppState()
                            .removeAtIndexFromMypageAcademicRecords(
                                removeIndex);
                        if (_model.academicRecords.length > removeIndex) {
                          _model.removeAtIndexFromAcademicRecords(removeIndex);
                        }
                        if (_model.academicGetDateTextControllers.length >
                            removeIndex) {
                          _model.removeAcademicRecordControllers(removeIndex);
                        }
                        safeSetState(() {});
                      }
                    },
                    text: FFLocalizations.of(context).getText(
                      'adyemods' /* 삭제 - */,
                    ),
                    icon: const Icon(
                      Icons.delete_forever,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      height: _sectionButtonHeight(context),
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            font: GoogleFonts.openSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: _sectionButtonFontSize(context),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTeachingSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child: _buildSectionTitle(context, 'bagrzgyr' /* [강사 경력] */),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
            child: _buildTeachingList(context),
          ),
        ),
        _buildTeachingActions(context),
      ],
    );
  }

  Widget _buildTeachingList(BuildContext context) {
    final recordCount = _model.teachingPeriodTextControllers.length;
    return Column(
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
          child: Scrollbar(
            thumbVisibility: recordCount > 2,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: recordCount,
              itemBuilder: (context, teachingIndex) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.teachingPeriodTextControllers[teachingIndex],
                        focusNode:
                            _model.teachingPeriodFocusNodes[teachingIndex],
                        decoration: _recordInputDecoration(
                          context,
                          '기간',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleTeachingFieldChanged(teachingIndex),
                        autofocus: false,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.teachingSchoolTextControllers[teachingIndex],
                        focusNode:
                            _model.teachingSchoolFocusNodes[teachingIndex],
                        decoration: _recordInputDecoration(
                          context,
                          'OO대학교 / OO학과',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleTeachingFieldChanged(teachingIndex),
                        autofocus: false,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.teachingSubjectTextControllers[teachingIndex],
                        focusNode:
                            _model.teachingSubjectFocusNodes[teachingIndex],
                        decoration: _recordInputDecoration(
                          context,
                          '과목명',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleTeachingFieldChanged(teachingIndex),
                        autofocus: false,
                        obscureText: false,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        controller:
                            _model.teachingCreditTextControllers[teachingIndex],
                        focusNode:
                            _model.teachingCreditFocusNodes[teachingIndex],
                        decoration: _recordInputDecoration(
                          context,
                          '3학점 / 45시간',
                        ),
                        style: _recordTextStyle(context),
                        onChanged: (_) =>
                            _handleTeachingFieldChanged(teachingIndex),
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
      ],
    );
  }

  Widget _buildTeachingActions(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 25.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
      ),
      child: Row(
        children: [
          if (_model.teachingRecords.length < 3)
            Flexible(
              child: Align(
                alignment: const AlignmentDirectional(-1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      5.0, 0.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (_model.teachingRecords.length < 3) {
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
                    text: FFLocalizations.of(context).getText(
                      '2ngodbc9' /* 추가 + */,
                    ),
                    icon: const Icon(
                      Icons.add_to_photos_outlined,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      height: _sectionButtonHeight(context),
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      color: const Color(0xFFA6B6C3),
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            font: GoogleFonts.openSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: _sectionButtonFontSize(context),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                      elevation: 0.0,
                      borderSide: const BorderSide(color: Color(0x00000000)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          if (_model.teachingRecords.length > 1)
            Flexible(
              child: Align(
                alignment: const AlignmentDirectional(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      0.0, 0.0, 5.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (_model.teachingRecords.length > 1) {
                        final removeIndex =
                            _model.teachingRecords.length - 1;
                        FFAppState()
                            .removeAtIndexFromMypageTeachingRecords(
                                removeIndex);
                        if (_model.teachingRecords.length > removeIndex) {
                          _model.removeAtIndexFromTeachingRecords(removeIndex);
                        }
                        if (_model.teachingPeriodTextControllers.length >
                            removeIndex) {
                          _model.removeTeachingRecordControllers(removeIndex);
                        }
                        safeSetState(() {});
                      }
                    },
                    text: FFLocalizations.of(context).getText(
                      'd31dksav' /* 삭제 - */,
                    ),
                    icon: const Icon(
                      Icons.delete_forever,
                      size: 15.0,
                    ),
                    options: FFButtonOptions(
                      height: _sectionButtonHeight(context),
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      iconPadding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 0.0, 0.0),
                      iconColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(
                            font: GoogleFonts.openSans(
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            color: Colors.white,
                            fontSize: _sectionButtonFontSize(context),
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontWeight,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
          child:
              _buildSectionTitle(context, 'tshfg401' /* [주요성과 및 프로젝트] */),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
              ),
              child: TextFormField(
                controller: _model.projectTextFieldTextController,
                focusNode: _model.projectTextFieldFocusNode,
                autofocus: true,
                obscureText: false,
                decoration: InputDecoration(
                  isDense: true,
                  labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              FlutterFlowTheme.of(context).labelMedium.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                  hintText: FFLocalizations.of(context).getText(
                    'bbx9df2u' /* 논문. 프로젝트 등 경력사항 */,
                  ),
                  hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.openSans(
                          fontWeight:
                              FlutterFlowTheme.of(context).labelMedium.fontWeight,
                          fontStyle:
                              FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        ),
                        fontSize: () {
                          final width = MediaQuery.sizeOf(context).width;
                          if (width < kBreakpointSmall) {
                            return 6.0;
                          }
                          if (width < kBreakpointMedium) {
                            return 8.0;
                          }
                          if (width < kBreakpointLarge) {
                            return 10.0;
                          }
                          return 12.0;
                        }(),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
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
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: FlutterFlowTheme.of(context).error,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.openSans(
                        fontWeight:
                            FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: () {
                        final width = MediaQuery.sizeOf(context).width;
                        if (width < kBreakpointSmall) {
                          return 6.0;
                        }
                        if (width < kBreakpointMedium) {
                          return 8.0;
                        }
                        if (width < kBreakpointLarge) {
                          return 10.0;
                        }
                        return 12.0;
                      }(),
                      letterSpacing: 0.0,
                      fontWeight:
                          FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                textAlign: TextAlign.start,
                cursorColor: FlutterFlowTheme.of(context).primaryText,
                maxLines: null,
                minLines: 8,
                maxLength: 500,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                validator: _model.projectTextFieldTextControllerValidator
                    .asValidator(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightPanelActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Align(
            alignment: const AlignmentDirectional(1.0, 0.0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  0.0, 5.0, 0.0, 0.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Visibility(
                  visible: _model.phoneTextFieldTextController.text != '',
                  child: Align(
                    alignment: const AlignmentDirectional(1.0, 0.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 4.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                final academicRecords = _collectAcademicRecords();
                                final teachingRecords = _collectTeachingRecords();

                                _model.academicRecords =
                                    List<dynamic>.from(academicRecords);
                                _model.teachingRecords =
                                    List<dynamic>.from(teachingRecords);

                                FFAppState().mypageAcademicRecords =
                                    _model.academicRecords
                                        .toList()
                                        .cast<dynamic>();
                                FFAppState().mypageTeachingRecords =
                                    _model.teachingRecords
                                        .toList()
                                        .cast<dynamic>();
                                safeSetState(() {});

                                if (_model.myProfileList != null) {
                                  await ProfessorMyprofileTable().update(
                                    data: {
                                      'professor_name': _model
                                          .fullNameTextFieldTextController1.text,
                                      'pfr_phonenumber':
                                          valueOrDefault<String>(
                                        _model
                                            .phoneTextFieldTextController.text,
                                        '010-0000-0000',
                                      ),
                                      'pfr_birth': valueOrDefault<String>(
                                        _model
                                            .birthTextFieldTextController.text,
                                        '0000.00',
                                      ),
                                      'pfr_email':
                                          _model.fullNameTextFieldTextController2
                                              .text,
                                      'pfr_institution':
                                          _model.fullNameTextFieldTextController3
                                              .text,
                                      'prf_positon': valueOrDefault<String>(
                                        _model
                                            .positionTextFieldTextController.text,
                                        '직책',
                                      ),
                                      'pfr_licensed': <String, dynamic>{
                                        'archix': FFAppState().archix,
                                        'technicx': FFAppState().technicx,
                                        'archikr': FFAppState().archikr,
                                        'technickr': FFAppState().technickr,
                                        'archiabroad':
                                            FFAppState().archiabroad,
                                        'technicabroad':
                                            FFAppState().technicabroad,
                                        'other': FFAppState().other,
                                      },
                                      'pfr_speciality': <String, dynamic>{
                                        'environment': FFAppState().environment,
                                        'finance': FFAppState().finance,
                                        'technique': FFAppState().technique,
                                        'other': FFAppState().other,
                                      },
                                      'pfr_speciality_detail':
                                          FFAppState().specialityJson,
                                      'degreeList': _model.academicRecords,
                                      'teachingList': _model.teachingRecords,
                                      'project':
                                          _model.projectTextFieldTextController
                                              .text,
                                    },
                                    matchingRows: (rows) => rows.eq(
                                      'id',
                                      _model.myProfileList?.id,
                                    ),
                                  );
                                }

                              },
                              text: FFLocalizations.of(context).getText(
                                '0i6b0l4v' /* 저장하기 */,
                              ),
                              options: FFButtonOptions(
                                height: 45.0,
                                padding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        30.0, 0.0, 30.0, 0.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color:
                                    FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle:
                                            FlutterFlowTheme.of(context)
                                                .titleSmall
                                                .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                elevation: 2.0,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await _resetProfileForms();
                            },
                            text: FFLocalizations.of(context).getText(
                              'mev6wy42' /* 초기화 */,
                            ),
                            options: FFButtonOptions(
                              height: 45.0,
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      30.0, 0.0, 30.0, 0.0),
                              iconPadding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                              color:
                                  FlutterFlowTheme.of(context).secondaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightPanel(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 4,
          child: _buildAcademicSection(context),
        ),
        const SizedBox(height: 12.0),
        Expanded(
          flex: 4,
          child: _buildTeachingSection(context),
        ),
        const SizedBox(height: 12.0),
        Expanded(
          flex: 3,
          child: _buildProjectSection(context),
        ),
        const SizedBox(height: 12.0),
        _buildRightPanelActions(context),
      ],
    );
  }

  Future<void> _resetProfileForms() async {
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (alertDialogContext) {
            return WebViewAware(
              child: AlertDialog(
                title: const Text('내 정보 초기화'),
                content: const Text('정말 초기화하시겠습니까?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, false),
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext, true),
                    child: const Text('확인'),
                  ),
                ],
              ),
            );
          },
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    FFAppState().archix = false;
    FFAppState().archikr = false;
    FFAppState().archiabroad = false;
    FFAppState().technicx = false;
    FFAppState().technickr = false;
    FFAppState().technicabroad = false;
    FFAppState().digital = false;
    FFAppState().design = false;
    FFAppState().structural = false;
    FFAppState().environment = false;
    FFAppState().scape = false;
    FFAppState().other = false;
    FFAppState().consturction = false;
    safeSetState(() {});

    _model.myProfileList = null;
    _model.degreeTextField = null;

    _setAcademicRecords(
      _normalizeRecords(
        const [],
        _academicFieldKeys,
        3,
      ),
    );
    _setTeachingRecords(
      _normalizeRecords(
        const [],
        _teachingFieldKeys,
        4,
      ),
    );
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
                      child: _buildRightPanel(context),
),
                  ],
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
                tabletLandscape: false,
                desktop: false,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF1F6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Expanded(
                              child: wrapWithModel(
                                model: _model.headerMobileModel1,
                                updateCallback: () => safeSetState(() {}),
                                child: HeaderMobileWidget(),
                              ),
                            ),
                        ],
                      ),
                      if (responsiveVisibility(
                        context: context,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEF1F6),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: wrapWithModel(
                                    model: _model.naviSidebarMobileModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: NaviSidebarMobileWidget(
                                      activePageName: 'Home',
                                      pageIsInSubMenu: false,
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
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      wrapWithModel(
                        model: _model.headerMobileModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: HeaderMobileWidget(),
                      ),
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Stack(
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            tabletLandscape: false,
                            desktop: false,
                          ))
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: wrapWithModel(
                                model: _model.naviSidebarMobileModel2,
                                updateCallback: () => safeSetState(() {}),
                                child: NaviSidebarMobileWidget(
                                  activePageName: 'Home',
                                  pageIsInSubMenu: false,
                                ),
                              ),
                            ),
                        ],
                      ),
                  ],
                ),
              if (FFAppState().channelTalk == true)
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: FlutterFlowWebView(
                    content:
                        '<script>\n  (function(){var w=window;if(w.ChannelIO){return w.console.error(\"ChannelIO script included twice.\");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement(\"script\");s.type=\"text/javascript\";s.async=true;s.src=\"https://cdn.channel.io/plugin/ch-plugin-web.js\";var x=document.getElementsByTagName(\"script\")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState===\"complete\"){l();}else{w.addEventListener(\"DOMContentLoaded\",l);w.addEventListener(\"load\",l);}})();\n\n  ChannelIO(\'boot\', {\n    \"pluginKey\": \"4f440600-f8b3-494e-b133-5476520fcf8a\"\n  });\n</script>',
                    width: 550.0,
                    height: 680.0,
                    verticalScroll: false,
                    horizontalScroll: false,
                    html: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
