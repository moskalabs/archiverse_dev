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

import 'dart:html' as html;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> startDownloadAction(
  BuildContext context,
  String url,
  String fileName,
) async {
  if (url.isEmpty || fileName.isEmpty) {
    print('Error: URL or fileName is empty');
    return;
  }

  final String downloadFileName = "$fileName.pdf"; // 확장자 추가

  if (kIsWeb) {
    try {
      // 파일 데이터를 HTTP로 가져오기
      final http.Response response = await http.get(Uri.parse(url));
      final blob = html.Blob([response.bodyBytes], 'application/pdf');
      final downloadUrl = html.Url.createObjectUrlFromBlob(blob);

      // 바로 다운로드
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = downloadUrl
        ..style.display = 'none'
        ..download = downloadFileName;

      html.document.body!.children.add(anchor);
      anchor.click();

      // DOM 정리
      html.document.body!.children.remove(anchor);
      html.Url.revokeObjectUrl(downloadUrl);
    } catch (e) {
      print('Download error: $e');
    }
  } else {
    print('This function only supports web environment.');
  }
}
