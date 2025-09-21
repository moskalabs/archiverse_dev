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
import 'dart:ui' show Offset, Size;

Future<void> mergeAndDownloadPdf(List<String> pdfUrls) async {
  if (pdfUrls.isEmpty) {
    print('[mergeAndDownloadPdf] 병합할 PDF URL이 없습니다.');
    return;
  }

  final PdfDocument finalDoc = PdfDocument();
  final Map<String, PdfSection> _sectionCache = <String, PdfSection>{};
  Uint8List? outputBytes;
  final int totalFiles = pdfUrls.length;

  String _sectionKey(Size size) =>
      '${size.width.toStringAsFixed(3)}x${size.height.toStringAsFixed(3)}';

  PdfSection _resolveSection(Size pageSize) {
    final String key = _sectionKey(pageSize);
    final PdfSection? existing = _sectionCache[key];
    if (existing != null) {
      return existing;
    }

    final PdfSection section = finalDoc.sections.add();
    section.pageSettings.margins.all = 0;
    section.pageSettings.size = pageSize;
    _sectionCache[key] = section;
    return section;
  }

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
      final url = pdfUrls[index];
      final trimmedUrl = url.trim();

      updateProgress(index, '파일 $displayIndex / $totalFiles 다운로드 중');

      if (trimmedUrl.isEmpty) {
        print('[mergeAndDownloadPdf] 빈 URL 건너뜀: index $index');
        updateProgress(
          displayIndex,
          '파일 $displayIndex / $totalFiles 건너뜀',
        );
        continue;
      }

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
            final PdfPage srcPage = src.pages[pageIndex];
            final Size pageSize =
                Size(srcPage.size.width, srcPage.size.height);

            final PdfSection targetSection = _resolveSection(pageSize);
            final PdfPage dstPage = targetSection.pages.add();
            dstPage.rotation = srcPage.rotation;

            final PdfTemplate template = srcPage.createTemplate();
            dstPage.graphics.drawPdfTemplate(
              template,
              Offset.zero,
              pageSize,
            );
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
