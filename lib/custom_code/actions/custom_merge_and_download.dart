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

import '/app_state.dart';
import 'dart:collection';
import 'dart:convert';

import 'package:collection/collection.dart';

class _SectionAggregate {
  _SectionAggregate({
    required this.key,
    required this.displayLabel,
    this.professorName,
    this.sectionName,
  });

  final String key;
  final String displayLabel;
  final String? professorName;
  final String? sectionName;
  final List<PortfolioItemStruct> students = [];
  final List<PortfolioItemStruct> coursePlans = [];
  final List<PortfolioItemStruct> attendance = [];
  final List<PortfolioItemStruct> gradeRecords = [];
  final List<PortfolioItemStruct> evaluations = [];
  final List<PortfolioItemStruct> lectureMaterials = [];
  final List<PortfolioItemStruct> weeklyProgress = [];
  final List<PortfolioItemStruct> midterms = [];
  final List<PortfolioItemStruct> finals = [];
}

Future<List<PortfolioSectionStruct>> customMergeAndDownload(
  int classId,
) async {
  final List<PortfolioSectionStruct> sections = [];

  if (classId <= 0) {
    print('[customMergeAndDownload] 잘못된 classId: $classId');
    FFAppState().update(() {
      FFAppState().classPortfolioSections = sections;
    });
    return sections;
  }

  Future<List<T>> _safeQuery<T>(
    Future<List<T>> Function() queryFn,
    String label,
  ) async {
    try {
      return await queryFn();
    } catch (error) {
      print('[customMergeAndDownload] $label 조회 오류: $error');
      return <T>[];
    }
  }

  String _normalize(String? value) =>
      value == null ? '' : value.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();

  bool _isCommonSection(String? value) {
    if (value == null) {
      return true;
    }
    final normalized = _normalize(value);
    if (normalized.isEmpty) {
      return true;
    }
    const commonKeywords = ['common', '공통'];
    return commonKeywords.any((keyword) => normalized.contains(keyword));
  }

  String _buildSectionLabel({String? professorName, String? sectionName}) {
    final professor = professorName?.trim() ?? '';
    final section = sectionName?.trim() ?? '';
    if (professor.isNotEmpty && section.isNotEmpty) {
      return '$professor / $section';
    }
    if (professor.isNotEmpty) {
      return professor;
    }
    return section;
  }

  final classRows = await _safeQuery(
    () => ClassTable().queryRows(
      queryFn: (q) => q.eq('id', classId).limit(1),
    ),
    'class',
  );
  final classRow = classRows.isNotEmpty ? classRows.first : null;

  final courseStudents = await _safeQuery(
    () => CourseStudentTable().queryRows(
      queryFn: (q) => q.eq('classid', classId),
    ),
    'course_student',
  );

  final coursePlans = await _safeQuery(
    () => CourseplanTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'courseplan',
  );

  final attendanceRows = await _safeQuery(
    () => AttendanceTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'attendance',
  );

  final gradeSheets = await _safeQuery(
    () => GradesheetTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'gradesheet',
  );

  final workEvalForms = await _safeQuery(
    () => WorkevalformTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'workevalform',
  );

  final lectureMaterials = await _safeQuery(
    () => LecturematerialTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'lecturematerial',
  );

  final subjectPortfolios = await _safeQuery(
    () => SubjectportpolioTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'subjectportpolio',
  );

  final midtermResults = await _safeQuery(
    () => MidtermResultsTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'midterm_results',
  );

  final finalResults = await _safeQuery(
    () => FinalResultsTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    ),
    'final_results',
  );

  final LinkedHashMap<String, _SectionAggregate> sectionMap = LinkedHashMap();

  _SectionAggregate? _findByProfessor(String? professorName) {
    if (professorName == null || professorName.trim().isEmpty) {
      return null;
    }
    final normalizedProfessor = _normalize(professorName);
    return sectionMap.values.firstWhereOrNull(
      (aggregate) => _normalize(aggregate.professorName) == normalizedProfessor,
    );
  }

  _SectionAggregate? _findBySection(String? sectionName) {
    if (sectionName == null || sectionName.trim().isEmpty) {
      return null;
    }
    final normalizedSection = _normalize(sectionName);
    return sectionMap.values.firstWhereOrNull(
      (aggregate) => _normalize(aggregate.sectionName) == normalizedSection,
    );
  }

  _SectionAggregate _ensureSection({String? professorName, String? sectionName}) {
    final label = _buildSectionLabel(
      professorName: professorName,
      sectionName: sectionName,
    );
    final key = _normalize(label);
    final existing = sectionMap[key];
    if (existing != null) {
      return existing;
    }
    final aggregate = _SectionAggregate(
      key: key.isEmpty ? DateTime.now().microsecondsSinceEpoch.toString() : key,
      displayLabel: label.isEmpty ? (sectionName ?? professorName ?? '') : label,
      professorName: professorName?.trim(),
      sectionName: sectionName?.trim(),
    );
    sectionMap[aggregate.key] = aggregate;
    return aggregate;
  }

  _SectionAggregate? _resolveSection({
    String? professorName,
    String? sectionName,
  }) {
    final label = _buildSectionLabel(
      professorName: professorName,
      sectionName: sectionName,
    );
    if (label.isNotEmpty) {
      final key = _normalize(label);
      final aggregate = sectionMap[key];
      if (aggregate != null) {
        return aggregate;
      }
    }

    final bySection = _findBySection(sectionName);
    if (bySection != null) {
      return bySection;
    }

    final byProfessor = _findByProfessor(professorName);
    if (byProfessor != null) {
      return byProfessor;
    }

    if (label.isNotEmpty) {
      return _ensureSection(
        professorName: professorName,
        sectionName: sectionName,
      );
    }

    return null;
  }

  for (final student in courseStudents) {
    final aggregate = _ensureSection(
      professorName: student.professorName,
      sectionName: student.sectionType,
    );
    final item = createPortfolioItemStruct(
      title: student.studentName,
      category: 'student',
      professorName: student.professorName,
      sectionName: student.sectionType,
      order: aggregate.students.length,
      extraJson: jsonEncode({
        'studentId': student.studentId,
        'courseName': student.courseName,
        'year': student.year,
        'semester': student.semester,
        'grade': student.grade,
      }),
    );
    aggregate.students.add(item);
  }

  final List<PortfolioItemStruct> commonWeeklyPlans = [];

  for (final plan in coursePlans) {
    final item = createPortfolioItemStruct(
      title: plan.planTitle ?? plan.week ?? '수업계획서',
      url: plan.url,
      category: 'course_plan',
      professorName: plan.professorName,
      sectionName: plan.section,
      week: plan.week,
      order: 0,
    );

    if (_isCommonSection(plan.section)) {
      item.order = commonWeeklyPlans.length;
      commonWeeklyPlans.add(item);
      continue;
    }

    final aggregate = _resolveSection(
      professorName: plan.professorName,
      sectionName: plan.section,
    );

    if (aggregate != null) {
      item.order = aggregate.coursePlans.length;
      aggregate.coursePlans.add(item);
    }
  }

  final List<PortfolioItemStruct> globalAttendance = [];

  for (final attendance in attendanceRows) {
    final item = createPortfolioItemStruct(
      title: attendance.title ?? '출석부',
      url: attendance.url,
      category: 'attendance',
      professorName: attendance.professorName,
      sectionName: attendance.section,
      week: attendance.week,
      order: 0,
    );

    if (_isCommonSection(attendance.section)) {
      item.order = globalAttendance.length;
      globalAttendance.add(item);
      continue;
    }

    final aggregate = _resolveSection(
      professorName: attendance.professorName,
      sectionName: attendance.section,
    );

    if (aggregate != null) {
      item.order = aggregate.attendance.length;
      aggregate.attendance.add(item);
    } else {
      item.order = globalAttendance.length;
      globalAttendance.add(item);
    }
  }

  final List<PortfolioItemStruct> globalGradeRecords = [];

  for (final grade in gradeSheets) {
    final item = createPortfolioItemStruct(
      title: grade.title ?? '성적기록표',
      url: grade.url,
      category: 'grade_record',
      professorName: grade.professorName,
      sectionName: grade.section,
      week: grade.week,
      order: 0,
    );

    if (_isCommonSection(grade.section)) {
      item.order = globalGradeRecords.length;
      globalGradeRecords.add(item);
      continue;
    }

    final aggregate = _resolveSection(
      professorName: grade.professorName,
      sectionName: grade.section,
    );

    if (aggregate != null) {
      item.order = aggregate.gradeRecords.length;
      aggregate.gradeRecords.add(item);
    } else {
      item.order = globalGradeRecords.length;
      globalGradeRecords.add(item);
    }
  }

  for (final form in workEvalForms) {
    final aggregate = _resolveSection(
      professorName: form.professorName,
      sectionName: form.section,
    );
    if (aggregate == null) {
      continue;
    }
    final item = createPortfolioItemStruct(
      title: form.title ?? '학생작품평가표',
      url: form.url,
      category: 'evaluation',
      professorName: form.professorName,
      sectionName: form.section,
      week: form.week,
      order: aggregate.evaluations.length,
    );
    aggregate.evaluations.add(item);
  }

  for (final material in lectureMaterials) {
    final aggregate = _resolveSection(
      professorName: material.professorName,
      sectionName: material.section,
    );
    if (aggregate == null) {
      continue;
    }
    final item = createPortfolioItemStruct(
      title: material.title ?? '강의자료',
      url: material.url,
      category: 'lecture_material',
      professorName: material.professorName,
      sectionName: material.section,
      week: material.week,
      order: aggregate.lectureMaterials.length,
    );
    aggregate.lectureMaterials.add(item);
  }

  for (final portfolio in subjectPortfolios) {
    final aggregate = _resolveSection(
      professorName: portfolio.professorName,
      sectionName: portfolio.section,
    );
    if (aggregate == null) {
      continue;
    }
    final item = createPortfolioItemStruct(
      title: portfolio.title ?? portfolio.studentName ?? '설계 진행',
      url: portfolio.url,
      category: 'weekly_progress',
      professorName: portfolio.professorName,
      sectionName: portfolio.section,
      studentName: portfolio.studentName,
      week: portfolio.week,
      order: aggregate.weeklyProgress.length,
      extraJson: jsonEncode({
        'portpolioresult': portfolio.portpolioresult,
        'criticHtml': portfolio.criticHtml,
      }),
    );
    aggregate.weeklyProgress.add(item);
  }

  for (final midterm in midtermResults) {
    final aggregate = _resolveSection(
      professorName: midterm.professorName,
      sectionName: midterm.section,
    );
    if (aggregate == null) {
      continue;
    }
    final item = createPortfolioItemStruct(
      title: midterm.title ?? midterm.studentName ?? '중간 결과물',
      url: midterm.url,
      category: 'midterm',
      professorName: midterm.professorName,
      sectionName: midterm.section,
      studentName: midterm.studentName,
      week: midterm.week,
      order: aggregate.midterms.length,
      extraJson: jsonEncode({
        'studentEmail': midterm.studentEmail,
        'portpolioresult': midterm.portpolioresult,
        'grade': midterm.grade,
      }),
    );
    aggregate.midterms.add(item);
  }

  for (final finalResult in finalResults) {
    final aggregate = _resolveSection(
      professorName: finalResult.professorName,
      sectionName: finalResult.section,
    );
    if (aggregate == null) {
      continue;
    }
    final item = createPortfolioItemStruct(
      title: finalResult.title ?? finalResult.studentName ?? '최종 결과물',
      url: finalResult.url,
      category: 'final',
      professorName: finalResult.professorName,
      sectionName: finalResult.section,
      studentName: finalResult.studentName,
      week: finalResult.week,
      order: aggregate.finals.length,
      extraJson: jsonEncode({
        'studentEmail': finalResult.studentEmail,
        'portpolioresult': finalResult.portpolioresult,
        'grade': finalResult.grade,
      }),
    );
    aggregate.finals.add(item);
  }

  if (globalAttendance.isNotEmpty && sectionMap.isNotEmpty) {
    for (final aggregate in sectionMap.values) {
      for (final item in globalAttendance) {
        aggregate.attendance.add(
          item.copyWith(
            order: aggregate.attendance.length,
            professorName: aggregate.professorName ?? item.professorName,
            sectionName: aggregate.sectionName ?? item.sectionName,
          ),
        );
      }
    }
  }

  if (globalGradeRecords.isNotEmpty && sectionMap.isNotEmpty) {
    for (final aggregate in sectionMap.values) {
      for (final item in globalGradeRecords) {
        aggregate.gradeRecords.add(
          item.copyWith(
            order: aggregate.gradeRecords.length,
            professorName: aggregate.professorName ?? item.professorName,
            sectionName: aggregate.sectionName ?? item.sectionName,
          ),
        );
      }
    }
  }

  final List<PortfolioItemStruct> indexItems = [];
  int indexOrder = 0;

  indexItems.add(
    createPortfolioItemStruct(
      title: 'INDEX 페이지',
      category: 'index',
      order: indexOrder++,
    ),
  );

  indexItems.add(
    createPortfolioItemStruct(
      title: '표지',
      category: 'index',
      order: indexOrder++,
    ),
  );

  indexItems.add(
    createPortfolioItemStruct(
      title: '교과목 개요',
      category: 'index',
      order: indexOrder++,
    ),
  );

  if (commonWeeklyPlans.isNotEmpty) {
    indexItems.add(
      createPortfolioItemStruct(
        title: '공통 주차별 강의 계획서',
        category: 'index',
        order: indexOrder++,
      ),
    );
  }

  for (final aggregate in sectionMap.values) {
    indexItems.add(
      createPortfolioItemStruct(
        title: '분반 구분 페이지',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
        extraJson: jsonEncode({'label': aggregate.displayLabel}),
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '수업계획서',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '출석부',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '성적기록표',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '학생작품평가표',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '강의자료',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '주차별 설계 진행표 섹션',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '중간 결과물 섹션',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
    indexItems.add(
      createPortfolioItemStruct(
        title: '최종 결과물 섹션',
        category: 'index',
        professorName: aggregate.professorName,
        sectionName: aggregate.sectionName,
        order: indexOrder++,
      ),
    );
  }

  indexItems.add(
    createPortfolioItemStruct(
      title: '마지막 표지',
      category: 'index',
      order: indexOrder++,
    ),
  );

  int sectionOrder = 0;

  sections.add(
    createPortfolioSectionStruct(
      key: 'index',
      title: 'INDEX 페이지',
      order: sectionOrder++,
      items: indexItems,
    ),
  );

  final coverItems = <PortfolioItemStruct>[];
  if (classRow != null) {
    coverItems.add(
      createPortfolioItemStruct(
        title: classRow.course ?? '표지',
        category: 'cover',
        professorName: classRow.professor,
        sectionName: classRow.section,
        url: classRow.url,
        order: 0,
        extraJson: jsonEncode({
          'course': classRow.course,
          'professor': classRow.professor,
          'year': classRow.year,
          'semester': classRow.semester,
          'grade': classRow.grade,
          'section': classRow.section,
        }),
      ),
    );
  }

  sections.add(
    createPortfolioSectionStruct(
      key: 'cover',
      title: '표지',
      order: sectionOrder++,
      items: coverItems,
    ),
  );

  final courseOverviewItems = <PortfolioItemStruct>[];
  if (classRow != null) {
    courseOverviewItems.add(
      createPortfolioItemStruct(
        title: '교과목 개요',
        category: 'course_overview',
        order: 0,
        extraJson: jsonEncode({
          'course': classRow.course,
          'professor': classRow.professor,
          'year': classRow.year,
          'semester': classRow.semester,
          'grade': classRow.grade,
          'studentCount': courseStudents.length,
        }),
      ),
    );
  }

  sections.add(
    createPortfolioSectionStruct(
      key: 'course_overview',
      title: '교과목 개요',
      order: sectionOrder++,
      items: courseOverviewItems,
    ),
  );

  sections.add(
    createPortfolioSectionStruct(
      key: 'common_weekly_plan',
      title: '공통 주차별 강의 계획서',
      order: sectionOrder++,
      items: commonWeeklyPlans,
    ),
  );

  for (final aggregate in sectionMap.values) {
    sections.add(
      createPortfolioSectionStruct(
        key: 'section_divider',
        title: '분반 구분 페이지',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: [
          createPortfolioItemStruct(
            title: aggregate.displayLabel,
            category: 'section_divider',
            professorName: aggregate.professorName,
            sectionName: aggregate.sectionName,
            order: 0,
            extraJson: jsonEncode({
              'studentCount': aggregate.students.length,
              'students': aggregate.students
                  .map((item) => item.studentName)
                  .where((name) => name.isNotEmpty)
                  .toList(),
            }),
          ),
        ],
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'course_plan',
        title: '수업계획서',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.coursePlans,
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'attendance',
        title: '출석부',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.attendance,
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'grade_record',
        title: '성적기록표',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.gradeRecords,
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'evaluation',
        title: '학생작품평가표',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.evaluations,
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'lecture_material',
        title: '강의자료',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.lectureMaterials,
      ),
    );

    final weeklyProgressItems = aggregate.weeklyProgress.isNotEmpty
        ? aggregate.weeklyProgress
        : aggregate.students
            .map(
              (student) => student.copyWith(
                category: 'weekly_progress',
                order: aggregate.weeklyProgress.length,
              ),
            )
            .toList();

    sections.add(
      createPortfolioSectionStruct(
        key: 'weekly_progress',
        title: '주차별 설계 진행표 섹션',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: weeklyProgressItems,
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'midterm',
        title: '중간 결과물 섹션',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.midterms,
      ),
    );

    sections.add(
      createPortfolioSectionStruct(
        key: 'final',
        title: '최종 결과물 섹션',
        sectionLabel: aggregate.displayLabel,
        order: sectionOrder++,
        items: aggregate.finals,
      ),
    );
  }

  sections.add(
    createPortfolioSectionStruct(
      key: 'last_cover',
      title: '마지막 표지',
      order: sectionOrder++,
      items: const [],
    ),
  );

  FFAppState().update(() {
    FFAppState().classPortfolioSections = sections;
  });

  return sections;
}
