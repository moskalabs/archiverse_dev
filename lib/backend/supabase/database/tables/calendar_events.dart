import '../database.dart';

class CalendarEventsTable extends SupabaseTable<CalendarEventsRow> {
  @override
  String get tableName => 'calendar_events';

  @override
  CalendarEventsRow createRow(Map<String, dynamic> data) =>
      CalendarEventsRow(data);
}

class CalendarEventsRow extends SupabaseDataRow {
  CalendarEventsRow(super.data);

  @override
  SupabaseTable get table => CalendarEventsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime? get updatedAt => getField<DateTime>('updated_at');
  set updatedAt(DateTime? value) => setField<DateTime>('updated_at', value);

  String get title => getField<String>('title')!;
  set title(String value) => setField<String>('title', value);

  String? get content => getField<String>('content');
  set content(String? value) => setField<String>('content', value);

  String get startDate => getField<String>('start_date')!;
  set startDate(String value) => setField<String>('start_date', value);

  String? get startTime => getField<String>('start_time');
  set startTime(String? value) => setField<String>('start_time', value);

  String get endDate => getField<String>('end_date')!;
  set endDate(String value) => setField<String>('end_date', value);

  String? get endTime => getField<String>('end_time');
  set endTime(String? value) => setField<String>('end_time', value);

  bool get isAllDay => getField<bool>('is_all_day') ?? false;
  set isAllDay(bool value) => setField<bool>('is_all_day', value);

  String get createdByEmail => getField<String>('created_by_email')!;
  set createdByEmail(String value) =>
      setField<String>('created_by_email', value);

  String? get createdByName => getField<String>('created_by_name');
  set createdByName(String? value) =>
      setField<String>('created_by_name', value);

  int get classId => getField<int>('class_id')!;
  set classId(int value) => setField<int>('class_id', value);

  String get year => getField<String>('year')!;
  set year(String value) => setField<String>('year', value);

  String get semester => getField<String>('semester')!;
  set semester(String value) => setField<String>('semester', value);

  int get grade => getField<int>('grade')!;
  set grade(int value) => setField<int>('grade', value);

  String get courseName => getField<String>('course_name')!;
  set courseName(String value) => setField<String>('course_name', value);

  String? get section => getField<String>('section');
  set section(String? value) => setField<String>('section', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) =>
      setField<String>('professor_name', value);

  String get eventColor => getField<String>('event_color') ?? '#284E75';
  set eventColor(String value) => setField<String>('event_color', value);
}
