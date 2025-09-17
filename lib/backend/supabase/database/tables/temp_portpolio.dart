import '../database.dart';

class TempPortpolioTable extends SupabaseTable<TempPortpolioRow> {
  @override
  String get tableName => 'temp_portpolio';

  @override
  TempPortpolioRow createRow(Map<String, dynamic> data) =>
      TempPortpolioRow(data);
}

class TempPortpolioRow extends SupabaseDataRow {
  TempPortpolioRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => TempPortpolioTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  DateTime? get createdDate => getField<DateTime>('created_date');
  set createdDate(DateTime? value) => setField<DateTime>('created_date', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get studentName => getField<String>('student_name');
  set studentName(String? value) => setField<String>('student_name', value);

  String? get criticHtml => getField<String>('critic_html');
  set criticHtml(String? value) => setField<String>('critic_html', value);

  int get classField => getField<int>('class')!;
  set classField(int value) => setField<int>('class', value);

  String? get week => getField<String>('week');
  set week(String? value) => setField<String>('week', value);
}
