import 'package:supabase_flutter/supabase_flutter.dart';

export 'database/database.dart';
export 'storage/storage.dart';

String _kSupabaseUrl = 'https://ygagwsshehmtfqlkjwmv.supabase.co';
String _kSupabaseAnonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlnYWd3c3NoZWhtdGZxbGtqd212Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMxMDIxNDMsImV4cCI6MjA0ODY3ODE0M30.8_duIDI0wSMe3c0_H0kxUYCt4eSEyQnOLNK-nGGd-RI';

class SupaFlow {
  SupaFlow._();

  static SupaFlow? _instance;
  static SupaFlow get instance => _instance ??= SupaFlow._();

  final _supabase = Supabase.instance.client;
  static SupabaseClient get client => instance._supabase;

  static Future initialize() => Supabase.initialize(
        url: _kSupabaseUrl,
        headers: {
          'X-Client-Info': 'flutterflow',
        },
        anonKey: _kSupabaseAnonKey,
        debug: false,
        authOptions: FlutterAuthClientOptions(
          authFlowType: AuthFlowType.implicit,
          autoRefreshToken: false, // 자동 갱신 비활성화
          persistSession: true, // 세션 저장은 유지
        ),
      );
}

