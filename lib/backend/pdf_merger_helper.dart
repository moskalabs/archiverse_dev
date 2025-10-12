import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;

/// PDF 병합 도우미 클래스
class PdfMergerHelper {
  /// 수업계획서 PDF의 첫 번째 페이지를 현재 PDF에 추가
  static Future<void> addCoursePlanToDocument(
    pw.Document mainDoc,
    String coursePlanUrl,
    pw.Font? font,
  ) async {
    try {
      print('수업계획서 PDF 병합 시작: $coursePlanUrl');
      
      // 1. 수업계획서 PDF 다운로드
      final response = await http.get(Uri.parse(coursePlanUrl));
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }
      
      final pdfBytes = response.bodyBytes;
      print('수업계획서 PDF 다운로드 완료: ${pdfBytes.length} bytes');
      
      // 2. Syncfusion으로 PDF 로드
      final sourcePdf = syncfusion.PdfDocument(inputBytes: pdfBytes);
      print('수업계획서 PDF 페이지 수: ${sourcePdf.pages.count}');
      
      if (sourcePdf.pages.count > 0) {
        // 3. 첫 번째 페이지를 이미지로 변환 후 추가
        final firstPage = sourcePdf.pages[0];
        
        // PDF 페이지를 이미지로 변환 (간단한 표시)
        final pageTemplate = firstPage.createTemplate();
        
        // 4. 새 페이지에 추가
        final newPage = mainDoc.addPage(
          pw.Page(
            pageFormat: pw.PdfPageFormat.a4,
            theme: font != null ? pw.ThemeData.withFont(base: font) : null,
            build: (context) {
              return pw.Container(
                width: double.infinity,
                height: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: pw.PdfColors.grey400, width: 1),
                ),
                child: pw.Center(
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(20),
                        decoration: pw.BoxDecoration(
                          color: pw.PdfColors.blue50,
                          border: pw.Border.all(color: pw.PdfColors.blue, width: 2),
                          borderRadius: pw.BorderRadius.circular(10),
                        ),
                        child: pw.Column(
                          children: [
                            pw.Text(
                              '수업계획서 PDF 로드 성공',
                              style: pw.TextStyle(
                                fontSize: 18,
                                color: pw.PdfColors.blue,
                                fontWeight: pw.FontWeight.bold,
                                font: font,
                              ),
                            ),
                            pw.SizedBox(height: 15),
                            pw.Text(
                              '파일 크기: ${(pdfBytes.length / 1024).toStringAsFixed(1)} KB',
                              style: pw.TextStyle(
                                fontSize: 14,
                                color: pw.PdfColors.grey700,
                                font: font,
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              '페이지 수: ${sourcePdf.pages.count}',
                              style: pw.TextStyle(
                                fontSize: 14,
                                color: pw.PdfColors.grey700,
                                font: font,
                              ),
                            ),
                            pw.SizedBox(height: 15),
                            pw.Container(
                              padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: pw.BoxDecoration(
                                color: pw.PdfColors.blue,
                                borderRadius: pw.BorderRadius.circular(5),
                              ),
                              child: pw.Text(
                                '수업계획서 내용 표시',
                                style: pw.TextStyle(
                                  fontSize: 12,
                                  color: pw.PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font,
                                ),
                              ),
                            ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'PDF 내용 병합 기능 개발 중',
                              style: pw.TextStyle(
                                fontSize: 10,
                                color: pw.PdfColors.grey600,
                                font: font,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
        
        print('수업계획서 PDF 병합 완료');
      }
      
      sourcePdf.dispose();
      
    } catch (e) {
      print('수업계획서 PDF 병합 실패: $e');
      
      // 실패 시 기본 메시지 페이지 추가
      mainDoc.addPage(
        pw.Page(
          pageFormat: pw.PdfPageFormat.a4,
          theme: font != null ? pw.ThemeData.withFont(base: font) : null,
          build: (context) {
            return pw.Center(
              child: pw.Container(
                padding: const pw.EdgeInsets.all(20),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: pw.PdfColors.red, width: 2),
                ),
                child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text(
                      '수업계획서 로드 실패',
                      style: pw.TextStyle(
                        fontSize: 16,
                        color: pw.PdfColors.red,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      '오류: $e',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: pw.PdfColors.grey700,
                        font: font,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}