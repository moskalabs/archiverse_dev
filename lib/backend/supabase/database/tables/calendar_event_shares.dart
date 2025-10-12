import '../database.dart';

class CalendarEventSharesTable extends SupabaseTable<CalendarEventSharesRow> {
  @override
  String get tableName => 'calendar_event_shares';

  @override
  CalendarEventSharesRow createRow(Map<String, dynamic> data) =>
      CalendarEventSharesRow(data);
}

class CalendarEventSharesRow extends SupabaseDataRow {
  CalendarEventSharesRow(super.data);

  @override
  SupabaseTable get table => CalendarEventSharesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get eventId => getField<int>('event_id')!;
  set eventId(int value) => setField<int>('event_id', value);

  String get sharedWithEmail => getField<String>('shared_with_email')!;
  set sharedWithEmail(String value) =>
      setField<String>('shared_with_email', value);

  String? get sharedWithName => getField<String>('shared_with_name');
  set sharedWithName(String? value) =>
      setField<String>('shared_with_name', value);

  String? get sharedWithStudentId => getField<String>('shared_with_student_id');
  set sharedWithStudentId(String? value) =>
      setField<String>('shared_with_student_id', value);

  int get userType => getField<int>('user_type') ?? 2;
  set userType(int value) => setField<int>('user_type', value);

  int? get classId => getField<int>('class_id');
  set classId(int? value) => setField<int>('class_id', value);
}
