import 'dart:io';

void main() {
  final file = File('/Users/moseonghwan/code/archiverse/lib/pages/professor/home/home_widget.dart');
  final lines = file.readAsLinesSync();

  print('Original file: ${lines.length} lines');

  // Find the Column's children array
  // Line 1759: children: [
  // Line 4119: ],  (closes the children array)

  print('Line 1759: "${lines[1759]}"');  // Should be "children: ["
  print('Line 1760: "${lines[1760]}"');  // First child (start of table)
  print('Line 4118: "${lines[4118]}"');  // Last line before ],
  print('Line 4119: "${lines[4119]}"');  // Should be "],"

  // Replace lines 1760-4015 (the content of children array, but keep the 5th Expanded widget)
  // - Keep lines 0-1759 (up to and including "children: [")
  // - Replace lines 1760-4015 (manual table content)
  // - Keep lines 4016+ (5th Expanded widget onwards, which closes at 4125, then ], at 4126)

  final beforeChildren = lines.sublist(0, 1760);  // indexes 0-1759 = file lines 1-1760
  final afterChildren = lines.sublist(4016);      // index 4016+ = file lines 4017+ (includes 5th Expanded)

  // New content for children array - just our widget wrapped in Expanded
  // Indentation should match the old content (line 1760)
  // No need to add ], because line 4016+ already includes closing brackets
  final newChildren = [
    '                                                                                Expanded(',
    '                                                                                  child: MidtermFinalResultsTableWidget(',
    '                                                                                    studentNames: _getUniqueStudentNames(),',
    '                                                                                    getMidtermStatus: _getMidtermSubmitStatus,',
    '                                                                                    getFinalStatus: _getFinalSubmitStatus,',
    '                                                                                  ),',
    '                                                                                ),',
  ];

  final newLines = [...beforeChildren, ...newChildren, ...afterChildren];

  // Verify
  print('\nAfter replacement:');
  print('New file: ${newLines.length} lines');
  print('Lines replaced: ${4016 - 1760} (file lines 1761-4016)');
  print('Reduced by: ${lines.length - newLines.length} lines');

  // Write
  file.writeAsStringSync(newLines.join('\n') + '\n');
  print('\n✅ Replacement complete!');
}
