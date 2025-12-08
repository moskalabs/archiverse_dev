// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:fl_chart/fl_chart.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({
    super.key,
    this.width,
    this.height,
    this.chartData, // 차트 데이터를 위한 매개변수 추가
    this.maxValue, // 학생 수 기반 최대값 (옵션)
  });

  final double? width;
  final double? height;
  final List<int>? chartData; // 차트 데이터 매개변수를 int 타입으로 변경
  final int? maxValue; // 학생 수 기반 Y축 최대값

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  // 기본 샘플 데이터 (매개변수가 없을 경우 사용)
  final List<int> _defaultData = [8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  // 사용할 데이터 가져오기
  List<int> get _chartData => widget.chartData ?? _defaultData;

  // 데이터의 최대값 계산 (Y축 스케일링용)
  double get _maxYValue {
    // maxValue가 지정되면 그 값을 사용 (학생 수 기준)
    if (widget.maxValue != null && widget.maxValue! > 0) {
      return widget.maxValue!.toDouble();
    }
    // 그렇지 않으면 데이터 기반으로 계산
    if (_chartData.isEmpty) return 10;
    final maxValue = _chartData.reduce((a, b) => a > b ? a : b);
    // 최대값에 여유를 두기 위해 20% 추가하고, 최소 10으로 설정
    return (maxValue * 1.2).clamp(10, double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceEvenly,
            maxY: _maxYValue,
            minY: 0,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${group.x + 1}주차: ${rod.toY.toInt()}명',
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            barGroups: List.generate(
              15,
              (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: index < _chartData.length
                        ? _chartData[index].toDouble()
                        : 0,
                    color: const Color(0xFF284E75),
                    width: 16,
                    borderRadius: BorderRadius.circular(3),
                  )
                ],
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 20,
                  getTitlesWidget: (value, meta) {
                    int weekNum = value.toInt() + 1;
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '$weekNum',
                        style: TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              show: false,
            ),
            borderData: FlBorderData(
              show: false,
            ),
          ),
        ),
      ),
    );
  }
}
