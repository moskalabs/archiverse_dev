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
  });

  final double? width;
  final double? height;
  final List<int>? chartData; // 차트 데이터 매개변수를 int 타입으로 변경

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  // 기본 샘플 데이터 (매개변수가 없을 경우 사용)
  final List<int> _defaultData = [8, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  // 사용할 데이터 가져오기
  List<int> get _chartData => widget.chartData ?? _defaultData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: const EdgeInsets.all(
            0.0), // Removed padding to maximize chart space
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.center,
            maxY: 100, // 최대값 100% (15주 = 100%)
            minY: 0,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return BarTooltipItem(
                    '${rod.toY.toInt()}',
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  );
                },
              ),
            ),
            barGroups: List.generate(
              15, // 15주
              (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: index < _chartData.length
                        ? _chartData[index].toDouble()
                        : 0,
                    color: const Color(0xFF284E75), // 색상을 #284E75로 변경
                    width: 16,
                    borderRadius: BorderRadius.circular(4),
                  )
                ],
              ),
            ),
            titlesData: FlTitlesData(
              // 모든 축 레이블 완전히 제거
              show: false, // This disables all titles
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              drawHorizontalLine: true,
              horizontalInterval: 20, // 20% 간격으로 그리드 표시
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            borderData: FlBorderData(
              show: false, // 테두리 제거
            ),
          ),
        ),
      ),
    );
  }
}
