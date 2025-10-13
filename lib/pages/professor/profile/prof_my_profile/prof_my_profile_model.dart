import '/backend/schema/structs/index.dart';
import '/backend/supabase/supabase.dart';
import '/components/default_layout/headers/header/header_widget.dart';
import '/components/default_layout/headers/header_mobile/header_mobile_widget.dart';
import '/components/default_layout/left_right/left_widget/left_widget_widget.dart';
import '/components/default_layout/left_right/right_widget/right_widget_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar/navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/navi_sidebar_mobile/navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'prof_my_profile_widget.dart' show ProfMyProfileWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfMyProfileModel extends FlutterFlowModel<ProfMyProfileWidget> {
  ///  Local state fields for this page.

  int? academicButtonAdd;

  List<dynamic> teachingRecords = [];
  void addToTeachingRecords(dynamic item) => teachingRecords.add(item);
  void removeFromTeachingRecords(dynamic item) => teachingRecords.remove(item);
  void removeAtIndexFromTeachingRecords(int index) =>
      teachingRecords.removeAt(index);
  void insertAtIndexInTeachingRecords(int index, dynamic item) =>
      teachingRecords.insert(index, item);
  void updateTeachingRecordsAtIndex(int index, Function(dynamic) updateFn) =>
      teachingRecords[index] = updateFn(teachingRecords[index]);

  /// 자격증여부
  List<dynamic> licensedNorm = [];
  void addToLicensedNorm(dynamic item) => licensedNorm.add(item);
  void removeFromLicensedNorm(dynamic item) => licensedNorm.remove(item);
  void removeAtIndexFromLicensedNorm(int index) => licensedNorm.removeAt(index);
  void insertAtIndexInLicensedNorm(int index, dynamic item) =>
      licensedNorm.insert(index, item);
  void updateLicensedNormAtIndex(int index, Function(dynamic) updateFn) =>
      licensedNorm[index] = updateFn(licensedNorm[index]);

  /// 전문분야 JSON
  List<dynamic> specialtyNorm = [];
  void addToSpecialtyNorm(dynamic item) => specialtyNorm.add(item);
  void removeFromSpecialtyNorm(dynamic item) => specialtyNorm.remove(item);
  void removeAtIndexFromSpecialtyNorm(int index) =>
      specialtyNorm.removeAt(index);
  void insertAtIndexInSpecialtyNorm(int index, dynamic item) =>
      specialtyNorm.insert(index, item);
  void updateSpecialtyNormAtIndex(int index, Function(dynamic) updateFn) =>
      specialtyNorm[index] = updateFn(specialtyNorm[index]);

  DegreeTextFieldStruct? degreeTextField;
  void updateDegreeTextFieldStruct(Function(DegreeTextFieldStruct) updateFn) {
    updateFn(degreeTextField ??= DegreeTextFieldStruct());
  }

  ProfessorValidationRow? prfValList;

  ProfessorMyprofileRow? myProfileList;

  List<dynamic> academicRecords = [];
  void addToAcademicRecords(dynamic item) => academicRecords.add(item);
  void removeFromAcademicRecords(dynamic item) => academicRecords.remove(item);
  void removeAtIndexFromAcademicRecords(int index) =>
      academicRecords.removeAt(index);
  void insertAtIndexInAcademicRecords(int index, dynamic item) =>
      academicRecords.insert(index, item);
  void updateAcademicRecordsAtIndex(int index, Function(dynamic) updateFn) =>
      academicRecords[index] = updateFn(academicRecords[index]);

  int? nextInMobile = -1;

  /// 학력설정/ 강사경력 렌더링 제대로 되기 위한 꼼수 boolean
  bool boolForRender = true;

  // 백업 상태: 적용 버튼 누르지 않고 나갈 때 복구용
  bool? backupArchix;
  bool? backupArchikr;
  bool? backupArchiabroad;
  bool? backupTechnicx;
  bool? backupTechnickr;
  bool? backupTechnicabroad;
  bool? backupDesign;
  bool? backupDigital;
  bool? backupEnvironment;
  bool? backupOther;
  bool? backupConsturction;
  bool? backupStructural;
  bool? backupScape;
  List<dynamic>? backupAcademicRecords;
  List<dynamic>? backupTeachingRecords;

  /// 학력설정 degreelist 비어있을때 초기값 세팅
  List<dynamic> academicRecordsFirst = [];
  void addToAcademicRecordsFirst(dynamic item) =>
      academicRecordsFirst.add(item);
  void removeFromAcademicRecordsFirst(dynamic item) =>
      academicRecordsFirst.remove(item);
  void removeAtIndexFromAcademicRecordsFirst(int index) =>
      academicRecordsFirst.removeAt(index);
  void insertAtIndexInAcademicRecordsFirst(int index, dynamic item) =>
      academicRecordsFirst.insert(index, item);
  void updateAcademicRecordsFirstAtIndex(
          int index, Function(dynamic) updateFn) =>
      academicRecordsFirst[index] = updateFn(academicRecordsFirst[index]);

  /// 강사 경력 teachinglist 비어있을때 초기값 세팅
  List<dynamic> teachingRecordsFirst = [];
  void addToTeachingRecordsFirst(dynamic item) =>
      teachingRecordsFirst.add(item);
  void removeFromTeachingRecordsFirst(dynamic item) =>
      teachingRecordsFirst.remove(item);
  void removeAtIndexFromTeachingRecordsFirst(int index) =>
      teachingRecordsFirst.removeAt(index);
  void insertAtIndexInTeachingRecordsFirst(int index, dynamic item) =>
      teachingRecordsFirst.insert(index, item);
  void updateTeachingRecordsFirstAtIndex(
          int index, Function(dynamic) updateFn) =>
      teachingRecordsFirst[index] = updateFn(teachingRecordsFirst[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - Query Rows] action in Prof_MyProfile widget.
  List<ProfessorValidationRow>? pfrValList;
  // Stores action output result for [Backend Call - Query Rows] action in Prof_MyProfile widget.
  List<ProfessorMyprofileRow>? querybyname;
  // Model for NaviSidebar component.
  late NaviSidebarModel naviSidebarModel;
  // Model for Header component.
  late HeaderModel headerModel;
  // Model for LeftWidget component.
  late LeftWidgetModel leftWidgetModel;
  bool isDataUploading_uploadData = false;
  FFUploadedFile uploadedLocalFile_uploadData =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl_uploadData = '';

  // Stores action output result for [Backend Call - Update Row(s)] action in Container widget.
  List<ProfessorMyprofileRow>? imageurl;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode1;
  TextEditingController? fullNameTextFieldTextController1;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController1Validator;
  // State field(s) for PhoneTextField widget.
  FocusNode? phoneTextFieldFocusNode;
  TextEditingController? phoneTextFieldTextController;
  late MaskTextInputFormatter phoneTextFieldMask;
  String? Function(BuildContext, String?)?
      phoneTextFieldTextControllerValidator;
  // State field(s) for BirthTextField widget.
  FocusNode? birthTextFieldFocusNode;
  TextEditingController? birthTextFieldTextController;
  String? Function(BuildContext, String?)?
      birthTextFieldTextControllerValidator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode2;
  TextEditingController? fullNameTextFieldTextController2;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController2Validator;
  // State field(s) for FullNameTextField widget.
  FocusNode? fullNameTextFieldFocusNode3;
  TextEditingController? fullNameTextFieldTextController3;
  String? Function(BuildContext, String?)?
      fullNameTextFieldTextController3Validator;
  // State field(s) for PositionTextField widget.
  FocusNode? positionTextFieldFocusNode;
  TextEditingController? positionTextFieldTextController;
  String? Function(BuildContext, String?)?
      positionTextFieldTextControllerValidator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue3;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue4;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue5;
  // State field(s) for ArchiAbroadTextField widget.
  FocusNode? archiAbroadTextFieldFocusNode;
  TextEditingController? archiAbroadTextFieldTextController;
  String? Function(BuildContext, String?)?
      archiAbroadTextFieldTextControllerValidator;
  // State field(s) for TechnicAboardTextField widget.
  FocusNode? technicAboardTextFieldFocusNode;
  TextEditingController? technicAboardTextFieldTextController;
  String? Function(BuildContext, String?)?
      technicAboardTextFieldTextControllerValidator;
  // State field(s) for OtherTextField widget.
  FocusNode? otherTextFieldFocusNode;
  TextEditingController? otherTextFieldTextController;
  String? Function(BuildContext, String?)?
      otherTextFieldTextControllerValidator;
  /// Academic record controllers.
  final List<FocusNode> academicGetDateFocusNodes = [];
  final List<TextEditingController> academicGetDateTextControllers = [];
  final List<FocusNode> academicUniversityFocusNodes = [];
  final List<TextEditingController> academicUniversityTextControllers = [];
  final List<FocusNode> academicMajorFocusNodes = [];
  final List<TextEditingController> academicMajorTextControllers = [];
  final List<FocusNode> academicDegreeFocusNodes = [];
  final List<TextEditingController> academicDegreeTextControllers = [];

  /// Teaching history controllers.
  final List<FocusNode> teachingPeriodFocusNodes = [];
  final List<TextEditingController> teachingPeriodTextControllers = [];
  final List<FocusNode> teachingSchoolFocusNodes = [];
  final List<TextEditingController> teachingSchoolTextControllers = [];
  final List<FocusNode> teachingSubjectFocusNodes = [];
  final List<TextEditingController> teachingSubjectTextControllers = [];
  final List<FocusNode> teachingCreditFocusNodes = [];
  final List<TextEditingController> teachingCreditTextControllers = [];
  // State field(s) for ProjectTextField widget.
  FocusNode? projectTextFieldFocusNode;
  TextEditingController? projectTextFieldTextController;
  String? Function(BuildContext, String?)?
      projectTextFieldTextControllerValidator;
  // Stores action output result for [Backend Call - Update Row(s)] action in Button widget.
  List<ProfessorMyprofileRow>? updaterow;
  // State field(s) for MouseRegion widget.
  bool mouseRegionHovered = false;
  // Model for RightWidget component.
  late RightWidgetModel rightWidgetModel;
  // Model for Header_Mobile component.
  late HeaderMobileModel headerMobileModel1;
  // Model for NaviSidebar_Mobile component.
  late NaviSidebarMobileModel naviSidebarMobileModel1;
  // Model for Header_Mobile component.
  late HeaderMobileModel headerMobileModel2;
  // Model for NaviSidebar_Mobile component.
  late NaviSidebarMobileModel naviSidebarMobileModel2;

  @override
  void initState(BuildContext context) {
    naviSidebarModel = createModel(context, () => NaviSidebarModel());
    headerModel = createModel(context, () => HeaderModel());
    leftWidgetModel = createModel(context, () => LeftWidgetModel());
    resetAcademicControllersWithRecords(
        FFAppState().mypageAcademicRecords.take(3).toList());
    resetTeachingControllersWithRecords(
        FFAppState().mypageTeachingRecords.take(4).toList());
    rightWidgetModel = createModel(context, () => RightWidgetModel());
    headerMobileModel1 = createModel(context, () => HeaderMobileModel());
    naviSidebarMobileModel1 =
        createModel(context, () => NaviSidebarMobileModel());
    headerMobileModel2 = createModel(context, () => HeaderMobileModel());
    naviSidebarMobileModel2 =
        createModel(context, () => NaviSidebarMobileModel());
  }

  @override
  void dispose() {
    naviSidebarModel.dispose();
    headerModel.dispose();
    leftWidgetModel.dispose();
    fullNameTextFieldFocusNode1?.dispose();
    fullNameTextFieldTextController1?.dispose();

    phoneTextFieldFocusNode?.dispose();
    phoneTextFieldTextController?.dispose();

    birthTextFieldFocusNode?.dispose();
    birthTextFieldTextController?.dispose();

    fullNameTextFieldFocusNode2?.dispose();
    fullNameTextFieldTextController2?.dispose();

    fullNameTextFieldFocusNode3?.dispose();
    fullNameTextFieldTextController3?.dispose();

    positionTextFieldFocusNode?.dispose();
    positionTextFieldTextController?.dispose();

    archiAbroadTextFieldFocusNode?.dispose();
    archiAbroadTextFieldTextController?.dispose();

    technicAboardTextFieldFocusNode?.dispose();
    technicAboardTextFieldTextController?.dispose();

    otherTextFieldFocusNode?.dispose();
    otherTextFieldTextController?.dispose();

    for (final node in academicGetDateFocusNodes) {
      node.dispose();
    }
    for (final controller in academicGetDateTextControllers) {
      controller.dispose();
    }
    for (final node in academicUniversityFocusNodes) {
      node.dispose();
    }
    for (final controller in academicUniversityTextControllers) {
      controller.dispose();
    }
    for (final node in academicMajorFocusNodes) {
      node.dispose();
    }
    for (final controller in academicMajorTextControllers) {
      controller.dispose();
    }
    for (final node in academicDegreeFocusNodes) {
      node.dispose();
    }
    for (final controller in academicDegreeTextControllers) {
      controller.dispose();
    }
    for (final node in teachingPeriodFocusNodes) {
      node.dispose();
    }
    for (final controller in teachingPeriodTextControllers) {
      controller.dispose();
    }
    for (final node in teachingSchoolFocusNodes) {
      node.dispose();
    }
    for (final controller in teachingSchoolTextControllers) {
      controller.dispose();
    }
    for (final node in teachingSubjectFocusNodes) {
      node.dispose();
    }
    for (final controller in teachingSubjectTextControllers) {
      controller.dispose();
    }
    for (final node in teachingCreditFocusNodes) {
      node.dispose();
    }
    for (final controller in teachingCreditTextControllers) {
      controller.dispose();
    }
    projectTextFieldFocusNode?.dispose();
    projectTextFieldTextController?.dispose();

    rightWidgetModel.dispose();
    headerMobileModel1.dispose();
    naviSidebarMobileModel1.dispose();
    headerMobileModel2.dispose();
    naviSidebarMobileModel2.dispose();
  }

  void addAcademicRecordControllers({
    String? getDate,
    String? university,
    String? major,
    String? degree,
  }) {
    academicGetDateFocusNodes.add(FocusNode());
    academicGetDateTextControllers
        .add(TextEditingController(text: getDate ?? ''));
    academicUniversityFocusNodes.add(FocusNode());
    academicUniversityTextControllers
        .add(TextEditingController(text: university ?? ''));
    academicMajorFocusNodes.add(FocusNode());
    academicMajorTextControllers
        .add(TextEditingController(text: major ?? ''));
    academicDegreeFocusNodes.add(FocusNode());
    academicDegreeTextControllers
        .add(TextEditingController(text: degree ?? ''));
  }

  void removeAcademicRecordControllers(int index) {
    academicGetDateFocusNodes[index].dispose();
    academicGetDateFocusNodes.removeAt(index);
    academicGetDateTextControllers[index].dispose();
    academicGetDateTextControllers.removeAt(index);

    academicUniversityFocusNodes[index].dispose();
    academicUniversityFocusNodes.removeAt(index);
    academicUniversityTextControllers[index].dispose();
    academicUniversityTextControllers.removeAt(index);

    academicMajorFocusNodes[index].dispose();
    academicMajorFocusNodes.removeAt(index);
    academicMajorTextControllers[index].dispose();
    academicMajorTextControllers.removeAt(index);

    academicDegreeFocusNodes[index].dispose();
    academicDegreeFocusNodes.removeAt(index);
    academicDegreeTextControllers[index].dispose();
    academicDegreeTextControllers.removeAt(index);
  }

  void resetAcademicControllersWithRecords(List<dynamic> records) {
    while (academicGetDateFocusNodes.isNotEmpty) {
      removeAcademicRecordControllers(academicGetDateFocusNodes.length - 1);
    }
    if (records.isEmpty) {
      addAcademicRecordControllers();
      return;
    }
    for (final record in records) {
      final map = record is Map
          ? Map<String, dynamic>.from(record as Map)
          : <String, dynamic>{};
      addAcademicRecordControllers(
        getDate: map['getDate']?.toString(),
        university: map['university']?.toString(),
        major: map['major']?.toString(),
        degree: map['degree']?.toString(),
      );
    }
  }

  void addTeachingRecordControllers({
    String? period,
    String? schoolDepartment,
    String? subject,
    String? creditsHours,
  }) {
    teachingPeriodFocusNodes.add(FocusNode());
    teachingPeriodTextControllers
        .add(TextEditingController(text: period ?? ''));
    teachingSchoolFocusNodes.add(FocusNode());
    teachingSchoolTextControllers
        .add(TextEditingController(text: schoolDepartment ?? ''));
    teachingSubjectFocusNodes.add(FocusNode());
    teachingSubjectTextControllers
        .add(TextEditingController(text: subject ?? ''));
    teachingCreditFocusNodes.add(FocusNode());
    teachingCreditTextControllers
        .add(TextEditingController(text: creditsHours ?? ''));
  }

  void removeTeachingRecordControllers(int index) {
    teachingPeriodFocusNodes[index].dispose();
    teachingPeriodFocusNodes.removeAt(index);
    teachingPeriodTextControllers[index].dispose();
    teachingPeriodTextControllers.removeAt(index);

    teachingSchoolFocusNodes[index].dispose();
    teachingSchoolFocusNodes.removeAt(index);
    teachingSchoolTextControllers[index].dispose();
    teachingSchoolTextControllers.removeAt(index);

    teachingSubjectFocusNodes[index].dispose();
    teachingSubjectFocusNodes.removeAt(index);
    teachingSubjectTextControllers[index].dispose();
    teachingSubjectTextControllers.removeAt(index);

    teachingCreditFocusNodes[index].dispose();
    teachingCreditFocusNodes.removeAt(index);
    teachingCreditTextControllers[index].dispose();
    teachingCreditTextControllers.removeAt(index);
  }

  void resetTeachingControllersWithRecords(List<dynamic> records) {
    while (teachingPeriodFocusNodes.isNotEmpty) {
      removeTeachingRecordControllers(teachingPeriodFocusNodes.length - 1);
    }
    if (records.isEmpty) {
      addTeachingRecordControllers();
      return;
    }
    for (final record in records) {
      final map = record is Map
          ? Map<String, dynamic>.from(record as Map)
          : <String, dynamic>{};
      addTeachingRecordControllers(
        period: map['period']?.toString(),
        schoolDepartment: map['schoolDepartment']?.toString(),
        subject: map['subject']?.toString(),
        creditsHours: map['creditsHours']?.toString(),
      );
    }
  }
}
