#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')
print(f'Line 1733: {repr(lines[1732][:60])}...')
print(f'Line 1734: {repr(lines[1733][:60])}...')
print(f'Line 4127: {repr(lines[4126][:60])}...')
print(f'Line 4128: {repr(lines[4127][:60])}...')

# Keep lines 0-1733 (file lines 1-1734, including "child:")
# Replace lines 1734-4127 (file lines 1735-4128, Container only)
# Keep lines 4128+ (file lines 4129+, Expanded closing and onwards)

before = lines[:1734]  # lines 1-1734 (including "child:")
after = lines[4127:]   # lines 4128+ (including Expanded closing)

# New widget - match indentation of line 1734 (Container position - 76 spaces)
new_widget = [
    '                                                                            MidtermFinalResultsTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getMidtermStatus: _getMidtermSubmitStatus,\n',
    '                                                                              getFinalStatus: _getFinalSubmitStatus,\n',
    '                                                                            ),\n',
]

new_lines = before + new_widget + after

print(f'\nAfter: {len(new_lines)} lines')
print(f'Removed: {len(lines) - len(new_lines)} lines')
print(f'Expected to remove: {4127 - 1734 + 1} lines')
print(f'Added: {len(new_widget)} lines')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(new_lines)

print('✅ Done!')
