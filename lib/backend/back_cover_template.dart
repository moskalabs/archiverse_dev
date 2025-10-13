import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;

/// 뒷표지 템플릿 (첫 표지와 동일한 네이비 블루 스타일)
class BackCoverTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 뒷표지 페이지를 finalDoc에 추가
  static Future<void> addBackCover({
    required syncfusion.PdfDocument finalDoc,
    required Function(double, String) updateProgress,
    double startProgress = 0.99,
    double endProgress = 1.0,
  }) async {
    try {
      print('======= 뒷표지 생성 시작 =======');
      updateProgress(startProgress, '뒷표지 생성 중');
      
      final font = await _loadMalgunGothicFont();
      
      // 뒷표지 페이지 생성 (스크린샷과 동일한 스타일)
      final backCoverDoc = pw.Document();
      backCoverDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)), // 네이비 블루
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Spacer(),
                  
                  // 하단 텍스트
                  pw.Align(
                    alignment: pw.Alignment.bottomRight,
                    child: pw.Text(
                      'Department of Architecture, Soonchunhyang Univ.',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.white,
                        font: font,
                      ),
                    ),
                  ),
                  
                  pw.SizedBox(height: 20),
                  
                  // 하단 디자인 요소 (수평선들)
                  pw.Container(
                    width: double.infinity,
                    height: 80,
                    child: pw.Stack(
                      children: [
                        // 수평선들 (스크린샷처럼 주황색 계열)
                        ...List.generate(12, (i) {
                          return pw.Positioned(
                            bottom: i * 6.0,
                            left: 0,
                            right: 0,
                            child: pw.Container(
                              height: 3,
                              color: PdfColor.fromInt(0xFFE87722), // 주황색
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
      
      // 뒷표지를 finalDoc에 추가
      final backCoverBytes = await backCoverDoc.save();
      final backCoverSyncDoc = syncfusion.PdfDocument(inputBytes: backCoverBytes);
      
      final backCoverSourcePage = backCoverSyncDoc.pages[0];
      final backCoverNewPage = finalDoc.pages.add();
      final backCoverTemplate = backCoverSourcePage.createTemplate();
      
      final pageWidth = backCoverNewPage.getClientSize().width;
      final pageHeight = backCoverNewPage.getClientSize().height;
      
      backCoverNewPage.graphics.drawPdfTemplate(
        backCoverTemplate,
        ui.Offset.zero,
        ui.Size(pageWidth, pageHeight)
      );
      
      backCoverSyncDoc.dispose();
      
      updateProgress(endProgress, '뒷표지 완료');
      print('======= 뒷표지 생성 완료 =======');
      
    } catch (e) {
      print('뒷표지 생성 실패: $e');
      updateProgress(endProgress, '뒷표지 생성 실패');
    }
  }
}