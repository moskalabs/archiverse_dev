import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  // Replace lines 1732-4129 (0-indexed: 1731-4128)
  final beforeTable = lines.sublist(0, 1731);
  final afterTable = lines.sublist(4129);

  // New component code
  final newComponentCode = [
    '                                                                      Expanded(',
    '                                                                        flex: 4,',
    '                                                                        child: MidtermFinalResultsTableWidget(',
    '                                                                          studentNames: _getUniqueStudentNames(),',
    '                                                                          getMidtermStatus: _getMidtermSubmitStatus,',
    '                                                                          getFinalStatus: _getFinalSubmitStatus,',
    '                                                                        ),',
    '                                                                      ),',
  ];

  final newLines = [...beforeTable, ...newComponentCode, ...afterTable];

  file.writeAsStringSync(newLines.join('\n') + '\n');

  print('✅ Replaced ${4129 - 1731} lines with ${newComponentCode.length} lines');
  print('   Before: ${lines.length} lines');
  print('   After: ${newLines.length} lines');
  print('   Reduced by: ${lines.length - newLines.length} lines');
}
