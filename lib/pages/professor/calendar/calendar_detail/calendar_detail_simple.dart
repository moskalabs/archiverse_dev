import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import 'package:provider/provider.dart';

/// 간단한 일정 등록 폼
class CalendarDetailSimple extends StatefulWidget {
  const CalendarDetailSimple({
    super.key,
    this.selectedDate,
  });
  
  final DateTime? selectedDate;

  @override
  State<CalendarDetailSimple> createState() => _CalendarDetailSimpleState();
}

class _CalendarDetailSimpleState extends State<CalendarDetailSimple> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now();
  bool _isAllDay = false;
  
  // 선택된 수업 정보
  ClassRow? _selectedClass;
  List<ClassRow> _professorClasses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    
    // 더블클릭한 날짜가 있으면 해당 날짜로 초기화
    if (widget.selectedDate != null) {
      _startDate = widget.selectedDate!;
      _endDate = widget.selectedDate!;
    }
    
    _loadProfessorClasses();
  }

  Future<void> _loadProfessorClasses() async {
    try {
      // 현재 로그인한 교수님 이름 가져오기
      final professorName = FFAppState().professorNameSelected;
      
      if (professorName == null || professorName.isEmpty || professorName == '교수님') {
        print('교수님 정보 없음');
        setState(() => _isLoading = false);
        return;
      }
      
      // 교수님이 담당하는 모든 수업 가져오기 (professor 필드로 검색)
      final classes = await ClassTable().queryRows(
        queryFn: (q) => q.eq('professor', professorName),
      );
      
      setState(() {
        _professorClasses = classes;
        _isLoading = false;
      });
      
      print('교수님 수업 목록: ${classes.length}개');
    } catch (e) {
      print('수업 목록 로드 오류: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 0. 공유 대상 (수업 선택)
            _buildLabel('공유 대상'),
            SizedBox(height: 10.0),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<ClassRow>(
                        isExpanded: true,
                        hint: Text('수업을 선택하세요'),
                        value: _selectedClass,
                        items: _professorClasses.map((classItem) {
                          return DropdownMenuItem<ClassRow>(
                            value: classItem,
                            child: Text(
                              '${classItem.year} ${classItem.semester} - ${classItem.course} (${classItem.grade}학년 ${classItem.section ?? ''})',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          );
                        }).toList(),
                        onChanged: (ClassRow? newValue) {
                          setState(() {
                            _selectedClass = newValue;
                          });
                          print('선택된 수업: ${newValue?.course}');
                        },
                      ),
                    ),
                  ),
            SizedBox(height: 20.0),
            
            // 1. 제목
            _buildLabel('제목'),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: '일정 제목을 입력하세요',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              ),
            ),
            SizedBox(height: 20.0),
            
            // 2. 날짜 및 시간
            _buildLabel('날짜 및 시간'),
            SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _startDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) setState(() => _startDate = date);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20.0),
                          SizedBox(width: 10.0),
                          Text('${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _startTime,
                    );
                    if (time != null) setState(() => _startTime = time);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text('${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text('~', style: TextStyle(fontSize: 18.0)),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _endDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (date != null) setState(() => _endDate = date);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 20.0),
                          SizedBox(width: 10.0),
                          Text('${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')}'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                InkWell(
                  onTap: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: _endTime,
                    );
                    if (time != null) setState(() => _endTime = time);
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text('${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}'),
                  ),
                ),
                SizedBox(width: 10.0),
                Row(
                  children: [
                    Checkbox(
                      value: _isAllDay,
                      onChanged: (val) => setState(() => _isAllDay = val ?? false),
                    ),
                    Text('종일'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20.0),
            
            // 3. 내용
            _buildLabel('내용'),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '내용을 입력하세요',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              ),
            ),
            SizedBox(height: 20.0),
            
            // 6. 알림
            _buildLabel('알림'),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                // TODO: 알림 추가 기능
              },
              child: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: Color(0xFF284E75)),
                  SizedBox(width: 10.0),
                  Text(
                    '알림 추가',
                    style: TextStyle(
                      color: Color(0xFF284E75),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
            
            // 7. 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // 유효성 검사
                    if (_titleController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('제목을 입력해주세요')),
                      );
                      return;
                    }
                    
                    if (_selectedClass == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('공유할 수업을 선택해주세요')),
                      );
                      return;
                    }
                    
                    try {
                      // 0. posts 테이블에서 교수 이메일 가져오기
                      final professorName = FFAppState().professorNameSelected;
                      final professorData = await PostsTable().queryRows(
                        queryFn: (q) => q.eq('name', professorName).eq('user_type', 1), // user_type 1 = professor
      );
                      
                      if (professorData.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('교수 정보를 찾을 수 없습니다')),
                        );
                        return;
                      }
                      
                      final professorEmail = professorData.first.email ?? '';
                      
                      // 1. calendar_events 테이블에 일정 저장
                      final startTimeStr = _isAllDay ? null : '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}:00';
                      final endTimeStr = _isAllDay ? null : '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}:00';
                      
                      final eventData = {
                        'title': _titleController.text.trim(),
                        'content': _contentController.text.trim(),
                        'start_date': '${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}',
                        'start_time': startTimeStr,
                        'end_date': '${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')}',
                        'end_time': endTimeStr,
                        'is_all_day': _isAllDay,
                        'created_by_email': professorEmail,
                        'created_by_name': professorName,
                        'class_id': _selectedClass!.id,
                        'year': _selectedClass!.year,
                        'semester': _selectedClass!.semester,
                        'grade': _selectedClass!.grade,
                        'course_name': _selectedClass!.course,
                        'section': _selectedClass!.section,
                        'professor_name': _selectedClass!.professor,
                      };
                      
                      final response = await SupaFlow.client
                          .from('calendar_events')
                          .insert(eventData)
                          .select()
                          .single();
                      
                      final eventId = response['id'] as int;
                      
                      print('일정 저장 성공: Event ID = $eventId');
                      
                      // 2. 해당 수업의 학생들에게 자동 공유
                      // student_myprofile에서 courseMajor와 section이 일치하는 학생들 찾기
                      final studentsData = await SupaFlow.client
                          .from('student_myprofile')
                          .select('stu_email, name')
                          .eq('courseMajor', _selectedClass!.course ?? '')
                          .eq('section', _selectedClass!.section ?? '')
                          .eq('years', _selectedClass!.year ?? '')
                          .eq('semester', _selectedClass!.semester ?? '');
                      
                      final students = studentsData as List;
                      print('공유 대상 학생: ${students.length}명');
                      
                      // 각 학생에게 공유
                      for (final student in students) {
                        await SupaFlow.client
                            .from('calendar_event_shares')
                            .insert({
                          'event_id': eventId,
                          'shared_with_email': student['stu_email'] ?? '',
                          'shared_with_name': student['name'] ?? '',
                          'user_type': 2, // student
                          'class_id': _selectedClass!.id,
                        });
                      }
                      
                      print('학생들에게 공유 완료');
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('일정이 등록되었습니다')),
                      );
                      
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('일정 저장 오류: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('일정 등록 실패: $e')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF284E75),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    '취소',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF284E75),
      ),
    );
  }
}