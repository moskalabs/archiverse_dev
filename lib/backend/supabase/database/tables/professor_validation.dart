import '../database.dart';

class ProfessorValidationTable extends SupabaseTable<ProfessorValidationRow> {
  @override
  String get tableName => 'professor_validation';

  @override
  ProfessorValidationRow createRow(Map<String, dynamic> data) =>
      ProfessorValidationRow(data);
}

class ProfessorValidationRow extends SupabaseDataRow {
  ProfessorValidationRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ProfessorValidationTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get name => getField<String>('name');
  set name(String? value) => setField<String>('name', value);

  String? get phoneNum => getField<String>('phoneNum');
  set phoneNum(String? value) => setField<String>('phoneNum', value);

  int? get prfType => getField<int>('prf_type');
  set prfType(int? value) => setField<int>('prf_type', value);

  String? get userAlias => getField<String>('user_alias');
  set userAlias(String? value) => setField<String>('user_alias', value);
}
