import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;
import '/backend/supabase/supabase.dart';

/// 주차별 설계진행표 표지 템플릿 (학생 목록 포함)
class WeeklyProgressCoverTemplate {
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
      return null;
    }
  }
  
  /// 주차별 설계진행표 표지 페이지를 finalDoc에 추가하고 학생 목록 반환
  static Future<List<String>> addWeeklyProgressCover({
    required syncfusion.PdfDocument finalDoc,
    int? classId,
    String? year,
    String? semester,
    String? courseName,
    String? professorName,
    String? grade,
    String? section,
    required Function(double, String) updateProgress,
    double startProgress = 0.8,
    double endProgress = 0.85,
  }) async {
    try {
      print('======= 주차별 설계진행표 표지 생성 시작 =======');
      updateProgress(startProgress, '주차별 설계진행표 표지 생성 중');
      
      // subjectportpolio 테이블에서 해당 분반 학생 목록 조회 (중복 제거)
      List<String> studentNames = [];
      if (classId != null) {
        try {
          final portfolios = await SubjectportpolioTable().queryRows(
            queryFn: (q) => q.eq('class', classId),
          );
          
          // student_name을 가져와서 중복 제거 (Set 사용)
          final uniqueNames = <String>{};
          for (final portfolio in portfolios) {
            final studentName = portfolio.studentName;
            if (studentName != null && studentName.isNotEmpty) {
              uniqueNames.add(studentName);
            }
          }
          
          studentNames = uniqueNames.toList();
          studentNames.sort(); // 이름순 정렬
          
          print('${section ?? '분반'} 학생 수: ${studentNames.length}명 (총 포트폴리오: ${portfolios.length}개)');
          print('학생 목록: ${studentNames.join(', ')}');
        } catch (e) {
          print('학생 목록 조회 실패: $e');
          studentNames = ['학생 목록을 불러올 수 없습니다'];
        }
      } else {
        studentNames = ['클래스 ID가 없습니다'];
      }
      
      final font = await _loadMalgunGothicFont();
      
      // 주차별 설계진행표 표지 페이지 생성
      final coverDoc = pw.Document();
      coverDoc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) => pw.Padding(
          padding: const pw.EdgeInsets.all(40),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // 헤더 부분
              pw.Row(
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
                    pw.Text('주차별 설계 진행표', style: pw.TextStyle(
                      fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                    )),
                  ]),
                  pw.Text('${year ?? '2025'}년도 ${semester ?? '1학기'}', style: pw.TextStyle(
                    fontSize: 14, color: PdfColors.black, font: font,
                  )),
                ],
              ),
              
              pw.SizedBox(height: 30),
              
              // 과목 정보
              pw.Text(
                courseName ?? '과목명',
                style: pw.TextStyle(
                  fontSize: 24,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              
              pw.SizedBox(height: 10),
              
              pw.Text(
                '교수 ${professorName ?? '교수명'} | ${grade ?? '학년'} ${section ?? '분반'}',
                style: pw.TextStyle(
                  fontSize: 16,
                  color: PdfColors.black,
                  font: font,
                ),
              ),
              
              pw.SizedBox(height: 30),
              
              // 학생 목록 섹션
              pw.Text(
                '목록',
                style: pw.TextStyle(
                  fontSize: 18,
                  color: PdfColors.black,
                  fontWeight: pw.FontWeight.bold,
                  font: font,
                ),
              ),
              
              pw.SizedBox(height: 15),
              
              // 학생 목록을 2열로 배치
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    ...studentNames.map((name) {
                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 3),
                        child: pw.Text(
                          name, // 이름만 표시, 번호 없음
                          style: pw.TextStyle(
                            fontSize: 12,
                            color: PdfColors.black,
                            font: font,
                          ),
                        ),
                      );
                    }).toList(),
                    
                    // 학생 수가 적을 때 여백 확보
                    if (studentNames.length < 20) ...[
                      ...List.generate(20 - studentNames.length, (index) => 
                        pw.SizedBox(height: 15)
                      ),
                    ],
                  ],
                ),
              ),
              
              pw.SizedBox(height: 20),
              
              // 하단 디자인 요소 (스크린샷과 유사한 기하학적 패턴)
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                  width: 200,
                  height: 100,
                  child: pw.Stack(
                    children: [
                      // 수평선들 (스크린샷 스타일)
                      ...List.generate(15, (i) {
                        final lineWidth = 200 * (1 - i / 15);
                        return pw.Positioned(
                          top: (100 / 15) * i,
                          left: 0,
                          child: pw.Container(
                            width: lineWidth,
                            height: 1,
                            color: PdfColors.grey300,
                          ),
                        );
                      }),
                      // 수직선들 (오른쪽)
                      ...List.generate(10, (i) {
                        final lineHeight = 100 * (1 - i / 10);
                        final leftPosition = 200 * 0.7 + (200 * 0.3 / 10) * i;
                        return pw.Positioned(
                          left: leftPosition,
                          top: 0,
                          child: pw.Container(
                            width: 1,
                            height: lineHeight,
                            color: PdfColors.grey300,
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
      
      // 표지를 finalDoc에 추가
      final coverBytes = await coverDoc.save();
      final coverSyncDoc = syncfusion.PdfDocument(inputBytes: coverBytes);
      
      final coverSourcePage = coverSyncDoc.pages[0];
      final coverNewPage = finalDoc.pages.add();
      final coverTemplate = coverSourcePage.createTemplate();
      
      coverNewPage.graphics.drawPdfTemplate(coverTemplate, ui.Offset.zero);
      coverSyncDoc.dispose();
      
      updateProgress(endProgress, '주차별 설계진행표 표지 완료');
      print('======= 주차별 설계진행표 표지 생성 완료 =======');
      print('학생 수: ${studentNames.length}명');
      
      return studentNames; // 학생 목록 반환
      
    } catch (e) {
      print('주차별 설계진행표 표지 생성 실패: $e');
      updateProgress(endProgress, '주차별 설계진행표 표지 생성 실패');
      return []; // 오류 시 빈 리스트 반환
    }
  }
}