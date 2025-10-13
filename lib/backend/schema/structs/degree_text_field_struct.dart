// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class DegreeTextFieldStruct extends BaseStruct {
  DegreeTextFieldStruct({
    String? getDate,
    String? university,
    String? major,
    String? degre,
  })  : _getDate = getDate,
        _university = university,
        _major = major,
        _degre = degre;

  // "getDate" field.
  String? _getDate;
  String get getDate => _getDate ?? '';
  set getDate(String? val) => _getDate = val;

  bool hasGetDate() => _getDate != null;

  // "university" field.
  String? _university;
  String get university => _university ?? '';
  set university(String? val) => _university = val;

  bool hasUniversity() => _university != null;

  // "major" field.
  String? _major;
  String get major => _major ?? '';
  set major(String? val) => _major = val;

  bool hasMajor() => _major != null;

  // "degre" field.
  String? _degre;
  String get degre => _degre ?? '';
  set degre(String? val) => _degre = val;

  bool hasDegre() => _degre != null;

  static DegreeTextFieldStruct fromMap(Map<String, dynamic> data) =>
      DegreeTextFieldStruct(
        getDate: data['getDate'] as String?,
        university: data['university'] as String?,
        major: data['major'] as String?,
        degre: data['degre'] as String?,
      );

  static DegreeTextFieldStruct? maybeFromMap(dynamic data) => data is Map
      ? DegreeTextFieldStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'getDate': _getDate,
        'university': _university,
        'major': _major,
        'degre': _degre,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'getDate': serializeParam(
          _getDate,
          ParamType.String,
        ),
        'university': serializeParam(
          _university,
          ParamType.String,
        ),
        'major': serializeParam(
          _major,
          ParamType.String,
        ),
        'degre': serializeParam(
          _degre,
          ParamType.String,
        ),
      }.withoutNulls;

  static DegreeTextFieldStruct fromSerializableMap(Map<String, dynamic> data) =>
      DegreeTextFieldStruct(
        getDate: deserializeParam(
          data['getDate'],
          ParamType.String,
          false,
        ),
        university: deserializeParam(
          data['university'],
          ParamType.String,
          false,
        ),
        major: deserializeParam(
          data['major'],
          ParamType.String,
          false,
        ),
        degre: deserializeParam(
          data['degre'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DegreeTextFieldStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DegreeTextFieldStruct &&
        getDate == other.getDate &&
        university == other.university &&
        major == other.major &&
        degre == other.degre;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([getDate, university, major, degre]);
}

DegreeTextFieldStruct createDegreeTextFieldStruct({
  String? getDate,
  String? university,
  String? major,
  String? degre,
}) =>
    DegreeTextFieldStruct(
      getDate: getDate,
      university: university,
      major: major,
      degre: degre,
    );
