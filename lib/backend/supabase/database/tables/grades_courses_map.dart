import '../database.dart';

class GradesCoursesMapTable extends SupabaseTable<GradesCoursesMapRow> {
  @override
  String get tableName => 'grades_courses_map';

  @override
  GradesCoursesMapRow createRow(Map<String, dynamic> data) =>
      GradesCoursesMapRow(data);
}

class GradesCoursesMapRow extends SupabaseDataRow {
  GradesCoursesMapRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GradesCoursesMapTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get grade => getField<int>('grade');
  set grade(int? value) => setField<int>('grade', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);

  bool? get requireSections => getField<bool>('require_sections');
  set requireSections(bool? value) => setField<bool>('require_sections', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);

  int? get yearsSemesterMap => getField<int>('years_semester_map');
  set yearsSemesterMap(int? value) =>
      setField<int>('years_semester_map', value);

  String? get ySGradeText => getField<String>('y_s_grade_text');
  set ySGradeText(String? value) => setField<String>('y_s_grade_text', value);
}
