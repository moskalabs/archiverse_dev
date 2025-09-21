  List<int> _buildWeeklyCounts(List<SubjectportpolioRow>? rows) {
    final counts = List<int>.filled(15, 0);
    if (rows == null) {
      return counts;
    }
    for (final row in rows) {
      final rawWeek = row.week ?? '';
      final match = RegExp(r'\d+').firstMatch(rawWeek);
      if (match == null) {
        continue;
      }
      final weekNumber = int.tryParse(match.group(0)!);
      if (weekNumber == null || weekNumber < 1 || weekNumber > counts.length) {
        continue;
      }
      counts[weekNumber - 1]++;
    }
    return counts;
  }

  void _updateChartData(List<SubjectportpolioRow>? rows) {
    _model.chartDataParam = _buildWeeklyCounts(rows);
  }

                                                                                          _updateChartData(_model.progressoutput1);
                                                                                            _updateChartData(_model.progressoutput2);
                                                                                            _updateChartData(_model.progressoutput3);
                                                                                          _updateChartData(_model.progressoutput1A);
                                                                                            _updateChartData(_model.progressoutput2A);
                                                                                            _updateChartData(_model.progressoutput3A);
