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

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get user => getField<String>('user');
  set user(String? value) => setField<String>('user', value);

  int? get userType => getField<int>('user_type');
  set userType(int? value) => setField<int>('user_type', value);

  String? get userAlias => getField<String>('user_alias');
  set userAlias(String? value) => setField<String>('user_alias', value);

  String? get userEmail => getField<String>('user_email');
  set userEmail(String? value) => setField<String>('user_email', value);

  String? get university => getField<String>('university');
  set university(String? value) => setField<String>('university', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);
}
