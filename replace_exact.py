#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')
print(f'Line 1733 (child:): {repr(lines[1732][:50])}...')
print(f'Line 1734 (Container): {repr(lines[1733][:50])}...')
print(f'Line 4015 (Container closing): {repr(lines[4014][:50])}...')
print(f'Line 4016 (next widget): {repr(lines[4015][:50])}...')

# Keep lines 0-1733 (file lines 1-1734, including "child:")
# Replace lines 1734-4015 (file lines 1735-4016, entire Container)
# Keep lines 4016+ (file lines 4017+, next Expanded onwards)

before = lines[:1734]  # lines 1-1734
after = lines[4016:]   # lines 4017+

# New widget - match indentation of Container (76 spaces = 19 tabs worth)
# Line 1734 Container has 76 spaces before it
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
print(f'Expected to remove: {4016 - 1734} lines')

# Verify brackets
orig_open = sum(line.count('(') for line in lines)
orig_close = sum(line.count(')') for line in lines)
new_open = sum(line.count('(') for line in new_widget)
new_close = sum(line.count(')') for line in new_widget)
removed_open = sum(line.count('(') for line in lines[1734:4016])
removed_close = sum(line.count(')') for line in lines[1734:4016])

print(f'\nBracket analysis:')
print(f'Original: ( {orig_open}, ) {orig_close}')
print(f'Removed:  ( {removed_open}, ) {removed_close}')
print(f'Added:    ( {new_open}, ) {new_close}')
print(f'Result:   ( {orig_open - removed_open + new_open}, ) {orig_close - removed_close + new_close}')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(new_lines)

print('\n✅ Done!')
