import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _chatState = prefs.getBool('ff_chatState') ?? _chatState;
    });
    _safeInit(() {
      _lastLoggedInUserId =
          prefs.getString('ff_lastLoggedInUserId') ?? _lastLoggedInUserId;
    });
    _safeInit(() {
      _navOpen = prefs.getBool('ff_navOpen') ?? _navOpen;
    });
    _safeInit(() {
      _professorNameSelected =
          prefs.getString('ff_professorNameSelected') ?? _professorNameSelected;
    });
    _safeInit(() {
      _yearSelected = prefs.getString('ff_yearSelected') ?? _yearSelected;
    });
    _safeInit(() {
      _semesterSelected =
          prefs.getString('ff_semesterSelected') ?? _semesterSelected;
    });
    _safeInit(() {
      _gradeSelected = prefs.getInt('ff_gradeSelected') ?? _gradeSelected;
    });
    _safeInit(() {
      _sectionSelected =
          prefs.getString('ff_sectionSelected') ?? _sectionSelected;
    });
    _safeInit(() {
      _courseNameSelected =
          prefs.getString('ff_courseNameSelected') ?? _courseNameSelected;
    });
    _safeInit(() {
      _mypageImageUrl = prefs.getString('ff_mypageImageUrl') ?? _mypageImageUrl;
    });
    _safeInit(() {
      _archix = prefs.getBool('ff_archix') ?? _archix;
    });
    _safeInit(() {
      _archikr = prefs.getBool('ff_archikr') ?? _archikr;
    });
    _safeInit(() {
      _technicx = prefs.getBool('ff_technicx') ?? _technicx;
    });
    _safeInit(() {
      _technickr = prefs.getBool('ff_technickr') ?? _technickr;
    });
    _safeInit(() {
      _archiabroad = prefs.getBool('ff_archiabroad') ?? _archiabroad;
    });
    _safeInit(() {
      _technicabroad = prefs.getBool('ff_technicabroad') ?? _technicabroad;
    });
    _safeInit(() {
      _design = prefs.getBool('ff_design') ?? _design;
    });
    _safeInit(() {
      _other = prefs.getBool('ff_other') ?? _other;
    });
    _safeInit(() {
      _scape = prefs.getBool('ff_scape') ?? _scape;
    });
    _safeInit(() {
      _digital = prefs.getBool('ff_digital') ?? _digital;
    });
    _safeInit(() {
      _structural = prefs.getBool('ff_structural') ?? _structural;
    });
    _safeInit(() {
      _environment = prefs.getBool('ff_environment') ?? _environment;
    });
    _safeInit(() {
      _consturction = prefs.getBool('ff_consturction') ?? _consturction;
    });
    _safeInit(() {
      _mypagePhoneNumber =
          prefs.getString('ff_mypagePhoneNumber') ?? _mypagePhoneNumber;
    });
    _safeInit(() {
      _mypageBirth = prefs.getString('ff_mypageBirth') ?? _mypageBirth;
    });
    _safeInit(() {
      _mypagePosition = prefs.getString('ff_mypagePosition') ?? _mypagePosition;
    });
    _safeInit(() {
      _mypageProject = prefs.getString('ff_mypageProject') ?? _mypageProject;
    });
    _safeInit(() {
      _major = prefs.getStringList('ff_major') ?? _major;
    });
    _safeInit(() {
      _getDate = prefs.getStringList('ff_getDate') ?? _getDate;
    });
    _safeInit(() {
      _degree = prefs.getStringList('ff_degree') ?? _degree;
    });
    _safeInit(() {
      _university = prefs.getStringList('ff_university') ?? _university;
    });
    _safeInit(() {
      _mypageAcademicRecords =
          prefs.getStringList('ff_mypageAcademicRecords')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _mypageAcademicRecords;
    });
    _safeInit(() {
      _mypageTeachingRecords =
          prefs.getStringList('ff_mypageTeachingRecords')?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _mypageTeachingRecords;
    });
    _safeInit(() {
      _degreeTextField = prefs
              .getStringList('ff_degreeTextField')
              ?.map((x) {
                try {
                  return DegreeTextFieldStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _degreeTextField;
    });
    _safeInit(() {
      _StudentChatState =
          prefs.getBool('ff_StudentChatState') ?? _StudentChatState;
    });
    _safeInit(() {
      _studentPortporlioCourseClickedTest =
          prefs.getBool('ff_studentPortporlioCourseClickedTest') ??
              _studentPortporlioCourseClickedTest;
    });
    _safeInit(() {
      _studentPortporlioFileClickedTest =
          prefs.getBool('ff_studentPortporlioFileClickedTest') ??
              _studentPortporlioFileClickedTest;
    });
    _safeInit(() {
      _studentPortporlioEditorClickedTest =
          prefs.getBool('ff_studentPortporlioEditorClickedTest') ??
              _studentPortporlioEditorClickedTest;
    });
    _safeInit(() {
      _studentPortporlioAfterEditor =
          prefs.getBool('ff_studentPortporlioAfterEditor') ??
              _studentPortporlioAfterEditor;
    });
    _safeInit(() {
      _studentPortporlioDeleteClicked =
          prefs.getBool('ff_studentPortporlioDeleteClicked') ??
              _studentPortporlioDeleteClicked;
    });
    _safeInit(() {
      _coursePlanUploadFileURL =
          prefs.getString('ff_coursePlanUploadFileURL') ??
              _coursePlanUploadFileURL;
    });
    _safeInit(() {
      _mergepdfs = prefs.getStringList('ff_mergepdfs') ?? _mergepdfs;
    });
    _safeInit(() {
      _classSelectedID = prefs.getInt('ff_classSelectedID') ?? _classSelectedID;
    });
    _safeInit(() {
      _coursePlanUploadURLUse = prefs.getString('ff_coursePlanUploadURLUse') ??
          _coursePlanUploadURLUse;
    });
    _safeInit(() {
      _attenDanceUploadFileURL =
          prefs.getString('ff_attenDanceUploadFileURL') ??
              _attenDanceUploadFileURL;
    });
    _safeInit(() {
      _attendanceUploadURLUse = prefs.getString('ff_attendanceUploadURLUse') ??
          _attendanceUploadURLUse;
    });
    _safeInit(() {
      _gradeSheetUloadFileURL = prefs.getString('ff_gradeSheetUloadFileURL') ??
          _gradeSheetUloadFileURL;
    });
    _safeInit(() {
      _gradeSheetUploadURLUse = prefs.getString('ff_gradeSheetUploadURLUse') ??
          _gradeSheetUploadURLUse;
    });
    _safeInit(() {
      _workEvalUploadFileURL =
          prefs.getString('ff_workEvalUploadFileURL') ?? _workEvalUploadFileURL;
    });
    _safeInit(() {
      _workEvalUploadURLUse =
          prefs.getString('ff_workEvalUploadURLUse') ?? _workEvalUploadURLUse;
    });
    _safeInit(() {
      _lectureUploadFileURL =
          prefs.getString('ff_lectureUploadFileURL') ?? _lectureUploadFileURL;
    });
    _safeInit(() {
      _lectureUploadURLUse =
          prefs.getString('ff_lectureUploadURLUse') ?? _lectureUploadURLUse;
    });
    _safeInit(() {
      _studentNameSelected =
          prefs.getString('ff_studentNameSelected') ?? _studentNameSelected;
    });
    _safeInit(() {
      _MidUploadFileURL =
          prefs.getString('ff_MidUploadFileURL') ?? _MidUploadFileURL;
    });
    _safeInit(() {
      _MidUploadURLUse =
          prefs.getString('ff_MidUploadURLUse') ?? _MidUploadURLUse;
    });
    _safeInit(() {
      _FinalUploadFileURL =
          prefs.getString('ff_FinalUploadFileURL') ?? _FinalUploadFileURL;
    });
    _safeInit(() {
      _FinalUploadURLUse =
          prefs.getString('ff_FinalUploadURLUse') ?? _FinalUploadURLUse;
    });
    _safeInit(() {
      _sPortpolioUploadFileURL =
          prefs.getString('ff_sPortpolioUploadFileURL') ??
              _sPortpolioUploadFileURL;
    });
    _safeInit(() {
      _sPortpolioUploadURLUse = prefs.getString('ff_sPortpolioUploadURLUse') ??
          _sPortpolioUploadURLUse;
    });
    _safeInit(() {
      _studentMyprofileFirstCheck =
          prefs.getBool('ff_studentMyprofileFirstCheck') ??
              _studentMyprofileFirstCheck;
    });
    _safeInit(() {
      _openPopupBool = prefs.getBool('ff_openPopupBool') ?? _openPopupBool;
    });
    _safeInit(() {
      _channelTalk = prefs.getBool('ff_channelTalk') ?? _channelTalk;
    });
    _safeInit(() {
      _studentNavbarMobile =
          prefs.getBool('ff_studentNavbarMobile') ?? _studentNavbarMobile;
    });
    _safeInit(() {
      _navbarMobile = prefs.getBool('ff_navbarMobile') ?? _navbarMobile;
    });
    _safeInit(() {
      _studentMypageImageUrl =
          prefs.getString('ff_studentMypageImageUrl') ?? _studentMypageImageUrl;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _drawer = false;
  bool get drawer => _drawer;
  set drawer(bool value) {
    _drawer = value;
  }

  bool _chatState = false;
  bool get chatState => _chatState;
  set chatState(bool value) {
    _chatState = value;
    prefs.setBool('ff_chatState', value);
  }

  String _lastLoggedInUserId = '';
  String get lastLoggedInUserId => _lastLoggedInUserId;
  set lastLoggedInUserId(String value) {
    _lastLoggedInUserId = value;
    prefs.setString('ff_lastLoggedInUserId', value);
  }

  bool _navOpen = false;
  bool get navOpen => _navOpen;
  set navOpen(bool value) {
    _navOpen = value;
    prefs.setBool('ff_navOpen', value);
  }

  String _professorNameSelected = '교수님';
  String get professorNameSelected => _professorNameSelected;
  set professorNameSelected(String value) {
    _professorNameSelected = value;
    prefs.setString('ff_professorNameSelected', value);
  }

  String _yearSelected = '';
  String get yearSelected => _yearSelected;
  set yearSelected(String value) {
    _yearSelected = value;
    prefs.setString('ff_yearSelected', value);
  }

  String _semesterSelected = '';
  String get semesterSelected => _semesterSelected;
  set semesterSelected(String value) {
    _semesterSelected = value;
    prefs.setString('ff_semesterSelected', value);
  }

  int _gradeSelected = 0;
  int get gradeSelected => _gradeSelected;
  set gradeSelected(int value) {
    _gradeSelected = value;
    prefs.setInt('ff_gradeSelected', value);
  }

  String _sectionSelected = '';
  String get sectionSelected => _sectionSelected;
  set sectionSelected(String value) {
    _sectionSelected = value;
    prefs.setString('ff_sectionSelected', value);
  }

  String _courseNameSelected = '';
  String get courseNameSelected => _courseNameSelected;
  set courseNameSelected(String value) {
    _courseNameSelected = value;
    prefs.setString('ff_courseNameSelected', value);
  }

  List<DateTime> _datesPicked = [];
  List<DateTime> get datesPicked => _datesPicked;
  set datesPicked(List<DateTime> value) {
    _datesPicked = value;
  }

  void addToDatesPicked(DateTime value) {
    datesPicked.add(value);
  }

  void removeFromDatesPicked(DateTime value) {
    datesPicked.remove(value);
  }

  void removeAtIndexFromDatesPicked(int index) {
    datesPicked.removeAt(index);
  }

  void updateDatesPickedAtIndex(
    int index,
    DateTime Function(DateTime) updateFn,
  ) {
    datesPicked[index] = updateFn(_datesPicked[index]);
  }

  void insertAtIndexInDatesPicked(int index, DateTime value) {
    datesPicked.insert(index, value);
  }

  String _mypageImageUrl = '';
  String get mypageImageUrl => _mypageImageUrl;
  set mypageImageUrl(String value) {
    _mypageImageUrl = value;
    prefs.setString('ff_mypageImageUrl', value);
  }

  int _usertype = 0;
  int get usertype => _usertype;
  set usertype(int value) {
    _usertype = value;
  }

  bool _archix = false;
  bool get archix => _archix;
  set archix(bool value) {
    _archix = value;
    prefs.setBool('ff_archix', value);
  }

  bool _archikr = false;
  bool get archikr => _archikr;
  set archikr(bool value) {
    _archikr = value;
    prefs.setBool('ff_archikr', value);
  }

  bool _technicx = false;
  bool get technicx => _technicx;
  set technicx(bool value) {
    _technicx = value;
    prefs.setBool('ff_technicx', value);
  }

  bool _technickr = false;
  bool get technickr => _technickr;
  set technickr(bool value) {
    _technickr = value;
    prefs.setBool('ff_technickr', value);
  }

  bool _archiabroad = false;
  bool get archiabroad => _archiabroad;
  set archiabroad(bool value) {
    _archiabroad = value;
    prefs.setBool('ff_archiabroad', value);
  }

  bool _technicabroad = false;
  bool get technicabroad => _technicabroad;
  set technicabroad(bool value) {
    _technicabroad = value;
    prefs.setBool('ff_technicabroad', value);
  }

  bool _design = false;
  bool get design => _design;
  set design(bool value) {
    _design = value;
    prefs.setBool('ff_design', value);
  }

  bool _other = false;
  bool get other => _other;
  set other(bool value) {
    _other = value;
    prefs.setBool('ff_other', value);
  }

  bool _scape = false;
  bool get scape => _scape;
  set scape(bool value) {
    _scape = value;
    prefs.setBool('ff_scape', value);
  }

  bool _digital = false;
  bool get digital => _digital;
  set digital(bool value) {
    _digital = value;
    prefs.setBool('ff_digital', value);
  }

  bool _structural = false;
  bool get structural => _structural;
  set structural(bool value) {
    _structural = value;
    prefs.setBool('ff_structural', value);
  }

  bool _environment = false;
  bool get environment => _environment;
  set environment(bool value) {
    _environment = value;
    prefs.setBool('ff_environment', value);
  }

  bool _consturction = false;
  bool get consturction => _consturction;
  set consturction(bool value) {
    _consturction = value;
    prefs.setBool('ff_consturction', value);
  }

  String _mypagePhoneNumber = '';
  String get mypagePhoneNumber => _mypagePhoneNumber;
  set mypagePhoneNumber(String value) {
    _mypagePhoneNumber = value;
    prefs.setString('ff_mypagePhoneNumber', value);
  }

  String _mypageBirth = '';
  String get mypageBirth => _mypageBirth;
  set mypageBirth(String value) {
    _mypageBirth = value;
    prefs.setString('ff_mypageBirth', value);
  }

  String _mypagePosition = '';
  String get mypagePosition => _mypagePosition;
  set mypagePosition(String value) {
    _mypagePosition = value;
    prefs.setString('ff_mypagePosition', value);
  }

  String _mypageProject = '';
  String get mypageProject => _mypageProject;
  set mypageProject(String value) {
    _mypageProject = value;
    prefs.setString('ff_mypageProject', value);
  }

  List<String> _major = [];
  List<String> get major => _major;
  set major(List<String> value) {
    _major = value;
    prefs.setStringList('ff_major', value);
  }

  void addToMajor(String value) {
    major.add(value);
    prefs.setStringList('ff_major', _major);
  }

  void removeFromMajor(String value) {
    major.remove(value);
    prefs.setStringList('ff_major', _major);
  }

  void removeAtIndexFromMajor(int index) {
    major.removeAt(index);
    prefs.setStringList('ff_major', _major);
  }

  void updateMajorAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    major[index] = updateFn(_major[index]);
    prefs.setStringList('ff_major', _major);
  }

  void insertAtIndexInMajor(int index, String value) {
    major.insert(index, value);
    prefs.setStringList('ff_major', _major);
  }

  List<String> _getDate = [];
  List<String> get getDate => _getDate;
  set getDate(List<String> value) {
    _getDate = value;
    prefs.setStringList('ff_getDate', value);
  }

  void addToGetDate(String value) {
    getDate.add(value);
    prefs.setStringList('ff_getDate', _getDate);
  }

  void removeFromGetDate(String value) {
    getDate.remove(value);
    prefs.setStringList('ff_getDate', _getDate);
  }

  void removeAtIndexFromGetDate(int index) {
    getDate.removeAt(index);
    prefs.setStringList('ff_getDate', _getDate);
  }

  void updateGetDateAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    getDate[index] = updateFn(_getDate[index]);
    prefs.setStringList('ff_getDate', _getDate);
  }

  void insertAtIndexInGetDate(int index, String value) {
    getDate.insert(index, value);
    prefs.setStringList('ff_getDate', _getDate);
  }

  List<String> _degree = [];
  List<String> get degree => _degree;
  set degree(List<String> value) {
    _degree = value;
    prefs.setStringList('ff_degree', value);
  }

  void addToDegree(String value) {
    degree.add(value);
    prefs.setStringList('ff_degree', _degree);
  }

  void removeFromDegree(String value) {
    degree.remove(value);
    prefs.setStringList('ff_degree', _degree);
  }

  void removeAtIndexFromDegree(int index) {
    degree.removeAt(index);
    prefs.setStringList('ff_degree', _degree);
  }

  void updateDegreeAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    degree[index] = updateFn(_degree[index]);
    prefs.setStringList('ff_degree', _degree);
  }

  void insertAtIndexInDegree(int index, String value) {
    degree.insert(index, value);
    prefs.setStringList('ff_degree', _degree);
  }

  List<String> _university = [];
  List<String> get university => _university;
  set university(List<String> value) {
    _university = value;
    prefs.setStringList('ff_university', value);
  }

  void addToUniversity(String value) {
    university.add(value);
    prefs.setStringList('ff_university', _university);
  }

  void removeFromUniversity(String value) {
    university.remove(value);
    prefs.setStringList('ff_university', _university);
  }

  void removeAtIndexFromUniversity(int index) {
    university.removeAt(index);
    prefs.setStringList('ff_university', _university);
  }

  void updateUniversityAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    university[index] = updateFn(_university[index]);
    prefs.setStringList('ff_university', _university);
  }

  void insertAtIndexInUniversity(int index, String value) {
    university.insert(index, value);
    prefs.setStringList('ff_university', _university);
  }

  List<dynamic> _mypageAcademicRecords = [
    jsonDecode('{}'),
    jsonDecode('{}'),
    jsonDecode('{}')
  ];
  List<dynamic> get mypageAcademicRecords => _mypageAcademicRecords;
  set mypageAcademicRecords(List<dynamic> value) {
    _mypageAcademicRecords = value;
    prefs.setStringList(
        'ff_mypageAcademicRecords', value.map((x) => jsonEncode(x)).toList());
  }

  void addToMypageAcademicRecords(dynamic value) {
    mypageAcademicRecords.add(value);
    prefs.setStringList('ff_mypageAcademicRecords',
        _mypageAcademicRecords.map((x) => jsonEncode(x)).toList());
  }

  void removeFromMypageAcademicRecords(dynamic value) {
    mypageAcademicRecords.remove(value);
    prefs.setStringList('ff_mypageAcademicRecords',
        _mypageAcademicRecords.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromMypageAcademicRecords(int index) {
    mypageAcademicRecords.removeAt(index);
    prefs.setStringList('ff_mypageAcademicRecords',
        _mypageAcademicRecords.map((x) => jsonEncode(x)).toList());
  }

  void updateMypageAcademicRecordsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    mypageAcademicRecords[index] = updateFn(_mypageAcademicRecords[index]);
    prefs.setStringList('ff_mypageAcademicRecords',
        _mypageAcademicRecords.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInMypageAcademicRecords(int index, dynamic value) {
    mypageAcademicRecords.insert(index, value);
    prefs.setStringList('ff_mypageAcademicRecords',
        _mypageAcademicRecords.map((x) => jsonEncode(x)).toList());
  }

  List<dynamic> _mypageTeachingRecords = [
    jsonDecode('{}'),
    jsonDecode('{}'),
    jsonDecode('{}'),
    jsonDecode('{}')
  ];
  List<dynamic> get mypageTeachingRecords => _mypageTeachingRecords;
  set mypageTeachingRecords(List<dynamic> value) {
    _mypageTeachingRecords = value;
    prefs.setStringList(
        'ff_mypageTeachingRecords', value.map((x) => jsonEncode(x)).toList());
  }

  void addToMypageTeachingRecords(dynamic value) {
    mypageTeachingRecords.add(value);
    prefs.setStringList('ff_mypageTeachingRecords',
        _mypageTeachingRecords.map((x) => jsonEncode(x)).toList());
  }

  void removeFromMypageTeachingRecords(dynamic value) {
    mypageTeachingRecords.remove(value);
    prefs.setStringList('ff_mypageTeachingRecords',
        _mypageTeachingRecords.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromMypageTeachingRecords(int index) {
    mypageTeachingRecords.removeAt(index);
    prefs.setStringList('ff_mypageTeachingRecords',
        _mypageTeachingRecords.map((x) => jsonEncode(x)).toList());
  }

  void updateMypageTeachingRecordsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    mypageTeachingRecords[index] = updateFn(_mypageTeachingRecords[index]);
    prefs.setStringList('ff_mypageTeachingRecords',
        _mypageTeachingRecords.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInMypageTeachingRecords(int index, dynamic value) {
    mypageTeachingRecords.insert(index, value);
    prefs.setStringList('ff_mypageTeachingRecords',
        _mypageTeachingRecords.map((x) => jsonEncode(x)).toList());
  }

  List<DegreeTextFieldStruct> _degreeTextField = [];
  List<DegreeTextFieldStruct> get degreeTextField => _degreeTextField;
  set degreeTextField(List<DegreeTextFieldStruct> value) {
    _degreeTextField = value;
    prefs.setStringList(
        'ff_degreeTextField', value.map((x) => x.serialize()).toList());
  }

  void addToDegreeTextField(DegreeTextFieldStruct value) {
    degreeTextField.add(value);
    prefs.setStringList('ff_degreeTextField',
        _degreeTextField.map((x) => x.serialize()).toList());
  }

  void removeFromDegreeTextField(DegreeTextFieldStruct value) {
    degreeTextField.remove(value);
    prefs.setStringList('ff_degreeTextField',
        _degreeTextField.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromDegreeTextField(int index) {
    degreeTextField.removeAt(index);
    prefs.setStringList('ff_degreeTextField',
        _degreeTextField.map((x) => x.serialize()).toList());
  }

  void updateDegreeTextFieldAtIndex(
    int index,
    DegreeTextFieldStruct Function(DegreeTextFieldStruct) updateFn,
  ) {
    degreeTextField[index] = updateFn(_degreeTextField[index]);
    prefs.setStringList('ff_degreeTextField',
        _degreeTextField.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInDegreeTextField(int index, DegreeTextFieldStruct value) {
    degreeTextField.insert(index, value);
    prefs.setStringList('ff_degreeTextField',
        _degreeTextField.map((x) => x.serialize()).toList());
  }

  List<String> _studentOutputVar = [];
  List<String> get studentOutputVar => _studentOutputVar;
  set studentOutputVar(List<String> value) {
    _studentOutputVar = value;
  }

  void addToStudentOutputVar(String value) {
    studentOutputVar.add(value);
  }

  void removeFromStudentOutputVar(String value) {
    studentOutputVar.remove(value);
  }

  void removeAtIndexFromStudentOutputVar(int index) {
    studentOutputVar.removeAt(index);
  }

  void updateStudentOutputVarAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    studentOutputVar[index] = updateFn(_studentOutputVar[index]);
  }

  void insertAtIndexInStudentOutputVar(int index, String value) {
    studentOutputVar.insert(index, value);
  }

  bool _StudentChatState = false;
  bool get StudentChatState => _StudentChatState;
  set StudentChatState(bool value) {
    _StudentChatState = value;
    prefs.setBool('ff_StudentChatState', value);
  }

  bool _studentPortporlioCourseClickedTest = false;
  bool get studentPortporlioCourseClickedTest =>
      _studentPortporlioCourseClickedTest;
  set studentPortporlioCourseClickedTest(bool value) {
    _studentPortporlioCourseClickedTest = value;
    prefs.setBool('ff_studentPortporlioCourseClickedTest', value);
  }

  bool _studentPortporlioFileClickedTest = false;
  bool get studentPortporlioFileClickedTest =>
      _studentPortporlioFileClickedTest;
  set studentPortporlioFileClickedTest(bool value) {
    _studentPortporlioFileClickedTest = value;
    prefs.setBool('ff_studentPortporlioFileClickedTest', value);
  }

  bool _studentPortporlioEditorClickedTest = false;
  bool get studentPortporlioEditorClickedTest =>
      _studentPortporlioEditorClickedTest;
  set studentPortporlioEditorClickedTest(bool value) {
    _studentPortporlioEditorClickedTest = value;
    prefs.setBool('ff_studentPortporlioEditorClickedTest', value);
  }

  bool _studentPortporlioAfterEditor = false;
  bool get studentPortporlioAfterEditor => _studentPortporlioAfterEditor;
  set studentPortporlioAfterEditor(bool value) {
    _studentPortporlioAfterEditor = value;
    prefs.setBool('ff_studentPortporlioAfterEditor', value);
  }

  bool _studentPortporlioDeleteClicked = false;
  bool get studentPortporlioDeleteClicked => _studentPortporlioDeleteClicked;
  set studentPortporlioDeleteClicked(bool value) {
    _studentPortporlioDeleteClicked = value;
    prefs.setBool('ff_studentPortporlioDeleteClicked', value);
  }

  String _coursePlanUploadFileURL = '';
  String get coursePlanUploadFileURL => _coursePlanUploadFileURL;
  set coursePlanUploadFileURL(String value) {
    _coursePlanUploadFileURL = value;
    prefs.setString('ff_coursePlanUploadFileURL', value);
  }

  List<String> _mergepdfs = ['', ''];
  List<String> get mergepdfs => _mergepdfs;
  set mergepdfs(List<String> value) {
    _mergepdfs = value;
    prefs.setStringList('ff_mergepdfs', value);
  }

  void addToMergepdfs(String value) {
    mergepdfs.add(value);
    prefs.setStringList('ff_mergepdfs', _mergepdfs);
  }

  void removeFromMergepdfs(String value) {
    mergepdfs.remove(value);
    prefs.setStringList('ff_mergepdfs', _mergepdfs);
  }

  void removeAtIndexFromMergepdfs(int index) {
    mergepdfs.removeAt(index);
    prefs.setStringList('ff_mergepdfs', _mergepdfs);
  }

  void updateMergepdfsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    mergepdfs[index] = updateFn(_mergepdfs[index]);
    prefs.setStringList('ff_mergepdfs', _mergepdfs);
  }

  void insertAtIndexInMergepdfs(int index, String value) {
    mergepdfs.insert(index, value);
    prefs.setStringList('ff_mergepdfs', _mergepdfs);
  }

  /// 강좌 선택한거
  int _classSelectedID = 0;
  int get classSelectedID => _classSelectedID;
  set classSelectedID(int value) {
    _classSelectedID = value;
    prefs.setInt('ff_classSelectedID', value);
  }

  /// 수업계획서_제목
  String _courseplanPlaintext = '';
  String get courseplanPlaintext => _courseplanPlaintext;
  set courseplanPlaintext(String value) {
    _courseplanPlaintext = value;
  }

  String _coursePlanUploadURLUse = '';
  String get coursePlanUploadURLUse => _coursePlanUploadURLUse;
  set coursePlanUploadURLUse(String value) {
    _coursePlanUploadURLUse = value;
    prefs.setString('ff_coursePlanUploadURLUse', value);
  }

  String _attenDanceUploadFileURL = '';
  String get attenDanceUploadFileURL => _attenDanceUploadFileURL;
  set attenDanceUploadFileURL(String value) {
    _attenDanceUploadFileURL = value;
    prefs.setString('ff_attenDanceUploadFileURL', value);
  }

  String _attendanceUploadURLUse = '';
  String get attendanceUploadURLUse => _attendanceUploadURLUse;
  set attendanceUploadURLUse(String value) {
    _attendanceUploadURLUse = value;
    prefs.setString('ff_attendanceUploadURLUse', value);
  }

  /// 출석부_제목
  String _attendancePlaintext = '';
  String get attendancePlaintext => _attendancePlaintext;
  set attendancePlaintext(String value) {
    _attendancePlaintext = value;
  }

  /// 성적기록표_제목
  String _gradeSheetPlaintext = '';
  String get gradeSheetPlaintext => _gradeSheetPlaintext;
  set gradeSheetPlaintext(String value) {
    _gradeSheetPlaintext = value;
  }

  String _gradeSheetUloadFileURL = '';
  String get gradeSheetUloadFileURL => _gradeSheetUloadFileURL;
  set gradeSheetUloadFileURL(String value) {
    _gradeSheetUloadFileURL = value;
    prefs.setString('ff_gradeSheetUloadFileURL', value);
  }

  String _gradeSheetUploadURLUse = '';
  String get gradeSheetUploadURLUse => _gradeSheetUploadURLUse;
  set gradeSheetUploadURLUse(String value) {
    _gradeSheetUploadURLUse = value;
    prefs.setString('ff_gradeSheetUploadURLUse', value);
  }

  /// 학생작품평가표_제목
  String _workevalPlaintext = '';
  String get workevalPlaintext => _workevalPlaintext;
  set workevalPlaintext(String value) {
    _workevalPlaintext = value;
  }

  String _workEvalUploadFileURL = '';
  String get workEvalUploadFileURL => _workEvalUploadFileURL;
  set workEvalUploadFileURL(String value) {
    _workEvalUploadFileURL = value;
    prefs.setString('ff_workEvalUploadFileURL', value);
  }

  String _workEvalUploadURLUse = '';
  String get workEvalUploadURLUse => _workEvalUploadURLUse;
  set workEvalUploadURLUse(String value) {
    _workEvalUploadURLUse = value;
    prefs.setString('ff_workEvalUploadURLUse', value);
  }

  String _lecturePlaintext = '';
  String get lecturePlaintext => _lecturePlaintext;
  set lecturePlaintext(String value) {
    _lecturePlaintext = value;
  }

  String _lectureUploadFileURL = '';
  String get lectureUploadFileURL => _lectureUploadFileURL;
  set lectureUploadFileURL(String value) {
    _lectureUploadFileURL = value;
    prefs.setString('ff_lectureUploadFileURL', value);
  }

  String _lectureUploadURLUse = '';
  String get lectureUploadURLUse => _lectureUploadURLUse;
  set lectureUploadURLUse(String value) {
    _lectureUploadURLUse = value;
    prefs.setString('ff_lectureUploadURLUse', value);
  }

  /// 로그인한 학생 이름
  String _studentNameSelected = '';
  String get studentNameSelected => _studentNameSelected;
  set studentNameSelected(String value) {
    _studentNameSelected = value;
    prefs.setString('ff_studentNameSelected', value);
  }

  String _MidUploadFileURL = '';
  String get MidUploadFileURL => _MidUploadFileURL;
  set MidUploadFileURL(String value) {
    _MidUploadFileURL = value;
    prefs.setString('ff_MidUploadFileURL', value);
  }

  String _MidUploadURLUse = '';
  String get MidUploadURLUse => _MidUploadURLUse;
  set MidUploadURLUse(String value) {
    _MidUploadURLUse = value;
    prefs.setString('ff_MidUploadURLUse', value);
  }

  String _FinalUploadFileURL = '';
  String get FinalUploadFileURL => _FinalUploadFileURL;
  set FinalUploadFileURL(String value) {
    _FinalUploadFileURL = value;
    prefs.setString('ff_FinalUploadFileURL', value);
  }

  String _FinalUploadURLUse = '';
  String get FinalUploadURLUse => _FinalUploadURLUse;
  set FinalUploadURLUse(String value) {
    _FinalUploadURLUse = value;
    prefs.setString('ff_FinalUploadURLUse', value);
  }

  /// 학생 페이지에서, 포트폴리오 올릴때
  /// url 사용 1차.
  String _sPortpolioUploadFileURL = '';
  String get sPortpolioUploadFileURL => _sPortpolioUploadFileURL;
  set sPortpolioUploadFileURL(String value) {
    _sPortpolioUploadFileURL = value;
    prefs.setString('ff_sPortpolioUploadFileURL', value);
  }

  /// 학생페이지에서, 파일 올릴때 파일 겹치는 거 막기 위한, 실제 use url
  String _sPortpolioUploadURLUse = '';
  String get sPortpolioUploadURLUse => _sPortpolioUploadURLUse;
  set sPortpolioUploadURLUse(String value) {
    _sPortpolioUploadURLUse = value;
    prefs.setString('ff_sPortpolioUploadURLUse', value);
  }

  /// 학생 아이디로 로그인 했을때.
  ///
  /// 첫번째 로그인이면
  /// 마이페이지로 가서, 정보 입력하게끔
  /// 두번째부터는 대시보드로 가야한다. 그거 분기점 체크
  bool _studentMyprofileFirstCheck = false;
  bool get studentMyprofileFirstCheck => _studentMyprofileFirstCheck;
  set studentMyprofileFirstCheck(bool value) {
    _studentMyprofileFirstCheck = value;
    prefs.setBool('ff_studentMyprofileFirstCheck', value);
  }

  bool _openPopupBool = false;
  bool get openPopupBool => _openPopupBool;
  set openPopupBool(bool value) {
    _openPopupBool = value;
    prefs.setBool('ff_openPopupBool', value);
  }

  /// 홈에서부터는 이 app state로 nav 붙여서 컨트롤
  bool _channelTalk = false;
  bool get channelTalk => _channelTalk;
  set channelTalk(bool value) {
    _channelTalk = value;
    prefs.setBool('ff_channelTalk', value);
  }

  bool _studentNavbarMobile = false;
  bool get studentNavbarMobile => _studentNavbarMobile;
  set studentNavbarMobile(bool value) {
    _studentNavbarMobile = value;
    prefs.setBool('ff_studentNavbarMobile', value);
  }

  bool _navbarMobile = false;
  bool get navbarMobile => _navbarMobile;
  set navbarMobile(bool value) {
    _navbarMobile = value;
    prefs.setBool('ff_navbarMobile', value);
  }

  /// 수업계획서_id
  int _coursePlanId = 0;
  int get coursePlanId => _coursePlanId;
  set coursePlanId(int value) {
    _coursePlanId = value;
  }

  /// 학생 마이페이지 이미지
  String _studentMypageImageUrl = '';
  String get studentMypageImageUrl => _studentMypageImageUrl;
  set studentMypageImageUrl(String value) {
    _studentMypageImageUrl = value;
    prefs.setString('ff_studentMypageImageUrl', value);
  }

  Future<void> clearUserScopedState() async {
    _professorNameSelected = '교수님';
    await prefs.remove('ff_professorNameSelected');
    _studentNameSelected = '';
    await prefs.remove('ff_studentNameSelected');
    _yearSelected = '';
    await prefs.remove('ff_yearSelected');
    _semesterSelected = '';
    await prefs.remove('ff_semesterSelected');
    _gradeSelected = 0;
    await prefs.remove('ff_gradeSelected');
    _sectionSelected = '';
    await prefs.remove('ff_sectionSelected');
    _courseNameSelected = '';
    await prefs.remove('ff_courseNameSelected');
    _classSelectedID = 0;
    await prefs.remove('ff_classSelectedID');
    _mypageImageUrl = '';
    await prefs.remove('ff_mypageImageUrl');
    _mypagePhoneNumber = '';
    await prefs.remove('ff_mypagePhoneNumber');
    _mypageBirth = '';
    await prefs.remove('ff_mypageBirth');
    _mypagePosition = '';
    await prefs.remove('ff_mypagePosition');
    _mypageProject = '';
    await prefs.remove('ff_mypageProject');
    _major = [];
    await prefs.remove('ff_major');
    _getDate = [];
    await prefs.remove('ff_getDate');
    _degree = [];
    await prefs.remove('ff_degree');
    _university = [];
    await prefs.remove('ff_university');
    _mypageAcademicRecords = [
      jsonDecode('{}'),
      jsonDecode('{}'),
      jsonDecode('{}')
    ];
    await prefs.remove('ff_mypageAcademicRecords');
    _mypageTeachingRecords = [
      jsonDecode('{}'),
      jsonDecode('{}'),
      jsonDecode('{}'),
      jsonDecode('{}')
    ];
    await prefs.remove('ff_mypageTeachingRecords');
    _degreeTextField = [];
    await prefs.remove('ff_degreeTextField');
    _studentMypageImageUrl = '';
    await prefs.remove('ff_studentMypageImageUrl');
    notifyListeners();
  }

  List<String> _weeksList = [
    '1주차',
    '2주차',
    '3주차',
    '4주차',
    '5주차',
    '6주차',
    '7주차',
    '8주차',
    '9주차',
    '10주차',
    '11주차',
    '12주차',
    '13주차',
    '14주차',
    '15주차'
  ];
  List<String> get weeksList => _weeksList;
  set weeksList(List<String> value) {
    _weeksList = value;
  }

  void addToWeeksList(String value) {
    weeksList.add(value);
  }

  void removeFromWeeksList(String value) {
    weeksList.remove(value);
  }

  void removeAtIndexFromWeeksList(int index) {
    weeksList.removeAt(index);
  }

  void updateWeeksListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    weeksList[index] = updateFn(_weeksList[index]);
  }

  void insertAtIndexInWeeksList(int index, String value) {
    weeksList.insert(index, value);
  }

  String _currentPage = '';
  String get currentPage => _currentPage;
  set currentPage(String value) {
    _currentPage = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}
// 안쓰는 elements 들. 주석처리.
/*
Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
*/