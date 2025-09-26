import '../database.dart';

class FinalResultsTable extends SupabaseTable<FinalResultsRow> {
  @override
  String get tableName => 'final_results';

  @override
  FinalResultsRow createRow(Map<String, dynamic> data) => FinalResultsRow(data);
}

class FinalResultsRow extends SupabaseDataRow {
  FinalResultsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => FinalResultsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int get classField => getField<int>('class')!;
  set classField(int value) => setField<int>('class', value);

  String? get title => getField<String>('title');
  set title(String? value) => setField<String>('title', value);

  DateTime? get createdDate => getField<DateTime>('created_date');
  set createdDate(DateTime? value) => setField<DateTime>('created_date', value);

  String? get url => getField<String>('url');
  set url(String? value) => setField<String>('url', value);

  String? get fileUrl => getField<String>('url');
  set fileUrl(String? value) => setField<String>('url', value);

  String? get week => getField<String>('week');
  set week(String? value) => setField<String>('week', value);

  String? get studentName => getField<String>('student_name');
  set studentName(String? value) => setField<String>('student_name', value);

  String? get professorName => getField<String>('professor_name');
  set professorName(String? value) => setField<String>('professor_name', value);

  String? get portpolioresult => getField<String>('portpolioresult');
  set portpolioresult(String? value) =>
      setField<String>('portpolioresult', value);

  String? get studentEmail => getField<String>('student_email');
  set studentEmail(String? value) => setField<String>('student_email', value);

  int? get grade => getField<int>('grade');
  set grade(int? value) => setField<int>('grade', value);

  String? get section => getField<String>('section');
  set section(String? value) => setField<String>('section', value);
}
