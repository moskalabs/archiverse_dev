import '../database.dart';

class YearsSemesterMapTable extends SupabaseTable<YearsSemesterMapRow> {
  @override
  String get tableName => 'years_semester_map';

  @override
  YearsSemesterMapRow createRow(Map<String, dynamic> data) =>
      YearsSemesterMapRow(data);
}

class YearsSemesterMapRow extends SupabaseDataRow {
  YearsSemesterMapRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => YearsSemesterMapTable();

  int get mapId => getField<int>('map_id')!;
  set mapId(int value) => setField<int>('map_id', value);

  int? get yearsId => getField<int>('years_id');
  set yearsId(int? value) => setField<int>('years_id', value);

  int? get semesterId => getField<int>('semester_id');
  set semesterId(int? value) => setField<int>('semester_id', value);

  String? get yearText => getField<String>('year_text');
  set yearText(String? value) => setField<String>('year_text', value);

  String? get semesterTypeText => getField<String>('semester_type_text');
  set semesterTypeText(String? value) =>
      setField<String>('semester_type_text', value);

  String? get yearSemesterGrade => getField<String>('year_semester_grade');
  set yearSemesterGrade(String? value) =>
      setField<String>('year_semester_grade', value);
}
