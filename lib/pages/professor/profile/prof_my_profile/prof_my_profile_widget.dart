import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/components/profile/degree_input/degree_input_widget.dart';
import '/components/profile/teaching_history/teaching_history_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfMyProfileModel());

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
        _model.academicRecords = _model.querybyname!.firstOrNull!.degreeList
            .toList()
            .cast<dynamic>();
        _model.teachingRecords = _model.querybyname!.firstOrNull!.lecExperience
            .toList()
            .cast<dynamic>();
        safeSetState(() {});
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
        if ((_model.academicRecords.firstOrNull != null) ||
            (_model.teachingRecords.firstOrNull != null)) {
        } else {
          _model.addToAcademicRecordsFirst(<String, dynamic>{
            'getDate': '',
            'university': '',
            'major': '',
            'degree': '',
          });
          _model.addToTeachingRecordsFirst(<String, dynamic>{
            'period': '',
            'schoolDepartment': '',
            'subject': '',
            'creditsHours': '',
          });
          safeSetState(() {});
          _model.academicRecords =
              _model.academicRecordsFirst.firstOrNull!.toList().cast<dynamic>();
          _model.teachingRecords =
              _model.teachingRecordsFirst.firstOrNull!.toList().cast<dynamic>();
          safeSetState(() {});
        }

        FFAppState().mypageAcademicRecords =
            _model.academicRecords.toList().cast<dynamic>();
        FFAppState().mypageTeachingRecords =
            _model.teachingRecords.toList().cast<dynamic>();
        safeSetState(() {});
      } else {
        _model.addToAcademicRecordsFirst(<String, dynamic>{
          'getDate': '',
          'university': '',
          'major': '',
          'degree': '',
        });
        _model.addToTeachingRecordsFirst(<String, dynamic>{
          'period': '',
          'schoolDepartment': '',
          'subject': '',
          'creditsHours': '',
        });
        safeSetState(() {});
        _model.academicRecords =
            _model.academicRecordsFirst.firstOrNull!.toList().cast<dynamic>();
        _model.teachingRecords =
            _model.teachingRecordsFirst.firstOrNull!.toList().cast<dynamic>();
        safeSetState(() {});
        FFAppState().mypageAcademicRecords =
            _model.academicRecords.toList().cast<dynamic>();
        FFAppState().mypageTeachingRecords =
            FFAppState().mypageTeachingRecords.toList().cast<dynamic>();
        safeSetState(() {});
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
                                                    if (responsiveVisibility(
                                                      context: context,
                                                      phone: false,
                                                      tablet: false,
                                                    ))
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(
                                                          height:
                                                              MediaQuery.sizeOf(
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
                                                            children: [
                                                              Flexible(
                                                                flex: 1,
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
                                                                        35.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          10.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
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
                                                                              fontSize: () {
                                                                                if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                  return 10.0;
                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                  return 12.0;
                                                                                } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                  return 18.0;
                                                                                } else {
                                                                                  return 22.0;
                                                                                }
                                                                              }(),
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Flexible(
                                                                flex: 4,
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
                                                                flex: 12,
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
                                                                    flex: 2,
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
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                        ),
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 12.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 12.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 14.0;
                                                                                          } else {
                                                                                            return 18.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 14.0;
                                                                                            } else {
                                                                                              return 18.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                  style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                        ),
                                                                                        fontSize: () {
                                                                                          if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                            return 12.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                            return 12.0;
                                                                                          } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                            return 14.0;
                                                                                          } else {
                                                                                            return 18.0;
                                                                                          }
                                                                                        }(),
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 14.0;
                                                                                            } else {
                                                                                              return 18.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 14.0;
                                                                                            } else {
                                                                                              return 18.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                          ),
                                                                                          fontSize: () {
                                                                                            if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                              return 12.0;
                                                                                            } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                              return 14.0;
                                                                                            } else {
                                                                                              return 18.0;
                                                                                            }
                                                                                          }(),
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                ),
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 12.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 12.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 14.0;
                                                                                                  } else {
                                                                                                    return 18.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                font: GoogleFonts.openSans(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                ),
                                                                                                fontSize: () {
                                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                    return 12.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                    return 12.0;
                                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                    return 14.0;
                                                                                                  } else {
                                                                                                    return 18.0;
                                                                                                  }
                                                                                                }(),
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                                                  font: GoogleFonts.openSans(
                                                                                                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                                                                                                  ),
                                                                                                  fontSize: () {
                                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                                      return 12.0;
                                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                                      return 14.0;
                                                                                                    } else {
                                                                                                      return 18.0;
                                                                                                    }
                                                                                                  }(),
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
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
                                                                      .min,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          7.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'ib59489c' /* [학력 설정] */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                fontSize: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 10.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 12.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 18.0;
                                                                                  } else {
                                                                                    return 22.0;
                                                                                  }
                                                                                }(),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: valueOrDefault<
                                                                          double>(
                                                                        _model.academicRecords.elementAtOrNull(1) !=
                                                                                null
                                                                            ? 180.0
                                                                            : 100.0,
                                                                        100.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final academicSettingChildren = FFAppState()
                                                                              .mypageAcademicRecords
                                                                              .map((e) => e)
                                                                              .toList()
                                                                              .take(3)
                                                                              .toList();

                                                                          return ListView
                                                                              .builder(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            primary:
                                                                                false,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                academicSettingChildren.length,
                                                                            itemBuilder:
                                                                                (context, academicSettingChildrenIndex) {
                                                                              final academicSettingChildrenItem = academicSettingChildren[academicSettingChildrenIndex];
                                                                              return wrapWithModel(
                                                                                model: _model.degreeInputModels.getModel(
                                                                                  academicSettingChildrenIndex.toString(),
                                                                                  academicSettingChildrenIndex,
                                                                                ),
                                                                                updateCallback: () => safeSetState(() {}),
                                                                                updateOnChange: true,
                                                                                child: DegreeInputWidget(
                                                                                  key: Key(
                                                                                    'Keyj4i_${academicSettingChildrenIndex.toString()}',
                                                                                  ),
                                                                                  academicRecordItem: academicSettingChildrenItem,
                                                                                  getDate: getJsonField(
                                                                                    academicSettingChildrenItem,
                                                                                    r'''$.getDate''',
                                                                                  ).toString(),
                                                                                  university: getJsonField(
                                                                                    academicSettingChildrenItem,
                                                                                    r'''$.university''',
                                                                                  ).toString(),
                                                                                  major: getJsonField(
                                                                                    academicSettingChildrenItem,
                                                                                    r'''$.major''',
                                                                                  ).toString(),
                                                                                  degree: getJsonField(
                                                                                    academicSettingChildrenItem,
                                                                                    r'''$.degree''',
                                                                                  ).toString(),
                                                                                  currentSelectedSet: valueOrDefault<int>(
                                                                                    academicSettingChildrenIndex,
                                                                                    0,
                                                                                  ),
                                                                                  getAlldetails: () async {},
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 25.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      if (FFAppState()
                                                                              .mypageAcademicRecords
                                                                              .length <
                                                                          3)
                                                                        Flexible(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  FFAppState().addToMypageAcademicRecords(<String, dynamic>{
                                                                                    'getDate': '',
                                                                                    'university': '',
                                                                                    'major': '',
                                                                                    'degree': '',
                                                                                  });
                                                                                  safeSetState(() {});
                                                                                  _model.addToAcademicRecords(<String, dynamic>{
                                                                                    'getDate': '',
                                                                                    'university': '',
                                                                                    'major': '',
                                                                                    'degree': '',
                                                                                  });
                                                                                  safeSetState(() {});
                                                                                },
                                                                                text: FFLocalizations.of(context).getText(
                                                                                  'wbc1rycr' /* 추가 + */,
                                                                                ),
                                                                                icon: Icon(
                                                                                  Icons.add_to_photos_outlined,
                                                                                  size: 15.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: () {
                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                      return 20.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                      return 25.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                      return 30.0;
                                                                                    } else {
                                                                                      return 35.0;
                                                                                    }
                                                                                  }(),
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  iconColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  color: Color(0xFFA6B6C3),
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
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
                                                                      if (FFAppState()
                                                                              .mypageAcademicRecords
                                                                              .elementAtOrNull(1) !=
                                                                          null)
                                                                        Flexible(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  if (FFAppState().mypageAcademicRecords.elementAtOrNull(1) != null) {
                                                                                    FFAppState().removeFromMypageAcademicRecords(FFAppState().mypageAcademicRecords.lastOrNull!);
                                                                                    safeSetState(() {});
                                                                                    _model.removeFromAcademicRecords(_model.academicRecords.lastOrNull!);
                                                                                    safeSetState(() {});
                                                                                  }
                                                                                },
                                                                                text: FFLocalizations.of(context).getText(
                                                                                  'adyemods' /* 삭제 - */,
                                                                                ),
                                                                                icon: Icon(
                                                                                  Icons.delete_forever,
                                                                                  size: 15.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: () {
                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                      return 20.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                      return 25.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                      return 30.0;
                                                                                    } else {
                                                                                      return 35.0;
                                                                                    }
                                                                                  }(),
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  iconColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
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
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
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
                                                                ),
                                                                Padding(
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
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                    child:
                                                                        Align(
                                                                      alignment: AlignmentDirectional(
                                                                          -1.0,
                                                                          -1.0),
                                                                      child:
                                                                          Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          FFLocalizations.of(context)
                                                                              .getText(
                                                                            'bagrzgyr' /* [강사 경력] */,
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.openSans(
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                fontSize: () {
                                                                                  if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                    return 10.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                    return 12.0;
                                                                                  } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                    return 18.0;
                                                                                  } else {
                                                                                    return 22.0;
                                                                                  }
                                                                                }(),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0.0,
                                                                          -1.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child:
                                                                        Container(
                                                                      width: double
                                                                          .infinity,
                                                                      height: valueOrDefault<
                                                                          double>(
                                                                        _model.teachingRecords.elementAtOrNull(1) !=
                                                                                null
                                                                            ? 180.0
                                                                            : 100.0,
                                                                        100.0,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Builder(
                                                                        builder:
                                                                            (context) {
                                                                          final mypageTeachingRecordsInCV = FFAppState()
                                                                              .mypageTeachingRecords
                                                                              .map((e) => e)
                                                                              .toList()
                                                                              .take(4)
                                                                              .toList();

                                                                          return ListView
                                                                              .builder(
                                                                            padding:
                                                                                EdgeInsets.zero,
                                                                            shrinkWrap:
                                                                                true,
                                                                            scrollDirection:
                                                                                Axis.vertical,
                                                                            itemCount:
                                                                                mypageTeachingRecordsInCV.length,
                                                                            itemBuilder:
                                                                                (context, mypageTeachingRecordsInCVIndex) {
                                                                              final mypageTeachingRecordsInCVItem = mypageTeachingRecordsInCV[mypageTeachingRecordsInCVIndex];
                                                                              return wrapWithModel(
                                                                                model: _model.teachingHistoryModels.getModel(
                                                                                  mypageTeachingRecordsInCVIndex.toString(),
                                                                                  mypageTeachingRecordsInCVIndex,
                                                                                ),
                                                                                updateCallback: () => safeSetState(() {}),
                                                                                updateOnChange: true,
                                                                                child: TeachingHistoryWidget(
                                                                                  key: Key(
                                                                                    'Keymj1_${mypageTeachingRecordsInCVIndex.toString()}',
                                                                                  ),
                                                                                  teachingRecordItem: mypageTeachingRecordsInCVItem,
                                                                                ),
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: double
                                                                      .infinity,
                                                                  height: 25.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      if (FFAppState()
                                                                              .mypageTeachingRecords
                                                                              .length <
                                                                          4)
                                                                        Flexible(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  FFAppState().addToMypageTeachingRecords(<String, dynamic>{
                                                                                    'period': '',
                                                                                    'schoolDepartment': '',
                                                                                    'subject': '',
                                                                                    'creditsHours': '',
                                                                                  });
                                                                                  safeSetState(() {});
                                                                                  _model.addToTeachingRecords(<String, dynamic>{
                                                                                    'period': '',
                                                                                    'schoolDepartment': '',
                                                                                    'subject': '',
                                                                                    'creditsHours': '',
                                                                                  });
                                                                                  safeSetState(() {});
                                                                                },
                                                                                text: FFLocalizations.of(context).getText(
                                                                                  '0ci94j6j' /* 추가 + */,
                                                                                ),
                                                                                icon: Icon(
                                                                                  Icons.add_to_photos_outlined,
                                                                                  size: 15.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: () {
                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                      return 20.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                      return 25.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                      return 30.0;
                                                                                    } else {
                                                                                      return 35.0;
                                                                                    }
                                                                                  }(),
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  iconColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  color: Color(0xFFA6B6C3),
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
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
                                                                      if (FFAppState()
                                                                              .mypageTeachingRecords
                                                                              .elementAtOrNull(1) !=
                                                                          null)
                                                                        Flexible(
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(1.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                                                                              child: FFButtonWidget(
                                                                                onPressed: () async {
                                                                                  if (FFAppState().mypageTeachingRecords.elementAtOrNull(1) != null) {
                                                                                    FFAppState().removeFromMypageTeachingRecords(FFAppState().mypageTeachingRecords.lastOrNull!);
                                                                                    safeSetState(() {});
                                                                                    _model.removeFromTeachingRecords(_model.teachingRecords.lastOrNull!);
                                                                                    safeSetState(() {});
                                                                                  }
                                                                                },
                                                                                text: FFLocalizations.of(context).getText(
                                                                                  'd31dksav' /* 삭제 - */,
                                                                                ),
                                                                                icon: Icon(
                                                                                  Icons.delete_forever,
                                                                                  size: 15.0,
                                                                                ),
                                                                                options: FFButtonOptions(
                                                                                  height: () {
                                                                                    if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                      return 20.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                      return 25.0;
                                                                                    } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                      return 30.0;
                                                                                    } else {
                                                                                      return 35.0;
                                                                                    }
                                                                                  }(),
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                                                                                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                                                                  iconColor: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                        font: GoogleFonts.openSans(
                                                                                          fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                          fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                        ),
                                                                                        color: Colors.white,
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
                                                                                        fontWeight: FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                                        fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
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
                                                                ),
                                                                Padding(
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
                                                                        40.0,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1.0,
                                                                              -1.0),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                5.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              FFLocalizations.of(context).getText(
                                                                                'tshfg401' /* [주요성과 및 프로젝트] */,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.openSans(
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    fontSize: () {
                                                                                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                                                                                        return 10.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
                                                                                        return 12.0;
                                                                                      } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
                                                                                        return 18.0;
                                                                                      } else {
                                                                                        return 22.0;
                                                                                      }
                                                                                    }(),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w600,
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
                                                                  flex: 6,
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            5.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child:
                                                                        SafeArea(
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
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Flexible(
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                child: TextFormField(
                                                                                  controller: _model.projectTextFieldTextController,
                                                                                  focusNode: _model.projectTextFieldFocusNode,
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
                                                                                      'bbx9df2u' /* 논문. 프로젝트 등 경력사항 */,
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
                                                                                  maxLines: null,
                                                                                  minLines: 8,
                                                                                  maxLength: 500,
                                                                                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                                                                                  cursorColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  validator: _model.projectTextFieldTextControllerValidator.asValidator(context),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                                            if (_model.myProfileList != null) {
                                                                                              _model.academicRecords = [];
                                                                                              _model.teachingRecords = [];
                                                                                              safeSetState(() {});
                                                                                              _model.addToAcademicRecords(<String, dynamic>{
                                                                                                'getDate': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField1TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'university': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField2TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'major': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField3TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'degree': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField4TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                              });
                                                                                              _model.addToTeachingRecords(<String, dynamic>{
                                                                                                'period': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController1.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'schoolDepartment': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController2.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'subject': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController3.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'creditsHours': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController4.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                              });
                                                                                              safeSetState(() {});
                                                                                              await Future.wait([
                                                                                                Future(() async {
                                                                                                  if ((_model.degreeInputModels
                                                                                                                  .getValues(
                                                                                                                    (m) => m.textField1TextController.text,
                                                                                                                  )
                                                                                                                  .elementAtOrNull(1) !=
                                                                                                              null &&
                                                                                                          _model.degreeInputModels
                                                                                                                  .getValues(
                                                                                                                    (m) => m.textField1TextController.text,
                                                                                                                  )
                                                                                                                  .elementAtOrNull(1) !=
                                                                                                              '') ==
                                                                                                      true) {
                                                                                                    _model.addToAcademicRecords(<String, dynamic>{
                                                                                                      'getDate': _model.degreeInputModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textField1TextController.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                      'university': _model.degreeInputModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textField2TextController.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                      'major': _model.degreeInputModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textField3TextController.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                      'degree': _model.degreeInputModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textField4TextController.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                    });
                                                                                                    safeSetState(() {});
                                                                                                    if ((_model.degreeInputModels
                                                                                                                    .getValues(
                                                                                                                      (m) => m.textField1TextController.text,
                                                                                                                    )
                                                                                                                    .elementAtOrNull(2) !=
                                                                                                                null &&
                                                                                                            _model.degreeInputModels
                                                                                                                    .getValues(
                                                                                                                      (m) => m.textField1TextController.text,
                                                                                                                    )
                                                                                                                    .elementAtOrNull(2) !=
                                                                                                                '') ==
                                                                                                        true) {
                                                                                                      _model.addToAcademicRecords(<String, dynamic>{
                                                                                                        'getDate': _model.degreeInputModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textField1TextController.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                        'university': _model.degreeInputModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textField2TextController.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                        'major': _model.degreeInputModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textField3TextController.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                        'degree': _model.degreeInputModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textField4TextController.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                      });
                                                                                                      safeSetState(() {});
                                                                                                    }
                                                                                                    FFAppState().mypageAcademicRecords = _model.academicRecords.toList().cast<dynamic>();
                                                                                                    safeSetState(() {});
                                                                                                  }

                                                                                                  safeSetState(() {});
                                                                                                }),
                                                                                                Future(() async {
                                                                                                  if ((_model.teachingHistoryModels
                                                                                                                  .getValues(
                                                                                                                    (m) => m.textController1.text,
                                                                                                                  )
                                                                                                                  .elementAtOrNull(1) !=
                                                                                                              null &&
                                                                                                          _model.teachingHistoryModels
                                                                                                                  .getValues(
                                                                                                                    (m) => m.textController1.text,
                                                                                                                  )
                                                                                                                  .elementAtOrNull(1) !=
                                                                                                              '') ==
                                                                                                      true) {
                                                                                                    _model.addToTeachingRecords(<String, dynamic>{
                                                                                                      'period': _model.teachingHistoryModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textController1.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                      'schoolDepartment': _model.teachingHistoryModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textController2.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                      'subject': _model.teachingHistoryModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textController3.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                      'creditsHours': _model.teachingHistoryModels
                                                                                                          .getValues(
                                                                                                            (m) => m.textController4.text,
                                                                                                          )
                                                                                                          .elementAtOrNull(1),
                                                                                                    });
                                                                                                    safeSetState(() {});
                                                                                                    if ((_model.teachingHistoryModels
                                                                                                                    .getValues(
                                                                                                                      (m) => m.textController1.text,
                                                                                                                    )
                                                                                                                    .elementAtOrNull(2) !=
                                                                                                                null &&
                                                                                                            _model.teachingHistoryModels
                                                                                                                    .getValues(
                                                                                                                      (m) => m.textController1.text,
                                                                                                                    )
                                                                                                                    .elementAtOrNull(2) !=
                                                                                                                '') ==
                                                                                                        true) {
                                                                                                      _model.addToTeachingRecords(<String, dynamic>{
                                                                                                        'period': _model.teachingHistoryModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textController1.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                        'schoolDepartment': _model.teachingHistoryModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textController2.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                        'subject': _model.teachingHistoryModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textController3.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                        'creditsHours': _model.teachingHistoryModels
                                                                                                            .getValues(
                                                                                                              (m) => m.textController4.text,
                                                                                                            )
                                                                                                            .elementAtOrNull(2),
                                                                                                      });
                                                                                                      safeSetState(() {});
                                                                                                      if ((_model.teachingHistoryModels
                                                                                                                      .getValues(
                                                                                                                        (m) => m.textController1.text,
                                                                                                                      )
                                                                                                                      .elementAtOrNull(3) !=
                                                                                                                  null &&
                                                                                                              _model.teachingHistoryModels
                                                                                                                      .getValues(
                                                                                                                        (m) => m.textController1.text,
                                                                                                                      )
                                                                                                                      .elementAtOrNull(3) !=
                                                                                                                  '') ==
                                                                                                          true) {
                                                                                                        _model.addToTeachingRecords(<String, dynamic>{
                                                                                                          'period': _model.teachingHistoryModels
                                                                                                              .getValues(
                                                                                                                (m) => m.textController1.text,
                                                                                                              )
                                                                                                              .elementAtOrNull(3),
                                                                                                          'schoolDepartment': _model.teachingHistoryModels
                                                                                                              .getValues(
                                                                                                                (m) => m.textController2.text,
                                                                                                              )
                                                                                                              .elementAtOrNull(3),
                                                                                                          'subject': _model.teachingHistoryModels
                                                                                                              .getValues(
                                                                                                                (m) => m.textController3.text,
                                                                                                              )
                                                                                                              .elementAtOrNull(3),
                                                                                                          'creditsHours': _model.teachingHistoryModels
                                                                                                              .getValues(
                                                                                                                (m) => m.textController4.text,
                                                                                                              )
                                                                                                              .elementAtOrNull(3),
                                                                                                        });
                                                                                                        safeSetState(() {});
                                                                                                      }
                                                                                                      FFAppState().mypageTeachingRecords = _model.teachingRecords.toList().cast<dynamic>();
                                                                                                      safeSetState(() {});
                                                                                                    }

                                                                                                    safeSetState(() {});
                                                                                                  }

                                                                                                  safeSetState(() {});
                                                                                                }),
                                                                                              ]);
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
                                                                                              _model.academicRecords = [];
                                                                                              _model.teachingRecords = [];
                                                                                              safeSetState(() {});
                                                                                              _model.addToAcademicRecords(<String, dynamic>{
                                                                                                'getDate': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField1TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'university': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField2TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'major': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField3TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'degree': _model.degreeInputModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textField4TextController.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                              });
                                                                                              _model.addToTeachingRecords(<String, dynamic>{
                                                                                                'period': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController1.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'schoolDepartment': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController2.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'subject': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController3.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                                'creditsHours': _model.teachingHistoryModels
                                                                                                    .getValues(
                                                                                                      (m) => m.textController4.text,
                                                                                                    )
                                                                                                    .firstOrNull,
                                                                                              });
                                                                                              safeSetState(() {});
                                                                                              if ((_model.degreeInputModels
                                                                                                              .getValues(
                                                                                                                (m) => m.textField1TextController.text,
                                                                                                              )
                                                                                                              .elementAtOrNull(1) !=
                                                                                                          null &&
                                                                                                      _model.degreeInputModels
                                                                                                              .getValues(
                                                                                                                (m) => m.textField1TextController.text,
                                                                                                              )
                                                                                                              .elementAtOrNull(1) !=
                                                                                                          '') ==
                                                                                                  true) {
                                                                                                _model.addToAcademicRecords(<String, dynamic>{
                                                                                                  'getDate': _model.degreeInputModels
                                                                                                      .getValues(
                                                                                                        (m) => m.textField1TextController.text,
                                                                                                      )
                                                                                                      .elementAtOrNull(1),
                                                                                                  'university': _model.degreeInputModels
                                                                                                      .getValues(
                                                                                                        (m) => m.textField2TextController.text,
                                                                                                      )
                                                                                                      .elementAtOrNull(1),
                                                                                                  'major': _model.degreeInputModels
                                                                                                      .getValues(
                                                                                                        (m) => m.textField3TextController.text,
                                                                                                      )
                                                                                                      .elementAtOrNull(1),
                                                                                                  'degree': _model.degreeInputModels
                                                                                                      .getValues(
                                                                                                        (m) => m.textField4TextController.text,
                                                                                                      )
                                                                                                      .elementAtOrNull(1),
                                                                                                });
                                                                                                safeSetState(() {});
                                                                                                if ((_model.degreeInputModels
                                                                                                                .getValues(
                                                                                                                  (m) => m.textField1TextController.text,
                                                                                                                )
                                                                                                                .elementAtOrNull(2) !=
                                                                                                            null &&
                                                                                                        _model.degreeInputModels
                                                                                                                .getValues(
                                                                                                                  (m) => m.textField1TextController.text,
                                                                                                                )
                                                                                                                .elementAtOrNull(2) !=
                                                                                                            '') ==
                                                                                                    true) {
                                                                                                  _model.addToAcademicRecords(<String, dynamic>{
                                                                                                    'getDate': _model.degreeInputModels
                                                                                                        .getValues(
                                                                                                          (m) => m.textField1TextController.text,
                                                                                                        )
                                                                                                        .elementAtOrNull(2),
                                                                                                    'university': _model.degreeInputModels
                                                                                                        .getValues(
                                                                                                          (m) => m.textField2TextController.text,
                                                                                                        )
                                                                                                        .elementAtOrNull(2),
                                                                                                    'major': _model.degreeInputModels
                                                                                                        .getValues(
                                                                                                          (m) => m.textField3TextController.text,
                                                                                                        )
                                                                                                        .elementAtOrNull(2),
                                                                                                    'degree': _model.degreeInputModels
                                                                                                        .getValues(
                                                                                                          (m) => m.textField4TextController.text,
                                                                                                        )
                                                                                                        .elementAtOrNull(2),
                                                                                                  });
                                                                                                  safeSetState(() {});
                                                                                                }
                                                                                              }
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
                                                                                              FFAppState().mypageAcademicRecords = _model.academicRecords.toList().cast<dynamic>();
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
                                                                                              FFAppState().mypageAcademicRecords = [];
                                                                                              FFAppState().mypageTeachingRecords = [];
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
                                                                                              _model.academicRecords = [];
                                                                                              _model.degreeTextField = null;
                                                                                              safeSetState(() {});
                                                                                              FFAppState().addToMypageAcademicRecords(<String, dynamic>{
                                                                                                'getDate': '',
                                                                                                'university': '',
                                                                                                'major': '',
                                                                                                'degree': '',
                                                                                              });
                                                                                              FFAppState().addToMypageTeachingRecords(<String, dynamic>{
                                                                                                'period': '',
                                                                                                'schoolDepartment': '',
                                                                                                'subject': '',
                                                                                                'creditsHours': '',
                                                                                              });
                                                                                              safeSetState(() {});
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
                                          if (_model.boolForRender == false)
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
                                                                                  fontSize: 22.0,
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
                                                                              fontSize: 18.0,
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
