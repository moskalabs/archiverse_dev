import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');
  print('Line 1730: "${lines[1730]}"');  // Should be "                    ))"
  print('Line 1731: "${lines[1731]}"');  // Should be "                      Expanded("
  print('Line 4128: "${lines[4128]}"');  // Should be "                    ),"
  print('Line 4129: "${lines[4129]}"');  // Should be "                    Flexible("

  // We want to:
  // - Keep lines 0-1730 (file lines 1-1731, up to and including the "))" on line 1731)
  // - Replace lines 1731-4128 (file lines 1732-4129, the entire Expanded widget)
  // - Keep lines 4129+ (file lines 4130+, starting with Flexible)

  final beforeExpanded = lines.sublist(0, 1731);  // indexes 0-1730 = file lines 1-1731
  final afterExpanded = lines.sublist(4129);       // index 4129+ = file lines 4130+

  // New Expanded widget - exact indentation to match line 1731 (72 spaces)
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

  // Verify
  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines replaced: ${4129 - 1731} (file lines 1732-4129)');
  print('Reduced by: ${lines.length - newLines.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
