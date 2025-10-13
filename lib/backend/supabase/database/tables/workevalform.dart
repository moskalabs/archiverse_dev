import '../database.dart';

class WorkevalformTable extends SupabaseTable<WorkevalformRow> {
  @override
  String get tableName => 'workevalform';

  @override
  WorkevalformRow createRow(Map<String, dynamic> data) => WorkevalformRow(data);
}

class WorkevalformRow extends SupabaseDataRow {
  WorkevalformRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => WorkevalformTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get classField => getField<int>('class')!;
  set classField(int value) => setField<int>('class', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  DateTime? get createdDate => getField<DateTime>('created_date');
  set createdDate(DateTime? value) => setField<DateTime>('created_date', value);

  DateTime? get updatedDate => getField<DateTime>('updated_date');
  set updatedDate(DateTime? value) => setField<DateTime>('updated_date', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get week => getField<String>('week');
  set week(String? value) => setField<String>('week', value);

  String? get section => getField<String>('section');
  set section(String? value) => setField<String>('section', value);
}
