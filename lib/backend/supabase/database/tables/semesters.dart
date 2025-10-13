import '../database.dart';

class SemestersTable extends SupabaseTable<SemestersRow> {
  @override
  String get tableName => 'semesters';

  @override
  SemestersRow createRow(Map<String, dynamic> data) => SemestersRow(data);
}

class SemestersRow extends SupabaseDataRow {
  SemestersRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SemestersTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get semesterType => getField<String>('semester_type');
  set semesterType(String? value) => setField<String>('semester_type', value);
}
