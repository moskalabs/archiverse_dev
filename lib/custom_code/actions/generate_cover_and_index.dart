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
import '/backend/clean_combined_pdf_template.dart';

Future<void> generateCoverAndIndex({
  String? year,
  String? semester,
  String? courseName,
  String? professorName,
  int? grade,
  String? section,
  int? classId,
}) async {
  print('======= COMBINED PDF GENERATION START =======');
  print('전달된 데이터: year=$year, semester=$semester, courseName=$courseName, professorName=$professorName, grade=$grade, section=$section');
  
  try {
    // 표지 + INDEX + 수업계획서 페이지를 한 번에 생성
    final combinedPdfBytes = await CombinedPdfTemplate.generateCombinedPdf(
      year: year ?? '2025',
      semester: semester ?? '1학기',
      courseName: courseName ?? '과목명',
      professorName: professorName ?? '교수님',
      grade: grade != null ? '${grade}학년' : '학년',
      section: section ?? '분반',
      classId: classId,
    );
    
    print('Combined PDF 생성 완료: ${combinedPdfBytes.length} bytes');
    
    if (combinedPdfBytes.isEmpty) {
      throw Exception('Combined PDF 생성 실패');
    }
    
    if (kIsWeb && combinedPdfBytes.isNotEmpty) {
      print('======= 다운로드 시작 =======');
      
      final fileName = 'portfolio_cover_index_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final blob = html.Blob([combinedPdfBytes], 'application/pdf');
      final dlUrl = html.Url.createObjectUrlFromBlob(blob);
      final a = html.document.createElement('a') as html.AnchorElement
        ..href = dlUrl
        ..download = fileName;
      a.click();
      html.Url.revokeObjectUrl(dlUrl);
      
      print('======= COMBINED PDF SUCCESS =======');
      print('파일명: $fileName');
    } else {
      print('======= PDF GENERATION FAILED =======');
      print('Combined PDF empty: ${combinedPdfBytes.isEmpty}');
    }
  } catch (e) {
    print('======= COVER + INDEX PAGE ERROR: $e =======');
    rethrow;
  }
}