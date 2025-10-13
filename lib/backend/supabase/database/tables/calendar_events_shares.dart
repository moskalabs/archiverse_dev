import '../database.dart';

class CalendarEventsSharesTable extends SupabaseTable<CalendarEventsSharesRow> {
  @override
  String get tableName => 'calendar_events_shares';

  @override
  CalendarEventsSharesRow createRow(Map<String, dynamic> data) =>
      CalendarEventsSharesRow(data);
}

class CalendarEventsSharesRow extends SupabaseDataRow {
  CalendarEventsSharesRow(super.data);

  @override
  SupabaseTable get table => CalendarEventsSharesTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  String get eventId => getField<String>('event_id')!;
  set eventId(String value) => setField<String>('event_id', value);

  String get sharedWith => getField<String>('shared_with')!;
  set sharedWith(String value) => setField<String>('shared_with', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);
}
