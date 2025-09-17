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
}
