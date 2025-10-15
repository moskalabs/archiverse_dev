import '../database.dart';

class AdminPostTable extends SupabaseTable<AdminPostRow> {
  @override
  String get tableName => 'admin_post';

  @override
  AdminPostRow createRow(Map<String, dynamic> data) => AdminPostRow(data);
}

class AdminPostRow extends SupabaseDataRow {
  AdminPostRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AdminPostTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get adminId => getField<String>('adminId')!;
  set adminId(String value) => setField<String>('adminId', value);

  String get adminInfo => getField<String>('AdminInfo')!;
  set adminInfo(String value) => setField<String>('AdminInfo', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  int? get userType => getField<int>('user_type');
  set userType(int? value) => setField<int>('user_type', value);

  String get role => getField<String>('role')!;
  set role(String value) => setField<String>('role', value);

  String? get permissionType => getField<String>('permission_type');
  set permissionType(String? value) => setField<String>('permission_type', value);

  String? get phone => getField<String>('phone');
  set phone(String? value) => setField<String>('phone', value);

  String? get position => getField<String>('position');
  set position(String? value) => setField<String>('position', value);

  String? get editStatus => getField<String>('edit_status');
  set editStatus(String? value) => setField<String>('edit_status', value);

  String? get userEmail => getField<String>('user_email');
  set userEmail(String? value) => setField<String>('user_email', value);

  bool? get isActive => getField<bool>('is_active');
  set isActive(bool? value) => setField<bool>('is_active', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
