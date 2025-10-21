import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');
  print('Line 1733 (child:): "${lines[1732].trim()}"');
  print('Line 1734 (Container start): "${lines[1733].trim()}"');
  print('Line 4015 (Container end): "${lines[4014].trim()}"');
  print('Line 4016 (next Expanded): "${lines[4015].trim()}"');

  // Keep lines 0-1733 (file lines 1-1734, including "child:")
  // Replace lines 1734-4015 (file lines 1735-4016, the entire Container)
  // Keep lines 4016+ (file lines 4017+, next Expanded onwards)

  final beforeContainer = lines.sublist(0, 1734);  // lines 1-1734
  final afterContainer = lines.sublist(4016);      // lines 4017+

  // New widget - single line replacing the Container
  // Indentation must match line 1734 (Container level - 44 spaces)
  final newWidget = [
    '                                            MidtermFinalResultsTableWidget(',
    '                                              studentNames: _getUniqueStudentNames(),',
    '                                              getMidtermStatus: _getMidtermSubmitStatus,',
    '                                              getFinalStatus: _getFinalSubmitStatus,',
    '                                            ),',
  ];

  final newLines = [...beforeContainer, ...newWidget, ...afterContainer];

  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines removed: ${lines.length - newLines.length}');
  print('Expected: ${4016 - 1734} lines of Container → ${newWidget.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
