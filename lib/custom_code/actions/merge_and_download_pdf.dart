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

const String _indexPdfUrl =
    'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/pdfdefault/02.PDF_INDEX.pdf';

Future<void> mergeAndDownloadPdf(List<String> pdfUrls) async {
  final List<String> normalizedUrls = <String>[];
  for (final String url in pdfUrls) {
    final String trimmed = url.trim();
    if (trimmed.isNotEmpty) {
      normalizedUrls.add(trimmed);
    }
  }

  final bool alreadyContainsIndex =
      normalizedUrls.any((String url) => url == _indexPdfUrl);
  if (!alreadyContainsIndex) {
    if (normalizedUrls.isEmpty) {
      normalizedUrls.add(_indexPdfUrl);
    } else {
      normalizedUrls.insert(1, _indexPdfUrl);
    }
  }

  final PdfDocument finalDoc = PdfDocument();
  try {
    // 기본 여백 제거 (새로 추가되는 페이지들에 적용)
    finalDoc.pageSettings.margins.all = 0;
    for (final String url in normalizedUrls) {
      final resp = await http.get(Uri.parse(url));
      if (resp.statusCode != 200) {
        print('[mergeAndDownloadPdf] 다운로드 실패: $url (${resp.statusCode})');
        continue;
      }
      // 원본 PDF 로드
      final PdfDocument src = PdfDocument(inputBytes: resp.bodyBytes);
      for (int i = 0; i < src.pages.count; i++) {
        final PdfPage srcPage = src.pages[i];
        // ✅ 페이지 추가하기 전에, 다음에 생성될 페이지의 크기를 원본과 동일하게 설정
        finalDoc.pageSettings.size =
            Size(srcPage.size.width, srcPage.size.height);
        // 이제 add() 하면 위 설정이 적용된 페이지가 생성됨
        final PdfPage dstPage = finalDoc.pages.add();
        // 회전은 페이지에 직접 복사 (이 속성은 set 가능)
        dstPage.rotation = srcPage.rotation;
        // 템플릿을 (0,0) 위치에 원본 사이즈 그대로 그리기 (스케일 없음)
        final PdfTemplate tpl = srcPage.createTemplate();
        dstPage.graphics.drawPdfTemplate(tpl, Offset.zero, srcPage.size);
      }
      src.dispose();
    }
    final bytes = await finalDoc.save();
    finalDoc.dispose();
    if (kIsWeb) {
      final blob = html.Blob([Uint8List.fromList(bytes)], 'application/pdf');
      final dlUrl = html.Url.createObjectUrlFromBlob(blob);
      final a = html.document.createElement('a') as html.AnchorElement
        ..href = dlUrl
        ..download =
            'merged_document_${DateTime.now().millisecondsSinceEpoch}.pdf';
      a.click();
      html.Url.revokeObjectUrl(dlUrl);
    }
  } catch (e) {
    print('[mergeAndDownloadPdf] 오류: $e');
    rethrow;
  }
}
