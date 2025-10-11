import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '/backend/supabase/supabase.dart';

/// 학생별 중간결과물 콘텐츠 템플릿
class StudentMidtermContentTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 한 학생의 중간결과물 자료 추가
  static Future<void> addStudentMidtermContent({
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
      print('======= $studentName 중간결과물 자료 추가 시작 =======');
      
      final font = await _loadMalgunGothicFont();
      
      // midterm_results 테이블에서 해당 학생의 중간결과물 조회
      final midtermResults = await MidtermResultsTable().queryRows(
        queryFn: (q) => q
            .eq('class', classId)
            .eq('student_name', studentName),
      );
      
      print('$studentName 중간결과물 개수: ${midtermResults.length}개');
      
      if (midtermResults.isEmpty) {
        print('$studentName 중간결과물 없음 - 스킵');
        return;
      }
      
      // 중간결과물 처리
      for (int i = 0; i < midtermResults.length; i++) {
        final result = midtermResults[i];
        final pdfUrl = result.url;
        final title = result.title ?? '중간결과물';
        
        if (pdfUrl == null || pdfUrl.isEmpty) {
          print('$studentName 중간결과물 URL 없음 - 스킵');
          continue;
        }
        
        // 진행률 업데이트
        final progressValue = startProgress + (i / midtermResults.length) * (endProgress - startProgress);
        updateProgress(progressValue, '$studentName 중간결과물 처리 중 (${i + 1}/${midtermResults.length})');
        
        print('$studentName 중간결과물 PDF 다운로드 중: $pdfUrl');
        
        try {
          final response = await http.get(Uri.parse(pdfUrl));
          if (response.statusCode != 200) {
            print('$studentName 중간결과물 다운로드 실패: ${response.statusCode}');
            continue;
          }
          
          final resultPdfBytes = response.bodyBytes;
          final resultDoc = syncfusion.PdfDocument(inputBytes: resultPdfBytes);
          
          print('$studentName 중간결과물 페이지 수: ${resultDoc.pages.count}');
          
          // 중간결과물의 각 페이지마다 템플릿 생성
          for (int pageIndex = 0; pageIndex < resultDoc.pages.count; pageIndex++) {
            final sourcePage = resultDoc.pages[pageIndex];
            final sourceTemplate = sourcePage.createTemplate();
            
            // 중간결과물 페이지 템플릿 생성
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
                            child: pw.Center(child: pw.Text('07', style: pw.TextStyle(
                              fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                            ))),
                          ),
                          pw.SizedBox(width: 15),
                          pw.Text('중간 결과물 (${professorName ?? '교수명'} 교수)', style: pw.TextStyle(
                            fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                          )),
                        ]),
                        pw.Text('${year ?? '2024'}년도 ${semester ?? '1학기'}', style: pw.TextStyle(
                          fontSize: 14, color: PdfColors.black, font: font,
                        )),
                      ],
                    ),
                  ),
                  
                  pw.SizedBox(height: 10),
                  
                  // 제목 및 학생 정보
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          '제목: $title',
                          style: pw.TextStyle(fontSize: 12, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '학생: $studentName',
                          style: pw.TextStyle(fontSize: 12, color: PdfColors.black, font: font),
                        ),
                      ],
                    ),
                  ),
                  
                  pw.SizedBox(height: 15),
                  
                  // 콘텐츠 영역 (PDF 삽입)
                  pw.Expanded(
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                      child: pw.Container(
                        width: double.infinity,
                        color: PdfColors.white,
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
            final contentY = 120.0; // 헤더 + 제목/학생정보 높이
            final pageHeight = newPage.getClientSize().height;
            final pageWidth = newPage.getClientSize().width;
            
            final contentWidth = pageWidth - 100; // 좌우 여백 50씩
            final contentHeight = pageHeight - 120 - 50; // 상단(헤더+정보) - 하단(푸터)
            
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
            
            print('$studentName 중간결과물 페이지 ${pageIndex + 1}/${resultDoc.pages.count} 템플릿 기반 병합 완료');
          }
          
          resultDoc.dispose();
          print('$studentName 중간결과물 PDF 병합 완료');
          
        } catch (resultError) {
          print('$studentName 중간결과물 처리 오류: $resultError');
        }
      }
      
      updateProgress(endProgress, '$studentName 중간결과물 완료');
      print('======= $studentName 중간결과물 자료 추가 완료 =======');
      
    } catch (e) {
      print('$studentName 중간결과물 자료 추가 실패: $e');
    }
  }
}