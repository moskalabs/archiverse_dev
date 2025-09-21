import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:webviewx_plus/webviewx_plus.dart';

import '/backend/supabase/database/tables/class.dart';
import '/backend/supabase/database/tables/course_student.dart';
import '/backend/supabase/database/tables/professor_courses.dart';
import '/backend/supabase/database/tables/professors.dart';
import '/backend/supabase/database/tables/posts.dart';
import '/backend/supabase/database/tables/subjectportpolio.dart';
import '/custom_code/widgets/index.dart'; // custom_widgets 해결
    if (rawWeek == null || rawWeek.isEmpty) {
      return null;
    }
    final match = RegExp(r'\d+').firstMatch(rawWeek);
    if (match == null) {
      return null;
    }
    final weekNumber = int.tryParse(match.group(0)!);
    if (weekNumber == null || weekNumber < 1 || weekNumber > 15) {
      return null;
    }
    return weekNumber;
  }

  List<int> _buildWeeklyCounts(List<SubjectportpolioRow>? rows) {
    final counts = List<int>.filled(15, 0);
    if (rows == null) {
      return counts;
    }
    for (final row in rows) {
      final weekNumber = _parseWeekNumber(row.week);
      if (weekNumber == null) {
        continue;
      }
      counts[weekNumber - 1]++;
    }
    return counts;
  }

  List<double> _buildWeeklyGrades(List<SubjectportpolioRow>? rows) {
    final gradeBuckets = List<List<int>>.generate(15, (_) => <int>[]);
    if (rows == null) {
      return List<double>.filled(15, 0.0);
    }
    for (final row in rows) {
      final weekNumber = _parseWeekNumber(row.week);
      final grade = row.grade;
      if (weekNumber == null || grade == null) {
        continue;
      }
      gradeBuckets[weekNumber - 1].add(grade);
    }
    return List<double>.generate(15, (index) {
      final grades = gradeBuckets[index];
      if (grades.isEmpty) {
        return 0.0;
      }
      final total = grades.reduce((value, element) => value + element);
      return total / grades.length;
    });
  }

  void _resetDashboardMetrics() {
    weeklySubmissions = List<int>.filled(15, 0);
    weeklyGrades = List<double>.filled(15, 0.0);
    totalStudents = 0;
    activeCoursesCount = 0;
    _model.chartDataParam = List<int>.filled(15, 0);
    _model.progressSubject = 0;
  }

  String _buildChartSemanticsLabel() {
    if (_isDashboardLoading) {
      return '대시보드 데이터를 불러오는 중';
    }
    final professorName =
        _activeProfessorName ?? _model.profeesorName ?? '교수님';
    final professorTypeLabel =
        _activeProfessorType == 1 ? '전임교수' : '겸임교수';
    final idSegment =
        _activeProfessorId != null ? ' (ID ${_activeProfessorId})' : '';
    final positiveGrades = weeklyGrades.where((grade) => grade > 0).toList();
    final averageGrade = positiveGrades.isEmpty
        ? 0.0
        : positiveGrades.reduce((a, b) => a + b) / positiveGrades.length;
    return '$professorName$idSegment $professorTypeLabel의 총 학생 수 ${totalStudents}명, 담당 과목 ${activeCoursesCount}개, 평균 주차 성적 ${averageGrade.toStringAsFixed(1)}점';
  }

  void _updateChartData(List<SubjectportpolioRow>? rows) {
    final chartData = _buildWeeklyCounts(rows);
    final gradeData = _buildWeeklyGrades(rows);
    final submissionCount = rows?.length ?? 0;

    safeSetState(() {
      weeklySubmissions = List<int>.from(chartData);
      weeklyGrades = List<double>.from(gradeData);
      _model.chartDataParam = List<int>.from(chartData);
      _model.progressSubject = submissionCount;
    });
  }

  Future<void> loadDashboardData() async {
    safeSetState(() {
      _isDashboardLoading = true;
    });

    final totalSubmissions = weeklySubmissions.fold<int>(0, (sum, value) => sum + value);
    return '$professorName$idSegment $professorTypeLabel의 총 학생 수 ${totalStudents}명, 담당 과목 ${activeCoursesCount}개, 누적 제출 ${totalSubmissions}건, 평균 주차 성적 ${averageGrade.toStringAsFixed(1)}점';
      final targetEmail = (widget.email ?? currentUserEmail).trim();
      if (targetEmail.isEmpty) {
        safeSetState(_resetDashboardMetrics);
        return;
      }

      final professorRows = await ProfessorsTable().querySingleRow(
        queryFn: (q) => q.eqOrNull('email', targetEmail),
      );
      final professor = professorRows.isNotEmpty ? professorRows.first : null;

      if (professor == null) {
        safeSetState(_resetDashboardMetrics);
        return;
      }

      final professorId = professor.professorId;
      final professorName = professor.name ??
          _model.profeesorName ??
          currentUserDisplayName;
      final professorType = professor.prfType;

      safeSetState(() {
        _activeProfessorId = professorId;
        _activeProfessorName = professorName;
        _activeProfessorType = professorType;
        _model.profeesorName = professorName;
      });

      if (professorType == 1) {
        await loadFullTimeProfessorData(
          professorId: professorId,
          professorName: professorName,
        );
      } else {
        await loadPartTimeProfessorData(
          professorId: professorId,
          professorName: professorName,
        );
      }
    } catch (error, stackTrace) {
      debugPrint('Error loading professor dashboard: $error');
      debugPrint('$stackTrace');
      safeSetState(_resetDashboardMetrics);
    } finally {
      safeSetState(() {
        _isDashboardLoading = false;
      });
    }
  }

  Future<void> loadFullTimeProfessorData({
    required int professorId,
    required String? professorName,
  }) async {
    await _loadProfessorMetrics(
      professorId: professorId,
      professorName: professorName,
      restrictToProfessorId: true,
    );
  }

  Future<void> loadPartTimeProfessorData({
    required int professorId,
    required String? professorName,
  }) async {
    await _loadProfessorMetrics(
      professorId: professorId,
      professorName: professorName,
      restrictToProfessorId: false,
    );
  }

  Future<void> _loadProfessorMetrics({
    required int professorId,
    required String? professorName,
    required bool restrictToProfessorId,
  }) async {
    if (professorName == null || professorName.isEmpty) {
      safeSetState(_resetDashboardMetrics);
      return;
    }

    final portfolioRows = await SubjectportpolioTable().queryRows(
      queryFn: (q) => q
          .eqOrNull('professor_name', professorName)
          .order('week'),
    );

    _updateChartData(portfolioRows);

    final studentRows = await CourseStudentTable().queryRows(
      queryFn: (q) {
        var query = q.eqOrNull('professor_name', professorName);
        if (restrictToProfessorId) {
          query = query.eqOrNull('professor_id', professorId);
        }
        return query;
      },
    );

    final uniqueStudentIds = <int>{};
    for (final student in studentRows) {
      final studentId = student.studentId;
    List<SubjectportpolioRow> portfolioRows = [];

    if (restrictToProfessorId) {
      portfolioRows = await SubjectportpolioTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('professor_id', professorId)
            .order('week'),
      );
    }

    if (portfolioRows.isEmpty) {
      portfolioRows = await SubjectportpolioTable().queryRows(
        queryFn: (q) => q
            .eqOrNull('professor_name', professorName)
            .order('week'),
      );
    }
    List<CourseStudentRow> studentRows = [];

    if (restrictToProfessorId) {
      studentRows = await CourseStudentTable().queryRows(
        queryFn: (q) => q.eqOrNull('professor_id', professorId),
      );
    }

    if (studentRows.isEmpty) {
      studentRows = await CourseStudentTable().queryRows(
        queryFn: (q) => q.eqOrNull('professor_name', professorName),
      );
    }
        if (courseId != null) {
          uniqueCourseIds.add(courseId);
        }
      }
      computedCourseCount = uniqueCourseIds.length;

      if (computedCourseCount == 0) {
        final classRows = await ClassTable().queryRows(
          queryFn: (q) => q.eqOrNull('professor', professorName),
        );
        final uniqueClassNames = <String>{};
        for (final classRow in classRows) {
          final courseName = classRow.course;
          if (courseName != null && courseName.isNotEmpty) {
            uniqueClassNames.add(courseName);
          }
        }
        computedCourseCount = uniqueClassNames.length;
      }
    } else {
      final classRows = await ClassTable().queryRows(
        queryFn: (q) => q.eqOrNull('professor', professorName),
      );
      final uniqueClassNames = <String>{};
      for (final classRow in classRows) {
        final courseName = classRow.course;
        if (courseName != null && courseName.isNotEmpty) {
          uniqueClassNames.add(courseName);
        }
      }
      computedCourseCount = uniqueClassNames.length;
    }

    safeSetState(() {
      totalStudents = uniqueStudentIds.length;
      activeCoursesCount = computedCourseCount;
    });

      loadDashboardData();
      for (final rows in dataSets) {
        if (rows != null && rows.isNotEmpty) {
          _updateChartData(rows);
          return;
        }
      }

      _updateChartData(null);
    });

                                                                              child: Semantics(
                                                                                label: _buildChartSemanticsLabel(),
                                                                                child: Container(
                                                                                  child: custom_widgets.ChartWidget(
                                                                                    width: double.infinity,
                                                                                    height: double.infinity,
                                                                                    chartData: weeklySubmissions,
                                                                                  ),
                                                                              child: Semantics(
                                                                                label: _buildChartSemanticsLabel(),
                                                                                child: Container(
                                                                                  child: custom_widgets.ChartWidget(
                                                                                    width: double.infinity,
                                                                                    height: double.infinity,
                                                                                    chartData: weeklySubmissions,
                                                                                  ),
                                                                              child: Semantics(
                                                                                label: _buildChartSemanticsLabel(),
                                                                                child: Container(
                                                                                  child: custom_widgets.ChartWidget(
                                                                                    width: double.infinity,
                                                                                    height: double.infinity,
                                                                                    chartData: weeklySubmissions,
                                                                                  ),
                                                                                                  child: Semantics(
                                                                                                    label: _buildChartSemanticsLabel(),
                                                                                                    child: Container(
                                                                                                      child: custom_widgets.ChartWidget(
                                                                                                        width: double.infinity,
                                                                                                        height: double.infinity,
                                                                                                        chartData: weeklySubmissions,
                                                                                                      ),
                                                                                                  child: Semantics(
                                                                                                    label: _buildChartSemanticsLabel(),
                                                                                                    child: Container(
                                                                                                      child: custom_widgets.ChartWidget(
                                                                                                        width: double.infinity,
                                                                                                        height: double.infinity,
                                                                                                        chartData: weeklySubmissions,
                                                                                                      ),
                                                                                                  child: Semantics(
                                                                                                    label: _buildChartSemanticsLabel(),
                                                                                                    child: Container(
                                                                                                      child: custom_widgets.ChartWidget(
                                                                                                        width: double.infinity,
                                                                                                        height: double.infinity,
                                                                                                        chartData: weeklySubmissions,
                                                                                                      ),
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  return Semantics(
                                                                                    label: _buildChartSemanticsLabel(),
                                                                                    child: ChartWidget(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      chartData: weeklySubmissions,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  return Semantics(
                                                                                    label: _buildChartSemanticsLabel(),
                                                                                    child: ChartWidget(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      chartData: weeklySubmissions,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  return Semantics(
                                                                                    label: _buildChartSemanticsLabel(),
                                                                                    child: ChartWidget(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      chartData: weeklySubmissions,
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                                      Expanded(
                                                                                                        flex: 10,
                                                                                                        child: Builder(
                                                                                                          builder: (context) {
                                                                                                            return Semantics(
                                                                                                              label: _buildChartSemanticsLabel(),
                                                                                                              child: ChartWidget(
                                                                                                                width: double.infinity,
                                                                                                                height: double.infinity,
                                                                                                                chartData: weeklySubmissions,
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      Expanded(
                                                                                                        flex: 10,
                                                                                                        child: Builder(
                                                                                                          builder: (context) {
                                                                                                            return Semantics(
                                                                                                              label: _buildChartSemanticsLabel(),
                                                                                                              child: ChartWidget(
                                                                                                                width: double.infinity,
                                                                                                                height: double.infinity,
                                                                                                                chartData: weeklySubmissions,
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
                                                                                                      Expanded(
                                                                                                        flex: 10,
                                                                                                        child: Builder(
                                                                                                          builder: (context) {
                                                                                                            return Semantics(
                                                                                                              label: _buildChartSemanticsLabel(),
                                                                                                              child: ChartWidget(
                                                                                                                width: double.infinity,
                                                                                                                height: double.infinity,
                                                                                                                chartData: weeklySubmissions,
                                                                                                              ),
                                                                                                            );
                                                                                                          },
                                                                                                        ),
