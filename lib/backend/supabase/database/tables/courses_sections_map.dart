import '../database.dart';

class CoursesSectionsMapTable extends SupabaseTable<CoursesSectionsMapRow> {
  @override
  String get tableName => 'courses_sections_map';

  @override
  CoursesSectionsMapRow createRow(Map<String, dynamic> data) =>
      CoursesSectionsMapRow(data);
}

class CoursesSectionsMapRow extends SupabaseDataRow {
  CoursesSectionsMapRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CoursesSectionsMapTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);

  String? get pfsName => getField<String>('pfs_name');
  set pfsName(String? value) => setField<String>('pfs_name', value);

  String? get ySGText => getField<String>('y_s_g_text');
  set ySGText(String? value) => setField<String>('y_s_g_text', value);

  String? get sectionType => getField<String>('section_type');
  set sectionType(String? value) => setField<String>('section_type', value);
}
