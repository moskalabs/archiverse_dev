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
    
    // 기본적으로 boolForRender를 true로 설정 (회색 화면 방지)
    _model.boolForRender = true;

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

      // Safely extract profile data with null checks
      if (_model.myProfileList != null) {
        final profileData = _model.myProfileList!;

        // Extract licensed data safely
        if (profileData.pfrLicensed != null) {
          FFAppState().archix = getJsonField(
            profileData.pfrLicensed,
            r'''$.archix''',
          );
          FFAppState().archikr = getJsonField(
            profileData.pfrLicensed,
            r'''$.archikr''',
          );
          FFAppState().archiabroad = getJsonField(
            profileData.pfrLicensed,
            r'''$.archiabroad''',
          );
          FFAppState().technicx = getJsonField(
            profileData.pfrLicensed,
            r'''$.technicx''',
          );
          FFAppState().technickr = getJsonField(
            profileData.pfrLicensed,
            r'''$.technickr''',
          );
          FFAppState().technicabroad = getJsonField(
            profileData.pfrLicensed,
            r'''$.technicabroad''',
          );

          // 백업 저장 (자격증)
          _model.backupArchix = FFAppState().archix;
          _model.backupArchikr = FFAppState().archikr;
          _model.backupArchiabroad = FFAppState().archiabroad;
          _model.backupTechnicx = FFAppState().technicx;
          _model.backupTechnickr = FFAppState().technickr;
          _model.backupTechnicabroad = FFAppState().technicabroad;
        }

        // Extract speciality data safely
        if (profileData.pfrSpeciality != null) {
          FFAppState().design = getJsonField(
            profileData.pfrSpeciality,
            r'''$.design''',
          );
          FFAppState().other = getJsonField(
            profileData.pfrSpeciality,
            r'''$.other''',
          );
          FFAppState().scape = getJsonField(
            profileData.pfrSpeciality,
            r'''$.scape''',
          );
          FFAppState().structural = getJsonField(
            profileData.pfrSpeciality,
            r'''$.structural''',
          );
          FFAppState().digital = getJsonField(
            profileData.pfrSpeciality,
            r'''$.digital''',
          );
          FFAppState().environment = getJsonField(
            profileData.pfrSpeciality,
            r'''$.environment''',
          );
          FFAppState().consturction = getJsonField(
            profileData.pfrSpeciality,
            r'''$.consturction''',
          );

          // 백업 저장 (전문분야)
          _model.backupDesign = FFAppState().design;
          _model.backupDigital = FFAppState().digital;
          _model.backupEnvironment = FFAppState().environment;
          _model.backupOther = FFAppState().other;
          _model.backupConsturction = FFAppState().consturction;
          _model.backupStructural = FFAppState().structural;
          _model.backupScape = FFAppState().scape;
        }

        // Extract basic profile info
        FFAppState().mypagePhoneNumber = profileData.pfrPhonenumber ?? '';
        FFAppState().mypageBirth = profileData.pfrBirth ?? '';
        FFAppState().mypagePosition = profileData.prfPositon ?? '';
        FFAppState().mypageProject = profileData.pfrProject ?? '';
        FFAppState().mypageImageUrl = valueOrDefault<String>(
          profileData.pfrImageurl,
          'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/profileimage/myprofile/1739097345656000.jpg',
        );
      }
            
      // 데이터 로드 성공 - 항상 boolForRender를 true로 설정
      _model.boolForRender = true;
      
      safeSetState(() {});
      if (_model.myProfileList != null) {
        await Future.delayed(
          Duration(
            milliseconds: 500,
          ),
        );
        final profileData = _model.myProfileList!;

        final supabaseAcademicRecords = _normalizeRecords(
          profileData.degreeList,
          _academicFieldKeys,
          3,
        );
        final supabaseTeachingRecords = _normalizeRecords(
          profileData.lecExperience,
          _teachingFieldKeys,
          4,
        );
        _setAcademicRecords(supabaseAcademicRecords);
        _setTeachingRecords(supabaseTeachingRecords);

        // 백업 저장 (학력설정 및 경력사항)
        _model.backupAcademicRecords = List<dynamic>.from(FFAppState().mypageAcademicRecords);
        _model.backupTeachingRecords = List<dynamic>.from(FFAppState().mypageTeachingRecords);

        safeSetState(() {
          _model.archiAbroadTextFieldTextController?.text = valueOrDefault<String>(
            getJsonField(
              profileData.pfrLicensed,
              r'''$.archiabroaddetail''',
            )?.toString(),
            '',
          );
        });
        safeSetState(() {
          _model.technicAboardTextFieldTextController?.text = valueOrDefault<String>(
            getJsonField(
              profileData.pfrLicensed,
              r'''$.technicabroaddetail''',
            )?.toString(),
            '',
          );
        });
        safeSetState(() {
          _model.otherTextFieldTextController?.text = valueOrDefault<String>(
            getJsonField(
              profileData.pfrSpeciality,
              r'''$.otherdetail''',
            )?.toString(),
            '',
          );
        });
        safeSetState(() {
          _model.birthTextFieldTextController?.text = valueOrDefault<String>(
            profileData.pfrBirth,
            '0000.00',
          );
        });
        safeSetState(() {
          _model.positionTextFieldTextController?.text = profileData.prfPositon ?? '';
        });
        safeSetState(() {
          _model.projectTextFieldTextController?.text = profileData.pfrProject ?? '';
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
    // 백업 값으로 FFAppState 복구 (적용 버튼을 누르지 않았을 경우)
    if (_model.backupArchix != null) FFAppState().archix = _model.backupArchix!;
    if (_model.backupArchikr != null) FFAppState().archikr = _model.backupArchikr!;
    if (_model.backupArchiabroad != null) FFAppState().archiabroad = _model.backupArchiabroad!;
    if (_model.backupTechnicx != null) FFAppState().technicx = _model.backupTechnicx!;
    if (_model.backupTechnickr != null) FFAppState().technickr = _model.backupTechnickr!;
    if (_model.backupTechnicabroad != null) FFAppState().technicabroad = _model.backupTechnicabroad!;
    if (_model.backupDesign != null) FFAppState().design = _model.backupDesign!;
    if (_model.backupDigital != null) FFAppState().digital = _model.backupDigital!;
    if (_model.backupEnvironment != null) FFAppState().environment = _model.backupEnvironment!;
    if (_model.backupOther != null) FFAppState().other = _model.backupOther!;
    if (_model.backupConsturction != null) FFAppState().consturction = _model.backupConsturction!;
    if (_model.backupStructural != null) FFAppState().structural = _model.backupStructural!;
    if (_model.backupScape != null) FFAppState().scape = _model.backupScape!;
    if (_model.backupAcademicRecords != null) FFAppState().mypageAcademicRecords = List<dynamic>.from(_model.backupAcademicRecords!);
    if (_model.backupTeachingRecords != null) FFAppState().mypageTeachingRecords = List<dynamic>.from(_model.backupTeachingRecords!);

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
                                          if (true) // 항상 표시
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
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                    ))
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          height: MediaQuery.sizeOf(context).height * 0.86, // 학력 설정과 동일하게 변경
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
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              height: 30.0,
                                                                              decoration: BoxDecoration(),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'qau5753r' /* 성명 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 10.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 12.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 12.0;
                                                                                          } else {
                                                                                            return 12.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 60.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  child: TextFormField(
                                                                                    controller: _model.fullNameTextFieldTextController1,
                                                                                    focusNode: _model.fullNameTextFieldFocusNode1,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.fullNameTextFieldTextController1',
                                                                                      Duration(milliseconds: 500),
                                                                                      () => safeSetState(() {}),
                                                                                    ),
                                                                                    autofocus: false,
                                                                                    readOnly: true,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                          ),
                                                                                      alignLabelWithHint: false,
                                                                                      hintText: valueOrDefault<String>(
                                                                                        FFAppState().professorNameSelected,
                                                                                        '교수님',
                                                                                      ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0xFFA6B6C3),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      filled: true,
                                                                                      fillColor: FlutterFlowTheme.of(context).alternate,
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                                                                      hoverColor: FlutterFlowTheme.of(context).alternate,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 8.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 10.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 12.0;
                                                                                            } else {
                                                                                              return 16.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          useGoogleFonts: !FlutterFlowTheme.of(context).labelLargeIsCustom,
                                                                                        ),
                                                                                    textAlign: TextAlign.start,
                                                                                    minLines: 1,
                                                                                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                    validator: _model.fullNameTextFieldTextController1Validator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(22.0, 0.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: 59.2,
                                                                                height: 30.0,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      '3rvsd60q' /* 연락처 */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 10.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 12.0;
                                                                                            } else {
                                                                                              return 12.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: 60.0,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  child: TextFormField(
                                                                                    controller: _model.phoneTextFieldTextController,
                                                                                    focusNode: _model.phoneTextFieldFocusNode,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.phoneTextFieldTextController',
                                                                                      Duration(milliseconds: 500),
                                                                                      () => safeSetState(() {}),
                                                                                    ),
                                                                                    autofocus: false,
                                                                                    readOnly: true,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                      hintText: FFLocalizations.of(context).getText(
                                                                                        'px7s359a' /* 010-1234-5678 */,
                                                                                      ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                            color: Color(0xFFA6B6C3),
                                                                                            fontSize: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 10.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 12.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 14.0;
                                                                                              } else {
                                                                                                return 16.0;
                                                                                              }
                                                                                            }(),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0xFFA6B6C3),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      filled: true,
                                                                                      fillColor: FlutterFlowTheme.of(context).alternate,
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 20.0, 0.0, 0.0),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 8.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 10.0;
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
                                                                                    textAlign: TextAlign.start,
                                                                                    keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                                                                    validator: _model.phoneTextFieldTextControllerValidator.asValidator(context),
                                                                                    inputFormatters: [
                                                                                      _model.phoneTextFieldMask
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Flexible(
                                                                            flex:
                                                                                1,
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'qipqm2kr' /* 출생 */,
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                        ),
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 10.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 12.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 12.0;
                                                                                          } else {
                                                                                            return 12.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Container(
                                                                              width: 90.0,
                                                                              height: 90.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: 233.0,
                                                                                  child: TextFormField(
                                                                                    controller: _model.birthTextFieldTextController,
                                                                                    focusNode: _model.birthTextFieldFocusNode,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.birthTextFieldTextController',
                                                                                      Duration(milliseconds: 500),
                                                                                      () => safeSetState(() {}),
                                                                                    ),
                                                                                    autofocus: true,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                      hintText: FFLocalizations.of(context).getText(
                                                                                        '2ah9r4nv' /* 0000.00 */,
                                                                                      ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                            color: Color(0xFFA6B6C3),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0xFFA6B6C3),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 8.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 10.0;
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
                                                                                    minLines: 1,
                                                                                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                    validator: _model.birthTextFieldTextControllerValidator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(22.0, 0.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: 60.0,
                                                                                height: 40.0,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'y9f1cpiy' /* 이메일 */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 10.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 12.0;
                                                                                            } else {
                                                                                              return 12.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                5,
                                                                            child:
                                                                                Container(
                                                                              width: double.infinity,
                                                                              height: 90.0,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  child: TextFormField(
                                                                                    controller: _model.fullNameTextFieldTextController2,
                                                                                    focusNode: _model.fullNameTextFieldFocusNode2,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.fullNameTextFieldTextController2',
                                                                                      Duration(milliseconds: 500),
                                                                                      () => safeSetState(() {}),
                                                                                    ),
                                                                                    autofocus: false,
                                                                                    readOnly: true,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                            ),
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).neutral300,
                                                                                            fontSize: 12.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0xFFA6B6C3),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      filled: true,
                                                                                      fillColor: FlutterFlowTheme.of(context).alternate,
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 0.0, 0.0),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.normal,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 8.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 10.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 12.0;
                                                                                            } else {
                                                                                              return 16.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                          fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                        ),
                                                                                    minLines: 1,
                                                                                    keyboardType: TextInputType.emailAddress,
                                                                                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                    validator: _model.fullNameTextFieldTextController2Validator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Container(
                                                                              width: 83.8,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(),
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      '1657gish' /* 소속기관 */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 10.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 12.0;
                                                                                            } else {
                                                                                              return 12.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                8,
                                                                            child:
                                                                                Container(
                                                                              width: 297.0,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  child: TextFormField(
                                                                                    controller: _model.fullNameTextFieldTextController3,
                                                                                    focusNode: _model.fullNameTextFieldFocusNode3,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.fullNameTextFieldTextController3',
                                                                                      Duration(milliseconds: 500),
                                                                                      () => safeSetState(() {}),
                                                                                    ),
                                                                                    autofocus: false,
                                                                                    readOnly: true,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                      hintText: FFLocalizations.of(context).getText(
                                                                                        'hgnmusij' /* 순천향대학교 건축학과 */,
                                                                                      ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FontWeight.w600,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                                                            fontSize: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 8.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 10.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 14.0;
                                                                                              } else {
                                                                                                return 16.0;
                                                                                              }
                                                                                            }(),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0xFFA6B6C3),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      filled: true,
                                                                                      fillColor: FlutterFlowTheme.of(context).alternate,
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 8.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 10.0;
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
                                                                                    minLines: 1,
                                                                                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                    validator: _model.fullNameTextFieldTextController3Validator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 1,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          0.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            flex:
                                                                                2,
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Container(
                                                                                width: 53.8,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(),
                                                                                child: Align(
                                                                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                  child: Text(
                                                                                    FFLocalizations.of(context).getText(
                                                                                      'hwepwafm' /* 직책 */,
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FontWeight.w600,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 10.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 12.0;
                                                                                            } else {
                                                                                              return 12.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.w600,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            flex:
                                                                                8,
                                                                            child:
                                                                                Container(
                                                                              width: 297.0,
                                                                              height: double.infinity,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  child: TextFormField(
                                                                                    controller: _model.positionTextFieldTextController,
                                                                                    focusNode: _model.positionTextFieldFocusNode,
                                                                                    onChanged: (_) => EasyDebounce.debounce(
                                                                                      '_model.positionTextFieldTextController',
                                                                                      Duration(milliseconds: 500),
                                                                                      () => safeSetState(() {}),
                                                                                    ),
                                                                                    autofocus: true,
                                                                                    obscureText: false,
                                                                                    decoration: InputDecoration(
                                                                                      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                          ),
                                                                                      hintText: FFLocalizations.of(context).getText(
                                                                                        'h3d8rjue' /* 000 건축사회 부장 */,
                                                                                      ),
                                                                                      hintStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                            font: GoogleFonts.openSans(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                            ),
                                                                                            color: FlutterFlowTheme.of(context).neutral300,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyLarge.fontStyle,
                                                                                          ),
                                                                                      enabledBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).alternate,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: Color(0xFFA6B6C3),
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      errorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      focusedErrorBorder: OutlineInputBorder(
                                                                                        borderSide: BorderSide(
                                                                                          color: FlutterFlowTheme.of(context).error,
                                                                                          width: 1.0,
                                                                                        ),
                                                                                        borderRadius: BorderRadius.circular(4.0),
                                                                                      ),
                                                                                      contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 8.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 10.0;
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
                                                                                    minLines: 1,
                                                                                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                    validator: _model.positionTextFieldTextControllerValidator.asValidator(context),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 3,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          5.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 5,
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'yfbo7xjg' /* 교수/직급 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 10.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 12.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 12.0;
                                                                                                  } else {
                                                                                                    return 12.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'mtw428iw' /* 중복선택 불가 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 6.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 8.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 10.0;
                                                                                                  } else {
                                                                                                    return 12.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 7,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Material(
                                                                                        color: Colors.transparent,
                                                                                        child: Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              visualDensity: VisualDensity.compact,
                                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                            ),
                                                                                            unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
                                                                                          ),
                                                                                          child: CheckboxListTile(
                                                                                            value: _model.checkboxListTileValue1 ??= (FFAppState().usertype == 1) || (FFAppState().usertype == 0),
                                                                                            onChanged: true
                                                                                                ? null
                                                                                                : (newValue) async {
                                                                                                    safeSetState(() => _model.checkboxListTileValue1 = newValue!);
                                                                                                  },
                                                                                            title: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'n04ltll6' /* 교수 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 10.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 11.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 12.0;
                                                                                                      } else {
                                                                                                        return 16.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            tileColor: FlutterFlowTheme.of(context).alternate,
                                                                                            activeColor: Color(0xFF284E75),
                                                                                            checkColor: true ? null : FlutterFlowTheme.of(context).info,
                                                                                            dense: true,
                                                                                            controlAffinity: ListTileControlAffinity.leading,
                                                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Material(
                                                                                        color: Colors.transparent,
                                                                                        child: Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              visualDensity: VisualDensity.compact,
                                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                            ),
                                                                                            unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
                                                                                          ),
                                                                                          child: CheckboxListTile(
                                                                                            value: _model.checkboxListTileValue2 ??= FFAppState().usertype == 2,
                                                                                            onChanged: true
                                                                                                ? null
                                                                                                : (newValue) async {
                                                                                                    safeSetState(() => _model.checkboxListTileValue2 = newValue!);
                                                                                                  },
                                                                                            title: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'h98p06pq' /* 겸임교수 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 10.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 11.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 12.0;
                                                                                                      } else {
                                                                                                        return 16.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            tileColor: FlutterFlowTheme.of(context).alternate,
                                                                                            activeColor: Color(0xFF284E75),
                                                                                            checkColor: true ? null : FlutterFlowTheme.of(context).info,
                                                                                            dense: true,
                                                                                            controlAffinity: ListTileControlAffinity.leading,
                                                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 7,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Material(
                                                                                        color: Colors.transparent,
                                                                                        child: Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              visualDensity: VisualDensity.compact,
                                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                            ),
                                                                                            unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
                                                                                          ),
                                                                                          child: CheckboxListTile(
                                                                                            value: _model.checkboxListTileValue3 ??= FFAppState().usertype == 3,
                                                                                            onChanged: true
                                                                                                ? null
                                                                                                : (newValue) async {
                                                                                                    safeSetState(() => _model.checkboxListTileValue3 = newValue!);
                                                                                                  },
                                                                                            title: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'yoe20ttz' /* 부교수 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 10.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 11.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 12.0;
                                                                                                      } else {
                                                                                                        return 16.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            tileColor: FlutterFlowTheme.of(context).alternate,
                                                                                            activeColor: Color(0xFF284E75),
                                                                                            checkColor: true ? null : FlutterFlowTheme.of(context).info,
                                                                                            dense: true,
                                                                                            controlAffinity: ListTileControlAffinity.leading,
                                                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Material(
                                                                                        color: Colors.transparent,
                                                                                        child: Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              visualDensity: VisualDensity.compact,
                                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                            ),
                                                                                            unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
                                                                                          ),
                                                                                          child: CheckboxListTile(
                                                                                            value: _model.checkboxListTileValue4 ??= false,
                                                                                            onChanged: true
                                                                                                ? null
                                                                                                : (newValue) async {
                                                                                                    safeSetState(() => _model.checkboxListTileValue4 = newValue!);
                                                                                                  },
                                                                                            title: Text(
                                                                                              FFLocalizations.of(context).getText(
                                                                                                'gufm3ud4' /* 외래강사 */,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 10.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 11.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 12.0;
                                                                                                      } else {
                                                                                                        return 16.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                  ),
                                                                                            ),
                                                                                            tileColor: FlutterFlowTheme.of(context).alternate,
                                                                                            activeColor: Color(0xFF284E75),
                                                                                            checkColor: true ? null : FlutterFlowTheme.of(context).info,
                                                                                            dense: true,
                                                                                            controlAffinity: ListTileControlAffinity.leading,
                                                                                            contentPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 6,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Material(
                                                                                      color: Colors.transparent,
                                                                                      child: Theme(
                                                                                        data: ThemeData(
                                                                                          checkboxTheme: CheckboxThemeData(
                                                                                            visualDensity: VisualDensity.compact,
                                                                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                          ),
                                                                                          unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
                                                                                        ),
                                                                                        child: CheckboxListTile(
                                                                                          value: _model.checkboxListTileValue5 ??= false,
                                                                                          onChanged: true
                                                                                              ? null
                                                                                              : (newValue) async {
                                                                                                  safeSetState(() => _model.checkboxListTileValue5 = newValue!);
                                                                                                },
                                                                                          title: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'wkqh2lzl' /* 조교수 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 8.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 8.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 12.0;
                                                                                                    } else {
                                                                                                      return 16.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                          tileColor: FlutterFlowTheme.of(context).alternate,
                                                                                          activeColor: Color(0xFF284E75),
                                                                                          checkColor: true ? null : FlutterFlowTheme.of(context).info,
                                                                                          dense: true,
                                                                                          controlAffinity: ListTileControlAffinity.leading,
                                                                                          contentPadding: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 6.0, 0.0),
                                                                                          shape: RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                          ),
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
                                                                  Flexible(
                                                                    flex: 5,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          5.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 2,
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'tshmti4o' /* 자격증여부 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 10.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 12.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 12.0;
                                                                                                  } else {
                                                                                                    return 12.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Text(
                                                                                          FFLocalizations.of(context).getText(
                                                                                            'enfc42ye' /* 중복선택 가능 */,
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 6.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 8.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 10.0;
                                                                                                  } else {
                                                                                                    return 12.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().archix = !FFAppState().archix);
                                                                                                },
                                                                                                value: FFAppState().archix,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'dkdjih3h' /* 건축사 X */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Visibility(
                                                                                          visible: FFAppState().archix == false,
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                flex: 1,
                                                                                                child: ToggleIcon(
                                                                                                  onPressed: () async {
                                                                                                    safeSetState(() => FFAppState().archikr = !FFAppState().archikr);
                                                                                                  },
                                                                                                  value: FFAppState().archikr,
                                                                                                  onIcon: Icon(
                                                                                                    Icons.check_box,
                                                                                                    color: Color(0xFF284E75),
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                  offIcon: Icon(
                                                                                                    Icons.check_box_outline_blank,
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'zsl7644y' /* 건축사 (KR) */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Visibility(
                                                                                          visible: FFAppState().archix == false,
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                flex: 1,
                                                                                                child: ToggleIcon(
                                                                                                  onPressed: () async {
                                                                                                    safeSetState(() => FFAppState().archiabroad = !FFAppState().archiabroad);
                                                                                                  },
                                                                                                  value: FFAppState().archiabroad,
                                                                                                  onIcon: Icon(
                                                                                                    Icons.check_box,
                                                                                                    color: Color(0xFF284E75),
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                  offIcon: Icon(
                                                                                                    Icons.check_box_outline_blank,
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '81evr463' /* 건축사 해외 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Visibility(
                                                                                          visible: FFAppState().archiabroad == true,
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            child: TextFormField(
                                                                                              controller: _model.archiAbroadTextFieldTextController,
                                                                                              focusNode: _model.archiAbroadTextFieldFocusNode,
                                                                                              autofocus: true,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                    ),
                                                                                                hintText: FFLocalizations.of(context).getText(
                                                                                                  'kr0pvnl1' /* 건축사 취득국가 */,
                                                                                                ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 6.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                          return 8.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                          return 10.0;
                                                                                                        } else {
                                                                                                          return 12.0;
                                                                                                        }
                                                                                                      }(),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 6.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 8.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 10.0;
                                                                                                      } else {
                                                                                                        return 12.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                              textAlign: TextAlign.start,
                                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              validator: _model.archiAbroadTextFieldTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().technicx = !FFAppState().technicx);
                                                                                                },
                                                                                                value: FFAppState().technicx,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'lw1gmyfz' /* 기술사 X */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Visibility(
                                                                                          visible: FFAppState().technicx == false,
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                flex: 1,
                                                                                                child: ToggleIcon(
                                                                                                  onPressed: () async {
                                                                                                    safeSetState(() => FFAppState().technickr = !FFAppState().technickr);
                                                                                                  },
                                                                                                  value: FFAppState().technickr,
                                                                                                  onIcon: Icon(
                                                                                                    Icons.check_box,
                                                                                                    color: Color(0xFF284E75),
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                  offIcon: Icon(
                                                                                                    Icons.check_box_outline_blank,
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      '3f77m4mk' /* 기술사 (KR) */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Visibility(
                                                                                          visible: FFAppState().technicx == false,
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            children: [
                                                                                              Flexible(
                                                                                                flex: 1,
                                                                                                child: ToggleIcon(
                                                                                                  onPressed: () async {
                                                                                                    safeSetState(() => FFAppState().technicabroad = !FFAppState().technicabroad);
                                                                                                  },
                                                                                                  value: FFAppState().technicabroad,
                                                                                                  onIcon: Icon(
                                                                                                    Icons.check_box,
                                                                                                    color: Color(0xFF284E75),
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                  offIcon: Icon(
                                                                                                    Icons.check_box_outline_blank,
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    size: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 12.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 18.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 20.0;
                                                                                                      } else {
                                                                                                        return 24.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                              Expanded(
                                                                                                flex: 2,
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                  child: Text(
                                                                                                    FFLocalizations.of(context).getText(
                                                                                                      'dm3k8m83' /* 기술사 해외 */,
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          font: GoogleFonts.openSans(
                                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                          ),
                                                                                                          fontSize: () {
                                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                              return 8.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                              return 10.0;
                                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                              return 12.0;
                                                                                                            } else {
                                                                                                              return 16.0;
                                                                                                            }
                                                                                                          }(),
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 1,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Visibility(
                                                                                          visible: FFAppState().technicabroad == true,
                                                                                          child: Container(
                                                                                            width: double.infinity,
                                                                                            child: TextFormField(
                                                                                              controller: _model.technicAboardTextFieldTextController,
                                                                                              focusNode: _model.technicAboardTextFieldFocusNode,
                                                                                              autofocus: true,
                                                                                              obscureText: false,
                                                                                              decoration: InputDecoration(
                                                                                                isDense: true,
                                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                      ),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                    ),
                                                                                                hintText: FFLocalizations.of(context).getText(
                                                                                                  '4fhdm27x' /* 기술사 취득국가 */,
                                                                                                ),
                                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                      font: GoogleFonts.openSans(
                                                                                                        fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                      ),
                                                                                                      fontSize: () {
                                                                                                        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                          return 6.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                          return 8.0;
                                                                                                        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                          return 10.0;
                                                                                                        } else {
                                                                                                          return 12.0;
                                                                                                        }
                                                                                                      }(),
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
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
                                                                                                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                    ),
                                                                                                    fontSize: () {
                                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                        return 6.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                        return 8.0;
                                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                        return 10.0;
                                                                                                      } else {
                                                                                                        return 12.0;
                                                                                                      }
                                                                                                    }(),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                              textAlign: TextAlign.start,
                                                                                              cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                              validator: _model.technicAboardTextFieldTextControllerValidator.asValidator(context),
                                                                                            ),
                                                                                          ),
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
                                                                  Flexible(
                                                                    flex: 5,
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          5.0,
                                                                          5.0,
                                                                          5.0,
                                                                          0.0),
                                                                      child:
                                                                          Container(
                                                                        width: double
                                                                            .infinity,
                                                                        height:
                                                                            double.infinity,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                        ),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Flexible(
                                                                              flex: 2,
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  decoration: BoxDecoration(
                                                                                    color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  ),
                                                                                  child: Align(
                                                                                    alignment: AlignmentDirectional(-1.07, 0.35),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              'fhitymps' /* 전문분야 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 10.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 12.0;
                                                                                                    } else {
                                                                                                      return 12.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                          child: Text(
                                                                                            FFLocalizations.of(context).getText(
                                                                                              '3u1bw8mo' /* 중복선택 가능 */,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 6.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 8.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 10.0;
                                                                                                    } else {
                                                                                                      return 12.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().design = !FFAppState().design);
                                                                                                },
                                                                                                value: FFAppState().design,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'ocskd7zn' /* 설계분야 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().digital = !FFAppState().digital);
                                                                                                },
                                                                                                value: FFAppState().digital,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'y6w18cm5' /* 디지털분야 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().environment = !FFAppState().environment);
                                                                                                },
                                                                                                value: FFAppState().environment,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    '2krcaud0' /* 환경분야 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Expanded(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().other = !FFAppState().other);
                                                                                                },
                                                                                                value: FFAppState().other,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'kfw9fjyg' /* 기타 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
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
                                                                            Flexible(
                                                                              flex: 4,
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                ),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().consturction = !FFAppState().consturction);
                                                                                                },
                                                                                                value: FFAppState().consturction,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 18.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 20.0;
                                                                                                    } else {
                                                                                                      return 24.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'z6xljota' /* 시공분야 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().structural = !FFAppState().structural);
                                                                                                },
                                                                                                value: FFAppState().structural,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    'rgrtdouh' /* 구조분야 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Container(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        decoration: BoxDecoration(
                                                                                          color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        ),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Flexible(
                                                                                              flex: 1,
                                                                                              child: ToggleIcon(
                                                                                                onPressed: () async {
                                                                                                  safeSetState(() => FFAppState().scape = !FFAppState().scape);
                                                                                                },
                                                                                                value: FFAppState().scape,
                                                                                                onIcon: Icon(
                                                                                                  Icons.check_box,
                                                                                                  color: Color(0xFF284E75),
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                                offIcon: Icon(
                                                                                                  Icons.check_box_outline_blank,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 24.0,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 2,
                                                                                              child: Padding(
                                                                                                padding: EdgeInsetsDirectional.fromSTEB(10.0, 3.0, 0.0, 0.0),
                                                                                                child: Text(
                                                                                                  FFLocalizations.of(context).getText(
                                                                                                    '72bcm0kx' /* 조경분야 */,
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        font: GoogleFonts.openSans(
                                                                                                          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                        ),
                                                                                                        fontSize: () {
                                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                            return 8.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                            return 10.0;
                                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                            return 12.0;
                                                                                                          } else {
                                                                                                            return 16.0;
                                                                                                          }
                                                                                                        }(),
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Flexible(
                                                                                      flex: 2,
                                                                                      child: Align(
                                                                                        alignment: AlignmentDirectional(-1.0, 0.0),
                                                                                        child: Container(
                                                                                          width: double.infinity,
                                                                                          child: TextFormField(
                                                                                            controller: _model.otherTextFieldTextController,
                                                                                            focusNode: _model.otherTextFieldFocusNode,
                                                                                            autofocus: true,
                                                                                            obscureText: false,
                                                                                            decoration: InputDecoration(
                                                                                              isDense: true,
                                                                                              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                  ),
                                                                                              hintText: FFLocalizations.of(context).getText(
                                                                                                '9v2hle1k' /* 기타 전문분야 */,
                                                                                              ),
                                                                                              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                                    font: GoogleFonts.openSans(
                                                                                                      fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                      fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                                                                                                    ),
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
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
                                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 6.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 8.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 10.0;
                                                                                                    } else {
                                                                                                      return 12.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                            textAlign: TextAlign.start,
                                                                                            cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                            validator: _model.otherTextFieldTextControllerValidator.asValidator(context),
                                                                                          ),
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
                                                                  Flexible(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                      ),
                                                                      child:
                                                                          Visibility(
                                                                        visible:
                                                                            responsiveVisibility(
                                                                          context:
                                                                              context,
                                                                          tablet:
                                                                              false,
                                                                          tabletLandscape:
                                                                              false,
                                                                          desktop:
                                                                              false,
                                                                        ),
                                                                        child:
                                                                            FlutterFlowIconButton(
                                                                          borderRadius:
                                                                              8.0,
                                                                          buttonSize:
                                                                              20.0,
                                                                          fillColor:
                                                                              Color(0xFF284E75),
                                                                          icon:
                                                                              Icon(
                                                                            Icons.navigate_next,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).info,
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            _model.nextInMobile =
                                                                                0;
                                                                            safeSetState(() {});
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
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
                                                              .nextInMobile! >
                                                          -1) {
                                                        return true;
                                                      } else {
                                                        return false;
                                                      }
                                                    }())
                                                      Flexible(
                                                        flex: 4,
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
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
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
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                50.0,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).primaryBackground,
                                                                            ),
                                                                            child:
                                                                                Visibility(
                                                                              visible: _model.phoneTextFieldTextController.text != '',
                                                                              child: Align(
                                                                                alignment: AlignmentDirectional(1.0, 0.0),
                                                                                child: SingleChildScrollView(
                                                                                  scrollDirection: Axis.horizontal,
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 4.0, 0.0),
                                                                                        child: FFButtonWidget(
                                                                                          onPressed: () async {
                                                                                            final academicRecords = _collectAcademicRecords();
                                                                                            final teachingRecords = _collectTeachingRecords();

                                                                                            _model.academicRecords = List<dynamic>.from(academicRecords);
                                                                                            _model.teachingRecords = List<dynamic>.from(teachingRecords);

                                                                                            FFAppState().mypageAcademicRecords =
                                                                                                _model.academicRecords.toList().cast<dynamic>();
                                                                                            FFAppState().mypageTeachingRecords =
                                                                                                _model.teachingRecords.toList().cast<dynamic>();
                                                                                            safeSetState(() {});

                                                                                            if (_model.myProfileList != null) {
                                                                                              await ProfessorMyprofileTable().update(
                                                                                                data: {
                                                                                                  'professor_name': _model.fullNameTextFieldTextController1.text,
                                                                                                  'pfr_phonenumber': valueOrDefault<String>(
                                                                                                    _model.phoneTextFieldTextController.text,
                                                                                                    '010-0000-0000',
                                                                                                  ),
                                                                                                  'pfr_birth': valueOrDefault<String>(
                                                                                                    _model.birthTextFieldTextController.text,
                                                                                                    '0000.00',
                                                                                                  ),
                                                                                                  'pfr_email': _model.fullNameTextFieldTextController2.text,
                                                                                                  'pfr_institution': _model.fullNameTextFieldTextController3.text,
                                                                                                  'prf_positon': valueOrDefault<String>(
                                                                                                    _model.positionTextFieldTextController.text,
                                                                                                    '직책',
                                                                                                  ),
                                                                                                  'pfr_licensed': <String, dynamic>{
                                                                                                    'archix': FFAppState().archix,
                                                                                                    'technicx': FFAppState().technicx,
                                                                                                    'archikr': FFAppState().archikr,
                                                                                                    'technickr': FFAppState().technickr,
                                                                                                    'archiabroad': FFAppState().archiabroad,
                                                                                                    'technicabroad': FFAppState().technicabroad,
                                                                                                    'archiabroaddetail': _model.archiAbroadTextFieldTextController.text,
                                                                                                    'technicabroaddetail': _model.technicAboardTextFieldTextController.text,
                                                                                                  },
                                                                                                  'pfr_project': _model.projectTextFieldTextController.text,
                                                                                                  'pfr_speciality': <String, dynamic>{
                                                                                                    'design': FFAppState().design,
                                                                                                    'consturction': FFAppState().consturction,
                                                                                                    'digital': FFAppState().digital,
                                                                                                    'structural': FFAppState().structural,
                                                                                                    'environment': FFAppState().environment,
                                                                                                    'scape': FFAppState().scape,
                                                                                                    'other': FFAppState().other,
                                                                                                    'otherdetail': _model.otherTextFieldTextController.text,
                                                                                                  },
                                                                                                  'pfr_type': FFAppState().usertype,
                                                                                                  'pfr_imageurl': FFAppState().mypageImageUrl,
                                                                                                  'degreeList': _model.academicRecords,
                                                                                                  'lecExperience': _model.teachingRecords,
                                                                                                },
                                                                                                matchingRows: (rows) => rows.eqOrNull(
                                                                                                  'professor_name',
                                                                                                  FFAppState().professorNameSelected,
                                                                                                ),
                                                                                              );
                                                                                            } else {
                                                                                              await ProfessorMyprofileTable().insert({
                                                                                                'professor_name': _model.fullNameTextFieldTextController1.text,
                                                                                                'pfr_phonenumber': valueOrDefault<String>(
                                                                                                  _model.phoneTextFieldTextController.text,
                                                                                                  '010-0000-0000',
                                                                                                ),
                                                                                                'pfr_birth': valueOrDefault<String>(
                                                                                                  _model.birthTextFieldTextController.text,
                                                                                                  '0000.00',
                                                                                                ),
                                                                                                'pfr_email': currentUserEmail,
                                                                                                'pfr_institution': _model.fullNameTextFieldTextController3.text,
                                                                                                'pfr_type': FFAppState().usertype,
                                                                                                'pfr_speciality': <String, dynamic>{
                                                                                                  'design': FFAppState().design,
                                                                                                  'consturction': FFAppState().consturction,
                                                                                                  'digital': FFAppState().digital,
                                                                                                  'structural': FFAppState().structural,
                                                                                                  'environment': FFAppState().environment,
                                                                                                  'scape': FFAppState().scape,
                                                                                                  'other': FFAppState().other,
                                                                                                  'otherdetail': _model.otherTextFieldTextController.text,
                                                                                                },
                                                                                                'pfr_project': _model.projectTextFieldTextController.text,
                                                                                                'pfr_licensed': <String, dynamic>{
                                                                                                  'archix': FFAppState().archix,
                                                                                                  'technicx': FFAppState().technicx,
                                                                                                  'archikr': FFAppState().archikr,
                                                                                                  'technickr': FFAppState().technickr,
                                                                                                  'archiabroad': FFAppState().archiabroad,
                                                                                                  'technicabroad': FFAppState().technicabroad,
                                                                                                  'archiabroaddetail': _model.archiAbroadTextFieldTextController.text,
                                                                                                  'technicabroaddetail': _model.technicAboardTextFieldTextController.text,
                                                                                                },
                                                                                                'prf_positon': valueOrDefault<String>(
                                                                                                  _model.positionTextFieldTextController.text,
                                                                                                  '직책',
                                                                                                ),
                                                                                                'degreeList': _model.academicRecords,
                                                                                                'lecExperience': _model.teachingRecords,
                                                                                                'pfr_imageurl': FFAppState().mypageImageUrl,
                                                                                              });
                                                                                              FFAppState().mypageAcademicRecords =
                                                                                                  _model.academicRecords.toList().cast<dynamic>();
                                                                                              FFAppState().mypageTeachingRecords =
                                                                                                  _model.teachingRecords.toList().cast<dynamic>();

                                                                                              // 백업 값을 현재 값으로 업데이트 (적용 버튼 클릭 시)
                                                                                              _model.backupArchix = FFAppState().archix;
                                                                                              _model.backupArchikr = FFAppState().archikr;
                                                                                              _model.backupArchiabroad = FFAppState().archiabroad;
                                                                                              _model.backupTechnicx = FFAppState().technicx;
                                                                                              _model.backupTechnickr = FFAppState().technickr;
                                                                                              _model.backupTechnicabroad = FFAppState().technicabroad;
                                                                                              _model.backupDesign = FFAppState().design;
                                                                                              _model.backupDigital = FFAppState().digital;
                                                                                              _model.backupEnvironment = FFAppState().environment;
                                                                                              _model.backupOther = FFAppState().other;
                                                                                              _model.backupConsturction = FFAppState().consturction;
                                                                                              _model.backupStructural = FFAppState().structural;
                                                                                              _model.backupScape = FFAppState().scape;
                                                                                              _model.backupAcademicRecords = List<dynamic>.from(FFAppState().mypageAcademicRecords);
                                                                                              _model.backupTeachingRecords = List<dynamic>.from(FFAppState().mypageTeachingRecords);

                                                                                              safeSetState(() {});
                                                                                            }

                                                                                            safeSetState(() {});
                                                                                          },
                                                                                text: FFLocalizations.of(context).getText(
                                                                                            'j7aomech' /* 적용 */,
                                                                                          ),
                                                                                          options: FFButtonOptions(
                                                                                            width: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 80.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 80.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 100.0;
                                                                                              } else {
                                                                                                return 140.0;
                                                                                              }
                                                                                            }(),
                                                                                            height: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 40.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 40.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 40.0;
                                                                                              } else {
                                                                                                return 50.0;
                                                                                              }
                                                                                            }(),
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 13.0, 24.0, 13.0),
                                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                            color: Color(0xFF284E75),
                                                                                            textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).white0,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 10.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 10.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 14.0;
                                                                                                    } else {
                                                                                                      return 18.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                ),
                                                                                            elevation: 0.0,
                                                                                            borderSide: BorderSide(
                                                                                              color: Colors.transparent,
                                                                                              width: 1.0,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(8.0),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 5.0, 0.0),
                                                                                        child: FFButtonWidget(
                                                                                          onPressed: () async {
                                                                                            var confirmDialogResponse = await showDialog<bool>(
                                                                                                  context: context,
                                                                                                  builder: (alertDialogContext) {
                                                                                                    return WebViewAware(
                                                                                                      child: AlertDialog(
                                                                                                        title: Text('내 정보 초기화'),
                                                                                                        content: Text('정말 초기화하시겠습니까?'),
                                                                                                        actions: [
                                                                                                          TextButton(
                                                                                                            onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                            child: Text('취소'),
                                                                                                          ),
                                                                                                          TextButton(
                                                                                                            onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                            child: Text('확인'),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ) ??
                                                                                                false;
                                                                                            if (confirmDialogResponse) {
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

                                                                                              // 백업 값을 초기화된 값으로 업데이트 (초기화 버튼 클릭 시)
                                                                                              _model.backupArchix = false;
                                                                                              _model.backupArchikr = false;
                                                                                              _model.backupArchiabroad = false;
                                                                                              _model.backupTechnicx = false;
                                                                                              _model.backupTechnickr = false;
                                                                                              _model.backupTechnicabroad = false;
                                                                                              _model.backupDesign = false;
                                                                                              _model.backupDigital = false;
                                                                                              _model.backupEnvironment = false;
                                                                                              _model.backupOther = false;
                                                                                              _model.backupConsturction = false;
                                                                                              _model.backupStructural = false;
                                                                                              _model.backupScape = false;

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
                                                                                              // 백업 값을 초기화된 값으로 업데이트 (학력설정 및 경력사항)
                                                                                              _model.backupAcademicRecords = List<dynamic>.from(FFAppState().mypageAcademicRecords);
                                                                                              _model.backupTeachingRecords = List<dynamic>.from(FFAppState().mypageTeachingRecords);
                                                                                            }
                                                                                          },
                                                                                          text: FFLocalizations.of(context).getText(
                                                                                            '3flj97lu' /* 초기화 */,
                                                                                          ),
                                                                                          options: FFButtonOptions(
                                                                                            width: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 80.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 80.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 100.0;
                                                                                              } else {
                                                                                                return 140.0;
                                                                                              }
                                                                                            }(),
                                                                                            height: () {
                                                                                              if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                return 40.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                return 40.0;
                                                                                              } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                return 40.0;
                                                                                              } else {
                                                                                                return 50.0;
                                                                                              }
                                                                                            }(),
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 13.0, 24.0, 13.0),
                                                                                            iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FontWeight.w500,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                  ),
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 8.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 10.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 14.0;
                                                                                                    } else {
                                                                                                      return 18.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w500,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                                                ),
                                                                                            elevation: 0.0,
                                                                                            borderSide: BorderSide(
                                                                                              color: FlutterFlowTheme.of(context).alternate,
                                                                                              width: 1.0,
                                                                                            ),
                                                                                            borderRadius: BorderRadius.circular(8.0),
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
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (false) // 다이얼로그 비활성화
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 16.0,
                                                      color: Color(0x1B080B1F),
                                                      offset: Offset(
                                                        0.0,
                                                        6.0,
                                                      ),
                                                    )
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Flexible(
                                                        flex: 3,
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 3,
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 1.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 3.0,
                                                              ),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Flexible(
                                                                  flex: 1,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              'ietmoizm' /* 마이 프로필  등록 */,
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.openSans(
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              font: GoogleFonts.openSans(
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                              color: Color(0xFF284E75),
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Flexible(
                                                                  flex: 1,
                                                                  child: Text(
                                                                    FFLocalizations.of(
                                                                            context)
                                                                        .getText(
                                                                      'm6t6p3e8' /* 프로필 작성을 진행하시겠습니까? */,
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.openSans(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).labelLarge.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).labelLarge.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .labelLarge
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .labelLarge
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        flex: 1,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      10.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: MouseRegion(
                                                            opaque: false,
                                                            cursor: MouseCursor
                                                                    .defer,
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                context.goNamed(
                                                                    LoginPageWidget
                                                                        .routeName);
                                                              },
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                height: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                ),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              5.0,
                                                                              0.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              _model.boolForRender = true;
                                                                              safeSetState(() {});
                                                                            },
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              '14speupj' /* 네 */,
                                                                            ),
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 100.0,
                                                                              height: 40.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: Color(0xFF284E75),
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: Colors.white,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Flexible(
                                                                      child:
                                                                          Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              5.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              FFButtonWidget(
                                                                            onPressed:
                                                                                () async {
                                                                              context.safePop();
                                                                            },
                                                                            text:
                                                                                FFLocalizations.of(context).getText(
                                                                              '6z1tem9w' /* 아니오 */,
                                                                            ),
                                                                            options:
                                                                                FFButtonOptions(
                                                                              width: 100.0,
                                                                              height: 40.0,
                                                                              padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                              iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                    ),
                                                                                    color: Colors.white,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                              elevation: 0.0,
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            onEnter:
                                                                ((event) async {
                                                              safeSetState(() =>
                                                                  _model.mouseRegionHovered =
                                                                      true);
                                                            }),
                                                            onExit:
                                                                ((event) async {
                                                              safeSetState(() =>
                                                                  _model.mouseRegionHovered =
                                                                      false);
                                                            }),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    Expanded(
                                      flex: 3,
                                      child: wrapWithModel(
                                        model: _model.rightWidgetModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: RightWidgetWidget(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
