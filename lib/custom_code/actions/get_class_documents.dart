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

Future<List<String>> getClassDocuments(int classId) async {
  final List<String> urls = [];
  final Set<String> seen = <String>{};

  if (classId <= 0) {
    print('[getClassDocuments] 잘못된 classId: $classId');
    return urls;
  }

  void addUrl(String? value) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty && seen.add(trimmed)) {
      urls.add(trimmed);
    }
  }

  try {
    final classData = await ClassTable().queryRows(
      queryFn: (q) => q.eq('id', classId),
    );
    if (classData.isNotEmpty) {
      addUrl(classData.first.url);
    }
  } catch (error) {
    print('[getClassDocuments] class 테이블 조회 오류: $error');
  }

  try {
    final coursePlans = await CourseplanTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final plan in coursePlans) {
      addUrl(plan.url);
    }
  } catch (error) {
    print('[getClassDocuments] courseplan 테이블 조회 오류: $error');
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
    final portfolioData = await SubjectportpolioTable().queryRows(
      queryFn: (q) => q.eq('class', classId).order('created_date'),
    );
    for (final portfolio in portfolioData) {
      addUrl(portfolio.url);
    }
  } catch (error) {
    print('[getClassDocuments] subjectportpolio 테이블 조회 오류: $error');
  }

  try {
    final assessmentData = await Future.wait([
      MidtermResultsTable().queryRows(
        queryFn: (q) => q.eq('class', classId).order('created_date'),
      ),
      FinalResultsTable().queryRows(
        queryFn: (q) => q.eq('class', classId).order('created_date'),
      ),
    ]);

    for (final results in assessmentData.expand((rows) => rows)) {
      addUrl(results.url);
    }
  } catch (error) {
    print('[getClassDocuments] 평가 자료 조회 오류: $error');
  }

  return urls;
}
