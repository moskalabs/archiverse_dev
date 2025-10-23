import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;

/// 학생별 기말결과물 표지 템플릿
class StudentFinalCoverTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 학생별 기말결과물 표지 페이지를 finalDoc에 추가
  static Future<void> addStudentCoverPage({
    required syncfusion.PdfDocument finalDoc,
    required String studentName,
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    String? studentGrade, // 학생 성적
  }) async {
    try {
      print('$studentName 기말결과물 표지 생성 시작');
      
      final font = await _loadMalgunGothicFont();
      
      // 학생별 표지 페이지 생성
      final coverDoc = pw.Document();
      coverDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
                marginLeft: 0,
                marginRight: 0,
                marginTop: 0,
                marginBottom: 0,
              ),
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(40),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 오른쪽 상단 년도/학기
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text(
                  '${year ?? '2024'}년도 ${semester ?? '1학기'}',
                  style: pw.TextStyle(
                    fontSize: 14,
                    color: PdfColors.black,
                    font: font,
                  ),
                ),
              ),
              
              pw.Spacer(flex: 2),
              
              // 과목명 (중앙 크게)
              pw.Center(
                child: pw.Text(
                  courseName ?? '건축설계 9',
                  style: pw.TextStyle(
                    fontSize: 48,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
              ),
              
              pw.Spacer(flex: 1),
              
              // 교수, 학년, 분반 정보
              pw.Text(
                '교수 ${professorName ?? '천준호'} | ${grade ?? '5학년'} ${section ?? '1분반'}',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                  font: font,
                ),
              ),
              
              pw.SizedBox(height: 10),
              
              pw.Text(
                '08 최종 결과물',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                  font: font,
                ),
              ),
              
              pw.Spacer(flex: 1),
              
              // 학생 정보 (이름과 학번)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    studentName,
                    style: pw.TextStyle(
                      fontSize: 20,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      font: font,
                    ),
                  ),
                  // 성적 표시 (있으면)
                  if (studentGrade != null && studentGrade.isNotEmpty)
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.red, width: 2),
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Text(
                        studentGrade,
                        style: pw.TextStyle(
                          fontSize: 24,
                          color: PdfColors.red,
                          fontWeight: pw.FontWeight.bold,
                          font: font,
                        ),
                      ),
                    ),
                ],
              ),
              
              pw.Spacer(flex: 2),
              
              // 하단 디자인 요소
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                  width: 200,
                  height: 100,
                  child: pw.Stack(
                    children: [
                      // 수평선들
                      ...List.generate(15, (i) {
                        final lineWidth = 200 * (1 - i / 15);
                        return pw.Positioned(
                          top: (100 / 15) * i,
                          left: 0,
                          child: pw.Container(
                            width: lineWidth,
                            height: 1,
                            color: PdfColors.grey300,
                          ),
                        );
                      }),
                      // 수직선들
                      ...List.generate(10, (i) {
                        final lineHeight = 100 * (1 - i / 10);
                        final leftPosition = 200 * 0.7 + (200 * 0.3 / 10) * i;
                        return pw.Positioned(
                          left: leftPosition,
                          top: 0,
                          child: pw.Container(
                            width: 1,
                            height: lineHeight,
                            color: PdfColors.grey300,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              // 하단 푸터
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10),
                child: pw.Text(
                  'Department of Architecture, Soonchunhyang Univ.',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey600,
                    font: font,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ));
      
      // 표지를 finalDoc에 추가
      final coverBytes = await coverDoc.save();
      final coverSyncDoc = syncfusion.PdfDocument(inputBytes: coverBytes);
      
      final coverSourcePage = coverSyncDoc.pages[0];
      final coverNewPage = finalDoc.pages.add();
      final coverTemplate = coverSourcePage.createTemplate();
      
      coverNewPage.graphics.drawPdfTemplate(coverTemplate, ui.Offset.zero);
      coverSyncDoc.dispose();
      
      print('$studentName 기말결과물 표지 생성 완료');
      
    } catch (e) {
      print('$studentName 기말결과물 표지 생성 실패: $e');
    }
  }
}