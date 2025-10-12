import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart' as syncfusion;
import 'dart:ui' as ui;
import '/backend/supabase/supabase.dart';

/// 최종 4페이지 PDF 템플릿 (크기 조정 포함)
class Final4PageTemplate {
  /// 맑은 고딕 폰트 로드
  static Future<pw.Font?> _loadMalgunGothicFont() async {
    try {
      final fontData = await rootBundle.load('assets/fonts/malgun.ttf');
      return pw.Font.ttf(fontData);
    } catch (e) {
      print('맑은 고딕 폰트 로드 실패: $e');
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
    print('Final 4Page PDF 생성 시작');
    
    // 기본값 설정
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

    // 최종 PDF 문서 생성 (Syncfusion 사용)
    final finalDoc = syncfusion.PdfDocument();
    
    try {
      // 1. 기본 4페이지 템플릿 생성 (pw.Document)
      final templateDoc = pw.Document();
      final font = await _loadMalgunGothicFont();
      
      // 표지 페이지
      templateDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: font != null ? pw.ThemeData.withFont(base: font) : null,
          build: (context) {
            return pw.Container(
              decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
              child: pw.Padding(
                padding: const pw.EdgeInsets.all(40),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      children: [
                        pw.Container(
                          width: 70, height: 70,
                          decoration: pw.BoxDecoration(
                            color: PdfColors.white,
                            borderRadius: pw.BorderRadius.circular(15),
                          ),
                          child: pw.Center(
                            child: pw.Text('SA', style: pw.TextStyle(
                              fontSize: 28, fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xFF273F5F), font: font,
                            )),
                          ),
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
                      ],
                    ),
                    pw.Spacer(flex: 2),
                    pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text('$displayYear년도 $displaySemester', style: pw.TextStyle(
                        fontSize: 18, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                      )),
                    ),
                    pw.Spacer(flex: 1),
                    pw.Center(
                      child: pw.Text(displayCourseName, style: pw.TextStyle(
                        fontSize: 48, color: PdfColors.white, fontWeight: pw.FontWeight.bold, letterSpacing: 3, font: font,
                      )),
                    ),
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
            );
          },
        ),
      );

      // INDEX 페이지
      templateDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: font != null ? pw.ThemeData.withFont(base: font) : null,
          build: (context) {
            return pw.Padding(
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
            );
          },
        ),
      );

      // 섹션 구분자 페이지
      templateDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: font != null ? pw.ThemeData.withFont(base: font) : null,
          build: (context) {
            return pw.Padding(
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
            );
          },
        ),
      );

      // 수업계획서 템플릿 페이지
      templateDoc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: font != null ? pw.ThemeData.withFont(base: font) : null,
          build: (context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.all(30),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 40, height: 30,
                            decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFF273F5F)),
                            child: pw.Center(
                              child: pw.Text('01', style: pw.TextStyle(
                                fontSize: 16, color: PdfColors.white, fontWeight: pw.FontWeight.bold, font: font,
                              )),
                            ),
                          ),
                          pw.SizedBox(width: 15),
                          pw.Text('수업계획서', style: pw.TextStyle(
                            fontSize: 20, color: PdfColors.black, fontWeight: pw.FontWeight.bold, font: font,
                          )),
                        ],
                      ),
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
                              ? '수업계획서 PDF 발견\n다음 페이지부터 실제 내용 표시\n\nURL: $coursePlanUrl'
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
            );
          },
        ),
      );

      // 2. 기본 템플릿을 Syncfusion에 추가
      final templateBytes = await templateDoc.save();
      final templateSyncDoc = syncfusion.PdfDocument(inputBytes: templateBytes);
      
      for (int i = 0; i < templateSyncDoc.pages.count; i++) {
        final sourcePage = templateSyncDoc.pages[i];
        final newPage = finalDoc.pages.add();
        final template = sourcePage.createTemplate();
        newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
        print('템플릿 페이지 ${i + 1} 추가 완료');
      }
      templateSyncDoc.dispose();
      
      // 3. 수업계획서 PDF 병합 (크기 조정 포함)
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
              
              // 마진을 적용하여 잘림 방지 (BoxFit.contain 효과)
              final margin = 20.0; // 좌우상하 20px 마진
              
              // 페이지 크기 정보 확인
              final pageSize = newPage.getClientSize();
              final templateSize = template.size;
              print('페이지 크기: ${pageSize.width}x${pageSize.height}, 템플릿 크기: ${templateSize.width}x${templateSize.height}');
              
              // 스케일 계산 (contain 효과: 마진을 고려하여 전체가 들어가도록)
              final availableWidth = pageSize.width - (margin * 2);
              final availableHeight = pageSize.height - (margin * 2);
              final scaleX = availableWidth / templateSize.width;
              final scaleY = availableHeight / templateSize.height;
              final scale = (scaleX < scaleY ? scaleX : scaleY).clamp(0.3, 0.9); // 0.3~0.9 사이로 제한
              
              print('스케일 계산: scaleX=$scaleX, scaleY=$scaleY, 최종 scale=$scale');
              
              try {
                // Transform Matrix 사용하여 크기 조정 및 중앙 정렬
                newPage.graphics.save();
                
                // 중앙 정렬을 위한 오프셋 계산
                final scaledWidth = templateSize.width * scale;
                final scaledHeight = templateSize.height * scale;
                final centerX = (pageSize.width - scaledWidth) / 2;
                final centerY = (pageSize.height - scaledHeight) / 2;
                
                // Transform 적용: 이동 -> 스케일
                newPage.graphics.translateTransform(centerX, centerY);
                newPage.graphics.scaleTransform(scale, scale);
                
                // PDF 템플릿 그리기
                newPage.graphics.drawPdfTemplate(template, ui.Offset.zero);
                
                newPage.graphics.restore();
                print('수업계획서 페이지 ${i + 1} 병합 완료 (스케일: ${scale.toStringAsFixed(2)})');
                
              } catch (transformError) {
                print('Transform 실패: $transformError, 기본 방식 사용');
                // 실패 시 단순 마진만 적용
                newPage.graphics.drawPdfTemplate(template, ui.Offset(margin, margin));
                print('수업계획서 페이지 ${i + 1} 병합 완료 (마진만 적용)');
              }
              
              print('수업계획서 페이지 ${i + 1} 병합 완료 (마진 적용)');
            }
            
            courseDoc.dispose();
            print('수업계획서 PDF 병합 완료');
          }
        } catch (e) {
          print('수업계획서 병합 실패: $e');
        }
      }
      
      // 4. 최종 결과
      final finalBytes = await finalDoc.save();
      finalDoc.dispose();
      
      print('최종 PDF 생성 완료');
      print('총 페이지 수: ${finalDoc.pages.count}');
      
      return Uint8List.fromList(finalBytes);
      
    } catch (e) {
      print('PDF 생성 오류: $e');
      finalDoc.dispose();
      
      // 오류 시 기본 4페이지만 반환
      final errorDoc = pw.Document();
      errorDoc.addPage(
        pw.Page(
          build: (context) {
            return pw.Center(
              child: pw.Text('PDF 생성 오류: $e', style: pw.TextStyle(fontSize: 14, color: PdfColors.red)),
            );
          },
        ),
      );
      return errorDoc.save();
    }
  }
}