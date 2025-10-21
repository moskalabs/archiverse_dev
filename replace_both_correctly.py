#!/usr/bin/env python3

with open('lib/pages/professor/home/home_widget.dart', 'r') as f:
    lines = f.readlines()

print('Original file:', len(lines), 'lines')

# 1. Replace Weekly Progress Table first (Line 428-1717)
print('\n1. Weekly Progress Table (Line 429-1718):')

before_weekly = lines[:428]  # Lines 1-428 (including "child:")
after_weekly = lines[1718:]  # Lines 1719+ (closing brackets)

new_weekly = [
    '                                                                            WeeklyProgressTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getWeekStatus: _getWeekSubmitStatus,\n',
    '                                                                            ),\n',
]

lines_after_weekly = before_weekly + new_weekly + after_weekly
print(f'   After weekly: {len(lines_after_weekly)} lines')

# 2. Replace Midterm/Final Results Table
shift = (1718 - 428) - len(new_weekly)
new_midterm_start = 1734 - shift
new_midterm_end = 4011 - shift

print(f'\n2. Midterm/Final Results Table:')
print(f'   New position: Lines {new_midterm_start}-{new_midterm_end}')

before_midterm = lines_after_weekly[:new_midterm_start]
after_midterm = lines_after_weekly[new_midterm_end:]

new_midterm = [
    '                                                                            MidtermFinalResultsTableWidget(\n',
    '                                                                              studentNames: _getUniqueStudentNames(),\n',
    '                                                                              getMidtermStatus: _getMidtermSubmitStatus,\n',
    '                                                                              getFinalStatus: _getFinalSubmitStatus,\n',
    '                                                                            ),\n',
]

final_lines = before_midterm + new_midterm + after_midterm

print(f'   After midterm: {len(final_lines)} lines')
print(f'\nTotal: {len(lines)} -> {len(final_lines)} lines (- {len(lines) - len(final_lines)})')

# Verify brackets
orig_open = sum(line.count('(') for line in lines)
orig_close = sum(line.count(')') for line in lines)
final_open = sum(line.count('(') for line in final_lines)
final_close = sum(line.count(')') for line in final_lines)

print(f'\nBracket check:')
print(f'Original:  ( {orig_open}  ) {orig_close}')
print(f'Final:     ( {final_open}  ) {final_close}')
if final_open == final_close:
    print('Balanced: YES')
else:
    print(f'Balanced: NO - diff: {final_open - final_close}')

with open('lib/pages/professor/home/home_widget.dart', 'w') as f:
    f.writelines(final_lines)

print('\nDone!')
