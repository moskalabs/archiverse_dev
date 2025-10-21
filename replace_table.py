#!/usr/bin/env python3
"""
Replace the manual midterm/final table with DataTable2
"""

def replace_table():
    file_path = '/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart'

    # Read the file
    with open(file_path, 'r', encoding='utf-8') as f:
        lines = f.readlines()

    # Define the new DataTable2 code
    new_table_code = '''                                                                      Expanded(
                                                                        flex: 4,
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.33,
                                                                          constraints:
                                                                              BoxConstraints(
                                                                            maxWidth:
                                                                                1270.0,
                                                                          ),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                          ),
                                                                          child:
                                                                              DataTable2(
                                                                            columnSpacing: 12,
                                                                            horizontalMargin: 12,
                                                                            minWidth: 600,
                                                                            headingRowColor: MaterialStateProperty.all(
                                                                              Color(0xFF284E75),
                                                                            ),
                                                                            headingRowHeight: 56,
                                                                            dataRowHeight: 52,
                                                                            columns: [
                                                                              DataColumn2(
                                                                                label: Text(
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'student_label' /* 학생 */,
                                                                                  ),
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
                                                                                  FFLocalizations.of(context).getText(
                                                                                    'd2if6pf4' /* 중간
결과물 */,
                                                                                  ),
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
                                                                                  FFLocalizations.of(context).getText(
                                                                                    '1m3ye670' /* 기말
결과물 */,
                                                                                  ),
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
                                                                            rows: _getUniqueStudentNames().map((studentName) {
                                                                              final midtermStatus = _getMidtermSubmitStatus(studentName);
                                                                              final finalStatus = _getFinalSubmitStatus(studentName);

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
                                                                                  DataCell(
                                                                                    Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            color: midtermStatus == '제출'
                                                                                                ? Color(0xFF4CAF50)
                                                                                                : FlutterFlowTheme.of(context).secondaryText,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                          fontSize: 12.0,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  DataCell(
                                                                                    Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          font: GoogleFonts.openSans(
                                                                                            color: finalStatus == '제출'
                                                                                                ? Color(0xFF2196F3)
                                                                                                : FlutterFlowTheme.of(context).secondaryText,
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
'''

    # Replace lines 1730-4128 (0-indexed: 1730-4127)
    # Keep lines before 1730 and after 4128
    new_lines = lines[:1730] + [new_table_code] + lines[4128:]

    # Write back
    with open(file_path, 'w', encoding='utf-8') as f:
        f.writelines(new_lines)

    print(f"✅ Replaced {4128-1730} lines with new DataTable2")
    print(f"   Old lines: 1731-4128")
    print(f"   New table: ~170 lines")

if __name__ == '__main__':
    replace_table()
