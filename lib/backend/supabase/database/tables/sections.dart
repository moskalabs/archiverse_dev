import '../database.dart';

class SectionsTable extends SupabaseTable<SectionsRow> {
  @override
  String get tableName => 'sections';

  @override
  SectionsRow createRow(Map<String, dynamic> data) => SectionsRow(data);
}

class SectionsRow extends SupabaseDataRow {
  SectionsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => SectionsTable();

  int get secId => getField<int>('sec_id')!;
  set secId(int value) => setField<int>('sec_id', value);

  String? get secName => getField<String>('sec_name');
  set secName(String? value) => setField<String>('sec_name', value);
}
