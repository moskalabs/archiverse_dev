import '../database.dart';

class UsersTable extends SupabaseTable<UsersRow> {
  @override
  String get tableName => 'users';

  @override
  UsersRow createRow(Map<String, dynamic> data) => UsersRow(data);
}

class UsersRow extends SupabaseDataRow {
  UsersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UsersTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  DateTime get createdAt => getField<DateTime>('Created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('Created_at', value);

  int get userType => getField<int>('User_Type')!;
  set userType(int value) => setField<int>('User_Type', value);

  String? get email => getField<String>('Email');
  set email(String? value) => setField<String>('Email', value);

  bool? get isRememberSelect => getField<bool>('IsRememberSelect');
  set isRememberSelect(bool? value) =>
      setField<bool>('IsRememberSelect', value);
}
