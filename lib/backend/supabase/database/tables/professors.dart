import '../database.dart';

class ProfessorsTable extends SupabaseTable<ProfessorsRow> {
  @override
  String get tableName => 'professors';

  @override
  ProfessorsRow createRow(Map<String, dynamic> data) => ProfessorsRow(data);
}

class ProfessorsRow extends SupabaseDataRow {
  ProfessorsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfessorsTable();

  int get professorId => getField<int>('professor_id')!;
  set professorId(int value) => setField<int>('professor_id', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get email => getField<String>('email');
  set email(String? value) => setField<String>('email', value);

  int? get prfType => getField<int>('prf_type');
  set prfType(int? value) => setField<int>('prf_type', value);
}
