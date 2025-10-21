import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');
  print('Line 1751: "${lines[1751]}"');  // Should be "child:"
  print('Line 1752: "${lines[1752]}"');  // Should be "Padding("
  print('Line 4125: "${lines[4125]}"');  // Should be "),"
  print('Line 4126: "${lines[4126]}"');  // Should be "],"

  // We want to replace the child of Container
  // - Keep lines 0-1751 (file lines 1-1752, up to and including "child:")
  // - Replace lines 1752-4125 (file lines 1753-4126, Padding and all its content)
  // - Keep lines 4126+ (file lines 4127+, starting with "],")

  final beforeChild = lines.sublist(0, 1752);  // indexes 0-1751 = file lines 1-1752
  final afterChild = lines.sublist(4126);      // index 4126+ = file lines 4127+

  // New widget - indentation should match Padding (line 1752)
  // Line 1752 has lots of spaces before "Padding"
  final newWidget = [
    '                                                                              MidtermFinalResultsTableWidget(',
    '                                                                                studentNames: _getUniqueStudentNames(),',
    '                                                                                getMidtermStatus: _getMidtermSubmitStatus,',
    '                                                                                getFinalStatus: _getFinalSubmitStatus,',
    '                                                                              ),',
  ];

  final newLines = [...beforeChild, ...newWidget, ...afterChild];

  // Verify
  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines replaced: ${4126 - 1752} (file lines 1753-4126)');
  print('Reduced by: ${lines.length - newLines.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
