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
import 'dart:ui' as ui;
import '/backend/four_page_pdf_template.dart';
import 'package:pdf/pdf.dart' as pdf_lib;
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

Future<void> generateFullPortfolio({
  String? year,
  String? semester,
  String? courseName,
  String? professorName,
  int? grade,
  String? section,
}) async {
  print('======= FULL PORTFOLIO GENERATION START =======');
  print('전달된 데이터: year=$year, semester=$semester, courseName=$courseName, professorName=$professorName, grade=$grade, section=$section');
  
  try {
    // 1. 기본 3페이지 생성 (표지 + INDEX + 분반구분)
    final basicThreePageBytes = await FourPagePdfTemplate.generateFourPagePdf(
      year: year ?? '2025',
      semester: semester ?? '1학기',
      courseName: courseName ?? '과목명',
      professorName: professorName ?? '교수님',
      grade: grade != null ? '${grade}학년' : '학년',
      section: section ?? '분반',
      coursePlanData: [], // 기본 페이지에는 빈 데이터
    );
    
    print('기본 3페이지 생성 완료: ${basicThreePageBytes.length} bytes');
    
    // 2. 수업계획서 데이터 가져오기
    final classId = FFAppState().classSelectedID;
    List<String> coursePlanUrls = [];
    
    if (classId > 0) {
      final coursePlanRows = await getCoursePlan(
        classId: classId,
        year: year,
        semester: semester,
      );
      
      coursePlanUrls = coursePlanRows
          .where((row) => row.url != null && row.url!.isNotEmpty)
          .map((row) => row.url!)
          .toList();
      
      print('수업계획서 URL들: ${coursePlanUrls.length}개');
      for (final url in coursePlanUrls) {
        print('URL: $url');
      }
    }
    
    // 3. 최종 PDF 문서 생성
    final finalDoc = PdfDocument();
    
    try {
      // 3-1. 기본 3페이지 추가 (표지 + INDEX + 분반구분)
      final basicDoc = PdfDocument(inputBytes: basicThreePageBytes);
      for (int i = 0; i < basicDoc.pages.count; i++) {
        final template = basicDoc.pages[i].createTemplate();
        final newPage = finalDoc.pages.add();
        newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
      }
      basicDoc.dispose();
      print('기본 3페이지 병합 완료');
      
      // 3-2. 수업계획서 구분 페이지 추가
      await _addCoursePlanDividerPage(finalDoc, year, semester, courseName, professorName, grade?.toString(), section);
      
      // 3-3. 실제 수업계획서 PDF들 다운로드 및 병합
      if (coursePlanUrls.isNotEmpty) {
        for (int urlIndex = 0; urlIndex < coursePlanUrls.length; urlIndex++) {
          final url = coursePlanUrls[urlIndex];
          print('수업계획서 PDF 다운로드 시작: $url');
          
          try {
            final response = await http.get(Uri.parse(url)).timeout(const Duration(minutes: 2));
            
            if (response.statusCode == 200) {
              final coursePlanDoc = PdfDocument(inputBytes: response.bodyBytes);
              
              // 각 페이지를 최종 문서에 추가
              for (int pageIndex = 0; pageIndex < coursePlanDoc.pages.count; pageIndex++) {
                final template = coursePlanDoc.pages[pageIndex].createTemplate();
                final newPage = finalDoc.pages.add();
                newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
              }
              
              coursePlanDoc.dispose();
              print('수업계획서 PDF ${urlIndex + 1} 병합 완료: ${coursePlanDoc.pages.count}페이지');
            } else {
              print('수업계획서 PDF 다운로드 실패: $url (상태코드: ${response.statusCode})');
            }
          } catch (e) {
            print('수업계획서 PDF 처리 오류: $url - $e');
          }
        }
      } else {
        print('수업계획서 URL이 없습니다.');
      }
      
      // 4. 최종 PDF 저장 및 다운로드
      final finalPdfBytes = await finalDoc.save();
      print('최종 PDF 생성 완료: ${finalPdfBytes.length} bytes, 총 ${finalDoc.pages.count}페이지');
      
      if (kIsWeb && finalPdfBytes.isNotEmpty) {
        final fileName = 'full_portfolio_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final blob = html.Blob([finalPdfBytes], 'application/pdf');
        final dlUrl = html.Url.createObjectUrlFromBlob(blob);
        final a = html.document.createElement('a') as html.AnchorElement
          ..href = dlUrl
          ..download = fileName;
        a.click();
        html.Url.revokeObjectUrl(dlUrl);
        
        print('======= FULL PORTFOLIO SUCCESS =======');
        print('파일명: $fileName');
        print('총 페이지 수: ${finalDoc.pages.count}');
      }
      
    } finally {
      finalDoc.dispose();
    }
    
  } catch (e) {
    print('======= FULL PORTFOLIO ERROR: $e =======');
    rethrow;
  }
}

// 수업계획서 구분 페이지 추가 함수
Future<void> _addCoursePlanDividerPage(
  PdfDocument doc, 
  String? year, 
  String? semester, 
  String? courseName, 
  String? professorName, 
  String? grade, 
  String? section
) async {
  // 폰트 로드
  pw.Font? font;
  try {
    final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
    font = pw.Font.ttf(fontData);
  } catch (e) {
    print('맑은 고딕 폰트 로드 실패: $e');
    font = null;
  }
  final displayYear = year ?? '2025';
  final displaySemester = semester ?? '1학기';
  final displayCourseName = courseName ?? '과목명';
  final displayProfessorName = professorName ?? '교수명';
  final displayGrade = grade ?? '학년';
  final displaySection = section ?? '분반';
  
  // pw.Document를 임시로 만들어서 페이지 생성
  final tempDoc = pw.Document();
  
  tempDoc.addPage(
    pw.Page(
      pageFormat: pdf_lib.PdfPageFormat.a4,
      theme: font != null ? pw.ThemeData.withFont(base: font) : null,
      build: (context) {
        return pw.Container(
          color: const pdf_lib.PdfColor.fromInt(0xFFFFFFFF),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(30),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // 상단 "01 수업계획서" 및 년도/학기
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: pw.BoxDecoration(
                        color: const pdf_lib.PdfColor.fromInt(0xFF273F5F), // 네이비 블루
                        borderRadius: pw.BorderRadius.circular(5),
                      ),
                      child: pw.Text(
                        '01',
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: const pdf_lib.PdfColor.fromInt(0xFFFFFFFF),
                          fontWeight: pw.FontWeight.bold,
                          font: font,
                        ),
                      ),
                    ),
                    pw.Text(
                      '수업계획서',
                      style: pw.TextStyle(
                        fontSize: 24,
                        color: const pdf_lib.PdfColor.fromInt(0xFF000000),
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                    pw.Text(
                      '$displayYear년도 $displaySemester',
                      style: pw.TextStyle(
                        fontSize: 14,
                        color: const pdf_lib.PdfColor.fromInt(0xFF666666),
                        font: font,
                      ),
                    ),
                  ],
                ),
                
                pw.Spacer(),
                
                // 하단 대학 정보 (동적 학년 포함)
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      '순천향대학교 건축학과(${displayGrade.replaceAll('학년', '')})',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: const pdf_lib.PdfColor.fromInt(0xFF666666),
                        font: font,
                      ),
                    ),
                    pw.Text(
                      '$displayCourseName (${displayGrade.replaceAll('학년', '')}학년) | 교수: $displayProfessorName',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: const pdf_lib.PdfColor.fromInt(0xFF666666),
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
  
  // 임시 문서에서 Syncfusion 문서로 페이지 복사
  final tempBytes = await tempDoc.save();
  final tempSyncDoc = PdfDocument(inputBytes: tempBytes);
  
  final template = tempSyncDoc.pages[0].createTemplate();
  final newPage = doc.pages.add();
  newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
  
  tempSyncDoc.dispose();
}