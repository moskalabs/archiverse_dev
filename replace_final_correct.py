#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')

# Weekly table replacement:
# Keep: Lines 1-427 (includes "child:")
# Replace: Lines 428-1718 (Container(...))
# Keep: Lines 1719+ (closing brackets)

print('\n1. Replacing Weekly Progress Table:')
before_weekly = lines[:427]  # Lines 1-427
after_weekly = lines[1718:]  # Lines 1719+

new_weekly_widget = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

lines_after_weekly = before_weekly + new_weekly_widget + after_weekly
print(f'   After weekly: {len(lines_after_weekly)} lines')

# Midterm table replacement:
# After first replacement, need to recalculate line numbers
# Original midterm table structure:
# Line 1733: child:
# Line 1734: Container( ← START REPLACING
# Lines 1735-4009: Container contents
# Line 4010: ), ← END REPLACING (closes Container)
# Line 4011+: closing brackets

# Calculate new positions after weekly replacement:
# Lines 428-1718 (1291 lines) were replaced with 4 lines
# Shift = 1291 - 4 = 1287 lines removed
shift = (1718 - 428 + 1) - len(new_weekly_widget)

new_child_line = 1733 - shift  # Line with "child:"
new_container_start = 1734 - shift  # Container( line
new_container_end = 4010 - shift  # ), line that closes Container

print(f'\n2. Replacing Midterm/Final Results Table:')
print(f'   Shift from weekly replacement: {shift} lines')
print(f'   Midterm "child:" at new line: {new_child_line + 1}')
print(f'   Replacing new lines {new_container_start + 1}-{new_container_end + 1}')

before_midterm = lines_after_weekly[:new_child_line]
after_midterm = lines_after_weekly[new_container_end:]

new_midterm_widget = [
    '                                                                            MidtermFinalResultsTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getMidtermStatus: _getMidtermSubmitStatus,\n',
    '                                                                              getFinalStatus: _getFinalSubmitStatus,\n',
    '                                                                            ),\n',
]

final_lines = before_midterm + new_midterm_widget + after_midterm

print(f'   After midterm: {len(final_lines)} lines')
print(f'\nTotal: {len(lines)} → {len(final_lines)} (-{len(lines) - len(final_lines)} lines)')

# Verify brackets
orig_open_paren = sum(line.count('(') for line in lines)
orig_close_paren = sum(line.count(')') for line in lines)
orig_open_bracket = sum(line.count('[') for line in lines)
orig_close_bracket = sum(line.count(']') for line in lines)

final_open_paren = sum(line.count('(') for line in final_lines)
final_close_paren = sum(line.count(')') for line in final_lines)
final_open_bracket = sum(line.count('[') for line in final_lines)
final_close_bracket = sum(line.count(']') for line in final_lines)

print(f'\nBracket check:')
print(f'Original:  ( {orig_open_paren}  ) {orig_close_paren}  [ {orig_open_bracket}  ] {orig_close_bracket}')
print(f'Final:     ( {final_open_paren}  ) {final_close_paren}  [ {final_open_bracket}  ] {final_close_bracket}')
print(f'() Balanced: {"✅ YES" if final_open_paren == final_close_paren else f"❌ NO (off by {final_open_paren - final_close_paren})"}')
print(f'[] Balanced: {"✅ YES" if final_open_bracket == final_close_bracket else f"❌ NO (off by {final_open_bracket - final_close_bracket})"}')

if final_open_paren == final_close_paren and final_open_bracket == final_close_bracket:
    with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
        f.writelines(final_lines)
    print('\n✅ Replacement complete!')
else:
    print('\n❌ Brackets not balanced! Not writing file.')
