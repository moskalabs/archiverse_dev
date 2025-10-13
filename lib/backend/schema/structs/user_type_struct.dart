// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';
import '/backend/schema/enums/enums.dart';

import '/flutter_flow/flutter_flow_util.dart';

class UserTypeStruct extends BaseStruct {
  UserTypeStruct({
    String? email,
    bool? rememberUser,
    UserType? usertype,
    String? userTypeIsSelected,
  })  : _email = email,
        _rememberUser = rememberUser,
        _usertype = usertype,
        _userTypeIsSelected = userTypeIsSelected;

  // "Email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  // "remember_user" field.
  bool? _rememberUser;
  bool get rememberUser => _rememberUser ?? false;
  set rememberUser(bool? val) => _rememberUser = val;

  bool hasRememberUser() => _rememberUser != null;

  // "usertype" field.
  UserType? _usertype;
  UserType get usertype => _usertype ?? UserType.Student;
  set usertype(UserType? val) => _usertype = val;

  bool hasUsertype() => _usertype != null;

  // "userType_isSelected" field.
  String? _userTypeIsSelected;
  String get userTypeIsSelected => _userTypeIsSelected ?? '';
  set userTypeIsSelected(String? val) => _userTypeIsSelected = val;

  bool hasUserTypeIsSelected() => _userTypeIsSelected != null;

  static UserTypeStruct fromMap(Map<String, dynamic> data) => UserTypeStruct(
        email: data['Email'] as String?,
        rememberUser: data['remember_user'] as bool?,
        usertype: data['usertype'] is UserType
            ? data['usertype']
            : deserializeEnum<UserType>(data['usertype']),
        userTypeIsSelected: data['userType_isSelected'] as String?,
      );

  static UserTypeStruct? maybeFromMap(dynamic data) =>
      data is Map ? UserTypeStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'Email': _email,
        'remember_user': _rememberUser,
        'usertype': _usertype?.serialize(),
        'userType_isSelected': _userTypeIsSelected,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'Email': serializeParam(
          _email,
          ParamType.String,
        ),
        'remember_user': serializeParam(
          _rememberUser,
          ParamType.bool,
        ),
        'usertype': serializeParam(
          _usertype,
          ParamType.Enum,
        ),
        'userType_isSelected': serializeParam(
          _userTypeIsSelected,
          ParamType.String,
        ),
      }.withoutNulls;

  static UserTypeStruct fromSerializableMap(Map<String, dynamic> data) =>
      UserTypeStruct(
        email: deserializeParam(
          data['Email'],
          ParamType.String,
          false,
        ),
        rememberUser: deserializeParam(
          data['remember_user'],
          ParamType.bool,
          false,
        ),
        usertype: deserializeParam<UserType>(
          data['usertype'],
          ParamType.Enum,
          false,
        ),
        userTypeIsSelected: deserializeParam(
          data['userType_isSelected'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'UserTypeStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is UserTypeStruct &&
        email == other.email &&
        rememberUser == other.rememberUser &&
        usertype == other.usertype &&
        userTypeIsSelected == other.userTypeIsSelected;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([email, rememberUser, usertype, userTypeIsSelected]);
}

UserTypeStruct createUserTypeStruct({
  String? email,
  bool? rememberUser,
  UserType? usertype,
  String? userTypeIsSelected,
}) =>
    UserTypeStruct(
      email: email,
      rememberUser: rememberUser,
      usertype: usertype,
      userTypeIsSelected: userTypeIsSelected,
    );
