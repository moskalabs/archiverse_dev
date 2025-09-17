import '../database.dart';

class GradesTable extends SupabaseTable<GradesRow> {
  @override
  String get tableName => 'grades';

  @override
  GradesRow createRow(Map<String, dynamic> data) => GradesRow(data);
}

class GradesRow extends SupabaseDataRow {
  GradesRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => GradesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get grades => getField<int>('grades');
  set grades(int? value) => setField<int>('grades', value);
}
