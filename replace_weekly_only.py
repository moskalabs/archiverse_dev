#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')

# Find weekly table structure
# It should be similar to midterm table: Expanded -> child: -> Container
# Looking at line 427-428 area

# Based on previous analysis:
# Line 427: Expanded(
# Line 428: flex: 6,
# Line 429: child:
# Line 430: Container( <- Start replacing from here
# Line ~1718: end of Container
# Line 1719+: keep (closing brackets)

print('Replacing Weekly Progress Table')
print(f'Line 429 (child:): {repr(lines[428][:50])}...')
print(f'Line 430 (Container): {repr(lines[429][:50])}...')

# Keep lines 0-429 (including "child:")
# Replace lines 430-1718 (Container)
# Keep lines 1719+ (closing brackets)

before = lines[:430]
after = lines[1719:]

new_widget = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

new_lines = before + new_widget + after

print(f'\nAfter: {len(new_lines)} lines')
print(f'Removed: {len(lines) - len(new_lines)} lines')

# Verify brackets
removed = lines[430:1719]
orig_open = sum(line.count('(') for line in lines)
orig_close = sum(line.count(')') for line in lines)
removed_open = sum(line.count('(') for line in removed)
removed_close = sum(line.count(')') for line in removed)
added_open = sum(line.count('(') for line in new_widget)
added_close = sum(line.count(')') for line in new_widget)

final_open = orig_open - removed_open + added_open
final_close = orig_close - removed_close + added_close

print(f'\nBracket check:')
print(f'Original:  ( {orig_open}  ) {orig_close}')
print(f'Removed:   ( {removed_open}  ) {removed_close}')
print(f'Added:     ( {added_open}  ) {added_close}')
print(f'Final:     ( {final_open}  ) {final_close}')
print(f'Balanced: {"✅ YES" if final_open == final_close else "❌ NO"}')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(new_lines)

print('\n✅ Done!')
