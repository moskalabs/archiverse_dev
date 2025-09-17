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

Future<void> mergePdfs(String firstUrl, String secondUrl, String firstCoverUrl,
    String lastCoverUrl) async {
  List<String> mergePdfs = [];

  // URL 리스트에 추가
  mergePdfs.add(firstCoverUrl);
  mergePdfs.add(firstUrl);
  mergePdfs.add(secondUrl);
  mergePdfs.add(lastCoverUrl);

  // AppState에 저장
  FFAppState().mergepdfs = mergePdfs;
}
