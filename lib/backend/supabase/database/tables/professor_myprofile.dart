import '../database.dart';

class ProfessorMyprofileTable extends SupabaseTable<ProfessorMyprofileRow> {
  @override
  String get tableName => 'professor_myprofile';

  @override
  ProfessorMyprofileRow createRow(Map<String, dynamic> data) =>
      ProfessorMyprofileRow(data);
}

class ProfessorMyprofileRow extends SupabaseDataRow {
  ProfessorMyprofileRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfessorMyprofileTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);

  String? get pfrPhonenumber => getField<String>('pfr_phonenumber');
  set pfrPhonenumber(String? value) =>
      setField<String>('pfr_phonenumber', value);

  String? get pfrBirth => getField<String>('pfr_birth');
  set pfrBirth(String? value) => setField<String>('pfr_birth', value);

  String? get pfrEmail => getField<String>('pfr_email');
  set pfrEmail(String? value) => setField<String>('pfr_email', value);

  String? get pfrInstitution => getField<String>('pfr_institution');
  set pfrInstitution(String? value) =>
      setField<String>('pfr_institution', value);

  int? get pfrType => getField<int>('pfr_type');
  set pfrType(int? value) => setField<int>('pfr_type', value);

  dynamic get pfrSpeciality => getField<dynamic>('pfr_speciality');
  set pfrSpeciality(dynamic value) =>
      setField<dynamic>('pfr_speciality', value);

  String? get pfrProject => getField<String>('pfr_project');
  set pfrProject(String? value) => setField<String>('pfr_project', value);

  dynamic get pfrLicensed => getField<dynamic>('pfr_licensed');
  set pfrLicensed(dynamic value) => setField<dynamic>('pfr_licensed', value);

  String? get pfrImageurl => getField<String>('pfr_imageurl');
  set pfrImageurl(String? value) => setField<String>('pfr_imageurl', value);

  String? get prfPositon => getField<String>('prf_positon');
  set prfPositon(String? value) => setField<String>('prf_positon', value);

  List<dynamic> get degreeList => getListField<dynamic>('degreeList');
  set degreeList(List<dynamic>? value) =>
      setListField<dynamic>('degreeList', value);

  List<dynamic> get lecExperience => getListField<dynamic>('lecExperience');
  set lecExperience(List<dynamic>? value) =>
      setListField<dynamic>('lecExperience', value);
}
