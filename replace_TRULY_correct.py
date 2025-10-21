#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')

# Structure discovered:
# Lines 425-427: Expanded(flex: 6, child:
# Lines 428-1664: Container(...) for weekly table ← REPLACE THIS
# Lines 1665-1722: Title section for midterm table (keep this)
# Lines 1723-1733: if + Expanded(flex: 4, child:
# Lines 1734-4010: Container(...) for midterm table ← REPLACE THIS
# Lines 4011+: Closing brackets

print('\n1. Replacing Weekly Progress Table (Container):')
print('   Replacing lines 428-1664')

before_weekly = lines[:427]  # Lines 1-427 (includes "child:")
after_weekly = lines[1664:]  # Lines 1665+ (title section and onwards)

new_weekly_widget = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

lines_after_weekly = before_weekly + new_weekly_widget + after_weekly
print(f'   After weekly: {len(lines_after_weekly)} lines')

# After first replacement, recalculate line numbers
# Removed: lines 428-1664 (1237 lines)
# Added: 4 lines
# Shift = 1237 - 4 = 1233 lines removed

shift = (1664 - 428 + 1) - len(new_weekly_widget)

new_child_line = 1733 - shift  # Line with "child:" for midterm table
new_container_start = 1734 - shift  # Container( for midterm
new_container_end = 4010 - shift  # ), that closes midterm Container

print(f'\n2. Replacing Midterm/Final Results Table (Container):')
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
