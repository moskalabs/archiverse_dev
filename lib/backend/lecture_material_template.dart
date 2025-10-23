import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;

/// 강의자료 전용 템플릿 (rotation 적용)
class LectureMaterialTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 강의자료 URL의 PDF를 rotation 적용하여 템플릿에 병합
  static Future<void> addLectureMaterialPages({
    required syncfusion.PdfDocument finalDoc,
    required String lectureMaterialUrl,
    String? year,
    String? semester,
    String? professorName,
    required Function(double, String) updateProgress,
    double startProgress = 0.7,
    double endProgress = 0.8,
  }) async {
    try {
      print('강의자료 PDF rotation 적용 병합 시작');
      updateProgress(startProgress, '강의자료 다운로드 중');
      
      final response = await http.get(Uri.parse(lectureMaterialUrl));
      if (response.statusCode != 200) {
        print('강의자료 URL 접근 실패: ${response.statusCode}');
        return;
      }
      
      final lecturePdfBytes = response.bodyBytes;
      final lectureDoc = syncfusion.PdfDocument(inputBytes: lecturePdfBytes);
      final font = await _loadMalgunGothicFont();
      
      print('강의자료 페이지 수: ${lectureDoc.pages.count}');
      
      // 강의자료의 각 페이지마다 템플릿 생성
      for (int i = 0; i < lectureDoc.pages.count; i++) {
        final progressValue = startProgress + (i / lectureDoc.pages.count) * (endProgress - startProgress);
        updateProgress(progressValue, '강의자료 페이지 ${i + 1}/${lectureDoc.pages.count} 처리 중 (rotation 적용)');
        
        print('강의자료 페이지 ${i + 1}/${lectureDoc.pages.count} rotation 템플릿 생성 시작');
        
        final sourcePage = lectureDoc.pages[i];
        final sourceTemplate = sourcePage.createTemplate();
        
        // 강의자료 페이지 템플릿 생성
        final pageDoc = pw.Document();
        pageDoc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4.copyWith(
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
            marginBottom: 0,
          ),
          theme: font != null ? pw.ThemeData.withFont(base: font) : null,
          build: (context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 헤더 부분 (강의자료용)
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Container(
                        width: 40, height: 30,
                        decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                        child: pw.Center(child: pw.Text('05', style: pw.TextStyle(
                          fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                        ))),
                      ),
                      pw.SizedBox(width: 15),
                      pw.Text('강의자료', style: pw.TextStyle(
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

              // 콘텐츠 영역 (네모 테두리 - rotation된 내용이 들어갈 영역)
              pw.Expanded(
                child: pw.Padding(
                  padding: const pw.EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: pw.Container(
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black, width: 2), // 검은 테두리
                      color: PdfColors.white,
                    ),
                    child: pw.Padding(
                      padding: const pw.EdgeInsets.all(10),
                      child: pw.Center(
                        child: pw.Text(
                          '강의자료 콘텐츠 영역 (90도 회전 적용)',
                          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey400, font: font),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // 푸터 부분
              pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: pw.Text(
                  '순천향대학교 건축학과 | 건축설계 (5학년) | 교수 ${professorName ?? '교수명'}',
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
        
        // 강의자료는 rotation(90도) 적용하여 콘텐츠 영역에 그리기
        final contentX = 30.0; // 테두리 안쪽
        final contentY = 50.0;
        final contentWidth = newPage.getClientSize().width - 60; // 테두리 여백 고려
        final contentHeight = newPage.getClientSize().height - 85;
        
        // rotation(90도 회전) 적용을 위한 스케일링 계산
        final sourceSize = sourceTemplate.size;
        
        // 90도 회전 시 너비와 높이가 바뀌므로 조정
        final rotatedWidth = sourceSize.height; // 회전 후 너비
        final rotatedHeight = sourceSize.width;  // 회전 후 높이
        
        final contentScaleX = contentWidth / rotatedWidth;
        final contentScaleY = contentHeight / rotatedHeight;
        final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.75; // 75% 스케일링 (네모 박스 안에 여유롭게)
        
        final finalWidth = rotatedWidth * contentScale;
        final finalHeight = rotatedHeight * contentScale;
        
        // 콘텐츠 영역 내에서 중앙 정렬
        final contentCenterX = contentX + (contentWidth - finalWidth) / 2;
        final contentCenterY = contentY + (contentHeight - finalHeight) / 2;
        
        newPage.graphics.save();
        
        // 회전 중심점으로 이동
        final rotationCenterX = contentCenterX + finalWidth / 2;
        final rotationCenterY = contentCenterY + finalHeight / 2;
        newPage.graphics.translateTransform(rotationCenterX, rotationCenterY);
        
        // 90도 시계 방향 회전
        newPage.graphics.rotateTransform(90);
        
        // 회전 후 중심에서 다시 좌상단으로 이동
        newPage.graphics.translateTransform(-finalHeight / 2, -finalWidth / 2);
        
        // 실제 PDF 콘텐츠 그리기 (회전된 상태)
        newPage.graphics.drawPdfTemplate(
          sourceTemplate,
          ui.Offset.zero,
          ui.Size(sourceSize.width * contentScale, sourceSize.height * contentScale)
        );
        
        newPage.graphics.restore();
        
        pageSyncDoc.dispose();
        
        print('강의자료 페이지 ${i + 1}/${lectureDoc.pages.count} rotation 적용 병합 완료');
        print('템플릿: 헤더(05 강의자료) + 콘텐츠 영역(90도 회전) + 푸터(순천향대)');
        print('회전 적용: 90도 시계방향 회전');
        print('회전 전 크기: ${sourceSize.width}x${sourceSize.height}');
        print('회전 후 크기: ${finalWidth.toStringAsFixed(1)}x${finalHeight.toStringAsFixed(1)}');
      }
      
      lectureDoc.dispose();
      updateProgress(endProgress, '강의자료 처리 완료');
      print('강의자료 PDF rotation 적용 병합 완료');
      
    } catch (e) {
      print('강의자료 rotation 병합 실패: $e');
      updateProgress(endProgress, '강의자료 처리 실패');
    }
  }
}