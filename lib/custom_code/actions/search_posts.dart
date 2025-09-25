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
    final posts = await PostsTable().queryRows(
      queryFn: (q) => q.order('name', ascending: true),
    );
    final adminRows = await AdminPostTable().queryRows(
      queryFn: (q) => q.order('adminId', ascending: true),
    );
    return _mergeAdminRows(posts, adminRows);
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

  final posts = response
      .whereType<Map<String, dynamic>>()
      .map((e) => PostsRow(Map<String, dynamic>.from(e)))
      .toList();
  final adminRows = await AdminPostTable().queryRows(
    queryFn: (q) => q.order('adminId', ascending: true),
  );
  return _mergeAdminRows(posts, adminRows);
}

List<PostsRow> _mergeAdminRows(
  List<PostsRow> posts,
  List<AdminPostRow> adminRows,
) {
  if (posts.isEmpty) {
    return [];
  }
  if (adminRows.isEmpty) {
    return posts
        .map((row) => PostsRow(Map<String, dynamic>.from(row.data)))
        .toList();
  }
  final adminMap = {
    for (final admin in adminRows) admin.adminId.toLowerCase(): admin,
  };
  final merged = posts.map((row) {
    final cloned = PostsRow(Map<String, dynamic>.from(row.data));
    final emailKey = (cloned.email ?? '').toLowerCase();
    final admin = adminMap[emailKey];
    if (admin != null) {
      final adminName = admin.name;
      if (adminName != null && adminName.isNotEmpty) {
        cloned.name = adminName;
      }
      final role = admin.role;
      if (role.isNotEmpty) {
        cloned.permissionLevel = _permissionFromRole(role);
      }
      final userType = admin.userType;
      if (userType != null) {
        cloned.userType = userType;
      }
    }
    return cloned;
  }).toList();
  merged.sort(
    (a, b) => (a.name ?? '').compareTo(b.name ?? ''),
  );
  return merged;
}

int _permissionFromRole(String role) {
  final normalized = role.toLowerCase().trim();
  if (normalized.contains('master') ||
      normalized.contains('admin') ||
      normalized.contains('관리')) {
    return 2;
  }
  return 1;
}
