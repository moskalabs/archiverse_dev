#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print(f'Original: {len(lines)} lines')

# Original analysis:
# Weekly table: Line 425-1722 is the entire first Expanded widget
# - Line 425-427: Expanded( flex: 6, child:
# - Line 428-1718: Container(...) with all the table code
# - Line 1719-1722: closing brackets for Container and Expanded

# Midterm table: Line 1733-4015 is the entire second Expanded widget
# - Line 1733-1734: if + Expanded( flex: 4, child:
# - Line 1735-4010: Container(...) with all the table code
# - Line 4011-4015: closing brackets for Container, child, and Expanded

print('\n1. Replacing Weekly Progress Table:')
print(f'   Keeping lines 1-428 (up to and including "child:")')
print(f'   Replacing lines 429-1718 (Container with table)')
print(f'   Keeping lines 1719+ (closing brackets and rest)')

before_weekly = lines[:428]  # Lines 1-428
after_weekly = lines[1718:]   # Lines 1719+

new_weekly_widget = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

lines_after_first = before_weekly + new_weekly_widget + after_weekly
print(f'   After weekly: {len(lines_after_first)} lines')

# After first replacement, line numbers shifted
# Original line 1734 is now at: 428 + 4 + (1734 - 1719) = 428 + 4 + 15 = 447
# But we need to find where "child:" is for the midterm table
# Original structure:
# Line 1733: if (responsiveVisibility(...))
# Line 1734: Expanded(
# Line 1735: flex: 4,
# Line 1736: child:
# Line 1737: Container(

# After shift:
# Original 1733 -> New position: 428 + 4 + (1733-1719) = 428 + 4 + 14 = 446
# Original 1736 (child:) -> New: 449
# Original 1737 (Container) -> New: 450
# Original 4010 (end Container) -> New: 450 + (4010-1737) = 450 + 2273 = 2723

new_child_line = 428 + len(new_weekly_widget) + (1736 - 1719)  # Should be 449
new_container_start = new_child_line + 1  # Should be 450
new_container_end = new_container_start + (4010 - 1737)  # Should be 2723

print(f'\n2. Replacing Midterm/Final Results Table:')
print(f'   Keeping lines 1-{new_child_line} (up to and including "child:")')
print(f'   Replacing lines {new_container_start+1}-{new_container_end} (Container with table)')
print(f'   Keeping lines {new_container_end+1}+ (closing brackets and rest)')

before_midterm = lines_after_first[:new_container_start]
after_midterm = lines_after_first[new_container_end:]

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
print(f'() Balanced: {"✅ YES" if final_open_paren == final_close_paren else f"❌ NO ({final_open_paren - final_close_paren})"}')
print(f'[] Balanced: {"✅ YES" if final_open_bracket == final_close_bracket else f"❌ NO ({final_open_bracket - final_close_bracket})"}')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(final_lines)

print('\n✅ Replacement complete!')
