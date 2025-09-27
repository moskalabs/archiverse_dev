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

Future<List<CourseStudentRow>> fetchClassStudents({
  int? classId,
  String? year,
  String? semester,
  int? grade,
  String? courseName,
  String? professorName,
  String? section,
}) async {
  if (classId == null || classId <= 0) {
    debugPrint('[fetchClassStudents] 잘못된 classId: $classId');
    return [];
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

  List<CourseStudentRow> results = [];

  try {
    results = await CourseStudentTable().queryRows(
      queryFn: (q) {
        var query = q.eq('classid', classId);

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
          query = query.eqOrNull('course_name', normalizedCourse);
        }
        if (normalizedProfessor != null) {
          query = query.eqOrNull('professor_name', normalizedProfessor);
        }
        if (normalizedSection != null) {
          query = query.eqOrNull('section_type', normalizedSection);
        }

        return query.order('student_name');
      },
    );
  } catch (error) {
    debugPrint('[fetchClassStudents] 학생 목록 조회 실패: $error');
    return [];
  }

  debugPrint(
      '[fetchClassStudents] 선택 정보 => classId: $classId, year: ${normalizedYear ?? '-'}, semester: ${normalizedSemester ?? '-'}, grade: ${grade ?? '-'}, course: ${normalizedCourse ?? '-'}, professor: ${normalizedProfessor ?? '-'}, section: ${normalizedSection ?? '-'}');
  debugPrint('[fetchClassStudents] 조회된 학생 수: ${results.length}');
  for (final student in results) {
    final name = student.studentName ?? '이름 없음';
    final studentId = student.studentId?.toString() ?? 'ID 없음';
    debugPrint('  · 학생: $name (ID: $studentId)');
  }

  return results;
}
