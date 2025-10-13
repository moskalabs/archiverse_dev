import '../database.dart';

class NotificationsTable extends SupabaseTable<NotificationsRow> {
  @override
  String get tableName => 'notifications';

  @override
  NotificationsRow createRow(Map<String, dynamic> data) => NotificationsRow(data);
}

class NotificationsRow extends SupabaseDataRow {
  NotificationsRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => NotificationsTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  int? get eventId => getField<int>('event_id');
  set eventId(int? value) => setField<int>('event_id', value);

  String? get recipientEmail => getField<String>('recipient_email');
  set recipientEmail(String? value) => setField<String>('recipient_email', value);

  String? get recipientName => getField<String>('recipient_name');
  set recipientName(String? value) => setField<String>('recipient_name', value);

  int? get userType => getField<int>('user_type'); // 1: professor, 2: student
  set userType(int? value) => setField<int>('user_type', value);

  String? get notificationTitle => getField<String>('notification_title');
  set notificationTitle(String? value) => setField<String>('notification_title', value);

  String? get notificationContent => getField<String>('notification_content');
  set notificationContent(String? value) => setField<String>('notification_content', value);

  DateTime? get notificationDate => getField<DateTime>('notification_date');
  set notificationDate(DateTime? value) => setField<DateTime>('notification_date', value);

  // TIME 타입은 String으로 읽어야 함 (예: "15:30:00")
  String? get notificationTime => getField<String>('notification_time');
  set notificationTime(String? value) => setField<String>('notification_time', value);

  bool? get isRead => getField<bool>('is_read');
  set isRead(bool? value) => setField<bool>('is_read', value);

  DateTime? get createdAt => getField<DateTime>('created_at');
  set createdAt(DateTime? value) => setField<DateTime>('created_at', value);

  String? get eventTitle => getField<String>('event_title');
  set eventTitle(String? value) => setField<String>('event_title', value);

  String? get courseName => getField<String>('course_name');
  set courseName(String? value) => setField<String>('course_name', value);
}
