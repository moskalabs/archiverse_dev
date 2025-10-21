#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')
print(f'Line 428 (child:): {repr(lines[427][:50])}...')
print(f'Line 429 (Container): {repr(lines[428][:50])}...')
print(f'Line 1717: {repr(lines[1716][:50])}...')
print(f'Line 1718: {repr(lines[1717][:50])}...')

# Keep lines 0-428 (file lines 1-429, including "child:")
# Replace lines 429-1717 (file lines 430-1718, entire Container)
# Keep lines 1718+ (file lines 1719+, closing brackets and onwards)

before = lines[:429]  # lines 1-429
after = lines[1718:]   # lines 1719+

# New widget - 76 spaces to match Container position
new_widget = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

new_lines = before + new_widget + after

print(f'\nAfter: {len(new_lines)} lines')
print(f'Removed lines: {1718 - 429} (file lines 430-1718)')
print(f'File size change: {len(lines)} → {len(new_lines)} (-{len(lines) - len(new_lines)})')

# Verify brackets
removed = lines[429:1718]
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
