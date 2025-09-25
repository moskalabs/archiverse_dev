// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<List<PostsRow>> searchPosts(
  String? searchType,
  String? searchText,
) async {
  final normalizedSearch = searchText?.trim() ?? '';

  if (normalizedSearch.isEmpty) {
    return PostsTable().queryRows(
      queryFn: (q) => q.order('name', ascending: true),
    );
  }

  final supabase = SupaFlow.client;

  final type = searchType ?? '이 름';

  final response = type == '이 름'
      ? await supabase
          .from('posts')
          .select()
          .textSearch('name', normalizedSearch)
      : await supabase
          .from('posts')
          .select()
          .eq('phone', normalizedSearch);

  if (response is! List) {
    return [];
  }

  return response.map((e) => PostsRow(e as Map<String, dynamic>)).toList();
}
