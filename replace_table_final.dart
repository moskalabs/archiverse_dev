import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  // We want to replace the ENTIRE Expanded widget including closing brackets
  // Keep: Lines before the Expanded (0-1731, up to the closing )) of the if statement)
  // Replace: Lines 1732-4128 (entire Expanded widget from opening to closing)
  // Keep: Lines 4129+ (Flexible widget and beyond)

  // Keep everything before the Expanded widget (lines 0-1731, up to the closing ))
  final beforeContent = lines.sublist(0, 1731);

  // Keep everything after the Expanded widget (from line 4129 onwards, index 4128)
  final afterContent = lines.sublist(4128);

  // New Expanded widget (72 spaces indentation to match original)
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

  final newLines = [...beforeContent, ...newExpandedWidget, ...afterContent];

  file.writeAsStringSync(newLines.join('\n') + '\n');

  print('✅ Successfully replaced table with component');
  print('   Lines replaced: ${4128 - 1732 + 1} (from line 1732 to 4128)');
  print('   Before: ${lines.length} lines');
  print('   After: ${newLines.length} lines');
  print('   Reduced by: ${lines.length - newLines.length} lines');
}
