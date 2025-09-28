import '../database.dart';

class PostsTable extends SupabaseTable<PostsRow> {
  @override
  String get tableName => 'posts';

  @override
  PostsRow createRow(Map<String, dynamic> data) => PostsRow(data);
}

class PostsRow extends SupabaseDataRow {
  PostsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => PostsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get position => getField<String>('position');
  set position(String? value) => setField<String>('position', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get adminId => getField<String>('admin_id');
  set adminId(String? value) => setField<String>('admin_id', value);

  String? get phone => getField<String>('phone');
  set phone(String? value) => setField<String>('phone', value);

  int? get permissionLevel => getField<int>('permission_level');
  set permissionLevel(int? value) =>
      setField<int>('permission_level', value);

  int? get userType => getField<int>('user_type');
  set userType(int? value) => setField<int>('user_type', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);
}
