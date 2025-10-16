import '../database.dart';

class StudentMajorChangeRequestsTable
    extends SupabaseTable<StudentMajorChangeRequestsRow> {
  @override
  String get tableName => 'student_major_change_requests';

  @override
  StudentMajorChangeRequestsRow createRow(Map<String, dynamic> data) =>
      StudentMajorChangeRequestsRow(data);
}

class StudentMajorChangeRequestsRow extends SupabaseDataRow {
  StudentMajorChangeRequestsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentMajorChangeRequestsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get studentEmail => getField<String>('student_email')!;
  set studentEmail(String value) => setField<String>('student_email', value);

  String get studentName => getField<String>('student_name')!;
  set studentName(String value) => setField<String>('student_name', value);

  String? get studentCode => getField<String>('student_code');
  set studentCode(String? value) => setField<String>('student_code', value);

  String? get currentSection => getField<String>('current_section');
  set currentSection(String? value) =>
      setField<String>('current_section', value);

  String? get requestedSection => getField<String>('requested_section');
  set requestedSection(String? value) =>
      setField<String>('requested_section', value);

  String? get currentCourseMajor => getField<String>('current_course_major');
  set currentCourseMajor(String? value) =>
      setField<String>('current_course_major', value);

  String? get requestedCourseMajor =>
      getField<String>('requested_course_major');
  set requestedCourseMajor(String? value) =>
      setField<String>('requested_course_major', value);

  String get changeType => getField<String>('change_type')!;
  set changeType(String value) => setField<String>('change_type', value);

  String? get requestDescription => getField<String>('request_description');
  set requestDescription(String? value) =>
      setField<String>('request_description', value);

  String get status => getField<String>('status')!;
  set status(String value) => setField<String>('status', value);

  String? get approvedBy => getField<String>('approved_by');
  set approvedBy(String? value) => setField<String>('approved_by', value);

  DateTime? get approvedAt => getField<DateTime>('approved_at');
  set approvedAt(DateTime? value) => setField<DateTime>('approved_at', value);

  String? get rejectionReason => getField<String>('rejection_reason');
  set rejectionReason(String? value) =>
      setField<String>('rejection_reason', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  DateTime get updatedAt => getField<DateTime>('updated_at')!;
  set updatedAt(DateTime value) => setField<DateTime>('updated_at', value);
}
