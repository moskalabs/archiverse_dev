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
    String? attendanceUrl; // 출석부 URL 추가
    String? gradeRecordUrl; // 성적기록표 URL 추가
    String? workEvalUrl; // 학생작품평가표 URL 추가
    String? lectureMaterialUrl; // 강의자료 URL 추가
    
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
        
        // 출석부 URL 조회 (GradeSheet 테이블 사용)
        final gradeSheetRecords = await GradesheetTable().queryRows(
          queryFn: (q) => q.eq('class', classId), // classId 자체가 분반 구분 (33=1분반, 51=3분반)
        );
        if (gradeSheetRecords.isNotEmpty) {
          attendanceUrl = gradeSheetRecords.first.url;
        }
        print('출석부 URL: $attendanceUrl');
        
        // 성적기록표 URL 조회 (Attendance 테이블 사용)
        final gradeRecords = await AttendanceTable().queryRows(
          queryFn: (q) => q.eq('class', classId), // classId 자체가 분반 구분
        );
        if (gradeRecords.isNotEmpty) {
          gradeRecordUrl = gradeRecords.first.url;
        }
        print('성적기록표 URL: $gradeRecordUrl');
        
        // 학생작품평가표 URL 조회 (WorkEvalForm 테이블 사용)
        final workEvalRecords = await WorkevalformTable().queryRows(
          queryFn: (q) => q.eq('class', classId), // classId 자체가 분반 구분
        );
        if (workEvalRecords.isNotEmpty) {
          workEvalUrl = workEvalRecords.first.url;
        }
        print('학생작품평가표 URL: $workEvalUrl');
        
        // 강의자료 URL 조회 (LectureMaterial 테이블 사용)
        final lectureMaterialRecords = await LecturematerialTable().queryRows(
          queryFn: (q) => q.eq('class', classId), // classId 자체가 분반 구분
        );
        if (lectureMaterialRecords.isNotEmpty) {
          lectureMaterialUrl = lectureMaterialRecords.first.url;
        }
        print('강의자료 URL: $lectureMaterialUrl');
      } catch (e) {
        print('문서 URL 조회 실패: $e');
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
      print('현재 finalDoc 페이지 수 (표지 추가 후): ${finalDoc.pages.count}');
      
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
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(
                            '이 곳은 수업계획서 섹션입니다',
                            style: pw.TextStyle(fontSize: 16, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            coursePlanUrl != null 
                              ? '✓ 수업계획서 PDF 발견\n다음 페이지부터 실제 내용이 표시됩니다.'
                              : '✗ 수업계획서를 찾을 수 없습니다.',
                            style: pw.TextStyle(fontSize: 12, color: coursePlanUrl != null ? PdfColors.blue : PdfColors.red, font: font),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.SizedBox(height: 15),
                          pw.Text(
                            coursePlanUrl != null 
                              ? 'URL: ${coursePlanUrl!.length > 50 ? coursePlanUrl!.substring(0, 50) + "..." : coursePlanUrl!}'
                              : '',
                            style: pw.TextStyle(fontSize: 8, color: PdfColors.grey600, font: font),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
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
      print('템플릿 페이지 추가 완룼 - 현재 finalDoc 페이지 수: ${finalDoc.pages.count}');
      
      // 3. 수업계획서 PDF 병합 (마진 적용)
      if (coursePlanUrl != null && coursePlanUrl!.isNotEmpty) {
        try {
          print('수업계획서 PDF 병합 시작');
          
          final response = await http.get(Uri.parse(coursePlanUrl!));
          if (response.statusCode == 200) {
            final coursePdfBytes = response.bodyBytes;
            final courseDoc = syncfusion.PdfDocument(inputBytes: coursePdfBytes);
            
            print('수업계획서 페이지 수: ${courseDoc.pages.count}');
            
            // 수업계획서의 각 페이지마다 템플릿 생성
            for (int i = 0; i < courseDoc.pages.count; i++) {
              print('수업계획서 페이지 ${i + 1}/${courseDoc.pages.count} 템플릿 생성 시작');
              final sourcePage = courseDoc.pages[i];
              final sourceTemplate = sourcePage.createTemplate();
              
              // 각 수업계획서 페이지마다 템플릿 생성
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
                    ),
                    
                    pw.SizedBox(height: 20),
                    
                    // 콘텐츠 영역 (빈 상자 - 나중에 실제 PDF가 오버레이됨)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white, // 테두리 제거, 배경색만 유지
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              '콘텐츠 영역 (${i + 1}/${courseDoc.pages.count})',
                              style: pw.TextStyle(fontSize: 10, color: PdfColors.grey400, font: font),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                    // 푸터 부분 (깔끔하게)
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
              final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.9; // 90% 스케일링
              
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

              
              print('수업계획서 페이지 ${i + 1}/${courseDoc.pages.count} 템플릿 기반 병합 완룼');
              print('템플릿: 헤더(01 수업계획서) + 콘텐츠 영역 + 푸터(순천향대)');
              print('콘텐츠 위치: (${contentCenterX.toStringAsFixed(1)}, ${contentCenterY.toStringAsFixed(1)}) 크기: ${finalWidth.toStringAsFixed(1)}x${finalHeight.toStringAsFixed(1)}');
            }
            
            courseDoc.dispose();
            print('수업계획서 PDF 병합 완료');
          }
        } catch (e) {
          print('수업계획서 병합 실패: $e');
        }
      } else {
        print('수업계획서 URL이 없음: $coursePlanUrl');
      }
      
      // 4. 출석부 PDF 템플릿 기반 병합
      if (attendanceUrl != null && attendanceUrl!.isNotEmpty) {
        try {
          print('출석부 PDF 템플릿 기반 병합 시작');
          
          final response = await http.get(Uri.parse(attendanceUrl!));
          if (response.statusCode == 200) {
            final attendancePdfBytes = response.bodyBytes;
            final attendanceDoc = syncfusion.PdfDocument(inputBytes: attendancePdfBytes);
            
            print('출석부 페이지 수: ${attendanceDoc.pages.count}');
            
            // 출석부의 각 페이지마다 템플릿 생성
            for (int i = 0; i < attendanceDoc.pages.count; i++) {
              print('출석부 페이지 ${i + 1}/${attendanceDoc.pages.count} 템플릿 생성 시작');
              
              final sourcePage = attendanceDoc.pages[i];
              final sourceTemplate = sourcePage.createTemplate();
              
              // 각 출석부 페이지마다 템플릿 생성
              final pageDoc = pw.Document();
              pageDoc.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                theme: font != null ? pw.ThemeData.withFont(base: font) : null,
                build: (context) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // 헤더 부분 (출석부용)
                    pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(40, 30, 40, 0),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(children: [
                            pw.Container(
                              width: 40, height: 30,
                              decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                              child: pw.Center(child: pw.Text('02', style: pw.TextStyle(
                                fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                              ))),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Text('출석부 ($displayProfessorName 교수)', style: pw.TextStyle(
                              fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                            )),
                          ]),
                          pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                            fontSize: 14, color: PdfColors.black, font: font,
                          )),
                        ],
                      ),
                    ),
                    
                    pw.SizedBox(height: 20),
                    
                    // 콘텐츠 영역 (빈 상자 - 나중에 실제 PDF가 오버레이됨)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white, // 테두리 제거, 배경색만 유지
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              '출석부 콘텐츠 영역 (${i + 1}/${attendanceDoc.pages.count})',
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
              final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.9; // 90% 스케일링
              
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
              
              print('출석부 페이지 ${i + 1}/${attendanceDoc.pages.count} 템플릿 기반 병합 완룼');
              print('템플릿: 헤더(02 출석부) + 콘텐츠 영역 + 푸터(순천향대)');
              print('콘텐츠 위치: (${contentCenterX.toStringAsFixed(1)}, ${contentCenterY.toStringAsFixed(1)}) 크기: ${finalWidth.toStringAsFixed(1)}x${finalHeight.toStringAsFixed(1)}');
            }
            
            attendanceDoc.dispose();
            print('출석부 PDF 병합 완룼');
          } else {
            print('출석부 URL 접근 실패: ${response.statusCode}');
          }
        } catch (e) {
          print('출석부 병합 실패: $e');
        }
      } else {
        print('출석부 URL이 없음: $attendanceUrl');
      }
      
      // 5. 성적기록표 PDF 템플릿 기반 병합
      if (gradeRecordUrl != null && gradeRecordUrl!.isNotEmpty) {
        try {
          print('성적기록표 PDF 템플릿 기반 병합 시작');
          
          final response = await http.get(Uri.parse(gradeRecordUrl!));
          if (response.statusCode == 200) {
            final gradeRecordPdfBytes = response.bodyBytes;
            final gradeRecordDoc = syncfusion.PdfDocument(inputBytes: gradeRecordPdfBytes);
            
            print('성적기록표 페이지 수: ${gradeRecordDoc.pages.count}');
            
            // 성적기록표의 각 페이지마다 템플릿 생성
            for (int i = 0; i < gradeRecordDoc.pages.count; i++) {
              print('성적기록표 페이지 ${i + 1}/${gradeRecordDoc.pages.count} 템플릿 생성 시작');
              
              final sourcePage = gradeRecordDoc.pages[i];
              final sourceTemplate = sourcePage.createTemplate();
              
              // 각 성적기록표 페이지마다 템플릿 생성
              final pageDoc = pw.Document();
              pageDoc.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                theme: font != null ? pw.ThemeData.withFont(base: font) : null,
                build: (context) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // 헤더 부분 (성적기록표용)
                    pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(40, 30, 40, 0),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(children: [
                            pw.Container(
                              width: 40, height: 30,
                              decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                              child: pw.Center(child: pw.Text('03', style: pw.TextStyle(
                                fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                              ))),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Text('성적기록표 ($displayProfessorName 교수)', style: pw.TextStyle(
                              fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                            )),
                          ]),
                          pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                            fontSize: 14, color: PdfColors.black, font: font,
                          )),
                        ],
                      ),
                    ),
                    
                    pw.SizedBox(height: 20),
                    
                    // 콘텐츠 영역 (빈 상자 - 나중에 실제 PDF가 오버레이됨)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white, // 테두리 제거, 배경색만 유지
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              '성적기록표 콘텐츠 영역 (${i + 1}/${gradeRecordDoc.pages.count})',
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
              final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.9; // 90% 스케일링
              
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
              
              print('성적기록표 페이지 ${i + 1}/${gradeRecordDoc.pages.count} 템플릿 기반 병합 완룼');
              print('템플릿: 헤더(03 성적기록표) + 콘텐츠 영역 + 푸터(순천향대)');
              print('콘텐츠 위치: (${contentCenterX.toStringAsFixed(1)}, ${contentCenterY.toStringAsFixed(1)}) 크기: ${finalWidth.toStringAsFixed(1)}x${finalHeight.toStringAsFixed(1)}');
            }
            
            gradeRecordDoc.dispose();
            print('성적기록표 PDF 병합 완룼');
          } else {
            print('성적기록표 URL 접근 실패: ${response.statusCode}');
          }
        } catch (e) {
          print('성적기록표 병합 실패: $e');
        }
      } else {
        print('성적기록표 URL이 없음: $gradeRecordUrl');
      }
      
      // 6. 학생작품평가표 PDF 템플릿 기반 병합
      if (workEvalUrl != null && workEvalUrl!.isNotEmpty) {
        try {
          print('학생작품평가표 PDF 템플릿 기반 병합 시작');
          
          final response = await http.get(Uri.parse(workEvalUrl!));
          if (response.statusCode == 200) {
            final workEvalPdfBytes = response.bodyBytes;
            final workEvalDoc = syncfusion.PdfDocument(inputBytes: workEvalPdfBytes);
            
            print('학생작품평가표 페이지 수: ${workEvalDoc.pages.count}');
            
            // 학생작품평가표의 각 페이지마다 템플릿 생성
            for (int i = 0; i < workEvalDoc.pages.count; i++) {
              print('학생작품평가표 페이지 ${i + 1}/${workEvalDoc.pages.count} 템플릿 생성 시작');
              
              final sourcePage = workEvalDoc.pages[i];
              final sourceTemplate = sourcePage.createTemplate();
              
              // 각 학생작품평가표 페이지마다 템플릿 생성
              final pageDoc = pw.Document();
              pageDoc.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                theme: font != null ? pw.ThemeData.withFont(base: font) : null,
                build: (context) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // 헤더 부분 (학생작품평가표용)
                    pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(40, 30, 40, 0),
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(children: [
                            pw.Container(
                              width: 40, height: 30,
                              decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                              child: pw.Center(child: pw.Text('04', style: pw.TextStyle(
                                fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                              ))),
                            ),
                            pw.SizedBox(width: 15),
                            pw.Text('학생작품평가표 ($displayProfessorName 교수)', style: pw.TextStyle(
                              fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                            )),
                          ]),
                          pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                            fontSize: 14, color: PdfColors.black, font: font,
                          )),
                        ],
                      ),
                    ),
                    
                    pw.SizedBox(height: 20),
                    
                    // 콘텐츠 영역 (빈 상자 - 나중에 실제 PDF가 오버레이됨)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white, // 테두리 제거, 배경색만 유지
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              '학생작품평가표 콘텐츠 영역 (${i + 1}/${workEvalDoc.pages.count})',
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
              final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.9; // 90% 스케일링
              
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
              
              print('학생작품평가표 페이지 ${i + 1}/${workEvalDoc.pages.count} 템플릿 기반 병합 완룼');
              print('템플릿: 헤더(04 학생작품평가표) + 콘텐츠 영역 + 푸터(순천향대)');
              print('콘텐츠 위치: (${contentCenterX.toStringAsFixed(1)}, ${contentCenterY.toStringAsFixed(1)}) 크기: ${finalWidth.toStringAsFixed(1)}x${finalHeight.toStringAsFixed(1)}');
            }
            
            workEvalDoc.dispose();
            print('학생작품평가표 PDF 병합 완룼');
          } else {
            print('학생작품평가표 URL 접근 실패: ${response.statusCode}');
          }
        } catch (e) {
          print('학생작품평가표 병합 실패: $e');
        }
      } else {
        print('학생작품평가표 URL이 없음: $workEvalUrl');
      }
      
      // 7. 강의자료 PDF 기본 템플릿 병합 (회전 없이)
      if (lectureMaterialUrl != null && lectureMaterialUrl!.isNotEmpty) {
        try {
          print('강의자료 PDF 기본 병합 시작');
          
          final response = await http.get(Uri.parse(lectureMaterialUrl!));
          if (response.statusCode == 200) {
            final lecturePdfBytes = response.bodyBytes;
            final lectureDoc = syncfusion.PdfDocument(inputBytes: lecturePdfBytes);
            
            print('강의자료 페이지 수: ${lectureDoc.pages.count}');
            
            // 강의자료의 각 페이지마다 템플릿 생성
            for (int i = 0; i < lectureDoc.pages.count; i++) {
              print('강의자료 페이지 ${i + 1}/${lectureDoc.pages.count} 템플릿 생성 시작');
              
              final sourcePage = lectureDoc.pages[i];
              final sourceTemplate = sourcePage.createTemplate();
              
              // 각 강의자료 페이지마다 템플릿 생성
              final pageDoc = pw.Document();
              pageDoc.addPage(pw.Page(
                pageFormat: PdfPageFormat.a4,
                theme: font != null ? pw.ThemeData.withFont(base: font) : null,
                build: (context) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    // 헤더 부분 (강의자료용)
                    pw.Padding(
                      padding: const pw.EdgeInsets.fromLTRB(40, 30, 40, 0),
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
                          pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                            fontSize: 14, color: PdfColors.black, font: font,
                          )),
                        ],
                      ),
                    ),
                    
                    pw.SizedBox(height: 20),
                    
                    // 콘텐츠 영역 (네모 테두리와 함께)
                    pw.Expanded(
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.fromLTRB(50, 0, 50, 0),
                        child: pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.black, width: 2), // 검은 테두리 추가
                            color: PdfColors.white,
                          ),
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(10), // 내부 여백
                            child: pw.Center(
                              child: pw.Text(
                                '강의자료 콘텐츠 영역',
                                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey400, font: font),
                              ),
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
              final contentScale = (contentScaleX < contentScaleY ? contentScaleX : contentScaleY) * 0.9; // 90% 스케일링
              
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
              
              print('강의자료 페이지 ${i + 1}/${lectureDoc.pages.count} 템플릿 기반 병합 완룼');
              print('템플릿: 헤더(05 강의자료) + 콘텐츠 영역 + 푸터(순천향대)');
              print('콘텐츠 위치: (${contentCenterX.toStringAsFixed(1)}, ${contentCenterY.toStringAsFixed(1)}) 크기: ${finalWidth.toStringAsFixed(1)}x${finalHeight.toStringAsFixed(1)}');
            }
            
            lectureDoc.dispose();
            print('강의자료 PDF 기본 병합 완룼');
          }
        } catch (e) {
          print('강의자료 병합 실패: $e');
        }
      } else {
        print('강의자료 URL이 없음: $lectureMaterialUrl');
      }
      
      final finalBytes = await finalDoc.save();
      finalDoc.dispose();
      
      // 페이지 수 제대로 확인
      var totalPages = 0;
      try {
        totalPages = finalDoc.pages.count;
      } catch (e) {
        print('페이지 카운트 오류: $e');
        totalPages = -1;
      }
      
      print('최종 PDF 생성 완룼 - 총 페이지: $totalPages');
      print('=== PDF 페이지 구성 ===');
      print('1페이지: 표지 (네이비 블루)');
      print('2페이지: INDEX');
      print('3페이지: 섹션 구분자');
      print('4페이지: 수업계획서 템플릿 (01 수업계획서)');
      print('5-7페이지: 실제 수업계획서 PDF 내용');
      print('========================');
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