// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import '/backend/schema/util/schema_util.dart';

class PortfolioItemStruct extends BaseStruct {
  PortfolioItemStruct({
    String? title,
    String? url,
    String? category,
    String? professorName,
    String? sectionName,
    String? studentName,
    String? week,
    int? order,
    String? extraJson,
  })  : _title = title,
        _url = url,
        _category = category,
        _professorName = professorName,
        _sectionName = sectionName,
        _studentName = studentName,
        _week = week,
        _order = order,
        _extraJson = extraJson;

  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  String? _url;
  String get url => _url ?? '';
  set url(String? val) => _url = val;
  bool hasUrl() => _url != null && _url!.isNotEmpty;

  String? _category;
  String get category => _category ?? '';
  set category(String? val) => _category = val;
  bool hasCategory() => _category != null;

  String? _professorName;
  String get professorName => _professorName ?? '';
  set professorName(String? val) => _professorName = val;
  bool hasProfessorName() => _professorName != null;

  String? _sectionName;
  String get sectionName => _sectionName ?? '';
  set sectionName(String? val) => _sectionName = val;
  bool hasSectionName() => _sectionName != null;

  String? _studentName;
  String get studentName => _studentName ?? '';
  set studentName(String? val) => _studentName = val;
  bool hasStudentName() => _studentName != null;

  String? _week;
  String get week => _week ?? '';
  set week(String? val) => _week = val;
  bool hasWeek() => _week != null;

  int? _order;
  int get order => _order ?? 0;
  set order(int? val) => _order = val;
  bool hasOrder() => _order != null;

  String? _extraJson;
  String get extraJson => _extraJson ?? '';
  set extraJson(String? val) => _extraJson = val;
  bool hasExtraJson() => _extraJson != null;

  PortfolioItemStruct copyWith({
    String? title,
    String? url,
    String? category,
    String? professorName,
    String? sectionName,
    String? studentName,
    String? week,
    int? order,
    String? extraJson,
  }) {
    return PortfolioItemStruct(
      title: title ?? _title,
      url: url ?? _url,
      category: category ?? _category,
      professorName: professorName ?? _professorName,
      sectionName: sectionName ?? _sectionName,
      studentName: studentName ?? _studentName,
      week: week ?? _week,
      order: order ?? _order,
      extraJson: extraJson ?? _extraJson,
    );
  }

  static PortfolioItemStruct fromMap(Map<String, dynamic> data) =>
      PortfolioItemStruct(
        title: data['title'] as String?,
        url: data['url'] as String?,
        category: data['category'] as String?,
        professorName: data['professorName'] as String?,
        sectionName: data['sectionName'] as String?,
        studentName: data['studentName'] as String?,
        week: data['week'] as String?,
        order: data['order'] as int?,
        extraJson: data['extraJson'] as String?,
      );

  static PortfolioItemStruct? maybeFromMap(dynamic data) => data is Map
      ? PortfolioItemStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'url': _url,
        'category': _category,
        'professorName': _professorName,
        'sectionName': _sectionName,
        'studentName': _studentName,
        'week': _week,
        'order': _order,
        'extraJson': _extraJson,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'url': serializeParam(
          _url,
          ParamType.String,
        ),
        'category': serializeParam(
          _category,
          ParamType.String,
        ),
        'professorName': serializeParam(
          _professorName,
          ParamType.String,
        ),
        'sectionName': serializeParam(
          _sectionName,
          ParamType.String,
        ),
        'studentName': serializeParam(
          _studentName,
          ParamType.String,
        ),
        'week': serializeParam(
          _week,
          ParamType.String,
        ),
        'order': serializeParam(
          _order,
          ParamType.int,
        ),
        'extraJson': serializeParam(
          _extraJson,
          ParamType.String,
        ),
      }.withoutNulls;

  static PortfolioItemStruct fromSerializableMap(Map<String, dynamic> data) =>
      PortfolioItemStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        url: deserializeParam(
          data['url'],
          ParamType.String,
          false,
        ),
        category: deserializeParam(
          data['category'],
          ParamType.String,
          false,
        ),
        professorName: deserializeParam(
          data['professorName'],
          ParamType.String,
          false,
        ),
        sectionName: deserializeParam(
          data['sectionName'],
          ParamType.String,
          false,
        ),
        studentName: deserializeParam(
          data['studentName'],
          ParamType.String,
          false,
        ),
        week: deserializeParam(
          data['week'],
          ParamType.String,
          false,
        ),
        order: deserializeParam(
          data['order'],
          ParamType.int,
          false,
        ),
        extraJson: deserializeParam(
          data['extraJson'],
          ParamType.String,
          false,
        ),
      );

  Map<String, dynamic> toJson() => toSerializableMap();

  @override
  String toString() => 'PortfolioItemStruct(${jsonEncode(toMap())})';

  @override
  bool operator ==(Object other) {
    return other is PortfolioItemStruct &&
        title == other.title &&
        url == other.url &&
        category == other.category &&
        professorName == other.professorName &&
        sectionName == other.sectionName &&
        studentName == other.studentName &&
        week == other.week &&
        order == other.order &&
        extraJson == other.extraJson;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        url,
        category,
        professorName,
        sectionName,
        studentName,
        week,
        order,
        extraJson,
      ]);
}

PortfolioItemStruct createPortfolioItemStruct({
  String? title,
  String? url,
  String? category,
  String? professorName,
  String? sectionName,
  String? studentName,
  String? week,
  int? order,
  String? extraJson,
}) =>
    PortfolioItemStruct(
      title: title,
      url: url,
      category: category,
      professorName: professorName,
      sectionName: sectionName,
      studentName: studentName,
      week: week,
      order: order,
      extraJson: extraJson,
    );
