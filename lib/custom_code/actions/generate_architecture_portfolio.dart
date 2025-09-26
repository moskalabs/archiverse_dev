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

const String _firstCoverPdfUrl =
    'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/pdfdefault/PDF_cover_first.pdf';
const String _indexPdfUrl =
    'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/pdfdefault/02.PDF_INDEX.pdf';
const String _lastCoverPdfUrl =
    'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/fileupload/pdfdefault/20.PDF_COVER_LAST.pdf';

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
        .order('class_section')
        .order('name');
    final List<Map<String, dynamic>> studentsData =
        (studentsDataResponse as List)
            .map((dynamic item) =>
                Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
            .toList();

    final Set<int> studentIdSet = <int>{};
    final Map<String, int> studentIdByName = <String, int>{};
    for (final Map<String, dynamic> student in studentsData) {
      final int? idValue = _coerceToInt(student['id']);
      if (idValue != null) {
        studentIdSet.add(idValue);
      }
      final String? normalizedName =
          _normalizeStudentKey(student['name'] as String?);
      if (normalizedName != null && idValue != null) {
        studentIdByName.putIfAbsent(normalizedName, () => idValue);
      }
    }
    final List<int> studentIds = studentIdSet.toList();

    final Map<int, List<Map<String, dynamic>>> studentsBySection =
        <int, List<Map<String, dynamic>>>{};
    for (final Map<String, dynamic> student in studentsData) {
      final int section = _parseSection(student['class_section']);
      studentsBySection.putIfAbsent(section, () => <Map<String, dynamic>>[]);
      studentsBySection[section]!.add(student);
    }

    for (final List<Map<String, dynamic>> sectionStudents
        in studentsBySection.values) {
      sectionStudents.sort((Map<String, dynamic> a, Map<String, dynamic> b) {
        final String aName = (a['name'] as String?)?.toLowerCase() ?? '';
        final String bName = (b['name'] as String?)?.toLowerCase() ?? '';
        return aName.compareTo(bName);
      });
    }

    const Map<int, String> sectionTitles = <int, String>{
      1: '천준호 교수 / 1분반',
      2: '이재 교수 / 2분반',
      3: '김승 교수 / 3분반',
    };

    final Set<int> discoveredSections = <int>{}
      ..addAll(sectionTitles.keys)
      ..addAll(studentsBySection.keys);
    final List<int> orderedSectionNumbers = <int>[];
    for (final int key in sectionTitles.keys) {
      if (!orderedSectionNumbers.contains(key)) {
        orderedSectionNumbers.add(key);
      }
    }
    for (final int section in discoveredSections) {
      if (!orderedSectionNumbers.contains(section)) {
        final bool hasStudents =
            (studentsBySection[section]?.isNotEmpty ?? false);
        if (section != 0 || hasStudents) {
          orderedSectionNumbers.add(section);
        }
      }
    }

    final Map<String, List<Map<String, dynamic>>> weeklyLookup =
        await _fetchWeeklyProgressLookup(studentIds, studentIdByName);
    final Map<String, String> midtermLookup = await _fetchSingleResultLookup(
      'midterm_results',
      studentIds,
      studentIdByName,
    );
    final Map<String, String> finalLookup = await _fetchSingleResultLookup(
      'final_results',
      studentIds,
      studentIdByName,
    );
    final Map<String, List<Map<String, dynamic>>> critiqueLookup =
        await _fetchCritiquesLookup(
      orderedSectionNumbers,
      studentIdByName,
    );

    for (final Map<String, dynamic> student in studentsData) {
      final int? studentId = _coerceToInt(student['id']);
      final String? studentName = student['name'] as String?;
      final String idKey = _studentIdLookupKey(studentId);
      final String nameKey = _studentNameLookupKey(studentName);

      final List<Map<String, dynamic>>? weeklyRecords =
          weeklyLookup[idKey] ?? weeklyLookup[nameKey];
      if (weeklyRecords != null && weeklyRecords.isNotEmpty) {
        final List<Map<String, dynamic>> existingWeekly =
            _castToMapList(student['weekly_progress']);
        if (existingWeekly.isEmpty) {
          student['weekly_progress'] = weeklyRecords
              .map((Map<String, dynamic> item) =>
                  Map<String, dynamic>.from(item))
              .toList();
        }
      }

      final String? midtermUrl = midtermLookup[idKey] ?? midtermLookup[nameKey];
      if (_isNullOrEmptyString(student['midterm_pdf']) &&
          midtermUrl != null &&
          midtermUrl.isNotEmpty) {
        student['midterm_pdf'] = midtermUrl;
      }

      final String? finalUrl = finalLookup[idKey] ?? finalLookup[nameKey];
      if (_isNullOrEmptyString(student['final_pdf']) &&
          finalUrl != null &&
          finalUrl.isNotEmpty) {
        student['final_pdf'] = finalUrl;
      }

      final List<Map<String, dynamic>>? critiqueRecords =
          critiqueLookup[idKey] ?? critiqueLookup[nameKey];
      if (critiqueRecords != null && critiqueRecords.isNotEmpty) {
        final List<Map<String, dynamic>> existingCritiques =
            _castToMapList(student['critiques']);
        if (existingCritiques.isEmpty) {
          student['critiques'] = critiqueRecords
              .map((Map<String, dynamic> item) =>
                  Map<String, dynamic>.from(item))
              .toList();
        }
      }
    }

    final List<_SectionBundle> sections = orderedSectionNumbers
        .map((int sectionNumber) => _SectionBundle(
              number: sectionNumber,
              title: sectionTitles[sectionNumber] ?? '분반 $sectionNumber',
              students:
                  studentsBySection[sectionNumber] ?? <Map<String, dynamic>>[],
            ))
        .toList();

    final PdfDocument document = PdfDocument();
    document.pageSettings.margins.all = 0;

    if (!await _mergeExternalPdf(document, _firstCoverPdfUrl)) {
      _createFirstCoverPage(document, courseData);
    }
    if (!await _mergeExternalPdf(document, _indexPdfUrl)) {
      _createIndexPage(document, sections);
    }
    _createCoverPage(document, courseData);
    _createCourseOverviewPage(document, courseData);
    _createCourseHighlightsPage(document, courseData);
    _createWeeklyPlanPages(document, courseData);

    for (final _SectionBundle section in sections) {
      _createSectionDividerPage(document, section.title);
      _createCoursePlanPage(
        document,
        courseData,
        sectionLabel: section.title,
        sectionNumber: section.number,
      );
      _createAttendancePage(
        document,
        section.students,
        sectionLabel: section.title,
      );
      _createGradeRecordPage(
        document,
        section.students,
        sectionLabel: section.title,
      );
      _createEvaluationPages(
        document,
        section.students,
        sectionLabel: section.title,
      );
      _createLectureMaterialsSection(
        document,
        sectionLabel: section.title,
      );
      await _createWeeklyProgressSection(
        document,
        section.students,
        section.title,
      );
      await _createMidtermSection(
        document,
        section.students,
        section.title,
      );
      await _createFinalSection(
        document,
        section.students,
        section.title,
      );
    }

    if (!await _mergeExternalPdf(document, _lastCoverPdfUrl)) {
      _createLastCoverPage(document, courseData);
    }

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

class _SectionBundle {
  const _SectionBundle({
    required this.number,
    required this.title,
    required this.students,
  });

  final int number;
  final String title;
  final List<Map<String, dynamic>> students;
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

void _createFirstCoverPage(
  PdfDocument document,
  Map<String, dynamic> courseData,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(PdfColor(250, 250, 252)),
  );

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height * 0.35),
    brush: PdfSolidBrush(SCHColors.lightBlue),
  );

  final String portfolioTitle =
      courseData['portfolio_title'] as String? ?? 'Architecture 9 Portfolio';
  final String department =
      courseData['department'] as String? ?? '순천향대학교 건축학과';
  final String semesterLabel = courseData['semester_label'] as String? ??
      courseData['semester'] as String? ??
      '2024년도 1학기';
  final String tagline = courseData['portfolio_tagline'] as String? ??
      'SPC 11 연구기반 종합설계';

  graphics.drawString(
    department,
    PdfStandardFont(PdfFontFamily.helvetica, 18, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, page.size.height * 0.12, page.size.width - 120, 30),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  graphics.drawString(
    semesterLabel,
    PdfStandardFont(PdfFontFamily.helvetica, 16),
    bounds: ui.Rect.fromLTWH(60, page.size.height * 0.18, page.size.width - 120, 24),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  graphics.drawString(
    portfolioTitle,
    PdfStandardFont(PdfFontFamily.helvetica, 48, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, page.size.height * 0.4, page.size.width - 120, 60),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  graphics.drawString(
    tagline,
    PdfStandardFont(PdfFontFamily.helvetica, 20),
    bounds: ui.Rect.fromLTWH(60, page.size.height * 0.48, page.size.width - 120, 30),
    brush: PdfSolidBrush(SCHColors.mediumGray),
  );

  final String preparedBy = courseData['prepared_by'] as String? ??
      '순천향대학교 건축설계9 포트폴리오 자동 병합 시스템';

  graphics.drawString(
    preparedBy,
    PdfStandardFont(PdfFontFamily.helvetica, 14),
    bounds: ui.Rect.fromLTWH(60, page.size.height * 0.7, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  _drawSALogo(graphics, page.size.width - 220, page.size.height - 220, 180);
}

void _createCourseHighlightsPage(
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
    '교과목 주요 성과 요약',
    PdfStandardFont(PdfFontFamily.helvetica, 36, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final String highlights =
      courseData['achievement_summary'] as String? ??
          courseData['achievements'] as String? ??
          courseData['course_highlights'] as String? ??
          '교과목 주요 성과가 아직 등록되지 않았습니다.';

  final PdfTextElement textElement = PdfTextElement(
    text: highlights,
    font: PdfStandardFont(PdfFontFamily.helvetica, 14),
    brush: PdfSolidBrush(PdfColor(50, 50, 50)),
  );

  textElement.draw(
    page: page,
    bounds: ui.Rect.fromLTWH(60, 130, page.size.width - 120, 600),
  );
}

void _createLastCoverPage(
  PdfDocument document,
  Map<String, dynamic> courseData,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final String courseTitle =
      courseData['course_title'] as String? ?? '건축설계 9 포트폴리오';
  final String closingMessage = courseData['closing_message'] as String? ??
      '수고하셨습니다';

  graphics.drawString(
    courseTitle,
    PdfStandardFont(PdfFontFamily.helvetica, 40, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(0, page.size.height * 0.35, page.size.width, 50),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    closingMessage,
    PdfStandardFont(PdfFontFamily.helvetica, 20),
    bounds: ui.Rect.fromLTWH(0, page.size.height * 0.45, page.size.width, 30),
    format: PdfStringFormat(alignment: PdfTextAlignment.center),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  _drawSALogo(graphics, page.size.width - 220, page.size.height - 220, 180);
}

void _createIndexPage(PdfDocument document, List<_SectionBundle> sections) {
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

  final List<String> introItems = <String>[
    '건축설계9',
    '교과목 개요',
    '교과목 주요 성과 요약',
    '공통 주차별 강의 계획서',
  ];

  double yPos = 240;
  for (final String item in introItems) {
    graphics.drawString(
      item,
      PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(100, yPos, 420, 25),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );
    yPos += 32;
  }

  const List<String> sectionItems = <String>[
    '01 수업계획서',
    '02 출석부',
    '03 성적기록표',
    '04 학생 작품 평가표',
    '05 강의자료',
    '06 주차별 설계 진행표',
    '07 중간 결과물',
    '08 최종 결과물',
  ];

  if (sections.isNotEmpty) {
    yPos += 12;
  }

  for (final _SectionBundle section in sections) {
    graphics.drawString(
      section.title,
      PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
      bounds: ui.Rect.fromLTWH(100, yPos, 420, 25),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );
    yPos += 30;

    for (final String item in sectionItems) {
      graphics.drawString(
        item,
        PdfStandardFont(PdfFontFamily.helvetica, 14),
        bounds: ui.Rect.fromLTWH(130, yPos, 420, 22),
        brush: PdfSolidBrush(SCHColors.darkNavy),
      );
      yPos += 26;
    }

    yPos += 12;
  }

  graphics.drawString(
    '마지막 표지',
    PdfStandardFont(PdfFontFamily.helvetica, 16, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(100, yPos, 420, 25),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  _drawSALogo(graphics, page.size.width - 250, page.size.height - 250, 200);
}

void _createCoverPage(
  PdfDocument document,
  Map<String, dynamic> courseData,
) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawRectangle(
    bounds: ui.Rect.fromLTWH(0, 0, page.size.width, page.size.height),
    brush: PdfSolidBrush(SCHColors.navy),
  );

  final String department =
      courseData['department'] as String? ?? '순천향대학교 건축학과';
  final String semesterLabel = courseData['semester_label'] as String? ??
      courseData['semester'] as String? ??
      '2024년도 1학기';
  final String courseTitle =
      courseData['course_title'] as String? ?? '건축설계 9';
  final String professor = courseData['professor'] as String? ??
      courseData['main_professor'] as String? ??
      '담당교수 미정';
  final String sectionSummary = courseData['section_summary'] as String? ??
      '5학년 1분반';
  final String tagline = courseData['course_tagline'] as String? ??
      'SPC 11 연구기반 종합설계';

  graphics.drawString(
    department,
    PdfStandardFont(PdfFontFamily.helvetica, 14),
    bounds: ui.Rect.fromLTWH(50, 50, 300, 20),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    semesterLabel,
    PdfStandardFont(PdfFontFamily.helvetica, 16),
    bounds: ui.Rect.fromLTWH(page.size.width - 150, 50, 100, 20),
    brush: PdfSolidBrush(PdfColor(255, 255, 255)),
  );

  graphics.drawString(
    courseTitle,
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
    '교수 $professor | $sectionSummary',
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
    tagline,
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
  Map<String, dynamic> courseData, {
  String? sectionLabel,
  int? sectionNumber,
}) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    sectionLabel == null
        ? '01 수업계획서'
        : '01 수업계획서 - $sectionLabel',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  final Map<String, dynamic> plan =
      _coursePlanForSection(courseData, sectionNumber);
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
  List<Map<String, dynamic>> students, {
  String? sectionLabel,
}) {
  PdfPage currentPage = document.pages.add();
  PdfGraphics graphics = currentPage.graphics;

  graphics.drawString(
    sectionLabel == null
        ? '02 출석부'
        : '02 출석부 - $sectionLabel',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, currentPage.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  double yPos = 120;
  for (final Map<String, dynamic> student in students) {
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
  List<Map<String, dynamic>> students, {
  String? sectionLabel,
}) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    sectionLabel == null
        ? '03 성적기록표'
        : '03 성적기록표 - $sectionLabel',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  double yPos = 140;
  for (final Map<String, dynamic> student in students) {
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
  List<Map<String, dynamic>> students, {
  String? sectionLabel,
}) {
  for (final Map<String, dynamic> student in students) {
    final PdfPage page = document.pages.add();
    final PdfGraphics graphics = page.graphics;

    graphics.drawString(
      sectionLabel == null
          ? '04 학생 작품 평가표'
          : '04 학생 작품 평가표 - $sectionLabel',
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

void _createLectureMaterialsSection(
  PdfDocument document, {
  String? sectionLabel,
}) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    sectionLabel == null
        ? '05 강의자료'
        : '05 강의자료 - $sectionLabel',
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
  List<Map<String, dynamic>> students,
  String sectionLabel,
) async {
  _createSectionTitlePage(document, '06 주차별 설계 진행표', sectionLabel);
  _createStudentListPage(
    document,
    students,
    '주차별 설계 진행표',
    sectionLabel: sectionLabel,
  );

  for (final Map<String, dynamic> student in students) {
    _createStudentProgressDivider(document, student, sectionLabel: sectionLabel);

    final List<dynamic> progressList =
        student['weekly_progress'] as List<dynamic>? ?? <dynamic>[];
    for (final dynamic progress in progressList) {
      final String? pdfUrl = progress['pdf_url'] as String?;
      if (pdfUrl != null && pdfUrl.isNotEmpty) {
        await _mergeExternalPdf(document, pdfUrl);
      }
    }

    _createCritiquePage(document, student, sectionLabel: sectionLabel);
  }
}

Future<void> _createMidtermSection(
  PdfDocument document,
  List<Map<String, dynamic>> students,
  String sectionLabel,
) async {
  _createSectionTitlePage(document, '07 중간 결과물', sectionLabel);
  _createStudentListPage(
    document,
    students,
    '중간 결과물',
    sectionLabel: sectionLabel,
  );

  for (final Map<String, dynamic> student in students) {
    _createStudentDivider(
      document,
      student,
      '07 중간 결과물',
      sectionLabel: sectionLabel,
    );
    final String? pdfUrl = student['midterm_pdf'] as String?;
    if (pdfUrl != null && pdfUrl.isNotEmpty) {
      await _mergeExternalPdf(document, pdfUrl);
    }
  }
}

Future<void> _createFinalSection(
  PdfDocument document,
  List<Map<String, dynamic>> students,
  String sectionLabel,
) async {
  _createSectionTitlePage(document, '08 기말 결과물', sectionLabel);
  _createStudentListPage(
    document,
    students,
    '기말 결과물',
    sectionLabel: sectionLabel,
  );

  for (final Map<String, dynamic> student in students) {
    _createStudentDivider(
      document,
      student,
      '08 기말 결과물',
      sectionLabel: sectionLabel,
    );
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
  List<Map<String, dynamic>> students,
  String sectionTitle, {
  String? sectionLabel,
}) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    sectionLabel == null
        ? sectionTitle
        : '$sectionTitle - $sectionLabel',
    PdfStandardFont(PdfFontFamily.helvetica, 32, style: PdfFontStyle.bold),
    bounds: ui.Rect.fromLTWH(60, 60, page.size.width - 120, 40),
    brush: PdfSolidBrush(SCHColors.darkNavy),
  );

  double yPos = 120;
  for (final Map<String, dynamic> student in students) {
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
  Map<String, dynamic> student, {
  String? sectionLabel,
}) {
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

  if (sectionLabel != null) {
    graphics.drawString(
      sectionLabel,
      PdfStandardFont(PdfFontFamily.helvetica, 14),
      bounds: ui.Rect.fromLTWH(page.size.width - 260, 20, 200, 24),
      format: PdfStringFormat(alignment: PdfTextAlignment.right),
      brush: PdfSolidBrush(SCHColors.darkNavy),
    );
  }

  final String name = student['name'] as String? ?? '이름 미상';
  final String id = student['student_id']?.toString() ?? '-';

  graphics.drawString(
    '$name ($id)',
    PdfStandardFont(PdfFontFamily.helvetica, 18),
    bounds: ui.Rect.fromLTWH(60, 80, page.size.width - 120, 30),
  );
}

void _createCritiquePage(
  PdfDocument document,
  Map<String, dynamic> student, {
  String? sectionLabel,
}) {
  final PdfPage page = document.pages.add();
  final PdfGraphics graphics = page.graphics;

  graphics.drawString(
    sectionLabel == null
        ? '크리틱 기록'
        : '크리틱 기록 - $sectionLabel',
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

  final PdfGridCellCollection headerCells = grid.headers[0].cells;
  for (int i = 0; i < headerCells.count; i++) {
    headerCells[i].style = headerCellStyle;
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
  final String strengths =
      _stringValue(critique['strengths'])?.trim() ?? '';
  final String improvements =
      _stringValue(critique['improvements'])?.trim() ?? '';
  final String actionItems =
      _stringValue(critique['action_items'])?.trim() ?? '';
  final String content =
      _stringValue(critique['content'])?.trim() ?? '';

  String fallback(String value) {
    if (value.isNotEmpty) {
      return value;
    }
    if (content.isNotEmpty) {
      return content;
    }
    return '';
  }

  return <String>[
    '강점: ${fallback(strengths)}',
    '개선이 필요한 부분: ${fallback(improvements)}',
    '향후 작업 제안: ${fallback(actionItems)}',
  ].join('\n');
}

void _createStudentDivider(
  PdfDocument document,
  Map<String, dynamic> student,
  String section, {
  String? sectionLabel,
}) {
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

  final String sectionTitle = sectionLabel == null
      ? section
      : '$section - $sectionLabel';

  graphics.drawString(
    sectionTitle,
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

Future<bool> _mergeExternalPdf(PdfDocument targetDoc, String pdfUrl) async {
  try {
    final http.Response response = await http.get(Uri.parse(pdfUrl));
    if (response.statusCode != 200) {
      print('PDF 다운로드 실패: $pdfUrl (status: ${response.statusCode})');
      return false;
    }

    final PdfDocument sourceDoc = PdfDocument(inputBytes: response.bodyBytes);
    try {
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
    } finally {
      sourceDoc.dispose();
    }

    return true;
  } catch (e) {
    print('PDF 병합 실패: $pdfUrl - $e');
    return false;
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

int _parseSection(dynamic value) {
  if (value is int) {
    return value;
  }
  if (value is String) {
    return int.tryParse(value) ?? 0;
  }
  return 0;
}

Map<String, dynamic> _coursePlanForSection(
  Map<String, dynamic> courseData,
  int? sectionNumber,
) {
  if (sectionNumber != null) {
    final List<String> potentialKeys = <String>[
      'course_plan_section_$sectionNumber',
      'course_plan_section$sectionNumber',
      'course_plan_${sectionNumber}',
      'course_plan${sectionNumber}',
    ];
    for (final String key in potentialKeys) {
      final dynamic value = courseData[key];
      if (value is Map) {
        return Map<String, dynamic>.from(value as Map<dynamic, dynamic>);
      }
    }
  }

  final dynamic defaultPlan = courseData['course_plan'];
  if (defaultPlan is Map) {
    return Map<String, dynamic>.from(defaultPlan as Map<dynamic, dynamic>);
  }

  return <String, dynamic>{};
}


String? _stringValue(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is String) {
    return value;
  }
  return value.toString();
}

bool _isNullOrEmptyString(dynamic value) {
  final String? text = _stringValue(value);
  return text == null || text.trim().isEmpty;
}

int? _coerceToInt(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  if (value is String) {
    return int.tryParse(value);
  }
  return null;
}

DateTime? _coerceToDateTime(dynamic value) {
  if (value == null) {
    return null;
  }
  if (value is DateTime) {
    return value;
  }
  if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(value);
  }
  if (value is num) {
    return DateTime.fromMillisecondsSinceEpoch(value.toInt());
  }
  final String? text = _stringValue(value);
  if (text == null || text.isEmpty) {
    return null;
  }
  return DateTime.tryParse(text);
}

String? _normalizeStudentKey(String? name) {
  if (name == null) {
    return null;
  }
  final String trimmed = name.trim();
  if (trimmed.isEmpty) {
    return null;
  }
  return trimmed.toLowerCase();
}

String _studentIdLookupKey(int? id) {
  if (id == null) {
    return '';
  }
  return 'id:$id';
}

String _studentNameLookupKey(String? name) {
  final String? normalized = _normalizeStudentKey(name);
  if (normalized == null) {
    return '';
  }
  return 'name:$normalized';
}

int _parseWeekNumber(dynamic value) {
  if (value is int) {
    return value;
  }
  if (value is num) {
    return value.toInt();
  }
  final String? text = _stringValue(value);
  if (text == null) {
    return 0;
  }
  final RegExpMatch? match = RegExp(r'\d+').firstMatch(text);
  if (match != null) {
    return int.tryParse(match.group(0) ?? '') ?? 0;
  }
  return 0;
}

int _compareWeekValues(dynamic a, dynamic b) {
  final int weekA = _parseWeekNumber(a);
  final int weekB = _parseWeekNumber(b);
  if (weekA != weekB) {
    return weekA.compareTo(weekB);
  }
  final String valueA = _stringValue(a) ?? '';
  final String valueB = _stringValue(b) ?? '';
  return valueA.compareTo(valueB);
}

List<Map<String, dynamic>> _castToMapList(dynamic value) {
  if (value is! List) {
    return <Map<String, dynamic>>[];
  }
  return value
      .whereType<Map>()
      .map((Map<dynamic, dynamic> item) =>
          Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
      .toList();
}

String _stripHtmlTags(String? value) {
  if (value == null || value.isEmpty) {
    return '';
  }
  String text = value;
  text = text.replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n');
  text = text.replaceAll(RegExp(r'</p>', caseSensitive: false), '\n');
  text = text.replaceAll(RegExp(r'<[^>]+>'), '');
  text = text.replaceAll('&nbsp;', ' ');
  text = text.replaceAll('&amp;', '&');
  text = text.replaceAll('&lt;', '<');
  text = text.replaceAll('&gt;', '>');
  return text;
}

String _removeHeadingLabel(String line) {
  final int colonIndex = line.indexOf(':');
  if (colonIndex >= 0) {
    return line.substring(colonIndex + 1).trim();
  }
  final int dashIndex = line.indexOf('-');
  if (dashIndex >= 0 && dashIndex < line.length - 1) {
    return line.substring(dashIndex + 1).trim();
  }
  return line.trim();
}

String? _sectionKeyForLine(String line) {
  final String normalized = line.toLowerCase();
  if (normalized.contains('강점') || normalized.contains('strength')) {
    return 'strengths';
  }
  if (normalized.contains('개선') ||
      normalized.contains('보완') ||
      normalized.contains('약점') ||
      normalized.contains('improvement') ||
      normalized.contains('weakness')) {
    return 'improvements';
  }
  if (normalized.contains('향후') ||
      normalized.contains('계획') ||
      normalized.contains('제안') ||
      normalized.contains('action')) {
    return 'action_items';
  }
  return null;
}

Map<String, String> _extractCritiqueSections(String? html) {
  final String text = _stripHtmlTags(html).trim();
  if (text.isEmpty) {
    return <String, String>{
      'summary': '',
      'content': '',
      'strengths': '',
      'improvements': '',
      'action_items': '',
    };
  }

  final List<String> lines = text
      .split(RegExp(r'\r?\n'))
      .map((String line) => line.trim())
      .where((String line) => line.isNotEmpty)
      .toList();

  final Map<String, StringBuffer> sections = <String, StringBuffer>{
    'strengths': StringBuffer(),
    'improvements': StringBuffer(),
    'action_items': StringBuffer(),
  };
  final StringBuffer general = StringBuffer();
  String? summary;
  String? currentKey;

  for (final String line in lines) {
    final String? sectionKey = _sectionKeyForLine(line);
    if (sectionKey != null) {
      currentKey = sectionKey;
      final String cleaned = _removeHeadingLabel(line);
      if (cleaned.isNotEmpty) {
        sections[sectionKey]!.write(cleaned);
        sections[sectionKey]!.write('\n');
      }
      continue;
    }

    if (currentKey != null) {
      sections[currentKey]!
        ..write(line)
        ..write('\n');
    } else {
      general
        ..write(line)
        ..write('\n');
      summary ??= line;
    }
  }

  String bufferToString(StringBuffer buffer) => buffer.toString().trim();

  final String strengths = bufferToString(sections['strengths']!);
  final String improvements = bufferToString(sections['improvements']!);
  final String actionItems = bufferToString(sections['action_items']!);
  final String generalText = general.toString().trim();

  final String computedSummary = summary ??
      (generalText.isNotEmpty
          ? generalText.split('\n').first
          : (strengths.isNotEmpty
              ? strengths.split('\n').first
              : (improvements.isNotEmpty
                  ? improvements.split('\n').first
                  : (actionItems.isNotEmpty
                      ? actionItems.split('\n').first
                      : ''))));

  final String content = generalText.isNotEmpty
      ? generalText
      : <String>[strengths, improvements, actionItems]
          .where((String value) => value.isNotEmpty)
          .join('\n');

  return <String, String>{
    'summary': computedSummary,
    'content': content,
    'strengths': strengths,
    'improvements': improvements,
    'action_items': actionItems,
  };
}

String _firstNonEmptyString(List<dynamic> values) {
  for (final dynamic value in values) {
    final String? text = _stringValue(value);
    if (text != null && text.trim().isNotEmpty) {
      return text.trim();
    }
  }
  return '';
}

Future<Map<String, List<Map<String, dynamic>>>> _fetchWeeklyProgressLookup(
  List<int> studentIds,
  Map<String, int> studentIdByName,
) async {
  if (studentIds.isEmpty) {
    return <String, List<Map<String, dynamic>>>{};
  }

  try {
    final dynamic response = await SupaFlow.client
        .from('weekly_progress')
        .select('student_id, student_name, week, pdf_url, url, title')
        .inFilter('student_id', studentIds)
        .order('week', ascending: true);

    final List<Map<String, dynamic>> rows = (response as List)
        .map((dynamic item) =>
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
        .toList();

    final Map<String, List<Map<String, dynamic>>> lookup =
        <String, List<Map<String, dynamic>>>{};

    for (final Map<String, dynamic> row in rows) {
      final int? studentId = _coerceToInt(row['student_id']);
      final String? studentName = row['student_name'] as String?;
      final String pdfUrl = _firstNonEmptyString(<dynamic>[
        row['pdf_url'],
        row['url'],
        row['file_url'],
      ]);
      if (pdfUrl.isEmpty) {
        continue;
      }

      final Map<String, dynamic> normalized = <String, dynamic>{
        'week': row['week'],
        'pdf_url': pdfUrl,
      };
      final String? title = _stringValue(row['title']);
      if (title != null && title.isNotEmpty) {
        normalized['title'] = title;
      }

      final String idKey = _studentIdLookupKey(studentId);
      if (idKey.isNotEmpty) {
        lookup.putIfAbsent(idKey, () => <Map<String, dynamic>>[])
            .add(normalized);
      }

      final String nameKey = _studentNameLookupKey(studentName);
      if (nameKey.isNotEmpty) {
        lookup.putIfAbsent(nameKey, () => <Map<String, dynamic>>[])
            .add(normalized);
      } else if (studentName != null) {
        final int? mappedId =
            studentIdByName[_normalizeStudentKey(studentName) ?? ''];
        final String fallbackKey = _studentIdLookupKey(mappedId);
        if (fallbackKey.isNotEmpty) {
          lookup.putIfAbsent(fallbackKey, () => <Map<String, dynamic>>[])
              .add(normalized);
        }
      }
    }

    for (final List<Map<String, dynamic>> items in lookup.values) {
      items.sort((Map<String, dynamic> a, Map<String, dynamic> b) =>
          _compareWeekValues(a['week'], b['week']));
    }

    return lookup;
  } catch (error) {
    print('주차별 포트폴리오 조회 오류: $error');
    return <String, List<Map<String, dynamic>>>{};
  }
}

Future<Map<String, String>> _fetchSingleResultLookup(
  String tableName,
  List<int> studentIds,
  Map<String, int> studentIdByName,
) async {
  if (studentIds.isEmpty) {
    return <String, String>{};
  }

  try {
    final dynamic response = await SupaFlow.client
        .from(tableName)
        .select(
            'student_id, student_name, url, pdf_url, file_url, created_date, created_at, updated_at')
        .inFilter('student_id', studentIds);

    final List<Map<String, dynamic>> rows = (response as List)
        .map((dynamic item) =>
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
        .toList();

    final Map<String, String> lookup = <String, String>{};
    final Map<String, DateTime?> timestamps = <String, DateTime?>{};

    void assign(String key, String url, DateTime? timestamp) {
      if (key.isEmpty || url.isEmpty) {
        return;
      }
      final DateTime? existing = timestamps[key];
      if (existing == null ||
          (timestamp != null &&
              (existing == null || timestamp.isAfter(existing)))) {
        lookup[key] = url;
        timestamps[key] = timestamp ?? existing;
      } else if (!lookup.containsKey(key)) {
        lookup[key] = url;
      }
    }

    for (final Map<String, dynamic> row in rows) {
      final int? studentId = _coerceToInt(row['student_id']);
      final String? studentName = row['student_name'] as String?;
      final String url = _firstNonEmptyString(<dynamic>[
        row['pdf_url'],
        row['url'],
        row['file_url'],
      ]);
      if (url.isEmpty) {
        continue;
      }
      final DateTime? timestamp = _coerceToDateTime(
        row['updated_at'] ?? row['created_at'] ?? row['created_date'],
      );
      assign(_studentIdLookupKey(studentId), url, timestamp);
      final String nameKey = _studentNameLookupKey(studentName);
      if (nameKey.isNotEmpty) {
        assign(nameKey, url, timestamp);
      } else if (studentName != null) {
        final int? mappedId =
            studentIdByName[_normalizeStudentKey(studentName) ?? ''];
        assign(_studentIdLookupKey(mappedId), url, timestamp);
      }
    }

    return lookup;
  } catch (error) {
    print('결과물($tableName) 조회 오류: $error');
    return <String, String>{};
  }
}

Future<Map<String, List<Map<String, dynamic>>>> _fetchCritiquesLookup(
  List<int> sectionNumbers,
  Map<String, int> studentIdByName,
) async {
  if (sectionNumbers.isEmpty) {
    return <String, List<Map<String, dynamic>>>{};
  }

  final List<int> validSections =
      sectionNumbers.where((int value) => value != 0).toSet().toList();
  if (validSections.isEmpty) {
    return <String, List<Map<String, dynamic>>>{};
  }

  try {
    final dynamic response = await SupaFlow.client
        .from('subjectportpolio')
        .select('student_name, week, critic_html, class')
        .inFilter('class', validSections);

    final List<Map<String, dynamic>> rows = (response as List)
        .map((dynamic item) =>
            Map<String, dynamic>.from(item as Map<dynamic, dynamic>))
        .toList();

    final Map<String, List<Map<String, dynamic>>> lookup =
        <String, List<Map<String, dynamic>>>{};

    for (final Map<String, dynamic> row in rows) {
      final String html = _stringValue(row['critic_html']) ?? '';
      if (html.trim().isEmpty) {
        continue;
      }

      final Map<String, String> sections = _extractCritiqueSections(html);
      final Map<String, dynamic> normalized = <String, dynamic>{
        'week': row['week'],
        'summary': sections['summary'] ?? '',
        'content': sections['content'] ?? '',
        'strengths': sections['strengths'] ?? '',
        'improvements': sections['improvements'] ?? '',
        'action_items': sections['action_items'] ?? '',
      };

      final String? studentName = _stringValue(row['student_name']);
      final String nameKey = _studentNameLookupKey(studentName);
      if (nameKey.isNotEmpty) {
        lookup.putIfAbsent(nameKey, () => <Map<String, dynamic>>[])
            .add(normalized);
      }

      if (studentName != null) {
        final int? mappedId =
            studentIdByName[_normalizeStudentKey(studentName) ?? ''];
        final String idKey = _studentIdLookupKey(mappedId);
        if (idKey.isNotEmpty) {
          lookup.putIfAbsent(idKey, () => <Map<String, dynamic>>[])
              .add(normalized);
        }
      }
    }

    for (final List<Map<String, dynamic>> items in lookup.values) {
      items.sort((Map<String, dynamic> a, Map<String, dynamic> b) =>
          _compareWeekValues(a['week'], b['week']));
    }

    return lookup;
  } catch (error) {
    print('크리틱 데이터 조회 오류: $error');
    return <String, List<Map<String, dynamic>>>{};
  }
}
