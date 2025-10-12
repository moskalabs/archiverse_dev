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
import 'package:flutter/foundation.dart';
import '/backend/index_page_template.dart';

Future<void> testIndexPage({
  String? courseName,
  String? professorName,
  String? section,
}) async {
  print('======= INDEX PAGE TEST START =======');
  
  try {
    // INDEX 페이지 생성
    final indexPdfBytes = await IndexPageTemplate.generateIndexPage(
      courseName: courseName ?? '건축설계 9',
      professorName: professorName ?? '천준호',
      section: section ?? '1분반',
    );
    
    if (kIsWeb && indexPdfBytes.isNotEmpty) {
      final fileName = 'index_page_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final blob = html.Blob([indexPdfBytes], 'application/pdf');
      final dlUrl = html.Url.createObjectUrlFromBlob(blob);
      final a = html.document.createElement('a') as html.AnchorElement
        ..href = dlUrl
        ..download = fileName;
      a.click();
      html.Url.revokeObjectUrl(dlUrl);
      
      print('======= INDEX PAGE TEST SUCCESS =======');
    } else {
      print('======= INDEX PAGE GENERATION FAILED =======');
    }
  } catch (e) {
    print('======= INDEX PAGE ERROR: $e =======');
  }
}