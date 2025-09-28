import '../database.dart';

class EnrollmentsTable extends SupabaseTable<EnrollmentsRow> {
  @override
  String get tableName => 'enrollments';

  @override
  EnrollmentsRow createRow(Map<String, dynamic> data) => EnrollmentsRow(data);
}

class EnrollmentsRow extends SupabaseDataRow {
  EnrollmentsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => EnrollmentsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get studentId => getField<String>('student_id')!;
  set studentId(String value) => setField<String>('student_id', value);

  String? get classId => getField<String>('class_id');
  set classId(String? value) => setField<String>('class_id', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
