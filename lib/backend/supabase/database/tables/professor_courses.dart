import '../database.dart';

class ProfessorCoursesTable extends SupabaseTable<ProfessorCoursesRow> {
  @override
  String get tableName => 'professor-courses';

  @override
  ProfessorCoursesRow createRow(Map<String, dynamic> data) =>
      ProfessorCoursesRow(data);
}

class ProfessorCoursesRow extends SupabaseDataRow {
  ProfessorCoursesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfessorCoursesTable();

  int get professorId => getField<int>('professor_id')!;
  set professorId(int value) => setField<int>('professor_id', value);

  int? get courseId => getField<int>('course_id');
  set courseId(int? value) => setField<int>('course_id', value);

  String? get professorRole => getField<String>('professor_role');
  set professorRole(String? value) => setField<String>('professor_role', value);

  int? get semesterId => getField<int>('semester_id');
  set semesterId(int? value) => setField<int>('semester_id', value);
}
