import '../database.dart';

class YearsTable extends SupabaseTable<YearsRow> {
  @override
  String get tableName => 'years';

  @override
  YearsRow createRow(Map<String, dynamic> data) => YearsRow(data);
}

class YearsRow extends SupabaseDataRow {
  YearsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => YearsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get year => getField<String>('year');
  set year(String? value) => setField<String>('year', value);
}
