import '../database.dart';

class AttendanceTable extends SupabaseTable<AttendanceRow> {
  @override
  String get tableName => 'attendance';

  @override
  AttendanceRow createRow(Map<String, dynamic> data) => AttendanceRow(data);
}

class AttendanceRow extends SupabaseDataRow {
  AttendanceRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => AttendanceTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get classField => getField<int>('class')!;
  set classField(int value) => setField<int>('class', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  DateTime? get createdDate => getField<DateTime>('created_date');
  set createdDate(DateTime? value) => setField<DateTime>('created_date', value);

  DateTime? get updatedDate => getField<DateTime>('updated_date');
  set updatedDate(DateTime? value) => setField<DateTime>('updated_date', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get week => getField<String>('week');
  set week(String? value) => setField<String>('week', value);
}
