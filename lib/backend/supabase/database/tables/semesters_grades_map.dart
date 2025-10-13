import '../database.dart';

class SemestersGradesMapTable extends SupabaseTable<SemestersGradesMapRow> {
  @override
  String get tableName => 'semesters_grades_map';

  @override
  SemestersGradesMapRow createRow(Map<String, dynamic> data) =>
      SemestersGradesMapRow(data);
}

class SemestersGradesMapRow extends SupabaseDataRow {
  SemestersGradesMapRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SemestersGradesMapTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get semesterYear => getField<int>('semester_year');
  set semesterYear(int? value) => setField<int>('semester_year', value);

  String? get semesterType => getField<String>('semester_type');
  set semesterType(String? value) => setField<String>('semester_type', value);
}
