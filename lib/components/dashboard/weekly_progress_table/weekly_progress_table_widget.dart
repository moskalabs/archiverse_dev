import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'weekly_progress_table_model.dart';
export 'weekly_progress_table_model.dart';

class WeeklyProgressTableWidget extends StatefulWidget {
  const WeeklyProgressTableWidget({
    super.key,
    required this.studentNames,
    required this.getWeekStatus,
    this.onCellTap,
  });

  final List<String> studentNames;
  final String Function(String studentName, int week) getWeekStatus;
  final Function(String studentName, int week)? onCellTap;

  @override
  State<WeeklyProgressTableWidget> createState() =>
      _WeeklyProgressTableWidgetState();
}

class _WeeklyProgressTableWidgetState
    extends State<WeeklyProgressTableWidget> {
  late WeeklyProgressTableModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WeeklyProgressTableModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.61,
      constraints: BoxConstraints(maxWidth: 1270.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
              child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1200,
                headingRowHeight: 32,
                dataRowHeight: 44,
                headingRowColor: WidgetStateProperty.all(Color(0xFF284E75)),
                border: TableBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                columns: [
                  DataColumn2(
                    label: Text(
                      '학생',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                    ),
                    size: ColumnSize.L,
                  ),
                  // 15개 주차 컬럼
                  ...List.generate(
                    15,
                    (index) => DataColumn2(
                      label: Text(
                        '${index + 1}주차',
                        style: FlutterFlowTheme.of(context).labelLarge.override(
                              font: GoogleFonts.openSans(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                      ),
                      size: ColumnSize.S,
                    ),
                  ),
                ],
                rows: widget.studentNames.map((studentName) {
                  return DataRow2(
                    cells: [
                      DataCell(
                        Text(
                          studentName,
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                font: GoogleFonts.openSans(
                                  fontWeight: FontWeight.w500,
                                ),
                                fontSize: 13.0,
                              ),
                        ),
                      ),
                      // 15개 주차 데이터
                      ...List.generate(
                        15,
                        (weekIndex) {
                          final status = widget.getWeekStatus(studentName, weekIndex + 1);
                          final isSubmitted = status == '제출';
                          final week = weekIndex + 1;
                          return DataCell(
                            InkWell(
                              onTap: isSubmitted
                                  ? () => widget.onCellTap?.call(studentName, week)
                                  : null,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: isSubmitted
                                      ? Color(0xFF284E75).withOpacity(0.1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isSubmitted
                                        ? Color(0xFF284E75)
                                        : FlutterFlowTheme.of(context).alternate,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  status,
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.openSans(
                                          color: isSubmitted
                                              ? Color(0xFF284E75)
                                              : FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        fontSize: 11.0,
                                      ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
