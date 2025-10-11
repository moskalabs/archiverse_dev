import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;
import '/backend/supabase/supabase.dart';
import '/backend/lecture_material_template.dart';
import '/backend/weekly_progress_cover_template.dart';
import '/backend/student_weekly_progress_cover_template.dart';
import '/backend/student_weekly_content_template.dart';
import '/backend/weekly_progress_cover_template.dart';

/// 간단한 PDF 템플릿 (문법 오류 수정됨)
class UltraSimpleTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      return null;
    }
  }
  
  /// 문서를 템플릿과 함께 병합하는 헬퍼 함수
  static Future<void> _addDocumentWithTemplate(
    syncfusion.PdfDocument finalDoc,
    String documentUrl,
    String sectionNumber,
    String sectionTitle,
    String year,
    String semester,
    pw.Font? font,
    Function(double, String) updateProgress,
    double startProgress,
    double endProgress,
  ) async {
    try {
      print('$sectionTitle PDF 병합 시작');
      
      final response = await http.get(Uri.parse(documentUrl));
      if (response.statusCode == 200) {
        final documentPdfBytes = response.bodyBytes;
        final documentDoc = syncfusion.PdfDocument(inputBytes: documentPdfBytes);
        
        print('$sectionTitle 페이지 수: ${documentDoc.pages.count}');
        
        for (int i = 0; i < documentDoc.pages.count; i++) {
          final progressValue = startProgress + (i / documentDoc.pages.count) * (endProgress - startProgress);
          updateProgress(progressValue, '$sectionTitle 페이지 ${i + 1}/${documentDoc.pages.count} 처리 중');
          
          final sourcePage = documentDoc.pages[i];
          final sourceTemplate = sourcePage.createTemplate();
          
          // 각 문서 페이지마다 템플릿 생성
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
                          child: pw.Center(child: pw.Text(sectionNumber, style: pw.TextStyle(
                            fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                          ))),
                        ),
                        pw.SizedBox(width: 15),
                        pw.Text(sectionTitle, style: pw.TextStyle(
                          fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                        )),
                      ]),
                      pw.Text('${year}년도 $semester', style: pw.TextStyle(
                        fontSize: 14, color: PdfColors.black, font: font,
                      )),
                    ],
                  ),
                ),
                
                pw.SizedBox(height: 20),
                
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
                          '$sectionTitle 콘텐츠 영역 (${i + 1}/${documentDoc.pages.count})',
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
                    '순천향대학교 건축학과 | 건축설계 (5학년) | 교수 천준호, 김승, 이재',
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
          final contentY = 80.0;
          final contentWidth = newPage.getClientSize().width - 100;
          final contentHeight = newPage.getClientSize().height - 150;
          
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
          
          print('$sectionTitle 페이지 ${i + 1}/${documentDoc.pages.count} 템플릿 기반 병합 완료');
        }
        
        documentDoc.dispose();
        print('$sectionTitle PDF 병합 완룼');
      } else {
        print('$sectionTitle URL 접근 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('$sectionTitle 병합 실패: $e');
    }
  }
      
      // 강의자료 rotation 적용 (별도 처리)
  
  static Future<Uint8List> generateCombinedPdf({
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    int? classId,
    Function(double, String)? updateProgressCallback, // 진행률 콜백 추가
  }) async {
    print('Ultra Simple PDF 생성 시작');
    
    // 진행률 업데이트 함수 (콜백 사용)
    void updateProgress(double progress, String message) {
      try {
        if (updateProgressCallback != null) {
          updateProgressCallback(progress, message);
        }
        print('진행률: ${(progress * 100).toStringAsFixed(1)}% - $message');
      } catch (e) {
        print('진행률 업데이트 실패: $e');
      }
    }
    
    updateProgress(0.0, 'PDF 생성 시작');
    
    updateProgress(0.1, '표지 페이지 생성 시작');
    
    // 진행률 업데이트 함수
    // 기존 updateProgress 제거됨
    
          // 중복 updateProgress 제거
    
    updateProgress(0.1, '표지 페이지 생성 시작');
    
    final displayYear = year ?? '2025';
    final displaySemester = semester ?? '1학기';
    final displayCourseName = courseName ?? '과목명';
    final displayProfessorName = professorName ?? '교수명';
    final displayGrade = grade ?? '학년';
    final displaySection = section ?? '분반';
    
    // 모든 문서 URL 찾기
    String? coursePlanUrl;
    String? attendanceUrl;
    String? gradeRecordUrl;
    String? workEvalUrl;
    String? lectureMaterialUrl;
    
    if (classId != null) {
      try {
        // 수업계획서 URL 조회
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
        
        // 출석부 URL 조회
        final gradeSheetRecords = await GradesheetTable().queryRows(
          queryFn: (q) => q.eq('class', classId),
        );
        if (gradeSheetRecords.isNotEmpty) {
          attendanceUrl = gradeSheetRecords.first.url;
        }
        print('출석부 URL: $attendanceUrl');
        
        // 성적기록표 URL 조회
        final gradeRecords = await AttendanceTable().queryRows(
          queryFn: (q) => q.eq('class', classId),
        );
        if (gradeRecords.isNotEmpty) {
          gradeRecordUrl = gradeRecords.first.url;
        }
        print('성적기록표 URL: $gradeRecordUrl');
        
        // 학생작품평가표 URL 조회
        final workEvalRecords = await WorkevalformTable().queryRows(
          queryFn: (q) => q.eq('class', classId),
        );
        if (workEvalRecords.isNotEmpty) {
          workEvalUrl = workEvalRecords.first.url;
        }
        print('학생작품평가표 URL: $workEvalUrl');
        
        // 강의자료 URL 조회
        final lectureMaterialRecords = await LecturematerialTable().queryRows(
          queryFn: (q) => q.eq('class', classId),
        );
        if (lectureMaterialRecords.isNotEmpty) {
          lectureMaterialUrl = lectureMaterialRecords.first.url;
        }
        print('강의자료 URL: $lectureMaterialUrl');
      } catch (e) {
        print('문서 URL 조회 실패: $e');
      }
    }

    // 최종 PDF 문서
    final finalDoc = syncfusion.PdfDocument();
    finalDoc.pageSettings.margins.all = 0;
    
    try {
      final font = await _loadMalgunGothicFont();
      
      // 1페이지: 표지
      final coverDoc = pw.Document();
      coverDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.FullPage(
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
      
      // 표지를 finalDoc에 추가
      final coverBytes = await coverDoc.save();
      final coverSyncDoc = syncfusion.PdfDocument(inputBytes: coverBytes);
      
      final coverSourcePage = coverSyncDoc.pages[0];
      final coverNewPage = finalDoc.pages.add();
      final coverTemplate = coverSourcePage.createTemplate();
      
      final pageWidth = coverNewPage.getClientSize().width;
      final pageHeight = coverNewPage.getClientSize().height;
      
      coverNewPage.graphics.drawPdfTemplate(
        coverTemplate, 
        ui.Offset.zero,
        ui.Size(pageWidth, pageHeight)
      );
      
      coverSyncDoc.dispose();
      updateProgress(0.2, '표지 페이지 완료');

      // 2페이지: INDEX
      final indexDoc = pw.Document();
      indexDoc.addPage(pw.Page(
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

      // INDEX를 finalDoc에 추가
      final indexBytes = await indexDoc.save();
      final indexSyncDoc = syncfusion.PdfDocument(inputBytes: indexBytes);
      
      final indexSourcePage = indexSyncDoc.pages[0];
      final indexNewPage = finalDoc.pages.add();
      final indexTemplate = indexSourcePage.createTemplate();
      
      indexNewPage.graphics.drawPdfTemplate(indexTemplate, ui.Offset.zero);
      indexSyncDoc.dispose();
      updateProgress(0.4, 'INDEX 페이지 완료');

      // 3페이지: 섹션 구분자
      final sectionDoc = pw.Document();
      sectionDoc.addPage(pw.Page(
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
      
      // 섹션을 finalDoc에 추가
      final sectionBytes = await sectionDoc.save();
      final sectionSyncDoc = syncfusion.PdfDocument(inputBytes: sectionBytes);
      
      final sectionSourcePage = sectionSyncDoc.pages[0];
      final sectionNewPage = finalDoc.pages.add();
      final sectionTemplate = sectionSourcePage.createTemplate();
      
      sectionNewPage.graphics.drawPdfTemplate(sectionTemplate, ui.Offset.zero);
      sectionSyncDoc.dispose();
      updateProgress(0.5, '섹션 구분자 완료');
      
      // 4. 수업계획서 PDF 병합
      if (coursePlanUrl != null && coursePlanUrl!.isNotEmpty) {
        await _addDocumentWithTemplate(finalDoc, coursePlanUrl!, '01', '수업계획서', displayYear, displaySemester, font, updateProgress, 0.5, 0.6);
      }
      
      // 5. 출석부 PDF 병합
      if (attendanceUrl != null && attendanceUrl!.isNotEmpty) {
        await _addDocumentWithTemplate(finalDoc, attendanceUrl!, '02', '출석부 ($displayProfessorName 교수)', displayYear, displaySemester, font, updateProgress, 0.6, 0.65);
      }
      
      // 6. 성적기록표 PDF 병합
      if (gradeRecordUrl != null && gradeRecordUrl!.isNotEmpty) {
        await _addDocumentWithTemplate(finalDoc, gradeRecordUrl!, '03', '성적기록표 ($displayProfessorName 교수)', displayYear, displaySemester, font, updateProgress, 0.65, 0.7);
      }
      
      // 7. 학생작품평가표 PDF 병합
      if (workEvalUrl != null && workEvalUrl!.isNotEmpty) {
        await _addDocumentWithTemplate(finalDoc, workEvalUrl!, '04', '학생작품평가표 ($displayProfessorName 교수)', displayYear, displaySemester, font, updateProgress, 0.7, 0.8);
      }
      
      // 8. 강의자료 rotation 적용 (별도 처리)
      if (lectureMaterialUrl != null && lectureMaterialUrl!.isNotEmpty) {
        await LectureMaterialTemplate.addLectureMaterialPages(
          finalDoc: finalDoc,
          lectureMaterialUrl: lectureMaterialUrl!,
          year: displayYear,
          semester: displaySemester,
          professorName: displayProfessorName,
          updateProgress: updateProgress,
          startProgress: 0.7,
          endProgress: 0.9,
        );
      } else {
        print('강의자료 URL이 없음: $lectureMaterialUrl');
        updateProgress(0.9, '강의자료 없음 - 스킵');
      }
      
      // 9. 주차별 설계진행표 표지 (학생 목록 포함)
      final studentNames = await WeeklyProgressCoverTemplate.addWeeklyProgressCover(
        finalDoc: finalDoc,
        classId: classId,
        year: displayYear,
        semester: displaySemester,
        courseName: displayCourseName,
        professorName: displayProfessorName,
        grade: displayGrade,
        section: displaySection,
        updateProgress: updateProgress,
        startProgress: 0.85,
        endProgress: 0.87,
      );
      
      // 10. 각 학생별 표지 + 1주차~15주차 자료 추가
      if (studentNames.isNotEmpty && classId != null) {
        // 10-1. 모든 학생 표지 먼저 추가
        await StudentWeeklyProgressCoverTemplate.addAllStudentCovers(
          finalDoc: finalDoc,
          studentNames: studentNames,
          year: displayYear,
          semester: displaySemester,
          courseName: displayCourseName,
          professorName: displayProfessorName,
          grade: displayGrade,
          section: displaySection,
          updateProgress: updateProgress,
          startProgress: 0.87,
          endProgress: 0.89,
        );
        
        // 10-2. 각 학생의 1주차~15주차 자료 추가
        await StudentWeeklyContentTemplate.addAllStudentsWeeklyContent(
          finalDoc: finalDoc,
          studentNames: studentNames,
          classId: classId,
          year: displayYear,
          semester: displaySemester,
          courseName: displayCourseName,
          professorName: displayProfessorName,
          grade: displayGrade,
          section: displaySection,
          updateProgress: updateProgress,
          startProgress: 0.89,
          endProgress: 0.98,
        );
      }
      
      updateProgress(0.95, 'PDF 최종 생성 중');
      final finalBytes = await finalDoc.save();
      finalDoc.dispose();
      updateProgress(1.0, 'PDF 생성 완료');
      
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