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

  final posts = await PostsTable().queryRows(
    queryFn: (q) {
      var query = q.order('name', ascending: true);
      if (normalizedSearch.isNotEmpty) {
        query = query.ilike('name', '%$normalizedSearch%');
      }
      return query;
    },
  );
  final adminRows = await AdminPostTable().queryRows(
    queryFn: (q) => q.order('adminId', ascending: true),
  );
  final merged = _mergeAdminRows(posts, adminRows);
  if (normalizedSearch.isEmpty) {
    return merged;
  }
  final lowerKeyword = normalizedSearch.toLowerCase();
  return merged
      .where((row) => (row.name ?? '').toLowerCase().contains(lowerKeyword))
      .toList();
}

List<PostsRow> _mergeAdminRows(
  List<PostsRow> posts,
  List<AdminPostRow> adminRows,
) {
  if (posts.isEmpty) {
    return [];
  }
  if (adminRows.isEmpty) {
    return posts.map(_cloneWithDefaults).toList();
  }
  final adminMap = {
    for (final admin in adminRows) admin.adminId.toLowerCase(): admin,
  };
  final merged = posts.map((row) {
    final cloned = _cloneWithDefaults(row);
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
    cloned.userType = cloned.userType ?? 3;
    cloned.position = _userTypeLabel(cloned.userType);
    return cloned;
  }).toList();
  merged.sort(
    (a, b) => (a.name ?? '').compareTo(b.name ?? ''),
  );
  return merged;
}

PostsRow _cloneWithDefaults(PostsRow row) {
  final cloned = PostsRow(Map<String, dynamic>.from(row.data));
  cloned.userType = cloned.userType ?? 3;
  cloned.position = _userTypeLabel(cloned.userType);
  return cloned;
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

String _userTypeLabel(int? userType) {
  switch (userType) {
    case 0:
      return '마스터';
    case 1:
      return '전임';
    case 2:
      return '겸임';
    case 4:
      return '조교';
    case 3:
    default:
      return '일반';
  }
}
