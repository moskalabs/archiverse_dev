import '../database.dart';

class CoursesTable extends SupabaseTable<CoursesRow> {
  @override
  String get tableName => 'courses';

  @override
  CoursesRow createRow(Map<String, dynamic> data) => CoursesRow(data);
}

class CoursesRow extends SupabaseDataRow {
  CoursesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CoursesTable();

  int get courseId => getField<int>('course_id')!;
  set courseId(int value) => setField<int>('course_id', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);

  String? get courseType => getField<String>('course_type');
  set courseType(String? value) => setField<String>('course_type', value);

  int? get gradeLevel => getField<int>('grade_level');
  set gradeLevel(int? value) => setField<int>('grade_level', value);

  bool? get requireSections => getField<bool>('require_sections');
  set requireSections(bool? value) => setField<bool>('require_sections', value);
}
