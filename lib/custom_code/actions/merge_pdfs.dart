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

Future<void> mergePdfs(String? firstCoverUrl, List<String> contentUrls,
    String? lastCoverUrl) async {
  final List<String> mergedPdfs = [];

  void addIfValid(String? url) {
    final trimmedUrl = url?.trim();
    if (trimmedUrl != null && trimmedUrl.isNotEmpty) {
      mergedPdfs.add(trimmedUrl);
    }
  }

  // 첫 표지 추가
  addIfValid(firstCoverUrl);

  // 콘텐츠 파일 추가
  for (final url in contentUrls) {
    addIfValid(url);
  }

  // 마지막 표지 추가
  addIfValid(lastCoverUrl);

  // AppState에 저장
  FFAppState().mergepdfs = mergedPdfs;
}
