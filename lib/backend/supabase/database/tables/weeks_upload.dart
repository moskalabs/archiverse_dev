import '../database.dart';

class WeeksUploadTable extends SupabaseTable<WeeksUploadRow> {
  @override
  String get tableName => 'weeks_upload';

  @override
  WeeksUploadRow createRow(Map<String, dynamic> data) => WeeksUploadRow(data);
}

class WeeksUploadRow extends SupabaseDataRow {
  WeeksUploadRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WeeksUploadTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get weeksName => getField<String>('weeks_name');
  set weeksName(String? value) => setField<String>('weeks_name', value);
}
