import '../database.dart';

class LecturematerialTable extends SupabaseTable<LecturematerialRow> {
  @override
  String get tableName => 'lecturematerial';

  @override
  LecturematerialRow createRow(Map<String, dynamic> data) =>
      LecturematerialRow(data);
}

class LecturematerialRow extends SupabaseDataRow {
  LecturematerialRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => LecturematerialTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get classField => getField<int>('class')!;
  set classField(int value) => setField<int>('class', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  DateTime? get createdDate => getField<DateTime>('created_date');
  set createdDate(DateTime? value) => setField<DateTime>('created_date', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get week => getField<String>('week');
  set week(String? value) => setField<String>('week', value);

  String? get section => getField<String>('section');
  set section(String? value) => setField<String>('section', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);
}
