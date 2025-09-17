import '../database.dart';

class CourseStudentTable extends SupabaseTable<CourseStudentRow> {
  @override
  String get tableName => 'course_student';

  @override
  CourseStudentRow createRow(Map<String, dynamic> data) =>
      CourseStudentRow(data);
}

class CourseStudentRow extends SupabaseDataRow {
  CourseStudentRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CourseStudentTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);

  String? get year => getField<String>('year');
  set year(String? value) => setField<String>('year', value);

  String? get semester => getField<String>('semester');
  set semester(String? value) => setField<String>('semester', value);

  int? get grade => getField<int>('grade');
  set grade(int? value) => setField<int>('grade', value);

  String? get courseType => getField<String>('course_type');
  set courseType(String? value) => setField<String>('course_type', value);

  int? get professorId => getField<int>('professor_id');
  set professorId(int? value) => setField<int>('professor_id', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);

  String? get sectionType => getField<String>('section_type');
  set sectionType(String? value) => setField<String>('section_type', value);

  int? get studentId => getField<int>('student_id');
  set studentId(int? value) => setField<int>('student_id', value);

  String? get studentName => getField<String>('student_name');
  set studentName(String? value) => setField<String>('student_name', value);

  int? get studentGrade => getField<int>('student_grade');
  set studentGrade(int? value) => setField<int>('student_grade', value);

  int? get classid => getField<int>('classid');
  set classid(int? value) => setField<int>('classid', value);
}
