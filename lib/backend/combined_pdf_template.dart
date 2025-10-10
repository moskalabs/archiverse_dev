import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '/backend/supabase/supabase.dart';

/// 표지 + INDEX 페이지를 한 번에 생성하는 템플릿
class CombinedPdfTemplate {
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
  
  /// 오류 시 표시할 위젯
  static pw.Widget _createErrorWidget() {
    return pw.Center(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(20),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.red, width: 2),
        ),
        child: pw.Text(
          '수업계획서를 불러올 수 없습니다.',
          style: pw.TextStyle(
            fontSize: 14,
            color: PdfColors.red,
          ),
        ),
      ),
    );
  }
  
  /// 수업계획서 파일 로드 (간단한 버전)
  static Future<pw.Widget> _loadCoursePlanImage(String fileUrl) async {
    try {
      print('수업계획서 파일 로드 시작: $fileUrl');
      
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        final fileBytes = response.bodyBytes;
        print('수업계획서 파일 로드 성공: ${fileBytes.length} bytes');
        
        // PDF 파일 처리
        if (fileUrl.toLowerCase().endsWith('.pdf')) {
          print('PDF 파일 발견');
          
          return pw.Center(
            child: pw.Container(
              padding: const pw.EdgeInsets.all(20),
              decoration: pw.BoxDecoration(
                color: PdfColors.green50,
                border: pw.Border.all(color: PdfColors.green, width: 2),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Text(
                    '수업계획서 PDF 로드 완료',
                    style: pw.TextStyle(
                      fontSize: 16,
                      color: PdfColors.green,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    '파일 크기: ${(fileBytes.length / 1024).toStringAsFixed(1)} KB',
                    style: pw.TextStyle(
                      fontSize: 12,
                      color: PdfColors.grey700,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'PDF 이미지 변환 기능 구현 예정',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // 이미지 파일인 경우
          return pw.Container(
            width: double.infinity,
            child: pw.Image(
              pw.MemoryImage(fileBytes),
              fit: pw.BoxFit.contain,
            ),
          );
        }
      } else {
        print('수업계획서 파일 로드 실패: HTTP ${response.statusCode}');
        return _createErrorWidget();
      }
    } catch (e) {
      print('수업계획서 파일 로드 오류: $e');
      return _createErrorWidget();
    }
  }
        } else {
          print('이미지 파일 처리 중...');
          // 이미지 파일인 경우
          return pw.Container(
            width: double.infinity,
            child: pw.Image(
              pw.MemoryImage(fileBytes),
              fit: pw.BoxFit.contain,
            ),
          );
        }
      } else {
        print('수업계획서 파일 로드 실패: HTTP ${response.statusCode}');
        return _createErrorWidget();
      }
    } catch (e) {
      print('수업계획서 파일 로드 오류: $e');
      return _createErrorWidget();
    }
  }
      } else {
        print('수업계획서 파일 로드 실패: HTTP ${response.statusCode}');
        return _createErrorWidget();
      }
    } catch (e) {
      print('수업계획서 파일 로드 오류: $e');
      return _createErrorWidget();
    }
  }
  
  /// 오류 시 표시할 위젯
  static pw.Widget _createErrorWidget() {
    return pw.Center(
      child: pw.Container(
        padding: const pw.EdgeInsets.all(20),
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.red, width: 2),
        ),
        child: pw.Text(
          '수업계획서를 불러올 수 없습니다.',
          style: pw.TextStyle(
            fontSize: 14,
            color: PdfColors.red,
          ),
        ),
      ),
    );
  }
  
  /// 모든 분반 교수 정보 생성
  static List<pw.Widget> _buildAllSectionInfo(List<ClassRow> sectionClasses, pw.Font? font, String courseName) {
    if (sectionClasses.isEmpty) {
      return [];
    }
    
    // 분반별 교수 이름만 정리 (교수는 첫 번째만 표시)
    final List<String> professorNames = [];
    
    for (final sectionClass in sectionClasses) {
      if (sectionClass.professor != null) {
        professorNames.add(sectionClass.professor!);
      }
    }
    
    // 실제 데이터베이스에서 학년 정보 가져오기
    final actualGrade = sectionClasses.isNotEmpty && sectionClasses.first.grade != null 
        ? sectionClasses.first.grade.toString() 
        : '0';
    
    // 최종 텍스트 구성: "순천향대학교 건축학과(학년) | 과목명 (학년학년) | 교수 이름1, 이름2, 이름3"
    final allProfessorsText = professorNames.isNotEmpty 
        ? '교수 ${professorNames.join(', ')}'
        : '교수 정보 없음';
    final fullInfoText = '순천향대학교 건축학과($actualGrade) | $courseName (${actualGrade}학년) | $allProfessorsText';
    
    return [
      pw.Text(
        fullInfoText,
        style: pw.TextStyle(
          fontSize: 10,
          color: PdfColors.grey700,
          font: font,
        ),
      ),
    ];
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
    print('Combined PDF 생성 시작');
    
    // 기본값 설정
    final displayYear = year ?? '2025';
    final displaySemester = semester ?? '1학기';
    final displayCourseName = courseName ?? '과목명';
    final displayProfessorName = professorName ?? '교수명';
    final displayGrade = grade ?? '학년';
    final displaySection = section ?? '분반';
    
    final pdf = pw.Document();
    
    // 맑은 고딕 폰트 로드
    final font = await _loadMalgunGothicFont();
    print('Combined PDF - 맑은 고딕 폰트 로드 결과: ${font != null ? '성공' : '실패 - 기본 폰트 사용'}');
    
    // 해당 과목의 모든 분반 정보 가져오기
    List<ClassRow> allSectionClasses = [];
    
    if (classId != null) {
      try {
        // 1. 현재 클래스 정보 가져오기
        final currentClass = await ClassTable().queryRows(
          queryFn: (q) => q.eq('id', classId),
        );
        
        if (currentClass.isNotEmpty) {
          final currentCourse = currentClass.first.course;
          final currentYear = currentClass.first.year;
          final currentSemester = currentClass.first.semester;
          final currentGrade = currentClass.first.grade;
          
          print('현재 클래스 정보: 과목=$currentCourse, 년도=$currentYear, 학기=$currentSemester, 학년=$currentGrade');
          
          // 2. 같은 과목의 모든 분반 가져오기 (null 체크 추가)
          if (currentCourse != null && currentYear != null && currentSemester != null && currentGrade != null) {
            allSectionClasses = await ClassTable().queryRows(
              queryFn: (q) => q
                  .eq('course', currentCourse)
                  .eq('year', currentYear)
                  .eq('semester', currentSemester)
                  .eq('grade', currentGrade),
            );
          } else {
            print('필수 데이터 누락: course=$currentCourse, year=$currentYear, semester=$currentSemester, grade=$currentGrade');
          }
          
          print('같은 과목의 모든 분반: ${allSectionClasses.length}개');
          for (final sectionClass in allSectionClasses) {
            print('- ${sectionClass.section}: ${sectionClass.professor}');
          }
        }
      } catch (e) {
        print('모든 분반 데이터 로드 실패: $e');
      }
    }
    
    // 수업계획서 데이터 가져오기
    String? coursePlanUrl;
    List<CourseplanRow> allCoursePlans = [];
    pw.Widget? coursePlanContent;
    
    if (classId != null) {
      try {
        // 해당 클래스의 모든 수업계획서 가져오기
        allCoursePlans = await CourseplanTable().queryRows(
          queryFn: (q) => q.eq('class', classId),
        );
        
        // 현재 분반의 수업계획서 URL 찾기
        print('\n======= 섹션 매칭 시도 =======');
        print('찾는 섹션: "$displaySection"');
        
        CourseplanRow? currentSectionPlan;
        for (final plan in allCoursePlans) {
          print('비교: DB섹션="${plan.section}" vs 입력섹션="$displaySection" -> 매칭: ${plan.section == displaySection}');
          if (plan.section == displaySection) {
            currentSectionPlan = plan;
            break;
          }
        }
        
        coursePlanUrl = currentSectionPlan?.url;
        print('매칭 결과: ${currentSectionPlan != null ? '발견' : '미발견'}');
        print('=====================================\n');
        
        print('\n======= 수업계획서 데이터 로드 결과 =======');
        print('- 총 ${allCoursePlans.length}개 계획서 발견');
        print('- 현재 분반: $displaySection');
        print('- 현재 분반 URL: $coursePlanUrl');
        
        // 모든 계획서 상세 정보 출력
        for (int i = 0; i < allCoursePlans.length; i++) {
          final plan = allCoursePlans[i];
          print('  [$i] class: ${plan.classField}, section: ${plan.section}, url: ${plan.url}');
        }
        print('==============================================\n');
        
        // 수업계획서 이미지 로드
        if (coursePlanUrl != null && coursePlanUrl!.isNotEmpty) {
          try {
            print('\n======= 수업계획서 이미지 로드 시도 =======');
            print('URL: $coursePlanUrl');
            coursePlanContent = await _loadCoursePlanImage(coursePlanUrl!);
            print('수업계획서 이미지 로드 성공');
            print('===============================================\n');
          } catch (e) {
            print('\n======= 수업계획서 이미지 로드 실패 =======');
            print('오류: $e');
            print('URL: $coursePlanUrl');
            print('===============================================\n');
            coursePlanContent = _createErrorWidget();
          }
        } else {
          print('\n======= 수업계획서 URL 없음 =======');
          print('coursePlanUrl: $coursePlanUrl');
          
          // 임시 테스트: 1분반일 때 하드코딩 URL 사용
          if (displaySection == '1분반') {
            final testUrl = 'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/courseplan/1754960509960000.pdf';
            print('테스트 URL 사용: $testUrl');
            try {
              coursePlanContent = await _loadCoursePlanImage(testUrl);
              print('1분반 테스트 이미지 로드 성공');
            } catch (e) {
              print('1분반 테스트 이미지 로드 실패: $e');
            }
          }
          print('==========================================\n');
        }
      } catch (e) {
        print('수업계획서 데이터 로드 실패: $e');
      }
    }

    // 1페이지: 표지
    print('1페이지 표지 생성 중...');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) {
          return pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColor.fromInt(0xFF273F5F), // 네이비 블루
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(40),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // 상단 로고 및 대학 정보
                  pw.Row(
                    children: [
                      pw.Container(
                        width: 70,
                        height: 70,
                        decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(15),
                        ),
                        child: pw.Center(
                          child: pw.Text(
                            'SA',
                            style: pw.TextStyle(
                              fontSize: 28,
                              fontWeight: pw.FontWeight.bold,
                              color: const PdfColor.fromInt(0xFF273F5F),
                              font: font,
                            ),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '순천향대학교 건축학과',
                            style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColors.white,
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                            ),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Text(
                            'Department of Architecture',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.white,
                              font: font,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  pw.Spacer(flex: 2),
                  
                  // 년도 학기 정보
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      '$displayYear년도 $displaySemester',
                      style: pw.TextStyle(
                        fontSize: 18,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        font: font,
                      ),
                    ),
                  ),
                  
                  pw.Spacer(flex: 1),
                  
                  // 메인 과목명
                  pw.Center(
                    child: pw.Text(
                      displayCourseName,
                      style: pw.TextStyle(
                        fontSize: 48,
                        color: PdfColors.white,
                        fontWeight: pw.FontWeight.bold,
                        letterSpacing: 3,
                        font: font,
                      ),
                    ),
                  ),
                  
                  pw.Spacer(flex: 2),
                  
                  // 하단 정보
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        '교수: $displayProfessorName',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
                          font: font,
                        ),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text(
                        '$displayGrade $displaySection',
                        style: pw.TextStyle(
                          fontSize: 16,
                          color: PdfColors.white,
                          fontWeight: pw.FontWeight.bold,
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

    // 2페이지: INDEX
    print('2페이지 INDEX 생성 중...');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(40),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // INDEX 타이틀
                pw.Center(
                  child: pw.Text(
                    'INDEX',
                    style: pw.TextStyle(
                      fontSize: 36,
                      color: PdfColors.black,
                      fontWeight: pw.FontWeight.bold,
                      font: font,
                    ),
                  ),
                ),
                
                pw.SizedBox(height: 40),
                
                // 과목명 섹션
                pw.Text(
                  displayCourseName,
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
                
                pw.SizedBox(height: 8),
                
                pw.Text(
                  '과제의 기초',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    font: font,
                  ),
                ),
                
                pw.Text(
                  '과제와 주요 설계 요약',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    font: font,
                  ),
                ),
                
                pw.Text(
                  '공통 주제별 결과 제시서',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: PdfColors.grey700,
                    font: font,
                  ),
                ),
                
                pw.SizedBox(height: 30),
                
                // 교수 및 분반 섹션
                pw.Text(
                  '$displayProfessorName 교수 / $displaySection',
                  style: pw.TextStyle(
                    fontSize: 18,
                    color: PdfColors.black,
                    fontWeight: pw.FontWeight.bold,
                    font: font,
                  ),
                ),
                
                pw.SizedBox(height: 20),
                
                // 목차 리스트
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

    // 3페이지: 분반별 섹션 구분자 (3_section_divider) - 스크린샷 스타일
    print('3페이지 분반별 섹션 구분자 생성 중...');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) {
          return pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.white, // 흰색 배경
            ),
            child: pw.Stack(
              children: [
                                // 하단 기하학적 패턴 (간단한 버전)
                pw.Positioned(
                  bottom: 0,
                  right: 0,
                  child: pw.Container(
                    width: 400,
                    height: 200,
                    child: pw.Stack(
                      children: [
                        // 왼쪽 하단 사각형 영역
                        pw.Positioned(
                          left: 0,
                          bottom: 0,
                          child: pw.Container(
                            width: 150,
                            height: 150,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.grey200,
                            ),
                          ),
                        ),
                        // 수직선 패턴 (오른쪽)
                        ...List.generate(20, (i) => pw.Positioned(
                          right: i * 10.0,
                          bottom: 0,
                          child: pw.Container(
                            width: 2,
                            height: 200 - (i * 8.0),
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.grey300,
                            ),
                          ),
                        )),
                        // 수평선 패턴 (왼쪽 하단)
                        ...List.generate(12, (i) => pw.Positioned(
                          left: 0,
                          bottom: i * 12.0,
                          child: pw.Container(
                            width: 150 - (i * 8.0),
                            height: 1,
                            decoration: const pw.BoxDecoration(
                              color: PdfColors.grey300,
                            ),
                          ),
                        )),
                      ],
                    ),
                  ),
                      ),
                
                // 메인 컨텐츠
                pw.Positioned.fill(
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(40),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        // 상단 구분선
                        pw.Container(
                          width: 400,
                          height: 2,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.black,
                          ),
                        ),
                        
                        pw.SizedBox(height: 40),
                        
                        // 메인 텍스트
                        pw.Text(
                          '$displayCourseName / $displaySection / 담당교수 $displayProfessorName',
                          style: pw.TextStyle(
                            fontSize: 20,
                            color: PdfColors.black,
                            fontWeight: pw.FontWeight.bold,
                            font: font,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        
                        pw.SizedBox(height: 40),
                        
                        // 하단 구분선
                        pw.Container(
                          width: 400,
                          height: 2,
                          decoration: const pw.BoxDecoration(
                            color: PdfColors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                      ),
                
                // 왼쪽 하단 대학 정보
                pw.Positioned(
                  bottom: 30,
                  left: 40,
                  child: pw.Text(
                    'Department of Architecture, Soonchunhyang Univ.',
                    style: pw.TextStyle(
                      fontSize: 10,
                      color: PdfColors.grey600,
                      font: font,
                    ),
                  ),
              ),
              ],
            ),
          );
        },
      ),
    );

    // 4페이지: 수업계획서 (4_course_plan)
    print('4페이지 수업계획서 생성 중...');
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        theme: font != null ? pw.ThemeData.withFont(base: font) : null,
        build: (context) {
          return pw.Container(
            decoration: const pw.BoxDecoration(
              color: PdfColors.white,
            ),
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(30),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // 상단 헤더
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      // 왼쪽: 01 수업계획서
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 40,
                            height: 30,
                            decoration: const pw.BoxDecoration(
                              color: PdfColor.fromInt(0xFF273F5F),
                            ),
                            child: pw.Center(
                              child: pw.Text(
                                '01',
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  color: PdfColors.white,
                                  fontWeight: pw.FontWeight.bold,
                                  font: font,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(width: 15),
                          pw.Text(
                            '수업계획서',
                            style: pw.TextStyle(
                              fontSize: 20,
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold,
                              font: font,
                            ),
                          ),
                        ],
                      ),
                      // 오른쪽: 년도 학기
                      pw.Text(
                        '$displayYear년도 $displaySemester',
                        style: pw.TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                          font: font,
                        ),
                      ),
                    ],
                  ),
                  
                  pw.SizedBox(height: 30),
                  
                  // 중앙 컨텐츠 영역 (수업계획서 테이블이 들어갈 곳)
                  pw.Expanded(
                    child: pw.Container(
                      width: double.infinity,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          color: PdfColors.grey400,
                          width: 1,
                        ),
                      ),
                      child: pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: coursePlanContent ?? pw.Center(
                          child: pw.Text(
                            '수업계획서를 찾을 수 없습니다.',
                            style: pw.TextStyle(
                              fontSize: 12,
                              color: PdfColors.grey500,
                              font: font,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  pw.SizedBox(height: 20),
                  
                  // 하단 대학 정보 및 모든 분반 교수 정보
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      // 모든 분반 교수 정보
                      if (allSectionClasses.isNotEmpty) ...
                        _buildAllSectionInfo(allSectionClasses, font, displayCourseName),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    print('Combined PDF - 4페이지 생성 완료');
    return pdf.save();
  }
}