import '../database.dart';

class StudentMyprofileTable extends SupabaseTable<StudentMyprofileRow> {
  @override
  String get tableName => 'student_myprofile';

  @override
  StudentMyprofileRow createRow(Map<String, dynamic> data) =>
      StudentMyprofileRow(data);
}

class StudentMyprofileRow extends SupabaseDataRow {
  StudentMyprofileRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => StudentMyprofileTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get phoneNum => getField<String>('phoneNum');
  set phoneNum(String? value) => setField<String>('phoneNum', value);

  String? get birth => getField<String>('birth');
  set birth(String? value) => setField<String>('birth', value);

  String get stuEmail => getField<String>('stu_email')!;
  set stuEmail(String value) => setField<String>('stu_email', value);

  String? get gender => getField<String>('gender');
  set gender(String? value) => setField<String>('gender', value);

  String? get admissionType => getField<String>('admission_type');
  set admissionType(String? value) => setField<String>('admission_type', value);

  String? get enrollmentStatus => getField<String>('enrollment_status');
  set enrollmentStatus(String? value) =>
      setField<String>('enrollment_status', value);

  String? get grade => getField<String>('grade');
  set grade(String? value) => setField<String>('grade', value);

  String? get years => getField<String>('years');
  set years(String? value) => setField<String>('years', value);

  String? get semester => getField<String>('semester');
  set semester(String? value) => setField<String>('semester', value);

  String? get courseMajor => getField<String>('courseMajor');
  set courseMajor(String? value) => setField<String>('courseMajor', value);

  String? get section => getField<String>('section');
  set section(String? value) => setField<String>('section', value);

  String? get employmentStatus => getField<String>('employment_status');
  set employmentStatus(String? value) =>
      setField<String>('employment_status', value);

  String? get employmentDetails => getField<String>('employment_details');
  set employmentDetails(String? value) =>
      setField<String>('employment_details', value);

  List<String> get interestAreas => getListField<String>('interest_areas');
  set interestAreas(List<String>? value) =>
      setListField<String>('interest_areas', value);

  String? get interestDetail => getField<String>('interest_detail');
  set interestDetail(String? value) =>
      setField<String>('interest_detail', value);

  String? get certifications => getField<String>('certifications');
  set certifications(String? value) =>
      setField<String>('certifications', value);

  String? get competitionsAwards => getField<String>('competitions_awards');
  set competitionsAwards(String? value) =>
      setField<String>('competitions_awards', value);

  String? get networkingActivities => getField<String>('networking_activities');
  set networkingActivities(String? value) =>
      setField<String>('networking_activities', value);

  String? get softwareSkills => getField<String>('software_skills');
  set softwareSkills(String? value) =>
      setField<String>('software_skills', value);

  String? get stuImageurl => getField<String>('stu_imageurl');
  set stuImageurl(String? value) => setField<String>('stu_imageurl', value);
}
