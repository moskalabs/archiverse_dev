import '/backend/supabase/database/tables/course_student.dart';
import '/backend/supabase/database/tables/subjectportpolio.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'dart:math' as math;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
  int _studentEnrollmentCount = 0;

  List<int> _buildWeeklyCounts(List<SubjectportpolioRow>? rows) {
    final counts = List<int>.filled(15, 0);
    if (rows == null || rows.isEmpty) {
      return counts;
  static const String _defaultChartKey = '_default';

  final Map<String, List<int>> _chartDataByKey = <String, List<int>>{};
    }

    for (final row in rows) {
      final weekLabel = row.week;
      if (weekLabel == null || weekLabel.isEmpty) {
        continue;
      }

      final weekMatch = RegExp(r'(\d+)').firstMatch(weekLabel);
      final parsedWeek =
          weekMatch != null ? int.tryParse(weekMatch.group(1) ?? '') : null;
      if (parsedWeek == null) {
        continue;
      }

      final index = parsedWeek - 1;
      if (index >= 0 && index < counts.length) {
        counts[index] = counts[index] + 1;
      }
    }

    return counts;
  }

  String _chartKeyForType({required bool isAdjunct, required int index}) =>
      '${isAdjunct ? 'adjunct' : 'fullTime'}-$index';

  List<int> _getChartData(String key) {
    if (_chartDataByKey.containsKey(key)) {
      return _chartDataByKey[key]!;
    }
    return _chartDataByKey[_defaultChartKey] ?? List<int>.filled(15, 0);
  }

  String _buildChartSemanticsLabel(String key) {
    final data = _getChartData(key);
    final totalSubmissions = data.fold<int>(0, (sum, value) => sum + value);
    return '담당 학생 ${_studentEnrollmentCount}명, 총 제출 ${totalSubmissions}건';
  }

  void _updateChartData({
    required String key,
    List<SubjectportpolioRow>? rows,
  }) {
    final counts = _buildWeeklyCounts(rows);
    safeSetState(() {
      _chartDataByKey[key] = counts;
      if (key == _defaultChartKey) {
        _model.chartDataParam = counts;
      }
    });
  Future<void> _refreshStudentEnrollment(String professorName) async {
    }
  Future<void> _loadProfessorPortfolioSummary(String professorName) async {
    final rows = await SubjectportpolioTable().queryRows(
      queryFn: (q) => q
          .eqOrNull(
            'professor_name',
            professorName,
          )
          .order('week'),
    );

    if (!mounted) {
      return;
    }

    _updateChartData(key: _defaultChartKey, rows: rows);
  }
    _chartDataByKey[_defaultChartKey] = List<int>.from(_model.chartDataParam);

      final professorName = _model.profeesorName ?? '';
      if (professorName.isNotEmpty && professorName != '교수 이름') {
        await Future.wait([
          _loadProfessorPortfolioSummary(professorName),
          _refreshStudentEnrollment(professorName),
        ]);
      }
    final professorName = _model.profeesorName;
    if (professorName == null || professorName.isEmpty) {
      return;
    }

    final rows = await CourseStudentTable().queryRows(
      queryFn: (q) => q.eqOrNull(
        'professor_name',
        professorName,
      ),
    );

    if (!mounted) {
      return;
    }

    safeSetState(() {
      _studentEnrollmentCount = rows.length;
    });
  }

  int _studentEnrollmentCount = 0;

      await _refreshStudentCount();
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
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                child: custom_widgets.ChartWidget(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  chartData: _model.chartDataParam,
                                                                                ),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                child: custom_widgets.ChartWidget(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  chartData: _model.chartDataParam,
                                                                                ),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                child: custom_widgets.ChartWidget(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  chartData: _model.chartDataParam,
                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 10,
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: double.infinity,
                                                                                                    child: custom_widgets.ChartWidget(
                                                                                                      width: double.infinity,
                                                                                                      height: double.infinity,
                                                                                                      chartData: _model.chartDataParam,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 10,
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: double.infinity,
                                                                                                    child: custom_widgets.ChartWidget(
                                                                                                      width: double.infinity,
                                                                                                      height: double.infinity,
                                                                                                      chartData: _model.chartDataParam,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 10,
                                                                                                  child: Container(
                                                                                                    width: double.infinity,
                                                                                                    height: double.infinity,
                                                                                                    child: custom_widgets.ChartWidget(
                                                                                                      width: double.infinity,
                                                                                                      height: double.infinity,
                                                                                                      chartData: _model.chartDataParam,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                          _updateChartData(_model.progressoutput1);
                                                                                            _updateChartData(_model.progressoutput2);
                                                                                            _updateChartData(_model.progressoutput3);
                                                                                          _updateChartData(_model.progressoutput1A);
                                                                                            _updateChartData(_model.progressoutput2A);
                                                                                            _updateChartData(_model.progressoutput3A);
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final chartData = _model.chartDataParam;
                                                                                  return Semantics(
                                                                                    label: _buildChartSemanticsLabel(chartData),
                                                                                    child: Container(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      child: ChartWidget(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        chartData: chartData,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final chartData = _model.chartDataParam;
                                                                                  return Semantics(
                                                                                    label: _buildChartSemanticsLabel(chartData),
                                                                                    child: Container(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      child: ChartWidget(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        chartData: chartData,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                              child: Builder(
                                                                                builder: (context) {
                                                                                  final chartData = _model.chartDataParam;
                                                                                  return Semantics(
                                                                                    label: _buildChartSemanticsLabel(chartData),
                                                                                    child: Container(
                                                                                      width: double.infinity,
                                                                                      height: double.infinity,
                                                                                      child: ChartWidget(
                                                                                        width: double.infinity,
                                                                                        height: double.infinity,
                                                                                        chartData: chartData,
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                },
                                                                                                  child: Builder(
                                                                                                  builder: (context) {
                                                                                                    final chartData = _model.chartDataParam;
                                                                                                    return Semantics(
                                                                                                      label: _buildChartSemanticsLabel(chartData),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: double.infinity,
                                                                                                        child: ChartWidget(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          chartData: chartData,
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                                  child: Builder(
                                                                                                  builder: (context) {
                                                                                                    final chartData = _model.chartDataParam;
                                                                                                    return Semantics(
                                                                                                      label: _buildChartSemanticsLabel(chartData),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: double.infinity,
                                                                                                        child: ChartWidget(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          chartData: chartData,
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                                  child: Builder(
                                                                                                  builder: (context) {
                                                                                                    final chartData = _model.chartDataParam;
                                                                                                    return Semantics(
                                                                                                      label: _buildChartSemanticsLabel(chartData),
                                                                                                      child: Container(
                                                                                                        width: double.infinity,
                                                                                                        height: double.infinity,
                                                                                                        child: ChartWidget(
                                                                                                          width: double.infinity,
                                                                                                          height: double.infinity,
                                                                                                          chartData: chartData,
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                ),
                                                                                            _model.progressoutput1 = await SubjectportpolioTable().queryRows(
                                                                                              queryFn: (q) => q
                                                                                                  .eqOrNull(
                                                                                                    'professor_name',
                                                                                                    _model.profeesorName,
                                                                                                  )
                                                                                                  .eqOrNull(
                                                                                                    'class',
                                                                                                    _model.classAfterGradeByCourseForSection.firstOrNull?.id,
                                                                                                  ),
                                                                                            );
                                                                                            _model.progressSubject = _model.progressoutput1!.length;
                                                                                            safeSetState(() {});
                                                                                            _updateChartData(_model.progressoutput1);
                                                                                            safeSetState(() {});
                                                                                          },
                                                                                            _updateChartData(_model.progressoutput2);
                                                                                            _updateChartData(_model.progressoutput3);
                                                                              Expanded(
                                                                                flex: 10,
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  child: Semantics(
                                                                                    label: '담당 학생 ${_studentEnrollmentCount}명',
                                                                                    child: custom_widgets.ChartWidget(
                                                                                      chartData: _model.chartDataParam,
                                                                                  ),
                                                                                ),
                                                                              Expanded(
                                                                                flex: 10,
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  child: Semantics(
                                                                                    label: '담당 학생 ${_studentEnrollmentCount}명',
                                                                                    child: custom_widgets.ChartWidget(
                                                                                      chartData: _model.chartDataParam,
                                                                                  ),
                                                                                ),
                                                                              Expanded(
                                                                                flex: 10,
                                                                                child: Container(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  child: Semantics(
                                                                                    label: '담당 학생 ${_studentEnrollmentCount}명',
                                                                                    child: custom_widgets.ChartWidget(
                                                                                      chartData: _model.chartDataParam,
                                                                                  ),
                                                                                ),
                                                                                            _model.progressoutput1A = await SubjectportpolioTable().queryRows(
                                                                                              queryFn: (q) => q
                                                                                                  .eqOrNull(
                                                                                                    'professor_name',
                                                                                                    _model.profeesorName,
                                                                                                  )
                                                                                                  .eqOrNull(
                                                                                                    'class',
                                                                                                    _model.classAfterGradeByCourseForSection.firstOrNull?.id,
                                                                                                  ),
                                                                                            );
                                                                                            _model.progressSubject = _model.progressoutput1A!.length;
                                                                                            safeSetState(() {});
                                                                                            _updateChartData(_model.progressoutput1A);
                                                                                            safeSetState(() {});
                                                                                          },
                                                                                            _updateChartData(_model.progressoutput2A);
                                                                                            _updateChartData(_model.progressoutput3A);
                                                                                                  Expanded(
                                                                                                    flex: 10,
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: double.infinity,
                                                                                                      child: Semantics(
                                                                                                        label: '담당 학생 ${_studentEnrollmentCount}명',
                                                                                                        child: custom_widgets.ChartWidget(
                                                                                                          chartData: _model.chartDataParam,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 10,
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: double.infinity,
                                                                                                      child: Semantics(
                                                                                                        label: '담당 학생 ${_studentEnrollmentCount}명',
                                                                                                        child: custom_widgets.ChartWidget(
                                                                                                          chartData: _model.chartDataParam,
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 10,
                                                                                                    child: Container(
                                                                                                      width: double.infinity,
                                                                                                      height: double.infinity,
                                                                                                      child: Semantics(
                                                                                                        label: '담당 학생 ${_studentEnrollmentCount}명',
                                                                                                        child: custom_widgets.ChartWidget(
                                                                                                          chartData: _model.chartDataParam,
                                                                                                    ),
                                                                                                  ),
                                                                                            _updateChartData(
                                                                                              key: _chartKeyForType(
                                                                                                isAdjunct: false,
                                                                                                index: 0,
                                                                                              ),
                                                                                              rows: _model.progressoutput1,
                                                                                            );
                                                                                            _updateChartData(
                                                                                              key: _chartKeyForType(
                                                                                                isAdjunct: false,
                                                                                                index: 1,
                                                                                              ),
                                                                                              rows: _model.progressoutput2,
                                                                                            );
                                                                                            _updateChartData(
                                                                                              key: _chartKeyForType(
                                                                                                isAdjunct: false,
                                                                                                index: 2,
                                                                                              ),
                                                                                              rows: _model.progressoutput3,
                                                                                            );
                                                                                    label: _buildChartSemanticsLabel(
                                                                                      _chartKeyForType(
                                                                                        isAdjunct: false,
                                                                                        index: 0,
                                                                                      ),
                                                                                    ),
                                                                                      chartData: _getChartData(
                                                                                        _chartKeyForType(
                                                                                          isAdjunct: false,
                                                                                          index: 0,
                                                                                        ),
                                                                                      ),
                                                                                    label: _buildChartSemanticsLabel(
                                                                                      _chartKeyForType(
                                                                                        isAdjunct: false,
                                                                                        index: 1,
                                                                                      ),
                                                                                    ),
                                                                                      chartData: _getChartData(
                                                                                        _chartKeyForType(
                                                                                          isAdjunct: false,
                                                                                          index: 1,
                                                                                        ),
                                                                                      ),
                                                                                    label: _buildChartSemanticsLabel(
                                                                                      _chartKeyForType(
                                                                                        isAdjunct: false,
                                                                                        index: 2,
                                                                                      ),
                                                                                    ),
                                                                                      chartData: _getChartData(
                                                                                        _chartKeyForType(
                                                                                          isAdjunct: false,
                                                                                          index: 2,
                                                                                        ),
                                                                                      ),
                                                                                            _updateChartData(
                                                                                              key: _chartKeyForType(
                                                                                                isAdjunct: true,
                                                                                                index: 0,
                                                                                              ),
                                                                                              rows: _model.progressoutput1A,
                                                                                            );
                                                                                            _updateChartData(
                                                                                              key: _chartKeyForType(
                                                                                                isAdjunct: true,
                                                                                                index: 1,
                                                                                              ),
                                                                                              rows: _model.progressoutput2A,
                                                                                            );
                                                                                            _updateChartData(
                                                                                              key: _chartKeyForType(
                                                                                                isAdjunct: true,
                                                                                                index: 2,
                                                                                              ),
                                                                                              rows: _model.progressoutput3A,
                                                                                            );
                                                                                                        label: _buildChartSemanticsLabel(
                                                                                                          _chartKeyForType(
                                                                                                            isAdjunct: true,
                                                                                                            index: 0,
                                                                                                          ),
                                                                                                        ),
                                                                                                          chartData: _getChartData(
                                                                                                            _chartKeyForType(
                                                                                                              isAdjunct: true,
                                                                                                              index: 0,
                                                                                                            ),
                                                                                                          ),
                                                                                                        label: _buildChartSemanticsLabel(
                                                                                                          _chartKeyForType(
                                                                                                            isAdjunct: true,
                                                                                                            index: 1,
                                                                                                          ),
                                                                                                        ),
                                                                                                          chartData: _getChartData(
                                                                                                            _chartKeyForType(
                                                                                                              isAdjunct: true,
                                                                                                              index: 1,
                                                                                                            ),
                                                                                                          ),
                                                                                                        label: _buildChartSemanticsLabel(
                                                                                                          _chartKeyForType(
                                                                                                            isAdjunct: true,
                                                                                                            index: 2,
                                                                                                          ),
                                                                                                        ),
                                                                                                          chartData: _getChartData(
                                                                                                            _chartKeyForType(
                                                                                                              isAdjunct: true,
                                                                                                              index: 2,
                                                                                                            ),
                                                                                                          ),
