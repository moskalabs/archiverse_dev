import '../database.dart';

class ClassTable extends SupabaseTable<ClassRow> {
  @override
  String get tableName => 'class';

  @override
  ClassRow createRow(Map<String, dynamic> data) => ClassRow(data);
}

class ClassRow extends SupabaseDataRow {
  ClassRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ClassTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String? get course => getField<String>('course');
  set course(String? value) => setField<String>('course', value);

  String? get professor => getField<String>('professor');
  set professor(String? value) => setField<String>('professor', value);

  String? get year => getField<String>('year');
  set year(String? value) => setField<String>('year', value);

  String? get semester => getField<String>('semester');
  set semester(String? value) => setField<String>('semester', value);

  int? get grade => getField<int>('grade');
  set grade(int? value) => setField<int>('grade', value);

  bool? get sectionBool => getField<bool>('section_bool');
  set sectionBool(bool? value) => setField<bool>('section_bool', value);

  String? get section => getField<String>('section');
  set section(String? value) => setField<String>('section', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);
}
