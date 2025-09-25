// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdf/pdf.dart';

// 순천향대학교 건축설계9 포트폴리오 자동 병합 시스템
// 2024년도 1학기 - SPC 11 연구기반 종합설계
Future<void> generateArchitecturePortfolio() async {
  FFAppState().update(() {
    FFAppState().downloadProgress = 0.0;
    FFAppState().downloadProgressMessage = '포트폴리오 생성 준비 중...';
  });

  try {
    final dynamic courseDataResponse = await SupaFlow.client
        .from('course_info')
        .select()
        .eq('semester', '2024-1')
        .single();
    final Map<String, dynamic> courseData =
        Map<String, dynamic>.from(courseDataResponse as Map);

    final dynamic studentsDataResponse = await SupaFlow.client
        .from('students')
        .select('*, weekly_progress(*), critiques(*)')
        .eq('class_section', 1)
        .order('name');
    final List<dynamic> studentsData =
        List<dynamic>.from(studentsDataResponse as List);

    final PdfDocument document = PdfDocument();
    document.pageSettings.margins.all = 0;

    _createIndexPage(document);
    _createCoverPage(document);
    _createCourseOverviewPage(document, courseData);
    _createWeeklyPlanPages(document, courseData);
    _createSectionDividerPage(document, '천준호 교수 / 1분반');
    _createCoursePlanPage(document, courseData);
    _createAttendancePage(document, studentsData);
    _createGradeRecordPage(document, studentsData);
    _createEvaluationPages(document, studentsData);
    _createLectureMaterialsSection(document);
    await _createWeeklyProgressSection(document, studentsData);
    await _createMidtermSection(document, studentsData);
    await _createFinalSection(document, studentsData);

    final Uint8List bytes = Uint8List.fromList(await document.save());
    document.dispose();

    _downloadPdf(bytes, 'Architecture9_Portfolio_2024-1.pdf');

    FFAppState().update(() {
      FFAppState().downloadProgress = 1.0;
      FFAppState().downloadProgressMessage = '포트폴리오 생성 완료!';
    });
  } catch (e) {
    print('포트폴리오 생성 오류: $e');
    FFAppState().update(() {
      FFAppState().downloadProgressMessage = '오류 발생: $e';
    });
  }
}

class SCHColors {
  static final PdfColor navy = PdfColor(28, 48, 73);
  static final PdfColor darkNavy = PdfColor(20, 35, 54);
  static final PdfColor orange = PdfColor(255, 107, 63);
  static final PdfColor purple = PdfColor(103, 58, 183);
  static final PdfColor lightBlue = PdfColor(142, 169, 194);
  static final PdfColor lightGray = PdfColor(240, 240, 240);
  static final PdfColor mediumGray = PdfColor(150, 150, 150);
}

void _drawSALogo(PdfGraphics graphics, double x, double y, double size) {
  final PdfPen orangePen = PdfPen(SCHColors.orange, width: size / 15);
  for (int i = 0; i < 12; i++) {
    final double offset = i * size / 10;
    graphics.drawLine(
      orangePen,
      ui.Offset(x + offset, y + size),
      ui.Offset(x + size, y + offset),
    );
  }
}

void _createIndexPage(PdfDocument document) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    'INDEX',
    PdfStandardFont(PdfFontFamily.helvetica, 48, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(0, 100, page.size.width, 60),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
  );

  final List<String> indexItems = <String>[
    '건축설계9',
    '교과목 개요',
    '교과목 주요 성과 요약',
    '공통 주차별 강의 계획서',
    '',
    '천준호 교수 / 1분반',
    '01 수업계획서',
    '02 출석부',
    '03 성적기록표',
    '04 학생 작품 평가표',
    '05 강의자료',
    '06 주차별 설계 진행표',
    '07 중간 결과물',
    '08 최종 결과물',
  ];

  double yPos = 250;
  for (final String item in indexItems) {
    if (item.isEmpty) {
      yPos += 20;
      continue;
    }

    final PdfFont font = item.startsWith('0')
        ? PdfStandardFont(PdfFontFamily.helvetica, 14)
        : PdfStandardFont(PdfFontFamily.helvetica, 16,
            style: PdfFontStyle.bold);

    graphics.drawString(
      item,
      font,
      bounds: ui.Rect.fromLTWH(100, yPos, 400, 25),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );
    yPos += 30;
  }

  _drawSALogo(graphics, page.size.width - 250, page.size.height - 250, 200);
}

void _createCoverPage(PdfDocument document) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(SCHColors.navy),
  );

  graphics.drawString(
    '순천향대학교 건축학과',
    PdfStandardFont(PdfFontFamily.helvetica, 14),
    bounds: ui.Rect.fromLTWH(50, 50, 300, 20),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    '2024년도 1학기',
    PdfStandardFont(PdfFontFamily.helvetica, 16),
    bounds: ui.Rect.fromLTWH(page.size.width - 150, 50, 100, 20),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    '건축설계 9',
    PdfStandardFont(PdfFontFamily.helvetica, 72, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(
      0,
      page.size.height * 0.35,
      page.size.width,
      100,
    ),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    '교수 천준호 | 5학년 1분반',
    PdfStandardFont(PdfFontFamily.helvetica, 20),
    bounds: ui.Rect.fromLTWH(
      0,
      page.size.height * 0.45,
      page.size.width,
      30,
    ),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    'SPC 11 연구기반 종합설계',
    PdfStandardFont(PdfFontFamily.helvetica, 18),
    bounds: ui.Rect.fromLTWH(
      0,
      page.size.height * 0.5,
      page.size.width,
      30,
    ),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  _drawSALogo(graphics, page.size.width - 250, page.size.height - 250, 200);
}

void _createCourseOverviewPage(
  PdfDocument document,
  Map<String, dynamic> courseData,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    '교과목 개요',
    PdfStandardFont(PdfFontFamily.helvetica, 36, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final String overview = courseData['overview'] as String? ??
      '교과목 개요 정보가 아직 등록되지 않았습니다.';

  final PdfTextElement textElement = PdfTextElement(
    text: overview,
    font: PdfStandardFont(PdfFontFamily.helvetica, 14),
    brush: PdfSolidBrush(PdfColor(50, 50, 50)),
  );

  final PdfLayoutResult result = textElement.draw(
    page: page,
    bounds: ui.Rect.fromLTWH(60, 120, page.size.width - 120, 600),
  )!;

  graphics.drawLine(
    PdfPen(SCHColors.lightBlue, width: 2),
    ui.Offset(60, result.bounds.bottom + 20),
    ui.Offset(page.size.width - 60, result.bounds.bottom + 20),
  );
}

void _createWeeklyPlanPages(
  PdfDocument document,
  Map<String, dynamic> courseData,
) {
  final List<dynamic> weeklyPlans =
      courseData['weekly_plan'] as List<dynamic>? ?? <dynamic>[];

  if (weeklyPlans.isEmpty) {
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;
    graphics.drawString(
      '공통 주차별 강의 계획서',
      PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );
    graphics.drawString(
      '등록된 강의 계획서가 없습니다.',
      PdfStandardFont(PdfFontFamily.helvetica, 16),
      bounds: ui.Rect.fromLTWH(60, 120, page.size.width - 120, 40),
    );
    return;
  }

  int weekNumber = 1;
  for (final dynamic plan in weeklyPlans) {
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;

    graphics.drawRectangle(
      bounds: ui.Rect.fromLTWH(0, 0, page.size.width, 140),
      brush: PdfSolidBrush(SCHColors.lightGray),
    );

    graphics.drawString(
      'Week ${weekNumber.toString().padLeft(2, '0')}',
      PdfStandardFont(PdfFontFamily.helvetica, 24, style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(60, 40, 200, 40),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );

    final String topic = plan['topic'] as String? ?? '주제 미정';
    final String goals = plan['goals'] as String? ?? '학습 목표 미정';
    final String contents = plan['contents'] as String? ?? '강의 내용 미정';

    final PdfTextElement topicElement = PdfTextElement(
      text: '주제\n$topic',
      font: PdfStandardFont(PdfFontFamily.helvetica, 16,
          style: PdfFontStyle.bold),
    );

    topicElement.draw(
      page: page,
      bounds: ui.Rect.fromLTWH(60, 180, page.size.width - 120, 200),
    );

    final PdfTextElement goalsElement = PdfTextElement(
      text: '학습 목표\n$goals',
      font: PdfStandardFont(PdfFontFamily.helvetica, 14),
    );

    goalsElement.draw(
      page: page,
      bounds: ui.Rect.fromLTWH(60, 360, page.size.width - 120, 160),
    );

    final PdfTextElement contentsElement = PdfTextElement(
      text: '강의 내용\n$contents',
      font: PdfStandardFont(PdfFontFamily.helvetica, 14),
    );

    contentsElement.draw(
      page: page,
      bounds: ui.Rect.fromLTWH(60, 520, page.size.width - 120, 200),
    );

    weekNumber++;
  }
}

void _createSectionDividerPage(PdfDocument document, String title) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  graphics.drawString(
    title,
    PdfStandardFont(PdfFontFamily.helvetica, 48, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(0, page.size.height * 0.4, page.size.width, 60),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  _drawSALogo(graphics, page.size.width - 250, page.size.height - 250, 200);
}

void _createCoursePlanPage(
  PdfDocument document,
  Map<String, dynamic> courseData,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    '01 수업계획서',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final Map<String, dynamic> plan =
      courseData['course_plan'] as Map<String, dynamic>? ?? <String, dynamic>{};
  if (plan.isEmpty) {
    graphics.drawString(
      '수업계획서 데이터가 없습니다.',
      PdfStandardFont(PdfFontFamily.helvetica, 16),
      bounds: ui.Rect.fromLTWH(60, 120, page.size.width - 120, 40),
    );
    return;
  }

  double yPos = 140;
  plan.forEach((String key, dynamic value) {
    graphics.drawString(
      key,
      PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(60, yPos, 150, 20),
      brush: PdfSolidBrush(SCHColors.purple),
    );
    graphics.drawString(
      '${value ?? ''}',
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: ui.Rect.fromLTWH(220, yPos, page.size.width - 280, 20),
    );
    yPos += 28;
  });
}

void _createAttendancePage(
  PdfDocument document,
  List<dynamic> students,
) {
  PdfPage currentPage = document.pages.add();
  PdfGraphics graphics = currentPage.graphics;

  graphics.drawString(
    '02 출석부',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, currentPage.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  double yPos = 120;
  for (final dynamic student in students) {
    if (yPos > currentPage.size.height - 80) {
      graphics.drawString(
        '계속',
        PdfStandardFont(PdfFontFamily.helvetica, 12),
        bounds: ui.Rect.fromLTWH(
          currentPage.size.width - 120,
          currentPage.size.height - 40,
          100,
          20,
        ),
      );
      currentPage = document.pages.add();
      graphics = currentPage.graphics;
      yPos = 80;
    }

    final String name = student['name'] as String? ?? '이름 미상';
    final String id = student['student_id']?.toString() ?? '-';

    graphics.drawString(
      '$name ($id)',
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: ui.Rect.fromLTWH(60, yPos, currentPage.size.width - 120, 20),
    );
    yPos += 24;
  }
}

void _createGradeRecordPage(
  PdfDocument document,
  List<dynamic> students,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    '03 성적기록표',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  double yPos = 140;
  for (final dynamic student in students) {
    final String name = student['name'] as String? ?? '이름 미상';
    final String id = student['student_id']?.toString() ?? '-';
    final String grade = student['grade']?.toString() ?? '미평가';

    graphics.drawString(
      '$name ($id)',
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: ui.Rect.fromLTWH(60, yPos, 240, 20),
    );
    graphics.drawString(
      grade,
      PdfStandardFont(PdfFontFamily.helvetica, 14,
          style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(page.size.width - 200, yPos, 120, 20),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
    );
    yPos += 24;
  }
}

void _createEvaluationPages(
  PdfDocument document,
  List<dynamic> students,
) {
  for (final dynamic student in students) {
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;

    graphics.drawString(
      '04 학생 작품 평가표',
      PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );

    final String name = student['name'] as String? ?? '이름 미상';
    final String id = student['student_id']?.toString() ?? '-';

    graphics.drawString(
      '$name ($id)',
      PdfStandardFont(PdfFontFamily.helvetica, 18,
          style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(60, 120, page.size.width - 120, 30),
    );

    final PdfGrid grid = PdfGrid();
    grid.columns.add(count: 2);
    grid.headers.add(1);
    grid.headers[0].cells[0].value = '평가 항목';
    grid.headers[0].cells[1].value = '평가 내용';

    final List<Map<String, String>> rows = <Map<String, String>>[
      <String, String>{'title': '개념 및 아이디어', 'value': ''},
      <String, String>{'title': '공간 구성 및 기능', 'value': ''},
      <String, String>{'title': '표현력 및 전달력', 'value': ''},
      <String, String>{'title': '기술적 완성도', 'value': ''},
      <String, String>{'title': '종합 평가', 'value': ''},
    ];

    for (final Map<String, String> row in rows) {
      final PdfGridRow gridRow = grid.rows.add();
      gridRow.cells[0].value = row['title'];
      gridRow.cells[1].value = row['value'];
    }

    grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 12),
      cellPadding: PdfPaddings(left: 8, right: 8, top: 6, bottom: 6),
    );

    grid.draw(
      page: page,
      bounds: ui.Rect.fromLTWH(60, 180, page.size.width - 120, 200),
    );
  }
}

void _createLectureMaterialsSection(PdfDocument document) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    '05 강의자료',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  graphics.drawString(
    '강의자료는 별도 첨부 파일을 참조해주세요.',
    PdfStandardFont(PdfFontFamily.helvetica, 16),
    bounds: ui.Rect.fromLTWH(60, 130, page.size.width - 120, 40),
  );
}

Future<void> _createWeeklyProgressSection(
  PdfDocument document,
  List<dynamic> students,
) async {
  _createSectionTitlePage(document, '06 주차별 설계 진행표', '');
  _createStudentListPage(document, students, '주차별 설계 진행표');

  for (final dynamic student in students) {
    _createStudentProgressDivider(document, student);

    final List<dynamic> progressList =
        student['weekly_progress'] as List<dynamic>? ?? <dynamic>[];
    for (final dynamic progress in progressList) {
      final String? pdfUrl = progress['pdf_url'] as String?;
      if (pdfUrl != null && pdfUrl.isNotEmpty) {
        await _mergeExternalPdf(document, pdfUrl);
      }
    }

    _createCritiquePage(document, student);
  }
}

Future<void> _createMidtermSection(
  PdfDocument document,
  List<dynamic> students,
) async {
  _createSectionTitlePage(document, '07 중간 결과물', '');
  _createStudentListPage(document, students, '중간 결과물');

  for (final dynamic student in students) {
    _createStudentDivider(document, student, '07 중간 결과물');
    final String? pdfUrl = student['midterm_pdf'] as String?;
    if (pdfUrl != null && pdfUrl.isNotEmpty) {
      await _mergeExternalPdf(document, pdfUrl);
    }
  }
}

Future<void> _createFinalSection(
  PdfDocument document,
  List<dynamic> students,
) async {
  _createSectionTitlePage(document, '08 기말 결과물', '');
  _createStudentListPage(document, students, '기말 결과물');

  for (final dynamic student in students) {
    _createStudentDivider(document, student, '08 기말 결과물');
    final String? pdfUrl = student['final_pdf'] as String?;
    if (pdfUrl != null && pdfUrl.isNotEmpty) {
      await _mergeExternalPdf(document, pdfUrl);
    }
  }
}

void _createSectionTitlePage(
  PdfDocument document,
  String title,
  String subtitle,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(SCHColors.purple),
  );

  graphics.drawString(
    title,
    PdfStandardFont(PdfFontFamily.helvetica, 48, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(0, page.size.height * 0.35, page.size.width, 60),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  if (subtitle.isNotEmpty) {
    graphics.drawString(
      subtitle,
      PdfStandardFont(PdfFontFamily.helvetica, 20),
      bounds: ui.Rect.fromLTWH(
        0,
        page.size.height * 0.45,
        page.size.width,
        30,
      ),
      format: PdfStringFormat(alignment: PdfTextAlignment.center),
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
    );
  }

  _drawSALogo(graphics, page.size.width - 250, page.size.height - 250, 200);
}

void _createStudentListPage(
  PdfDocument document,
  List<dynamic> students,
  String sectionTitle,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    sectionTitle,
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  double yPos = 120;
  for (final dynamic student in students) {
    final String name = student['name'] as String? ?? '이름 미상';
    final String id = student['student_id']?.toString() ?? '-';

    graphics.drawString(
      '$name ($id)',
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: ui.Rect.fromLTWH(60, yPos, page.size.width - 120, 20),
    );

    yPos += 24;
  }
}

void _createStudentProgressDivider(
  PdfDocument document,
  dynamic student,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, 120),
    brush: PdfSolidBrush(SCHColors.lightBlue),
  );

  graphics.drawString(
    '학생 설계 진행표',
    PdfStandardFont(PdfFontFamily.helvetica, 28, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 40, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final String name = student['name'] as String? ?? '이름 미상';
  final String id = student['student_id']?.toString() ?? '-';

  graphics.drawString(
    '$name ($id)',
    PdfStandardFont(PdfFontFamily.helvetica, 18),
    bounds: ui.Rect.fromLTWH(60, 80, page.size.width - 120, 30),
  );
}

void _createCritiquePage(PdfDocument document, dynamic student) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    '크리틱 기록',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final List<dynamic> critiques =
      student['critique_templates'] as List<dynamic>? ??
          student['critiques'] as List<dynamic>? ??
              <dynamic>[];

  if (critiques.isEmpty) {
    graphics.drawString(
      '등록된 크리틱이 없습니다.',
      PdfStandardFont(PdfFontFamily.helvetica, 16),
      bounds: ui.Rect.fromLTWH(60, 120, page.size.width - 120, 40),
    );
    return;
  }

  final PdfGrid grid = PdfGrid();
  grid.columns.add(count: 3);
  grid.headers.add(1);
  grid.headers[0].cells[0].value = '주차';
  grid.headers[0].cells[1].value = '크리틱 요약';
  grid.headers[0].cells[2].value = '피드백 템플릿';

  final PdfGridCellStyle headerCellStyle = PdfGridCellStyle(
    font: PdfStandardFont(
      PdfFontFamily.helvetica,
      12,
      style: PdfFontStyle.bold,
    ),
    backgroundBrush: PdfSolidBrush(SCHColors.lightGray),
    cellPadding: PdfPaddings(left: 8, right: 8, top: 6, bottom: 6),
  );

  for (final PdfGridCell headerCell in grid.headers[0].cells) {
    headerCell.style = headerCellStyle;
  }

  for (final dynamic critique in critiques) {
    final PdfGridRow row = grid.rows.add();
    row.cells[0].value = critique['week']?.toString() ?? '-';
    row.cells[1].value = critique['summary'] ?? critique['content'] ?? '';

    final String feedbackTemplate = _buildCritiqueTemplate(critique);
    row.cells[2].value = feedbackTemplate;
  }

  grid.style = PdfGridStyle(
    font: PdfStandardFont(PdfFontFamily.helvetica, 12),
    cellPadding: PdfPaddings(left: 8, right: 8, top: 6, bottom: 6),
  );

  grid.draw(
    page: page,
    bounds: ui.Rect.fromLTWH(60, 140, page.size.width - 120, 400),
  );
}

String _buildCritiqueTemplate(dynamic critique) {
  final String strengths = critique['strengths'] as String? ?? '';
  final String improvements = critique['improvements'] as String? ?? '';
  final String actionItems = critique['action_items'] as String? ?? '';

  return [
    '강점: $strengths',
    '개선이 필요한 부분: $improvements',
    '향후 작업 제안: $actionItems',
  ].join('\n');
}

void _createStudentDivider(
  PdfDocument document,
  dynamic student,
  String section,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(50, 50, 80, 40),
    brush: PdfSolidBrush(section.contains('06')
        ? SCHColors.purple
        : section.contains('07')
            ? SCHColors.lightBlue
            : SCHColors.mediumGray),
  );

  graphics.drawString(
    section.split(' ')[0],
    PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(50, 50, 80, 40),
    format: PdfStringFormat(
      alignment: PdfTextAlignment.center,
      lineAlignment: PdfVerticalAlignment.middle,
    ),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    section,
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(0, page.size.height * 0.4, page.size.width, 50),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
  );

  final String studentInfo =
      '${student['name'] ?? '이름 미상'} (${student['student_id'] ?? '-'})';
  graphics.drawString(
    studentInfo,
    PdfStandardFont(PdfFontFamily.helvetica, 20),
    bounds: ui.Rect.fromLTWH(
      page.size.width - 250,
      page.size.height * 0.4,
      200,
      30,
    ),
    format: PdfStringFormat(alignment: PdfTextAlignment.right),
  );

  graphics.drawString(
    student['grade']?.toString() ?? '',
    PdfStandardFont(PdfFontFamily.helvetica, 24, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(page.size.width - 100, 100, 50, 40),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 0, 0)),
  );

  _drawSALogo(graphics, page.size.width - 250, page.size.height - 250, 200);
}

Future<void> _mergeExternalPdf(PdfDocument targetDoc, String pdfUrl) async {
  try {
    final http.Response response = await http.get(Uri.parse(pdfUrl));
    if (response.statusCode == 200) {
      final PdfDocument sourceDoc = PdfDocument(inputBytes: response.bodyBytes);

      for (int i = 0; i < sourceDoc.pages.count; i++) {
        final PdfPage sourcePage = sourceDoc.pages[i];
        final PdfTemplate template = sourcePage.createTemplate();

        targetDoc.pageSettings.size = sourcePage.size;
        targetDoc.pageSettings.margins.all = 0;

        final PdfPage newPage = targetDoc.pages.add();
        newPage.graphics.drawPdfTemplate(
          template,
          ui.Offset.zero,
        );
      }

      sourceDoc.dispose();
    }
  } catch (e) {
    print('PDF 병합 실패: $pdfUrl - $e');
  }
}

void _downloadPdf(Uint8List bytes, String fileName) {
  if (!kIsWeb) {
    print('웹 환경에서만 다운로드를 지원합니다.');
    return;
  }

  final html.Blob blob = html.Blob(<dynamic>[bytes], 'application/pdf');
  final String url = html.Url.createObjectUrlFromBlob(blob);
  final html.AnchorElement anchor =
      html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..download = fileName;
  anchor.click();
  html.Url.revokeObjectUrl(url);
}
