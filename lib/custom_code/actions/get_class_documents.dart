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
  final List<String> urls = [];
  final Set<String> seen = <String>{};

  if (classId <= 0) {
    print('[getClassDocuments] 잘못된 classId: $classId');
    return urls;
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

  void addUrl(String? value) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty && seen.add(trimmed)) {
      urls.add(trimmed);
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
      addUrl(classData.first.url);
    }
  } catch (error) {
    print('[getClassDocuments] class 테이블 조회 오류: $error');
  }

  try {
    final coursePlans = await CourseplanTable().queryRows(
      queryFn: (q) {
        var query = q.eq('class', classId);
        if (normalizedSection != null) {
          query = query.eqOrNull('section', normalizedSection);
        }
        return query.order('created_date');
      },
    );
    for (final plan in coursePlans) {
      addUrl(plan.url);
    }
  } catch (error) {
    print('[getClassDocuments] courseplan 테이블 조회 오류: $error');
  }

  try {
    final attendances = await AttendanceTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final attendance in attendances) {
      addUrl(attendance.url);
    }
  } catch (error) {
    print('[getClassDocuments] attendance 테이블 조회 오류: $error');
  }

  try {
    final gradeSheets = await GradesheetTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final gradeSheet in gradeSheets) {
      addUrl(gradeSheet.url);
    }
  } catch (error) {
    print('[getClassDocuments] gradesheet 테이블 조회 오류: $error');
  }

  try {
    final workEvaluations = await WorkevalformTable().queryRows(
      queryFn: (q) {
        var query = q.eq('class', classId);
        if (normalizedSection != null) {
          query = query.eqOrNull('section', normalizedSection);
        }
        return query.order('created_date');
      },
    );
    for (final evalForm in workEvaluations) {
      addUrl(evalForm.url);
    }
  } catch (error) {
    print('[getClassDocuments] workevalform 테이블 조회 오류: $error');
  }

  try {
    final lectureMaterials = await LecturematerialTable().queryRows(
      queryFn: (q) {
        var query = q.eq('class', classId);
        if (normalizedSection != null) {
          query = query.eqOrNull('section', normalizedSection);
        }
        return query.order('created_date');
      },
    );
    for (final material in lectureMaterials) {
      addUrl(material.url);
    }
  } catch (error) {
    print('[getClassDocuments] lecturematerial 테이블 조회 오류: $error');
  }

  try {
    final portfolioData = await SubjectportpolioTable().queryRows(
      queryFn: (q) {
        var query = q.eq('class', classId);
        if (normalizedSection != null) {
          query = query.eqOrNull('section', normalizedSection);
        }
        if (normalizedProfessor != null) {
          query = query.eqOrNull('professor_name', normalizedProfessor);
        }
        if (grade != null && grade > 0) {
          query = query.eqOrNull('grade', grade);
        }
        return query.order('created_date');
      },
    );
    for (final portfolio in portfolioData) {
      addUrl(portfolio.url);
    }
  } catch (error) {
    print('[getClassDocuments] subjectportpolio 테이블 조회 오류: $error');
  }

  try {
    final midtermResults = await MidtermResultsTable().queryRows(
      queryFn: (q) {
        var query = q.eq('class', classId);
        if (normalizedProfessor != null) {
          query = query.eqOrNull('professor_name', normalizedProfessor);
        }
        if (grade != null && grade > 0) {
          query = query.eqOrNull('grade', grade);
        }
        return query.order('created_date');
      },
    );
    for (final result in midtermResults) {
      addUrl(result.url);
    }
  } catch (error) {
    print('[getClassDocuments] midterm_results 테이블 조회 오류: $error');
  }

  try {
    final finalResults = await FinalResultsTable().queryRows(
      queryFn: (q) {
        var query = q.eq('class', classId);
        if (normalizedProfessor != null) {
          query = query.eqOrNull('professor_name', normalizedProfessor);
        }
        if (grade != null && grade > 0) {
          query = query.eqOrNull('grade', grade);
        }
        return query.order('created_date');
      },
    );
    for (final result in finalResults) {
      addUrl(result.url);
    }
  } catch (error) {
    print('[getClassDocuments] final_results 테이블 조회 오류: $error');
  }

  return urls;
}
