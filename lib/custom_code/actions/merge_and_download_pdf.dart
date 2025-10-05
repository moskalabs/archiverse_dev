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

import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import '/backend/simple_pdf_test.dart';

Future<void> mergeAndDownloadPdf(
  List<String> pdfUrls, {
  String? year,
  String? semester,
  String? courseName,
  String? professorName,
  int? grade,
  String? section,
}) async {
  print('======= NEW PDF SYSTEM TEST =======');
  
  // 1_cover_page 템플릿 생성 및 다운로드
  try {
    final coverPdfBytes = await CoverPageTemplate.generateCoverPage(
      year: year ?? '2025',
      semester: semester ?? '1학기',
      courseName: courseName ?? '과목명',
      professorName: professorName ?? '교수님',
      grade: grade != null ? '${grade}학년' : '학년',
      section: section ?? '분반',
    );
    
    if (kIsWeb && coverPdfBytes.isNotEmpty) {
      final fileName = 'cover_page_template_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final blob = html.Blob([coverPdfBytes], 'application/pdf');
      final dlUrl = html.Url.createObjectUrlFromBlob(blob);
      final a = html.document.createElement('a') as html.AnchorElement
        ..href = dlUrl
        ..download = fileName;
      a.click();
      html.Url.revokeObjectUrl(dlUrl);
      
      print('======= COVER PAGE TEMPLATE SUCCESS =======');
      return; // 새 템플릿 성공 시 기존 로직 건너뛰기
    }
  } catch (e) {
    print('======= COVER PAGE ERROR: $e =======');
  }
  
  print('======= FALLBACK TO EXISTING LOGIC =======');
  final Set<String> seen = <String>{};
  final List<String> sanitizedUrls = [];

  for (final rawUrl in pdfUrls) {
    final trimmed = rawUrl.trim();
    if (trimmed.isEmpty || trimmed.toLowerCase() == 'null') {
      continue;
    }
    if (seen.add(trimmed)) {
      sanitizedUrls.add(trimmed);
    }
  }

  if (sanitizedUrls.isEmpty) {
    print('[mergeAndDownloadPdf] 병합할 PDF URL이 없습니다.');
    return;
  }

  final PdfDocument finalDoc = PdfDocument();
  Uint8List? outputBytes;
  final int totalFiles = sanitizedUrls.length;

  double _progressValue(int processed) {
    if (totalFiles <= 0) {
      return 0.0;
    }
    final double value = processed / totalFiles;
    if (value.isNaN) {
      return 0.0;
    }
    return value.clamp(0.0, 1.0);
  }

  void updateProgress(int processedCount, String message) {
    FFAppState().update(() {
      FFAppState().downloadProgress = _progressValue(processedCount);
      FFAppState().downloadProgressMessage = message;
    });
  }

  updateProgress(0, '총 $totalFiles개 파일 다운로드 준비 중');

  try {
    finalDoc.pageSettings.margins.all = 0;

    for (int index = 0; index < totalFiles; index++) {
      final displayIndex = index + 1;
      final trimmedUrl = sanitizedUrls[index];

      updateProgress(index, '파일 $displayIndex / $totalFiles 다운로드 중');

      PdfDocument? src;
      try {
        final resp = await http
            .get(Uri.parse(trimmedUrl))
            .timeout(const Duration(minutes: 2));

        if (resp.statusCode != 200) {
          print('[mergeAndDownloadPdf] 다운로드 실패: $trimmedUrl');
          updateProgress(
            displayIndex,
            '파일 $displayIndex / $totalFiles 다운로드 실패',
          );
          continue;
        }

        src = PdfDocument(inputBytes: resp.bodyBytes);
        if (src.pages.count > 0) {
          for (int pageIndex = 0; pageIndex < src.pages.count; pageIndex++) {
            final template = src.pages[pageIndex].createTemplate();
            finalDoc.pageSettings.size = template.size;
            final newPage = finalDoc.pages.add();
            newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
          }
        }

        updateProgress(
          displayIndex,
          '파일 $displayIndex / $totalFiles 병합 완료',
        );
      } catch (error) {
        print('[mergeAndDownloadPdf] 파일 처리 오류 ($trimmedUrl): $error');
        updateProgress(
          displayIndex,
          '파일 $displayIndex / $totalFiles 처리 중 오류',
        );
      } finally {
        src?.dispose();
      }
    }

    if (finalDoc.pages.count == 0) {
      throw Exception('병합할 PDF 페이지가 없습니다.');
    }

    updateProgress(totalFiles, 'PDF 파일 생성 중');
    outputBytes = Uint8List.fromList(await finalDoc.save());
    updateProgress(totalFiles, 'PDF 다운로드 준비 완료');
  } catch (e) {
    updateProgress(totalFiles, 'PDF 병합 중 오류가 발생했습니다');
    print('[mergeAndDownloadPdf] 오류: $e');
    throw Exception('PDF 병합 중 오류가 발생했습니다: $e');
  } finally {
    finalDoc.dispose();
  }

  if (!kIsWeb || outputBytes == null) {
    return;
  }

  final fileName =
      'class_portfolio_${DateTime.now().millisecondsSinceEpoch}.pdf';
  final blob = html.Blob([outputBytes], 'application/pdf');
  final dlUrl = html.Url.createObjectUrlFromBlob(blob);
  final a = html.document.createElement('a') as html.AnchorElement
    ..href = dlUrl
    ..download = fileName;
  a.click();
  html.Url.revokeObjectUrl(dlUrl);
}
