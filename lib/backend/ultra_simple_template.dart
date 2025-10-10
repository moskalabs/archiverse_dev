import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;
import '/backend/supabase/supabase.dart';

/// 매우 간단한 4페이지 PDF 템플릿 (마진만 적용)
class UltraSimpleTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      return null;
    }
  }
  
  static Future<Uint8List> generateCombinedPdf({
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    int? classId,
  }) async {
    print('Ultra Simple PDF 생성 시작');
    
    final displayYear = year ?? '2025';
    final displaySemester = semester ?? '1학기';
    final displayCourseName = courseName ?? '과목명';
    final displayProfessorName = professorName ?? '교수명';
    final displayGrade = grade ?? '학년';
    final displaySection = section ?? '분반';
    
    // 수업계획서 URL 찾기
    String? coursePlanUrl;
    if (classId != null) {
      try {
        final coursePlans = await CourseplanTable().queryRows(
          queryFn: (q) => q.eq('class', classId),
        );
        for (final plan in coursePlans) {
          if (plan.section == displaySection) {
            coursePlanUrl = plan.url;
            break;
          }
        }
        print('수업계획서 URL: $coursePlanUrl');
      } catch (e) {
        print('수업계획서 URL 조회 실패: $e');
      }
    }

    // 최종 PDF 문서
    final finalDoc = syncfusion.PdfDocument();
    
    try {
      // 1. 기본 4페이지 템플릿 생성
      final templateDoc = pw.Document();
      final font = await _loadMalgunGothicFont();
      
      // 표지
      templateDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Container(
          decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(40),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(children: [
                  pw.Container(
                    width: 70, height: 70,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.white,
                      borderRadius: pw.BorderRadius.circular(15),
                    ),
                    child: pw.Center(child: pw.Text('SA', style: pw.TextStyle(
                      fontSize: 28, fontWeight: pw.FontWeight.bold,
                      color: const PdfColor.fromInt(0xFF273F5F), font: font,
                    ))),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('순천향대학교 건축학과', style: pw.TextStyle(
                        fontSize: 18, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                      )),
                      pw.SizedBox(height: 8),
                      pw.Text('Department of Architecture', style: pw.TextStyle(
                        fontSize: 12, color: PdfColors.white, font: font,
                      )),
                    ],
                  ),
                ]),
                pw.Spacer(flex: 2),
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                    fontSize: 18, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                  )),
                ),
                pw.Spacer(flex: 1),
                pw.Center(child: pw.Text(displayCourseName, style: pw.TextStyle(
                  fontSize: 48, color: PdfColors.white, fontWeight: pw.FontWeight.bold, letterSpacing: 3, font: font,
                ))),
                pw.Spacer(flex: 2),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('교수: $displayProfessorName', style: pw.TextStyle(
                      fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                    )),
                    pw.SizedBox(height: 12),
                    pw.Text('$displayGrade $displaySection', style: pw.TextStyle(
                      fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ));

      // INDEX
      templateDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(40),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Center(child: pw.Text('INDEX', style: pw.TextStyle(
                fontSize: 36, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
              ))),
              pw.SizedBox(height: 40),
              pw.Text(displayCourseName, style: pw.TextStyle(
                fontSize: 18, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
              )),
              pw.SizedBox(height: 8),
              pw.Text('과제의 기초', style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700, font: font)),
              pw.Text('과제와 주요 설계 요약', style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700, font: font)),
              pw.Text('공통 주제별 결과 제시서', style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700, font: font)),
              pw.SizedBox(height: 30),
              pw.Text('$displayProfessorName 교수 / $displaySection', style: pw.TextStyle(
                fontSize: 18, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
              )),
              pw.SizedBox(height: 20),
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
        ),
      ));

      // 섹션 구분자
      templateDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(40),
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Container(width: 400, height: 2, decoration: const pw.BoxDecoration(color: PdfColors.black)),
              pw.SizedBox(height: 40),
              pw.Text('$displayCourseName / $displaySection / 담당교수 $displayProfessorName', 
                style: pw.TextStyle(fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 40),
              pw.Container(width: 400, height: 2, decoration: const pw.BoxDecoration(color: PdfColors.black)),
            ],
          ),
        ),
      ));

      // 수업계획서 템플릿
      templateDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(30),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(children: [
                    pw.Container(
                      width: 40, height: 30,
                      decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                      child: pw.Center(child: pw.Text('01', style: pw.TextStyle(
                        fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                      ))),
                    ),
                    pw.SizedBox(width: 15),
                    pw.Text('수업계획서', style: pw.TextStyle(
                      fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                    )),
                  ]),
                  pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                    fontSize: 14, color: PdfColors.black, font: font,
                  )),
                ],
              ),
              pw.SizedBox(height: 30),
              pw.Expanded(
                child: pw.Container(
                  width: double.infinity,
                  decoration: pw.BoxDecoration(border: pw.Border.all(color: PdfColors.grey400, width: 1)),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Center(
                      child: pw.Text(
                        coursePlanUrl != null 
                          ? '수업계획서 PDF 발견\n다음 페이지부터 실제 내용 표시 (마진 적용)\n\nURL: $coursePlanUrl'
                          : '수업계획서를 찾을 수 없습니다.',
                        style: pw.TextStyle(fontSize: 12, color: PdfColors.blue, font: font),
                        textAlign: pw.TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ));

      // 2. 템플릿을 Syncfusion에 추가
      final templateBytes = await templateDoc.save();
      final templateSyncDoc = syncfusion.PdfDocument(inputBytes: templateBytes);
      
      for (int i = 0; i < templateSyncDoc.pages.count; i++) {
        final sourcePage = templateSyncDoc.pages[i];
        final newPage = finalDoc.pages.add();
        final template = sourcePage.createTemplate();
        newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
        print('템플릿 페이지 ${i + 1} 추가');
      }
      templateSyncDoc.dispose();
      
      // 3. 수업계획서 PDF 병합 (마진 적용)
      if (coursePlanUrl != null && coursePlanUrl!.isNotEmpty) {
        try {
          print('수업계획서 PDF 병합 시작');
          
          final response = await http.get(Uri.parse(coursePlanUrl!));
          if (response.statusCode == 200) {
            final coursePdfBytes = response.bodyBytes;
            final courseDoc = syncfusion.PdfDocument(inputBytes: coursePdfBytes);
            
            print('수업계획서 페이지 수: ${courseDoc.pages.count}');
            
            for (int i = 0; i < courseDoc.pages.count; i++) {
              final sourcePage = courseDoc.pages[i];
              final newPage = finalDoc.pages.add();
              final template = sourcePage.createTemplate();
              
              // 간단한 마진 적용 (잘림 방지)
              final margin = 25.0;
              newPage.graphics.drawPdfTemplate(template, ui.Offset(margin, margin));
              
              print('수업계획서 페이지 ${i + 1} 병합 완료 (마진: ${margin}px)');
            }
            
            courseDoc.dispose();
            print('수업계획서 PDF 병합 완료');
          }
        } catch (e) {
          print('수업계획서 병합 실패: $e');
        }
      }
      
      final finalBytes = await finalDoc.save();
      finalDoc.dispose();
      
      print('최종 PDF 생성 완료 - 총 페이지: ${finalDoc.pages.count}');
      return Uint8List.fromList(finalBytes);
      
    } catch (e) {
      print('PDF 생성 오류: $e');
      finalDoc.dispose();
      
      // 오류 시 기본 PDF 반환
      final errorDoc = pw.Document();
      errorDoc.addPage(pw.Page(
        build: (context) => pw.Center(
          child: pw.Text('PDF 생성 오류: $e', style: pw.TextStyle(fontSize: 14, color: PdfColors.red)),
        ),
      ));
      return errorDoc.save();
    }
  }
}