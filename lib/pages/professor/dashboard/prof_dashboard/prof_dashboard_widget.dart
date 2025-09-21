import '/backend/supabase/database/tables/subjectportpolio.dart';
import '/backend/supabase/database/tables/course_student.dart';
import '/custom_code/widgets/index.dart';
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
  List<int> _buildWeeklyCounts(List<SubjectportpolioRow>? rows) {
    final counts = List<int>.filled(15, 0);
    if (rows == null || rows.isEmpty) {
      return counts;
    }

    for (final row in rows) {
      final weekValue = row.week;
      if (weekValue == null || weekValue.isEmpty) {
        continue;
      }

      final weekMatch = RegExp(r'\d+').firstMatch(weekValue);
      final parsedWeek =
          weekMatch != null ? int.tryParse(weekMatch.group(0)!) : null;
      if (parsedWeek == null) {
        continue;
      }

      if (parsedWeek >= 1 && parsedWeek <= counts.length) {
        counts[parsedWeek - 1] = counts[parsedWeek - 1] + 1;
      }
    }

    return counts;
  }

  void _updateChartData(List<SubjectportpolioRow>? rows) {
    final counts = _buildWeeklyCounts(rows);
    final current = _model.chartDataParam;
    var hasDifference = current.length != counts.length;
    if (!hasDifference) {
      for (var i = 0; i < counts.length; i++) {
        if (current[i] != counts[i]) {
          hasDifference = true;
          break;
        }
      }
    }

    _model.chartDataParam = counts;
    if (!hasDifference || !mounted) {
      return;
    }
    safeSetState(() {});
  }

    _updateChartData(null);

                                                                                    height: double.infinity,
                                                                                    chartData: weeklySubmissions,
                                                                                  ),
                                                                              child: Semantics(
                                                                                label: _buildChartSemanticsLabel(),
                                                                                child: Container(
  String _buildChartSemanticsLabel(List<int> chartData) {
    if (chartData.isEmpty) {
      return '주차별 제출 현황 데이터가 없습니다.';
    }
    final total = chartData.fold<int>(0, (sum, value) => sum + value);
    final details = <String>[];
    for (var i = 0; i < chartData.length; i++) {
      final value = chartData[i];
      if (value > 0) {
        details.add('${i + 1}주차 ${value}건');
      }
    }
    final buffer = StringBuffer('주차별 제출 현황. 총 제출 수 ${total}건');
    if (_studentEnrollmentCount > 0) {
      buffer.write(', 담당 학생 ${_studentEnrollmentCount}명');
    }
    if (details.isNotEmpty) {
      buffer.write(', ');
      buffer.write(details.join(', '));
    }
    return buffer.toString();
  }

  Future<void> _refreshStudentCount() async {
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
