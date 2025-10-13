// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import '/flutter_flow/flutter_flow_util.dart';

class PfrLicensedStruct extends BaseStruct {
  PfrLicensedStruct({
    bool? archix,
    bool? archikr,
    bool? technicx,
    bool? technickr,
    bool? archiabroad,
    bool? technicabroad,
    String? archiabroaddetail,
    String? technicabroaddetail,
  })  : _archix = archix,
        _archikr = archikr,
        _technicx = technicx,
        _technickr = technickr,
        _archiabroad = archiabroad,
        _technicabroad = technicabroad,
        _archiabroaddetail = archiabroaddetail,
        _technicabroaddetail = technicabroaddetail;

  // "archix" field.
  bool? _archix;
  bool get archix => _archix ?? false;
  set archix(bool? val) => _archix = val;

  bool hasArchix() => _archix != null;

  // "archikr" field.
  bool? _archikr;
  bool get archikr => _archikr ?? false;
  set archikr(bool? val) => _archikr = val;

  bool hasArchikr() => _archikr != null;

  // "technicx" field.
  bool? _technicx;
  bool get technicx => _technicx ?? false;
  set technicx(bool? val) => _technicx = val;

  bool hasTechnicx() => _technicx != null;

  // "technickr" field.
  bool? _technickr;
  bool get technickr => _technickr ?? false;
  set technickr(bool? val) => _technickr = val;

  bool hasTechnickr() => _technickr != null;

  // "archiabroad" field.
  bool? _archiabroad;
  bool get archiabroad => _archiabroad ?? false;
  set archiabroad(bool? val) => _archiabroad = val;

  bool hasArchiabroad() => _archiabroad != null;

  // "technicabroad" field.
  bool? _technicabroad;
  bool get technicabroad => _technicabroad ?? false;
  set technicabroad(bool? val) => _technicabroad = val;

  bool hasTechnicabroad() => _technicabroad != null;

  // "archiabroaddetail" field.
  String? _archiabroaddetail;
  String get archiabroaddetail => _archiabroaddetail ?? '';
  set archiabroaddetail(String? val) => _archiabroaddetail = val;

  bool hasArchiabroaddetail() => _archiabroaddetail != null;

  // "technicabroaddetail" field.
  String? _technicabroaddetail;
  String get technicabroaddetail => _technicabroaddetail ?? '';
  set technicabroaddetail(String? val) => _technicabroaddetail = val;

  bool hasTechnicabroaddetail() => _technicabroaddetail != null;

  static PfrLicensedStruct fromMap(Map<String, dynamic> data) =>
      PfrLicensedStruct(
        archix: data['archix'] as bool?,
        archikr: data['archikr'] as bool?,
        technicx: data['technicx'] as bool?,
        technickr: data['technickr'] as bool?,
        archiabroad: data['archiabroad'] as bool?,
        technicabroad: data['technicabroad'] as bool?,
        archiabroaddetail: data['archiabroaddetail'] as String?,
        technicabroaddetail: data['technicabroaddetail'] as String?,
      );

  static PfrLicensedStruct? maybeFromMap(dynamic data) => data is Map
      ? PfrLicensedStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'archix': _archix,
        'archikr': _archikr,
        'technicx': _technicx,
        'technickr': _technickr,
        'archiabroad': _archiabroad,
        'technicabroad': _technicabroad,
        'archiabroaddetail': _archiabroaddetail,
        'technicabroaddetail': _technicabroaddetail,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'archix': serializeParam(
          _archix,
          ParamType.bool,
        ),
        'archikr': serializeParam(
          _archikr,
          ParamType.bool,
        ),
        'technicx': serializeParam(
          _technicx,
          ParamType.bool,
        ),
        'technickr': serializeParam(
          _technickr,
          ParamType.bool,
        ),
        'archiabroad': serializeParam(
          _archiabroad,
          ParamType.bool,
        ),
        'technicabroad': serializeParam(
          _technicabroad,
          ParamType.bool,
        ),
        'archiabroaddetail': serializeParam(
          _archiabroaddetail,
          ParamType.String,
        ),
        'technicabroaddetail': serializeParam(
          _technicabroaddetail,
          ParamType.String,
        ),
      }.withoutNulls;

  static PfrLicensedStruct fromSerializableMap(Map<String, dynamic> data) =>
      PfrLicensedStruct(
        archix: deserializeParam(
          data['archix'],
          ParamType.bool,
          false,
        ),
        archikr: deserializeParam(
          data['archikr'],
          ParamType.bool,
          false,
        ),
        technicx: deserializeParam(
          data['technicx'],
          ParamType.bool,
          false,
        ),
        technickr: deserializeParam(
          data['technickr'],
          ParamType.bool,
          false,
        ),
        archiabroad: deserializeParam(
          data['archiabroad'],
          ParamType.bool,
          false,
        ),
        technicabroad: deserializeParam(
          data['technicabroad'],
          ParamType.bool,
          false,
        ),
        archiabroaddetail: deserializeParam(
          data['archiabroaddetail'],
          ParamType.String,
          false,
        ),
        technicabroaddetail: deserializeParam(
          data['technicabroaddetail'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'PfrLicensedStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is PfrLicensedStruct &&
        archix == other.archix &&
        archikr == other.archikr &&
        technicx == other.technicx &&
        technickr == other.technickr &&
        archiabroad == other.archiabroad &&
        technicabroad == other.technicabroad &&
        archiabroaddetail == other.archiabroaddetail &&
        technicabroaddetail == other.technicabroaddetail;
  }

  @override
  int get hashCode => const ListEquality().hash([
        archix,
        archikr,
        technicx,
        technickr,
        archiabroad,
        technicabroad,
        archiabroaddetail,
        technicabroaddetail
      ]);
}

PfrLicensedStruct createPfrLicensedStruct({
  bool? archix,
  bool? archikr,
  bool? technicx,
  bool? technickr,
  bool? archiabroad,
  bool? technicabroad,
  String? archiabroaddetail,
  String? technicabroaddetail,
}) =>
    PfrLicensedStruct(
      archix: archix,
      archikr: archikr,
      technicx: technicx,
      technickr: technickr,
      archiabroad: archiabroad,
      technicabroad: technicabroad,
      archiabroaddetail: archiabroaddetail,
      technicabroaddetail: technicabroaddetail,
    );
