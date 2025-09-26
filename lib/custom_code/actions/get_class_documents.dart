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

import '/app_state.dart';
import 'custom_merge_and_download.dart';

Future<List<String>> getClassDocuments(int classId) async {
  final List<String> urls = [];
  final Set<String> seen = <String>{};

  if (classId <= 0) {
    print('[getClassDocuments] 잘못된 classId: $classId');
    return urls;
  }

  List<PortfolioSectionStruct> sections =
      FFAppState().classPortfolioSections.toList();

  if (sections.isEmpty) {
    sections = await customMergeAndDownload(classId);
  }

  for (final section in sections) {
    for (final item in section.items) {
      final trimmed = item.url.trim();
      if (trimmed.isNotEmpty && seen.add(trimmed)) {
        urls.add(trimmed);
      }
    }
  }

  if (urls.isEmpty) {
    print('[getClassDocuments] 섹션 데이터에서 URL을 찾지 못했습니다.');
  }

  return urls;
}
