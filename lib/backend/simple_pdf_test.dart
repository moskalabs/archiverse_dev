import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 1번 템플릿: 표지 페이지
class CoverPageTemplate {
  /// 맑은 고딕 폰트 로드
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  static Future<Uint8List> generateCoverPage({
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
  }) async {
    // 기본값 설정 (데이터가 없을 때)
    final displayYear = year ?? '2025';
    final displaySemester = semester ?? '1학기';
    final displayCourseName = courseName ?? '건축설계 9';
    final displayProfessorName = professorName ?? '천준호';
    final displayGrade = grade ?? '5학년';
    final displaySection = section ?? '1분반';
    final pdf = pw.Document();
    
    // 맑은 고딕 폰트 로드
    final font = await _loadMalgunGothicFont();
    print('맑은 고딕 폰트 로드 결과: ${font != null ? '성공' : '실패 - 기본 폰트 사용'}');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) {
          return pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColor.fromInt(0xFF273F5F), // 스크린샷의 네이비 블루 색상
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // 상단 로고 및 대학 정보 (두 번째 스크린샷 스타일)
                  pw.Row(
                    children: [
                      pw.Container(
                        width: 70,
                        height: 70,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(15),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'SA',
                            style: pw.TextStyle(
                              fontSize: 28,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xFF273F5F),
                              font: font,
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '순천향대학교 건축학과',
                            style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            'Department of Architecture',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                              font: font,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  pw.Spacer(flex: 2),
                  
                  // 년도 학기 정보
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      '$displayYear년도 $displaySemester',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                  ),
                  
                  pw.Spacer(flex: 1),
                  
                  // 메인 과목명 (두 번째 스크린샷 스타일)
                  pw.Center(
                    child: pw.Text(
                      displayCourseName,
                      style: pw.TextStyle(
                        fontSize: 48,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        letterSpacing: 3,
                        font: font,
                      ),
                    ),
                  ),
                  
                  pw.Spacer(flex: 2),
                  
                  // 하단 정보 (두 번째 스크린샷 스타일)
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '교수: $displayProfessorName',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                          font: font,
                        ),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text(
                        '$displayGrade $displaySection',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                          font: font,
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}