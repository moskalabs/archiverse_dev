import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;

/// 학생별 주차별 설계진행표 표지 템플릿
class StudentWeeklyProgressCoverTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 학생별 표지 페이지를 finalDoc에 추가
  static Future<void> addStudentCoverPage({
    required syncfusion.PdfDocument finalDoc,
    required String studentName,
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    String? studentGrade, // 학생 성적 (A+, B+ 등)
  }) async {
    try {
      print('학생 표지 생성: $studentName');
      
      final font = await _loadMalgunGothicFont();
      
      // 학생별 표지 페이지 생성
      final studentCoverDoc = pw.Document();
      studentCoverDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4.copyWith(
                marginLeft: 0,
                marginRight: 0,
                marginTop: 0,
                marginBottom: 0,
              ),
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(40),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 왼쪽 상단: 과목명
              pw.Text(
                courseName ?? '건축설계 9',
                style: pw.TextStyle(
                  fontSize: 32,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              
              pw.SizedBox(height: 10),
              
              // 왼쪽: 교수, 학년, 분반 정보
              pw.Text(
                '교수 ${professorName ?? '교수명'} | ${grade ?? '5학년'} ${section ?? '1분반'}',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey700,
                  font: font,
                ),
              ),
              
              pw.SizedBox(height: 5),
              
              pw.Text(
                '06 주차별 설계 진행표',
                style: pw.TextStyle(
                  fontSize: 14,
                  color: PdfColors.grey700,
                  font: font,
                ),
              ),
              
              pw.Spacer(flex: 2),
              
              // 중앙: 학생 이름과 성적
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.SizedBox(width: 100), // 왼쪽 여백
                  
                  // 학생 이름 (중앙)
                  pw.Text(
                    studentName,
                    style: pw.TextStyle(
                      fontSize: 36,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      font: font,
                    ),
                  ),
                  
                  pw.Spacer(),
                  
                  // 성적은 아직 미구현 - 제거
                  // if (studentGrade != null)
                  //   pw.Container(...),
                ],
              ),
              
              pw.Spacer(flex: 2),
              
              // 하단: 기하학적 디자인 요소 (스크린샷 스타일)
              pw.Align(
                alignment: pw.Alignment.bottomRight,
                child: pw.Container(
                  width: 250,
                  height: 200,
                  child: pw.Stack(
                    children: [
                      // 수평선들 (왼쪽에서 오른쪽으로 점점 짧아짐)
                      ...List.generate(25, (i) {
                        final lineWidth = 250 * (1 - i / 25);
                        return pw.Positioned(
                          top: (200 / 25) * i,
                          left: 0,
                          child: pw.Container(
                            width: lineWidth,
                            height: 1.5,
                            color: PdfColors.grey400,
                          ),
                        );
                      }),
                      // 수직선들 (오른쪽 부분)
                      ...List.generate(20, (i) {
                        final lineHeight = 200 * (1 - i / 20);
                        final leftPosition = 250 * 0.6 + (250 * 0.4 / 20) * i;
                        return pw.Positioned(
                          left: leftPosition,
                          top: 0,
                          child: pw.Container(
                            width: 1.5,
                            height: lineHeight,
                            color: PdfColors.grey400,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              
              // 하단 푸터
              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 10),
                child: pw.Text(
                  'Department of Architecture, Soonchunhyang Univ.',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey600,
                    font: font,
                  ),
                  textAlign: pw.TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ));
      
      // 학생 표지를 finalDoc에 추가
      final coverBytes = await studentCoverDoc.save();
      final coverSyncDoc = syncfusion.PdfDocument(inputBytes: coverBytes);
      
      final coverSourcePage = coverSyncDoc.pages[0];
      final coverNewPage = finalDoc.pages.add();
      final coverTemplate = coverSourcePage.createTemplate();
      
      coverNewPage.graphics.drawPdfTemplate(coverTemplate, ui.Offset.zero);
      coverSyncDoc.dispose();
      
      print('학생 표지 생성 완료: $studentName');
      
    } catch (e) {
      print('학생 표지 생성 실패 ($studentName): $e');
    }
  }
  
  /// 모든 학생의 표지를 추가
  static Future<void> addAllStudentCovers({
    required syncfusion.PdfDocument finalDoc,
    required List<String> studentNames,
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    required Function(double, String) updateProgress,
    double startProgress = 0.9,
    double endProgress = 0.95,
  }) async {
    print('======= 모든 학생 표지 생성 시작 (총 ${studentNames.length}명) =======');
    
    for (int i = 0; i < studentNames.length; i++) {
      final studentName = studentNames[i];
      
      // 진행률 업데이트
      final progressValue = startProgress + (i / studentNames.length) * (endProgress - startProgress);
      updateProgress(progressValue, '학생 표지 생성 중 (${i + 1}/${studentNames.length}): $studentName');
      
      // 각 학생별 표지 추가 (성적은 일단 null로, 나중에 추가 가능)
      await addStudentCoverPage(
        finalDoc: finalDoc,
        studentName: studentName,
        year: year,
        semester: semester,
        courseName: courseName,
        professorName: professorName,
        grade: grade,
        section: section,
        studentGrade: null, // 성적 정보는 나중에 조회 가능
      );
    }
    
    updateProgress(endProgress, '모든 학생 표지 생성 완료');
    print('======= 모든 학생 표지 생성 완료 (${studentNames.length}명) =======');
  }
}