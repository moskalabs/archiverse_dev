import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

/// INDEX 페이지 템플릿
class IndexPageTemplate {
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
  
  static Future<Uint8List> generateIndexPage({
    String? courseName,
    String? professorName,
    String? section,
  }) async {
    print('INDEX 페이지 생성 시작');
    
    // 기본값 설정
    final displayCourseName = courseName ?? '과목명';
    final displayProfessorName = professorName ?? '교수명';
    final displaySection = section ?? '분반';
    
    final pdf = pw.Document();
    
    // 맑은 고딕 폰트 로드
    final font = await _loadMalgunGothicFont();
    print('INDEX 페이지 - 맑은 고딕 폰트 로드 결과: ${font != null ? '성공' : '실패 - 기본 폰트 사용'}');

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(40),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // INDEX 타이틀
                pw.Center(
                  child: pw.Text(
                    'INDEX',
                    style: pw.TextStyle(
                      fontSize: 36,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      font: font,
                    ),
                  ),
                ),
                
                pw.SizedBox(height: 40),
                
                // 과목명 섹션
                pw.Text(
                  displayCourseName,
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
                
                pw.SizedBox(height: 8),
                
                pw.Text(
                  '과제의 기초',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    font: font,
                  ),
                ),
                
                pw.Text(
                  '과제와 주요 설계 요약',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    font: font,
                  ),
                ),
                
                pw.Text(
                  '공통 주제별 결과 제시서',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    font: font,
                  ),
                ),
                
                pw.SizedBox(height: 30),
                
                // 교수 및 분반 섹션
                pw.Text(
                  '$displayProfessorName 교수 / $displaySection',
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
                
                pw.SizedBox(height: 20),
                
                // 목차 리스트
                pw.Text('01 수업계획서', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('02 출석부', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('03 성적기록표', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('04 학생 작품 평가표', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('05 강의자료', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('06 주차별 설계 진행표', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('07 중간 결과물', style: pw.TextStyle(fontSize: 12, font: font)),
                pw.SizedBox(height: 5),
                pw.Text('08 최종 결과물', style: pw.TextStyle(fontSize: 12, font: font)),
              ],
            ),
          );
        },
      ),
    );

    print('INDEX 페이지 생성 완료');
    return pdf.save();
  }
}