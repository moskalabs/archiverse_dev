import '../database.dart';

class StudentPostTable extends SupabaseTable<StudentPostRow> {
  @override
  String get tableName => 'student_post';

  @override
  StudentPostRow createRow(Map<String, dynamic> data) => StudentPostRow(data);
}

class StudentPostRow extends SupabaseDataRow {
  StudentPostRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentPostTable();

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get university => getField<String>('university');
  set university(String? value) => setField<String>('university', value);

  String? get studentCode => getField<String>('studentCode');
  set studentCode(String? value) => setField<String>('studentCode', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  String? get uuid => getField<String>('uuid');
  set uuid(String? value) => setField<String>('uuid', value);
}
