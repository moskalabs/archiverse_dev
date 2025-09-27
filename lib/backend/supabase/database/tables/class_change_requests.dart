import '../database.dart';

class ClassChangeRequestsTable extends SupabaseTable<ClassChangeRequestsRow> {
  @override
  String get tableName => 'class_change_requests';

  @override
  ClassChangeRequestsRow createRow(Map<String, dynamic> data) =>
      ClassChangeRequestsRow(data);
}

class ClassChangeRequestsRow extends SupabaseDataRow {
  ClassChangeRequestsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ClassChangeRequestsTable();

  String get id => getField<String>('id')!;
  set id(String value) => setField<String>('id', value);

  String get studentId => getField<String>('student_id')!;
  set studentId(String value) => setField<String>('student_id', value);

  String get studentName => getField<String>('student_name')!;
  set studentName(String value) => setField<String>('student_name', value);

  String get studentNumber => getField<String>('student_number')!;
  set studentNumber(String value) => setField<String>('student_number', value);

  String? get currentClassId => getField<String>('current_class_id');
  set currentClassId(String? value) => setField<String>('current_class_id', value);

  String? get currentClassSection =>
      getField<String>('current_class_section');
  set currentClassSection(String? value) =>
      setField<String>('current_class_section', value);

  String? get requestedClassId => getField<String>('requested_class_id');
  set requestedClassId(String? value) =>
      setField<String>('requested_class_id', value);

  String? get requestedClassSection =>
      getField<String>('requested_class_section');
  set requestedClassSection(String? value) =>
      setField<String>('requested_class_section', value);

  String? get requestStatus => getField<String>('request_status');
  set requestStatus(String? value) => setField<String>('request_status', value);

  String? get requestReason => getField<String>('request_reason');
  set requestReason(String? value) => setField<String>('request_reason', value);

  DateTime? get requestDate => getField<DateTime>('request_date');
  set requestDate(DateTime? value) => setField<DateTime>('request_date', value);

  String? get approvedBy => getField<String>('approved_by');
  set approvedBy(String? value) => setField<String>('approved_by', value);

  DateTime? get approvedDate => getField<DateTime>('approved_date');
  set approvedDate(DateTime? value) =>
      setField<DateTime>('approved_date', value);

  String get year => getField<String>('year')!;
  set year(String value) => setField<String>('year', value);

  String get semester => getField<String>('semester')!;
  set semester(String value) => setField<String>('semester', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);
}
