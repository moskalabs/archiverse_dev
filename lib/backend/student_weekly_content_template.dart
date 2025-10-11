import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '/backend/supabase/supabase.dart';

/// 학생별 주차별 설계진행표 콘텐츠 템플릿 (1주차~15주차)
class StudentWeeklyContentTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 한 학생의 1주차~15주차 자료를 모두 추가
  static Future<void> addStudentWeeklyContent({
    required syncfusion.PdfDocument finalDoc,
    required String studentName,
    required int classId,
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    required Function(double, String) updateProgress,
    double startProgress = 0.0,
    double endProgress = 1.0,
  }) async {
    try {
      print('======= $studentName 주차별 자료 추가 시작 =======');
      
      final font = await _loadMalgunGothicFont();
      
      // subjectportpolio 테이블에서 해당 학생의 주차별 자료 조회
      final portfolios = await SubjectportpolioTable().queryRows(
        queryFn: (q) => q
            .eq('class', classId)
            .eq('student_name', studentName)
            .order('week', ascending: true), // 주차별로 정렬
      );
      
      print('$studentName 포트폴리오 개수: ${portfolios.length}개');
      
      // 1주차부터 15주차까지 처리
      for (int i = 0; i < portfolios.length; i++) {
        final portfolio = portfolios[i];
        final week = portfolio.week ?? (i + 1);
        final pdfUrl = portfolio.url;
        
        if (pdfUrl == null || pdfUrl.isEmpty) {
          print('$studentName ${week}주차 URL 없음 - 스킵');
          continue;
        }
        
        // 진행률 업데이트
        final progressValue = startProgress + (i / portfolios.length) * (endProgress - startProgress);
        updateProgress(progressValue, '$studentName ${week}주차 처리 중 (${i + 1}/${portfolios.length})');
        
        print('$studentName ${week}주차 PDF 다운로드 중: $pdfUrl');
        
        try {
          final response = await http.get(Uri.parse(pdfUrl));
          if (response.statusCode != 200) {
            print('$studentName ${week}주차 다운로드 실패: ${response.statusCode}');
            continue;
          }
          
          final weekPdfBytes = response.bodyBytes;
          final weekDoc = syncfusion.PdfDocument(inputBytes: weekPdfBytes);
          
          print('$studentName ${week}주차 페이지 수: ${weekDoc.pages.count}');
          
          // 주차별 자료의 각 페이지마다 템플릿 생성
          for (int pageIndex = 0; pageIndex < weekDoc.pages.count; pageIndex++) {
            final sourcePage = weekDoc.pages[pageIndex];
            final sourceTemplate = sourcePage.createTemplate();
            
            // 주차별 페이지 템플릿 생성
            final pageDoc = pw.Document();
            pageDoc.addPage(pw.Page(
              pageFormat: PdfPageFormat.a4,
              theme: font != null ? pw.ThemeData.withFont(base: font) : null,
              build: (context) => pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // 헤더 부분
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(40, 30, 40, 0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Row(children: [
                          pw.Container(
                            width: 40, height: 30,
                            decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                            child: pw.Center(child: pw.Text('06', style: pw.TextStyle(
                              fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                            ))),
                          ),
                          pw.SizedBox(width: 15),
                          pw.Text('주차별 설계 진행표 (${professorName ?? '교수명'} 교수)', style: pw.TextStyle(
                            fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                          )),
                        ]),
                        pw.Text('${year ?? '2025'}년도 ${semester ?? '1학기'}', style: pw.TextStyle(
                          fontSize: 14, color: PdfColors.black, font: font,
                        )),
                      ],
                    ),
                  ),
                  
                  pw.SizedBox(height: 10),
                  
                  // 학생 정보 (헤더 바로 아래)
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          '${week}주차 | 내용: 주별과제제출내용(1)\n학생: $studentName',
                          style: pw.TextStyle(fontSize: 12, color: PdfColors.black, font: font),
                        ),
                        // 성적은 나중에 추가 가능
                        pw.Container(
                          width: 50,
                          height: 50,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.red, width: 2),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              'A+',
                              style: pw.TextStyle(
                                fontSize: 20,
                                color: PdfColors.red,
                                fontWeight: pw.FontWeight.bold,
                                font: font,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  pw.SizedBox(height: 15),
                  
                  // 콘텐츠 영역
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: pw.Container(
                        width: double.infinity,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            '$studentName ${week}주차 콘텐츠 영역',
                            style: pw.TextStyle(fontSize: 10, color: PdfColors.grey400, font: font),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // 푸터 부분
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(40, 10, 40, 20),
                    child: pw.Text(
                      '순천향대학교 건축학과(9) | 건축설계 9 (5학년) | 교수 천준호, 김승, 이재',
                      style: pw.TextStyle(fontSize: 10, color: PdfColors.grey600, font: font),
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                ],
              ),
            ));
            
            // 템플릿을 finalDoc에 추가
            final pageBytes = await pageDoc.save();
            final pageSyncDoc = syncfusion.PdfDocument(inputBytes: pageBytes);
            final templateSourcePage = pageSyncDoc.pages[0];
            final newPage = finalDoc.pages.add();
            final pageTemplate = templateSourcePage.createTemplate();
            
            // 템플릿 배경 그리기
            newPage.graphics.drawPdfTemplate(pageTemplate, ui.Offset.zero);
            
            // 실제 PDF 콘텐츠를 콘텐츠 영역에 오버레이로 그리기
            final contentX = 50.0;
            final contentY = 130.0; // 헤더가 더 커졌으므로 Y 위치 조정
            final contentWidth = newPage.getClientSize().width - 100;
            final contentHeight = newPage.getClientSize().height - 180;
            
            // 실제 PDF 콘텐츠를 콘텐츠 영역에 맞게 스케일링하여 그리기
            final sourceSize = sourceTemplate.size;
            final contentScaleX = contentWidth / sourceSize.width;
            final contentScaleY = contentHeight / sourceSize.height;
            final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.9;
            
            final finalWidth = sourceSize.width * contentScale;
            final finalHeight = sourceSize.height * contentScale;
            
            // 콘텐츠 영역 내에서 중앙 정렬
            final contentCenterX = contentX + (contentWidth - finalWidth) / 2;
            final contentCenterY = contentY + (contentHeight - finalHeight) / 2;
            
            newPage.graphics.save();
            newPage.graphics.translateTransform(contentCenterX, contentCenterY);
            
            // 실제 PDF 콘텐츠 그리기
            newPage.graphics.drawPdfTemplate(
              sourceTemplate,
              ui.Offset.zero,
              ui.Size(finalWidth, finalHeight)
            );
            
            newPage.graphics.restore();
            
            pageSyncDoc.dispose();
            
            print('$studentName ${week}주차 페이지 ${pageIndex + 1}/${weekDoc.pages.count} 템플릿 기반 병합 완료');
          }
          
          weekDoc.dispose();
          print('$studentName ${week}주차 PDF 병합 완료');
          
        } catch (weekError) {
          print('$studentName ${week}주차 처리 오류: $weekError');
        }
      }
      
      updateProgress(endProgress, '$studentName 주차별 자료 완료');
      print('======= $studentName 주차별 자료 추가 완료 =======');
      
    } catch (e) {
      print('$studentName 주차별 자료 추가 실패: $e');
    }
  }
  
  /// 모든 학생의 주차별 자료를 추가
  static Future<void> addAllStudentsWeeklyContent({
    required syncfusion.PdfDocument finalDoc,
    required List<String> studentNames,
    required int classId,
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    required Function(double, String) updateProgress,
    double startProgress = 0.93,
    double endProgress = 0.99,
  }) async {
    print('======= 모든 학생 주차별 자료 추가 시작 (${studentNames.length}명) =======');
    
    for (int i = 0; i < studentNames.length; i++) {
      final studentName = studentNames[i];
      
      // 각 학생당 진행률 계산
      final studentStartProgress = startProgress + (i / studentNames.length) * (endProgress - startProgress);
      final studentEndProgress = startProgress + ((i + 1) / studentNames.length) * (endProgress - startProgress);
      
      updateProgress(studentStartProgress, '학생 ${i + 1}/${studentNames.length}: $studentName 주차별 자료 처리 중');
      
      // 각 학생의 1주차~15주차 자료 추가
      await addStudentWeeklyContent(
        finalDoc: finalDoc,
        studentName: studentName,
        classId: classId,
        year: year,
        semester: semester,
        courseName: courseName,
        professorName: professorName,
        grade: grade,
        section: section,
        updateProgress: updateProgress,
        startProgress: studentStartProgress,
        endProgress: studentEndProgress,
      );
    }
    
    updateProgress(endProgress, '모든 학생 주차별 자료 완료');
    print('======= 모든 학생 주차별 자료 추가 완료 =======');
  }
}