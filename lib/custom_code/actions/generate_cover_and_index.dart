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
import '/backend/combined_pdf_template.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

// PDF 다운로드 헬퍼 함수
Future<void> _downloadPdf(Uint8List pdfBytes, String fileName) async {
  if (kIsWeb && pdfBytes.isNotEmpty) {
    print('PDF 다운로드 시작: $fileName');
    
    final blob = html.Blob([pdfBytes], 'application/pdf');
    final dlUrl = html.Url.createObjectUrlFromBlob(blob);
    final a = html.document.createElement('a') as html.AnchorElement
      ..href = dlUrl
      ..download = fileName;
    a.click();
    html.Url.revokeObjectUrl(dlUrl);
    
    print('PDF 다운로드 완료: $fileName');
  } else {
    print('PDF 다운로드 실패: 비어있는 데이터');
  }
}
import 'dart:ui' as ui;

Future<void> generateCoverAndIndex({
  String? year,
  String? semester,
  String? courseName,
  String? professorName,
  int? grade,
  String? section,
  List<String>? additionalPdfUrls,
}) async {
  print('======= COMBINED PDF GENERATION START =======');
  print('전달된 데이터: year=$year, semester=$semester, courseName=$courseName, professorName=$professorName, grade=$grade, section=$section');
  
  try {
    // 1-3페이지: 표지 + INDEX + 분반별 섹션 생성
    final basePdfBytes = await CombinedPdfTemplate.generateCombinedPdf(
      year: year ?? '2025',
      semester: semester ?? '1학기',
      courseName: courseName ?? '과목명',
      professorName: professorName ?? '교수님',
      grade: grade != null ? '${grade}학년' : '학년',
      section: section ?? '분반',
    );
    
    print('1-3페이지 생성 완료: ${basePdfBytes.length} bytes');
    
    // 4페이지부터: URL에서 가져온 PDF들을 추가 병합
    if (additionalPdfUrls != null && additionalPdfUrls.isNotEmpty) {
      print('======= 4페이지부터 URL PDF 병합 시작 =======');
      
      final finalDoc = PdfDocument(inputBytes: basePdfBytes);
      
      // URL PDF들을 하나씩 추가
      for (int urlIndex = 0; urlIndex < additionalPdfUrls.length; urlIndex++) {
        final pdfUrl = additionalPdfUrls[urlIndex].trim();
        if (pdfUrl.isEmpty || pdfUrl.toLowerCase() == 'null') continue;
        
        print('추가 PDF ${urlIndex + 1} 다운로드 중: $pdfUrl');
        
        try {
          final resp = await http.get(Uri.parse(pdfUrl)).timeout(const Duration(minutes: 2));
          
          if (resp.statusCode == 200) {
            final srcDoc = PdfDocument(inputBytes: resp.bodyBytes);
            
            // 각 페이지를 새로운 페이지로 추가
            for (int pageIndex = 0; pageIndex < srcDoc.pages.count; pageIndex++) {
              final template = srcDoc.pages[pageIndex].createTemplate();
              final newPage = finalDoc.pages.add();
              newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
            }
            
            srcDoc.dispose();
            print('URL PDF ${urlIndex + 1} 병합 완료');
          } else {
            print('URL PDF ${urlIndex + 1} 다운로드 실패: ${resp.statusCode}');
          }
        } catch (urlError) {
          print('URL PDF ${urlIndex + 1} 처리 오류: $urlError');
        }
      }
      
      final finalPdfBytes = await finalDoc.save();
      finalDoc.dispose();
      
      print('전체 PDF 병합 완료: ${finalPdfBytes.length} bytes');
      
      // 다운로드
      await _downloadPdf(finalPdfBytes, 'portfolio_with_additional_${DateTime.now().millisecondsSinceEpoch}.pdf');
    } else {
      print('추가 URL이 없어서 1-3페이지만 사용');
      
      // 다운로드
      await _downloadPdf(basePdfBytes, 'portfolio_base_${DateTime.now().millisecondsSinceEpoch}.pdf');
    }
    

  } catch (e) {
    print('======= COVER + INDEX PAGE ERROR: $e =======');
    rethrow;
  }
}