import '../database.dart';

class UploadByStudentAndWeeksTable
    extends SupabaseTable<UploadByStudentAndWeeksRow> {
  @override
  String get tableName => 'upload_by_student_and_weeks';

  @override
  UploadByStudentAndWeeksRow createRow(Map<String, dynamic> data) =>
      UploadByStudentAndWeeksRow(data);
}

class UploadByStudentAndWeeksRow extends SupabaseDataRow {
  UploadByStudentAndWeeksRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => UploadByStudentAndWeeksTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get year => getField<String>('year');
  set year(String? value) => setField<String>('year', value);

  String? get semesterType => getField<String>('semester_type');
  set semesterType(String? value) => setField<String>('semester_type', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);

  String? get sectionName => getField<String>('section_name');
  set sectionName(String? value) => setField<String>('section_name', value);

  String? get weeks => getField<String>('weeks');
  set weeks(String? value) => setField<String>('weeks', value);

  String? get studentName => getField<String>('student_name');
  set studentName(String? value) => setField<String>('student_name', value);

  bool? get uploadBoolean => getField<bool>('upload_boolean');
  set uploadBoolean(bool? value) => setField<bool>('upload_boolean', value);

  int? get grade => getField<int>('grade');
  set grade(int? value) => setField<int>('grade', value);
}
