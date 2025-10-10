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

    // 최종 PDF 문서 (페이지 마진 설정)
    final finalDoc = syncfusion.PdfDocument();
    finalDoc.pageSettings.margins.all = 0; // 모든 마진 제거
    
    try {
      final font = await _loadMalgunGothicFont();
      
      // 1페이지: 표지 - 간단한 방식으로 다시 시도
      final coverDoc = pw.Document();
      coverDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero, // 모든 마진 제거
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.FullPage( // FullPage 위젯 사용
          ignoreMargins: true,
          child: pw.Container(
            width: double.infinity,
            height: double.infinity,
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
        ),
      ));
      
      // 표지를 finalDoc에 추가 (완전한 풀스크린)
      final coverBytes = await coverDoc.save();
      final coverSyncDoc = syncfusion.PdfDocument(inputBytes: coverBytes);
      coverSyncDoc.pageSettings.margins.all = 0; // 소스 문서도 마진 제거
      
      final coverSourcePage = coverSyncDoc.pages[0];
      
      // 페이지 사이즈 설정을 먼저 적용
      finalDoc.pageSettings.size = syncfusion.PdfPageSize.a4;
      finalDoc.pageSettings.margins.all = 0; // 마진 다시 한번 확실히 제거
      
      final coverNewPage = finalDoc.pages.add();
      final coverTemplate = coverSourcePage.createTemplate();
      
      // 완전한 풀스크린으로 그리기 (Syncfusion 방식)
      final pageWidth = coverNewPage.getClientSize().width;
      final pageHeight = coverNewPage.getClientSize().height;
      
      coverNewPage.graphics.drawPdfTemplate(
        coverTemplate, 
        ui.Offset.zero,
        ui.Size(pageWidth, pageHeight)
      );
      
      coverSyncDoc.dispose();
      
      print('표지 페이지 완전 풀스크린 추가 완료');
      
      // 2. 2-4페이지 템플릿 생성
      final templateDoc = pw.Document();

      // 2페이지: INDEX
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

      // 수업계획서 템플릿 (마진 조정)
      templateDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.fromLTRB(50, 50, 50, 50), // 마진 증가
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
                  height: 400, // 고정 높이 설정
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.grey400, width: 1),
                    color: PdfColors.grey50, // 배경색 추가
                  ),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(15), // 내부 패딩 감소
                    child: pw.Center(
                      child: pw.Text(
                        coursePlanUrl != null 
                          ? '수업계획서 PDF 발견\n다음 페이지부터 실제 내용 표시 (마진 적용)\n\nURL: $coursePlanUrl'
                          : '수업계획서를 찾을 수 없습니다.',
                        style: pw.TextStyle(fontSize: 11, color: PdfColors.blue, font: font), // 폰트 사이즈 감소
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

      // 2. 2-4페이지 템플릿을 Syncfusion에 추가 (마진 적용)
      final templateBytes = await templateDoc.save();
      final templateSyncDoc = syncfusion.PdfDocument(inputBytes: templateBytes);
      
      for (int i = 0; i < templateSyncDoc.pages.count; i++) {
        final sourcePage = templateSyncDoc.pages[i];
        final newPage = finalDoc.pages.add();
        final template = sourcePage.createTemplate();
        
        // 2-4페이지: 중앙 정렬을 위한 마진 조정
        final horizontalMargin = 50.0;
        final verticalMargin = 60.0; // 세로 마진을 더 크게
        final scale = 0.75;
        
        final templateSize = template.size;
        final pageWidth = newPage.getClientSize().width;
        final pageHeight = newPage.getClientSize().height;
        
        final maxWidth = pageWidth - (horizontalMargin * 2);
        final maxHeight = pageHeight - (verticalMargin * 2);
        
        final scaleX = maxWidth / templateSize.width;
        final scaleY = maxHeight / templateSize.height;
        final finalScale = (scaleX < scaleY ? scaleX : scaleY) * scale;
        
        final scaledWidth = templateSize.width * finalScale;
        final scaledHeight = templateSize.height * finalScale;
        
        // 중앙 정렬을 위한 오프셋 계산
        final centerX = (pageWidth - scaledWidth) / 2;
        final centerY = (pageHeight - scaledHeight) / 2;
        
        newPage.graphics.save();
        newPage.graphics.translateTransform(centerX, centerY);
        
        final scaledSize = ui.Size(scaledWidth, scaledHeight);
        newPage.graphics.drawPdfTemplate(template, ui.Offset.zero, scaledSize);
        newPage.graphics.restore();
        
        print('템플릿 페이지 ${i + 2} 추가 (중앙정렬: ${centerX.toStringAsFixed(1)}, ${centerY.toStringAsFixed(1)}, 스케일: ${(finalScale * 100).toStringAsFixed(1)}%)');
        
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
              
              // Syncfusion 마진 제거로 더 큰 마진 필요
              final margin = 40.0; // 기존 20px에서 40px로 증가
              final scale = 0.75; // 기존 0.85에서 0.75로 감소
              
              // 중앙 정렬을 위한 계산
              final templateSize = template.size;
              final pageWidth = newPage.getClientSize().width;
              final pageHeight = newPage.getClientSize().height;
              
              final maxWidth = pageWidth - (margin * 2);
              final maxHeight = pageHeight - (margin * 2);
              
              final scaleX = maxWidth / templateSize.width;
              final scaleY = maxHeight / templateSize.height;
              final finalScale = (scaleX < scaleY ? scaleX : scaleY) * scale;
              
              final scaledWidth = templateSize.width * finalScale;
              final scaledHeight = templateSize.height * finalScale;
              
              // 중앙 정렬 오프셋 계산
              final centerX = (pageWidth - scaledWidth) / 2;
              final centerY = (pageHeight - scaledHeight) / 2;
              
              newPage.graphics.save();
              newPage.graphics.translateTransform(centerX, centerY);
              
              final scaledSize = ui.Size(scaledWidth, scaledHeight);
              newPage.graphics.drawPdfTemplate(template, ui.Offset.zero, scaledSize);
              
              newPage.graphics.restore();
              
              print('수업계획서 페이지 ${i + 1} 병합 완룼 (중앙정렬: ${centerX.toStringAsFixed(1)}, ${centerY.toStringAsFixed(1)}, 스케일: ${(finalScale * 100).toStringAsFixed(1)}%)');
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