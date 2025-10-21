import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');
  print('Line 1733 (child:): "${lines[1732].trim()}"');
  print('Line 1734 (Container): "${lines[1733].trim()}"');
  print('Line 4127 (last line of Container content): "${lines[4126].trim()}"');
  print('Line 4128 (Expanded closing): "${lines[4127].trim()}"');
  print('Line 4129 (next Flexible): "${lines[4128].trim()}"');

  // Keep lines 0-1733 (file lines 1-1734, including "child:")
  // Replace lines 1734-4127 (file lines 1735-4128, the entire Container and its contents)
  // Keep lines 4128+ (file lines 4129+, Expanded closing and onwards)

  final before = lines.sublist(0, 1734);  // lines 1-1734
  final after = lines.sublist(4128);      // lines 4129+

  // New widget - match indentation of line 1734 (Container level - many spaces)
  final newWidget = [
    '                                                                            MidtermFinalResultsTableWidget(',
    '                                                                              studentNames: _getUniqueStudentNames(),',
    '                                                                              getMidtermStatus: _getMidtermSubmitStatus,',
    '                                                                              getFinalStatus: _getFinalSubmitStatus,',
    '                                                                            ),',
  ];

  final newLines = [...before, ...newWidget, ...after];

  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines removed: ${lines.length - newLines.length}');
  print('Expected: ${4128 - 1734} lines of Container → ${newWidget.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
