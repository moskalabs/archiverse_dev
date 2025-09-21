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

Future<void> mergeAndDownloadPdf(List<String> pdfUrls) async {
  final List<String> validUrls = pdfUrls
      .map((url) => url.trim())
      .where((url) => url.isNotEmpty)
      .toList();

  if (validUrls.isEmpty) {
    print('[mergeAndDownloadPdf] 병합할 PDF URL이 없습니다.');
    return;
  }

  final PdfDocument finalDoc = PdfDocument();
  Uint8List? outputBytes;
  final int totalFiles = validUrls.length;
  bool appendedAnyPage = false;

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
    for (int index = 0; index < totalFiles; index++) {
      final displayIndex = index + 1;
      final url = validUrls[index];

      updateProgress(index, '파일 $displayIndex / $totalFiles 다운로드 중');

      PdfDocument? currentDoc;
      try {
        final resp = await http
            .get(Uri.parse(url))
            .timeout(const Duration(minutes: 2));

        if (resp.statusCode != 200) {
          print('[mergeAndDownloadPdf] 다운로드 실패: $url');
          updateProgress(
            displayIndex,
            '파일 $displayIndex / $totalFiles 다운로드 실패',
          );
          continue;
        }

        currentDoc = PdfDocument(inputBytes: resp.bodyBytes);
        if (currentDoc.pages.count == 0) {
          updateProgress(
            displayIndex,
            '파일 $displayIndex / $totalFiles 빈 문서 건너뜀',
          );
          continue;
        }

        for (int pageIndex = 0; pageIndex < currentDoc.pages.count; pageIndex++) {
          final PdfPage srcPage = currentDoc.pages[pageIndex];
          final PdfTemplate template = srcPage.createTemplate();

          finalDoc.pageSettings
            ..margins.all = 0
            ..size = Size(srcPage.size.width, srcPage.size.height);

          final PdfPage dstPage = finalDoc.pages.add()
            ..rotation = srcPage.rotation;

          dstPage.graphics.drawPdfTemplate(
            template,
            Offset.zero,
            Size(srcPage.size.width, srcPage.size.height),
          );

          appendedAnyPage = true;
        }

        updateProgress(
          displayIndex,
          '파일 $displayIndex / $totalFiles 병합 완료',
        );
      } catch (error) {
        print('[mergeAndDownloadPdf] 파일 처리 오류 ($url): $error');
        updateProgress(
          displayIndex,
          '파일 $displayIndex / $totalFiles 처리 중 오류',
        );
      } finally {
        currentDoc?.dispose();
      }
    }

    if (!appendedAnyPage || finalDoc.pages.count == 0) {
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
