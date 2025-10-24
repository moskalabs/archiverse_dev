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

/// PDF 미리보기 - 새 탭에서 열기
Future<void> previewPdf({
  String? year,
  String? semester,
  String? courseName,
  String? professorName,
  int? grade,
  String? section,
  int? classId,
  Map<String, bool>? selectedItems,
}) async {
  print('======= PDF PREVIEW START =======');
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

    updateProgressState(0.0, 'PDF 미리보기 생성 시작');

    // PDF 생성
    final combinedPdfBytes = await UltraSimpleTemplate.generateCombinedPdf(
      year: year,
      semester: semester,
      courseName: courseName,
      professorName: professorName,
      grade: grade != null ? '${grade}학년' : '학년',
      section: section,
      classId: classId,
      updateProgressCallback: updateProgressState,
      selectedItems: selectedItems,
    );

    print('PDF 생성 완료: ${combinedPdfBytes.length} bytes');

    if (combinedPdfBytes.isEmpty) {
      throw Exception('PDF 생성 실패');
    }

    updateProgressState(0.95, 'PDF 미리보기 준비 중');

    if (kIsWeb && combinedPdfBytes.isNotEmpty) {
      print('======= PDF 미리보기 열기 =======');

      try {
        // Blob 생성
        final blob = html.Blob([combinedPdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);

        print('Blob URL 생성: $url');

        // 새 탭에서 PDF 열기
        final newWindow = html.window.open(url, '_blank');

        if (newWindow == null) {
          print('팝업이 차단되었습니다. 대체 방법 사용');

          // 팝업이 차단된 경우 현재 탭에서 열기
          final anchor = html.AnchorElement(href: url)
            ..target = '_blank'
            ..rel = 'noopener noreferrer';
          html.document.body?.append(anchor);
          anchor.click();
          anchor.remove();
        }

        updateProgressState(1.0, 'PDF 미리보기 완료');

        print('======= PDF PREVIEW SUCCESS =======');
      } catch (e) {
        print('PDF 미리보기 열기 실패: $e');
        rethrow;
      }
    } else {
      print('======= PDF PREVIEW FAILED =======');
      print('PDF empty: ${combinedPdfBytes.isEmpty}');
    }
  } catch (e) {
    print('======= PDF PREVIEW ERROR: $e =======');
    rethrow;
  }
}
