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

Future<List<PostsRow>> searchPosts(String? searchType, String? searchText) async {
  if (searchText == null || searchText.isEmpty) {
    return await PostsTable().queryRows(
      queryFn: (q) => q.order('name', ascending: true),
    );
  }

  List<PostsRow> allRows;
  try {
    allRows = await PostsTable().queryRows(
      queryFn: (q) => q.order('name', ascending: true),
    );
  } catch (e) {
    debugPrint('데이터 로드 실패: $e');
    return [];
  }

  final normalizedSearch = searchText.trim().toLowerCase();

  if (searchType == '이 름') {
    return allRows.where((row) {
      final name = row.name?.toLowerCase() ?? '';
      return name.contains(normalizedSearch);
    }).toList();
  }

  if (searchType == '학 번' || searchType == '연락처') {
    return allRows.where((row) {
      final phone = row.phone ?? '';
      return phone.contains(searchText.trim());
    }).toList();
  }

  return allRows.where((row) {
    final name = row.name?.toLowerCase() ?? '';
    return name.contains(normalizedSearch);
  }).toList();
}
