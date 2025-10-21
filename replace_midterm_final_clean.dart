import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');

  // Verify key lines
  print('Line 1730 (last line before Expanded): "${lines[1729].trim()}"');
  print('Line 1731 (Expanded start): "${lines[1730].trim()}"');
  print('Line 4015 (last line of Expanded): "${lines[4014].trim()}"');
  print('Line 4016 (next Expanded start): "${lines[4015].trim()}"');

  // Keep lines 0-1730 (file lines 1-1731, up to and including the "))" after if statement)
  // Replace lines 1731-4015 (file lines 1732-4016, the entire "중간기말 결과물" Expanded widget)
  // Keep lines 4016+ (file lines 4017+, the next Expanded widget onwards)

  final beforeExpanded = lines.sublist(0, 1731);  // lines 1-1731
  final afterExpanded = lines.sublist(4016);      // lines 4017+

  // New Expanded widget - match indentation of line 1731
  final newExpanded = [
    '                                                                      Expanded(',
    '                                                                        flex: 4,',
    '                                                                        child: MidtermFinalResultsTableWidget(',
    '                                                                          studentNames: _getUniqueStudentNames(),',
    '                                                                          getMidtermStatus: _getMidtermSubmitStatus,',
    '                                                                          getFinalStatus: _getFinalSubmitStatus,',
    '                                                                        ),',
    '                                                                      ),',
  ];

  final newLines = [...beforeExpanded, ...newExpanded, ...afterExpanded];

  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines removed: ${lines.length - newLines.length}');
  print('Expected reduction: ${4016 - 1731} lines of table code → ${newExpanded.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
