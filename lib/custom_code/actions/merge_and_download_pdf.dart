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
  if (pdfUrls.isEmpty) {
    print('[mergeAndDownloadPdf] 병합할 PDF URL이 없습니다.');
    return;
  }

  final PdfDocument finalDoc = PdfDocument();
  Uint8List? outputBytes;
  int processedFiles = 0;
  final int totalFiles = pdfUrls.length;

  try {
    for (final url in pdfUrls) {
      final trimmedUrl = url.trim();
      if (trimmedUrl.isEmpty) {
        print('[mergeAndDownloadPdf] 빈 URL 건너뜀');
        continue;
      }

      processedFiles++;
      print('Processing file $processedFiles of $totalFiles');

      final resp = await http
          .get(Uri.parse(trimmedUrl))
          .timeout(const Duration(minutes: 2));

      if (resp.statusCode != 200) {
        print('[mergeAndDownloadPdf] 다운로드 실패: $trimmedUrl');
        continue;
      }

      final PdfDocument src = PdfDocument(inputBytes: resp.bodyBytes);
      if (src.pages.count > 0) {
        finalDoc.importPageRange(src, 0, src.pages.count - 1);
      }
      src.dispose();
    }

    if (finalDoc.pages.count == 0) {
      throw Exception('병합할 PDF 페이지가 없습니다.');
    }

    outputBytes = Uint8List.fromList(await finalDoc.save());
  } catch (e) {
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
