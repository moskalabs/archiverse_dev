import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  // We want to replace the Expanded widget that starts at line 1732 (index 1731)
  // and ends at line 4129 (index 4128) with our new component

  // Keep everything before the Expanded widget (lines 0-1731, which is up to and including line 1731 with the "))")
  final beforeExpanded = lines.sublist(0, 1731);

  // Keep everything after the closing of the Expanded widget (from line 4130 onwards, index 4129)
  final afterExpanded = lines.sublist(4129);

  // New Expanded widget with our component (72 spaces indentation to match original)
  final newExpandedWidget = [
    '                                                                        Expanded(',
    '                                                                          flex: 4,',
    '                                                                          child: MidtermFinalResultsTableWidget(',
    '                                                                            studentNames: _getUniqueStudentNames(),',
    '                                                                            getMidtermStatus: _getMidtermSubmitStatus,',
    '                                                                            getFinalStatus: _getFinalSubmitStatus,',
    '                                                                          ),',
    '                                                                        ),',
  ];

  final newLines = [...beforeExpanded, ...newExpandedWidget, ...afterExpanded];

  file.writeAsStringSync(newLines.join('\n') + '\n');

  print('✅ Successfully replaced table with component');
  print('   Lines replaced: ${4129 - 1731} (from line 1732 to 4129)');
  print('   Before: ${lines.length} lines');
  print('   After: ${newLines.length} lines');
  print('   Reduced by: ${lines.length - newLines.length} lines');
}
