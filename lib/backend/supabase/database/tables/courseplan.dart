import '../database.dart';

class CourseplanTable extends SupabaseTable<CourseplanRow> {
  @override
  String get tableName => 'courseplan';

  @override
  CourseplanRow createRow(Map<String, dynamic> data) => CourseplanRow(data);
}

class CourseplanRow extends SupabaseDataRow {
  CourseplanRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => CourseplanTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get classField => getField<int>('class')!;
  set classField(int value) => setField<int>('class', value);

  String? get planTitle => getField<String>('plan_title');
  set planTitle(String? value) => setField<String>('plan_title', value);

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

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);
}
