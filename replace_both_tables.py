#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print('=' * 80)
print('REPLACING BOTH TABLES')
print('=' * 80)

# 1. First replacement: Weekly Progress Table (Line 429-1717)
print('\n1. Weekly Progress Table:')
print(f'   Original line count: {len(lines)}')
print(f'   Replacing lines 430-1718 (Container)')

before_weekly = lines[:429]  # lines 1-429 (including "child:")
after_weekly = lines[1718:]   # lines 1719+ (closing brackets)

new_weekly = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

lines_after_weekly = before_weekly + new_weekly + after_weekly
print(f'   After weekly: {len(lines_after_weekly)} lines (-{len(lines) - len(lines_after_weekly)})')

# 2. Second replacement: Midterm/Final Results Table
# After first replacement, line numbers shifted
# Original Line 1734 is now at different position
# Need to recalculate

# In original file:
# - Weekly table was at Line 429-1717 (1289 lines)
# - Midterm table was at Line 1734-4010 (2277 lines)
# After removing weekly (1289 lines), midterm table moves up by 1289 lines
# So new position: 1734 - 1289 = 445

new_midterm_start = 1734 - 1289  # 445
new_midterm_container_start = new_midterm_start  # Line 445 in new file

# But we need to find where Container starts after "child:"
# In original: Line 1733 "child:", Line 1734 "Container("
# After shift: Line 444 "child:", Line 445 "Container("

# And Container ends at original Line 4010
# After shift: 4010 - 1289 = 2721

new_midterm_container_end = 4011 - 1289  # Line 2722 in new file

print(f'\n2. Midterm/Final Results Table:')
print(f'   File after weekly: {len(lines_after_weekly)} lines')
print(f'   Replacing lines {new_midterm_container_start+1}-{new_midterm_container_end} (Container)')

before_midterm = lines_after_weekly[:new_midterm_container_start]
after_midterm = lines_after_weekly[new_midterm_container_end:]

new_midterm = [
    '                                                                            MidtermFinalResultsTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getMidtermStatus: _getMidtermSubmitStatus,\n',
    '                                                                              getFinalStatus: _getFinalSubmitStatus,\n',
    '                                                                            ),\n',
]

final_lines = before_midterm + new_midterm + after_midterm

print(f'   After midterm: {len(final_lines)} lines (-{len(lines_after_weekly) - len(final_lines)})')
print(f'\nTotal reduction: {len(lines)} → {len(final_lines)} (-{len(lines) - len(final_lines)} lines)')

# Verify brackets
orig_open = sum(line.count('(') for line in lines)
orig_close = sum(line.count(')') for line in lines)
final_open = sum(line.count('(') for line in final_lines)
final_close = sum(line.count(')') for line in final_lines)

print(f'\nBracket check:')
print(f'Original:  ( {orig_open}  ) {orig_close}')
print(f'Final:     ( {final_open}  ) {final_close}')
print(f'Balanced: {"✅ YES" if final_open == final_close else "❌ NO"}')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(final_lines)

print('\n✅ Replacement complete!')
