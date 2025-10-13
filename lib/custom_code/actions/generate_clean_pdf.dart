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
import '/backend/ultra_simple_template.dart';

Future<void> generateCleanPdf({
  String? year,
  String? semester,
  String? courseName,
  String? professorName,
  int? grade,
  String? section,
  int? classId,
}) async {
  print('======= CLEAN PDF GENERATION START =======');
  print('전달된 데이터: year=$year, semester=$semester, courseName=$courseName, professorName=$professorName, grade=$grade, section=$section, classId=$classId');
  
  try {
    // 진행률 업데이트 함수 (FFAppState 업데이트)
    void updateProgressState(double progress, String message) {
      try {
        FFAppState().update(() {
          FFAppState().downloadProgress = progress.clamp(0.0, 1.0);
          FFAppState().downloadProgressMessage = message;
        });
        print('진행률 UI 업데이트: ${(progress * 100).toStringAsFixed(1)}% - $message');
      } catch (e) {
        print('진행률 UI 업데이트 실패: $e');
      }
    }
    
    updateProgressState(0.0, 'PDF 생성 시작');
    
    // 4페이지 PDF 생성 (표지 + INDEX + 섹션구분자 + 수업계획서)
    final combinedPdfBytes = await UltraSimpleTemplate.generateCombinedPdf(
      year: year,
      semester: semester,
      courseName: courseName,
      professorName: professorName,
      grade: grade != null ? '${grade}학년' : '학년',
      section: section,
      classId: classId,
      updateProgressCallback: updateProgressState, // 진행률 콜백 전달
    );
    
    print('4페이지 PDF 생성 완료: ${combinedPdfBytes.length} bytes');
    
    if (combinedPdfBytes.isEmpty) {
      throw Exception('PDF 생성 실패');
    }
    
    updateProgressState(0.95, 'PDF 다운로드 준비 중');
    
    if (kIsWeb && combinedPdfBytes.isNotEmpty) {
      print('======= 다운로드 시작 =======');
      
      final fileName = 'portfolio_complete_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final blob = html.Blob([combinedPdfBytes], 'application/pdf');
      final dlUrl = html.Url.createObjectUrlFromBlob(blob);
      final a = html.document.createElement('a') as html.AnchorElement
        ..href = dlUrl
        ..download = fileName;
      a.click();
      html.Url.revokeObjectUrl(dlUrl);
      
      updateProgressState(1.0, 'PDF 다운로드 완료');
      
      print('======= 전체 PDF SUCCESS =======');
      print('파일명: $fileName');
    } else {
      print('======= PDF GENERATION FAILED =======');
      print('PDF empty: ${combinedPdfBytes.isEmpty}');
    }
  } catch (e) {
    print('======= PDF GENERATION ERROR: $e =======');
    rethrow;
  }
}