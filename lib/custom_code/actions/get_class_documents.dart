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

Future<List<String>> getClassDocuments(
  int classId, {
  String? year,
  String? semester,
  int? grade,
  String? courseName,
  String? professorName,
  String? section,
}) async {
  final List<String> orderedUrls = [];
  final Set<String> seen = <String>{};
  final List<String> indexPlanUrls = [];
  final List<String> coursePlanUrls = [];
  final List<String> remainingUrls = [];
  String? coverUrl;

  if (classId <= 0) {
    print('[getClassDocuments] 잘못된 classId: $classId');
    return orderedUrls;
  }

  String? _clean(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  final normalizedYear = _clean(year);
  final normalizedSemester = _clean(semester);
  final normalizedCourse = _clean(courseName);
  final normalizedProfessor = _clean(professorName);
  final normalizedSection = _clean(section);

  bool _matchesSection(String? recordSection) {
    final normalizedRecord = _clean(recordSection);
    if (normalizedSection == null) {
      return true;
    }
    if (normalizedRecord == null) {
      return true;
    }
    return normalizedRecord == normalizedSection;
  }

  bool _matchesProfessor(String? recordProfessor) {
    final normalizedRecord = _clean(recordProfessor);
    if (normalizedProfessor == null) {
      return true;
    }
    if (normalizedRecord == null) {
      return true;
    }
    return normalizedRecord == normalizedProfessor;
  }

  bool _matchesGrade(int? recordGrade) {
    if (grade == null || grade <= 0) {
      return true;
    }
    if (recordGrade == null) {
      return true;
    }
    return recordGrade == grade;
  }

  void _stageUrl(List<String> bucket, String? value) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) {
      bucket.add(trimmed);
    }
  }

  void _commitUrl(String? value) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty && seen.add(trimmed)) {
      orderedUrls.add(trimmed);
    }
  }

  try {
    final classData = await ClassTable().queryRows(
      queryFn: (q) {
        var query = q.eq('id', classId);
        if (normalizedYear != null) {
          query = query.eqOrNull('year', normalizedYear);
        }
        if (normalizedSemester != null) {
          query = query.eqOrNull('semester', normalizedSemester);
        }
        if (grade != null && grade > 0) {
          query = query.eqOrNull('grade', grade);
        }
        if (normalizedCourse != null) {
          query = query.eqOrNull('course', normalizedCourse);
        }
        if (normalizedProfessor != null) {
          query = query.eqOrNull('professor', normalizedProfessor);
        }
        if (normalizedSection != null) {
          query = query.eqOrNull('section', normalizedSection);
        }
        return query;
      },
    );
    if (classData.isNotEmpty) {
      coverUrl = classData.first.url;
    }
  } catch (error) {
    print('[getClassDocuments] class 테이블 조회 오류: $error');
  }

  try {
    final coursePlans = await CourseplanTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final plan in coursePlans) {
      if (!_matchesSection(plan.section)) {
        continue;
      }
      final planTitle = _clean(plan.planTitle)?.toLowerCase() ?? '';
      final targetBucket =
          planTitle.contains('index') ? indexPlanUrls : coursePlanUrls;
      _stageUrl(targetBucket, plan.url);
    }
  } catch (error) {
    print('[getClassDocuments] courseplan 테이블 조회 오류: $error');
  }

  try {
    final attendances = await AttendanceTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final attendance in attendances) {
      _stageUrl(remainingUrls, attendance.url);
    }
  } catch (error) {
    print('[getClassDocuments] attendance 테이블 조회 오류: $error');
  }

  try {
    final gradeSheets = await GradesheetTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final gradeSheet in gradeSheets) {
      _stageUrl(remainingUrls, gradeSheet.url);
    }
  } catch (error) {
    print('[getClassDocuments] gradesheet 테이블 조회 오류: $error');
  }

  try {
    final workEvaluations = await WorkevalformTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final evalForm in workEvaluations) {
      if (!_matchesSection(evalForm.section)) {
        continue;
      }
      _stageUrl(remainingUrls, evalForm.url);
    }
  } catch (error) {
    print('[getClassDocuments] workevalform 테이블 조회 오류: $error');
  }

  try {
    final lectureMaterials = await LecturematerialTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final material in lectureMaterials) {
      if (!_matchesSection(material.section)) {
        continue;
      }
      _stageUrl(remainingUrls, material.url);
    }
  } catch (error) {
    print('[getClassDocuments] lecturematerial 테이블 조회 오류: $error');
  }

  try {
    final portfolioData = await SubjectportpolioTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final portfolio in portfolioData) {
      if (!_matchesSection(portfolio.section)) {
        continue;
      }
      if (!_matchesProfessor(portfolio.professorName)) {
        continue;
      }
      if (!_matchesGrade(portfolio.grade)) {
        continue;
      }
      _stageUrl(remainingUrls, portfolio.url);
    }
  } catch (error) {
    print('[getClassDocuments] subjectportpolio 테이블 조회 오류: $error');
  }

  try {
    final midtermResults = await MidtermResultsTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final result in midtermResults) {
      if (!_matchesProfessor(result.professorName)) {
        continue;
      }
      if (!_matchesGrade(result.grade)) {
        continue;
      }
      _stageUrl(remainingUrls, result.url);
    }
  } catch (error) {
    print('[getClassDocuments] midterm_results 테이블 조회 오류: $error');
  }

  try {
    final finalResults = await FinalResultsTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final result in finalResults) {
      if (!_matchesProfessor(result.professorName)) {
        continue;
      }
      if (!_matchesGrade(result.grade)) {
        continue;
      }
      _stageUrl(remainingUrls, result.url);
    }
  } catch (error) {
    print('[getClassDocuments] final_results 테이블 조회 오류: $error');
  }

  _commitUrl(coverUrl);
  for (final url in indexPlanUrls) {
    _commitUrl(url);
  }
  for (final url in coursePlanUrls) {
    _commitUrl(url);
  }
  for (final url in remainingUrls) {
    _commitUrl(url);
  }

  return orderedUrls;
}
