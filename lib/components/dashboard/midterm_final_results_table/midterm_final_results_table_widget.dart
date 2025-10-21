import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'midterm_final_results_table_model.dart';
export 'midterm_final_results_table_model.dart';

class MidtermFinalResultsTableWidget extends StatefulWidget {
  const MidtermFinalResultsTableWidget({
    super.key,
    required this.studentNames,
    required this.getMidtermStatus,
    required this.getFinalStatus,
  });

  final List<String> studentNames;
  final String Function(String) getMidtermStatus;
  final String Function(String) getFinalStatus;

  @override
  State<MidtermFinalResultsTableWidget> createState() =>
      _MidtermFinalResultsTableWidgetState();
}

class _MidtermFinalResultsTableWidgetState
    extends State<MidtermFinalResultsTableWidget> {
  late MidtermFinalResultsTableModel _model;
  int _currentPage = 0;
  static const int _studentsPerPage = 3;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MidtermFinalResultsTableModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  int get _totalPages =>
      (widget.studentNames.length / _studentsPerPage).ceil();

  List<String> get _currentPageStudents {
    final startIndex = _currentPage * _studentsPerPage;
    final endIndex = (startIndex + _studentsPerPage).clamp(0, widget.studentNames.length);
    return widget.studentNames.sublist(startIndex, endIndex);
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.33,
      constraints: BoxConstraints(
        maxWidth: 1270.0,
      ),
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
                minWidth: 600,
                headingRowHeight: 32,
                dataRowHeight: 44,
                headingRowColor: WidgetStateProperty.all(
                  Color(0xFF284E75),
                ),
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
                  DataColumn2(
                    label: Text(
                      '중간 결과물',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                    ),
                    size: ColumnSize.M,
                  ),
                  DataColumn2(
                    label: Text(
                      '기말 결과물',
                      style: FlutterFlowTheme.of(context).labelLarge.override(
                            font: GoogleFonts.openSans(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            fontSize: 14.0,
                            color: Colors.white,
                          ),
                    ),
                    size: ColumnSize.M,
                  ),
                ],
                rows: _currentPageStudents.map((studentName) {
                  final midtermStatus = widget.getMidtermStatus(studentName);
                  final finalStatus = widget.getFinalStatus(studentName);

                  return DataRow2(
                    cells: [
                      // Student Name
                      DataCell(
                        Text(
                          studentName,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    fontSize: 13.0,
                                  ),
                        ),
                      ),
                      // Midterm Status
                      DataCell(
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: midtermStatus == '제출'
                                ? Color(0xFF4CAF50).withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: midtermStatus == '제출'
                                  ? Color(0xFF4CAF50)
                                  : FlutterFlowTheme.of(context).alternate,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            midtermStatus,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.openSans(
                                    color: midtermStatus == '제출'
                                        ? Color(0xFF4CAF50)
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  fontSize: 12.0,
                                ),
                          ),
                        ),
                      ),
                      // Final Status
                      DataCell(
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: finalStatus == '제출'
                                ? Color(0xFF2196F3).withOpacity(0.1)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: finalStatus == '제출'
                                  ? Color(0xFF2196F3)
                                  : FlutterFlowTheme.of(context).alternate,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            finalStatus,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.openSans(
                                    color: finalStatus == '제출'
                                        ? Color(0xFF2196F3)
                                        : FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  fontSize: 12.0,
                                ),
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          // Pagination Controls
          if (widget.studentNames.length > _studentsPerPage)
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.chevron_left,
                      color: _currentPage > 0
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                    onPressed: _currentPage > 0 ? _previousPage : null,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '${_currentPage + 1} / $_totalPages',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.w500,
                            ),
                            fontSize: 13.0,
                          ),
                    ),
                  ),
                  FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.chevron_right,
                      color: _currentPage < _totalPages - 1
                          ? FlutterFlowTheme.of(context).primaryText
                          : FlutterFlowTheme.of(context).secondaryText,
                      size: 24,
                    ),
                    onPressed:
                        _currentPage < _totalPages - 1 ? _nextPage : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
