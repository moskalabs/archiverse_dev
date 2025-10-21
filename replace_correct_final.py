#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')

# Keep lines 0-1733 (file lines 1-1734, including "child:")
# Replace lines 1734-4010 (file lines 1735-4011, Container and all its content)
# Keep lines 4011+ (file lines 4012+, Expanded closing and onwards)

before = lines[:1734]  # lines 1-1734
after = lines[4011:]   # lines 4012+

# New widget - 76 spaces to match Container position
new_widget = [
    '                                                                            MidtermFinalResultsTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getMidtermStatus: _getMidtermSubmitStatus,\n',
    '                                                                              getFinalStatus: _getFinalSubmitStatus,\n',
    '                                                                            ),\n',
]

new_lines = before + new_widget + after

print(f'After: {len(new_lines)} lines')
print(f'Removed lines: {4011 - 1734} (file lines 1735-4011)')
print(f'File size change: {len(lines)} → {len(new_lines)} (-{len(lines) - len(new_lines)})')

# Verify brackets
removed = lines[1734:4011]
orig_open_paren = sum(line.count('(') for line in lines)
orig_close_paren = sum(line.count(')') for line in lines)
removed_open_paren = sum(line.count('(') for line in removed)
removed_close_paren = sum(line.count(')') for line in removed)
added_open_paren = sum(line.count('(') for line in new_widget)
added_close_paren = sum(line.count(')') for line in new_widget)

final_open = orig_open_paren - removed_open_paren + added_open_paren
final_close = orig_close_paren - removed_close_paren + added_close_paren

print(f'\nBracket check:')
print(f'Original:  ( {orig_open_paren}  ) {orig_close_paren}')
print(f'Removed:   ( {removed_open_paren}  ) {removed_close_paren}')
print(f'Added:     ( {added_open_paren}  ) {added_close_paren}')
print(f'Final:     ( {final_open}  ) {final_close}')
print(f'Balanced: {"✅ YES" if final_open == final_close else "❌ NO - need to fix!"}')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(new_lines)

print('\n✅ Replacement done!')
