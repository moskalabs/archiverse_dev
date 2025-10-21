import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');
  print('Line 1730: "${lines[1730]}"');  // Should be "))" - if statement closing
  print('Line 1731: "${lines[1731]}"');  // Should be "Expanded(" - start of midterm/final table
  print('Line 4015: "${lines[4015]}"');  // Last line of table Expanded
  print('Line 4016: "${lines[4016]}"');  // Should be "Expanded(" - 5th widget

  // Replace the entire "중간기말 결과물" Expanded widget (lines 1731-4015)
  // - Keep lines 0-1730 (up to and including "))" of if statement)
  // - Replace lines 1731-4015 (entire Expanded widget with complex table)
  // - Keep lines 4016+ (5th Expanded widget onwards)

  final beforeExpanded = lines.sublist(0, 1731);  // indexes 0-1730 = file lines 1-1731
  final afterExpanded = lines.sublist(4016);      // index 4016+ = file lines 4017+

  // New Expanded widget - simple and clean!
  // Indentation should match line 1732 (original Expanded)
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

  // Verify
  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines replaced: ${4016 - 1731} (file lines 1732-4016)');
  print('Reduced by: ${lines.length - newLines.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
