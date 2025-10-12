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
    this.eventId,
  });
  
  final DateTime? selectedDate;
  final String? eventId; // String으로 받아서 내부에서 파싱

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
    
    print('===== CalendarDetailSimple initState =====');
    print('selectedDate: ${widget.selectedDate}');
    print('eventId: ${widget.eventId}');
    
    // 더블클릭한 날짜가 있으면 해당 날짜로 초기화
    if (widget.selectedDate != null) {
      _startDate = widget.selectedDate!;
      _endDate = widget.selectedDate!;
      
      // 시간도 해당 날짜의 현재 시간으로 설정
      final now = DateTime.now();
      _startTime = TimeOfDay(hour: now.hour, minute: 0);
      _endTime = TimeOfDay(hour: now.hour + 1, minute: 0);
      
      print('더블클릭한 날짜로 초기화: ${widget.selectedDate}');
    }
    
    _loadInitialData();
  }
  
  // 초기 데이터 로드
  Future<void> _loadInitialData() async {
    await _loadProfessorClasses();
    
    // eventId가 있으면 기존 일정 데이터 로드
    if (widget.eventId != null && widget.eventId!.isNotEmpty) {
      await _loadExistingEvent();
    }
  }
  
  // 기존 일정 데이터 로드
  Future<void> _loadExistingEvent() async {
    try {
      final eventIdInt = int.tryParse(widget.eventId!);
      if (eventIdInt == null) {
        print('잘못된 eventId: ${widget.eventId}');
        return;
      }
      
      print('기존 일정 로드 시작: ID $eventIdInt');
      
      final eventData = await SupaFlow.client
          .from('calendar_events')
          .select()
          .eq('id', eventIdInt)
          .single();
      
      // 폼 필드에 기존 데이터 채우기
      _titleController.text = eventData['title'] as String? ?? '';
      _contentController.text = eventData['content'] as String? ?? '';
      
      // 날짜 및 시간 파싱
      final startDateStr = eventData['start_date'] as String?;
      final startTimeStr = eventData['start_time'] as String?;
      final endDateStr = eventData['end_date'] as String?;
      final endTimeStr = eventData['end_time'] as String?;
      final isAllDay = eventData['is_all_day'] as bool? ?? false;
      
      if (startDateStr != null) {
        _startDate = DateTime.parse(startDateStr);
      }
      if (endDateStr != null) {
        _endDate = DateTime.parse(endDateStr);
      }
      
      if (!isAllDay && startTimeStr != null) {
        final startTimeParts = startTimeStr.split(':');
        _startTime = TimeOfDay(
          hour: int.parse(startTimeParts[0]),
          minute: int.parse(startTimeParts[1]),
        );
      }
      
      if (!isAllDay && endTimeStr != null) {
        final endTimeParts = endTimeStr.split(':');
        _endTime = TimeOfDay(
          hour: int.parse(endTimeParts[0]),
          minute: int.parse(endTimeParts[1]),
        );
      }
      
      _isAllDay = isAllDay;
      
      // 선택된 수업 찾기 (이미 _loadProfessorClasses()가 호출되었음)
      final classId = eventData['class_id'] as int?;
      if (classId != null && _professorClasses.isNotEmpty) {
        try {
          _selectedClass = _professorClasses.firstWhere(
            (c) => c.id == classId,
          );
          print('선택된 수업: ${_selectedClass?.course}');
        } catch (e) {
          print('수업을 찾을 수 없음: $e');
        }
      }
      
      setState(() {});
      print('기존 일정 로드 완료');
    } catch (e) {
      print('기존 일정 로드 오류: $e');
    }
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
      
      // 현재 년도와 학기 가져오기
      final currentYear = DateTime.now().year.toString();
      // 현재 달을 기준으로 학기 결정 (1-6월: 1학기, 7-12월: 2학기)
      final currentMonth = DateTime.now().month;
      final currentSemester = currentMonth <= 6 ? '1학기' : '2학기';
      
      print('현재 학기 정보: $currentYear년 $currentSemester');
      
      // 교수님이 담당하는 현재 학기의 수업만 가져오기
      final classes = await ClassTable().queryRows(
        queryFn: (q) => q
            .eq('professor', professorName)
            .eq('year', currentYear)
            .eq('semester', currentSemester),
      );
      
      setState(() {
        _professorClasses = classes;
        _isLoading = false;
      });
      
      print('현재 학기 수업 목록: ${classes.length}개');
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
                      if (date != null) {
                        setState(() {
                          _startDate = date;
                          // 시작날짜가 종료날짜보다 늦으면 종료날짜도 조정
                          if (_endDate.isBefore(date)) {
                            _endDate = date;
                          }
                        });
                      }
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
                        firstDate: _startDate, // 시작날짜 이후로만 선택 가능
                        lastDate: DateTime(2030),
                      );
                      if (date != null) {
                        setState(() => _endDate = date);
                      }
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
                // 삭제 버튼 (UPDATE 모드일 때만 표시)
                if (widget.eventId != null && widget.eventId!.isNotEmpty)
                  ElevatedButton(
                    onPressed: () async {
                      // 삭제 확인 다이얼로그
                      final confirmDelete = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('일정 삭제'),
                          content: Text('이 일정을 삭제하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('삭제', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      
                      if (confirmDelete != true) return;
                      
                      try {
                        final eventIdInt = int.tryParse(widget.eventId!);
                        if (eventIdInt == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('잘못된 일정 ID입니다')),
                          );
                          return;
                        }
                        
                        // 공유 먼저 삭제
                        await SupaFlow.client
                            .from('calendar_event_shares')
                            .delete()
                            .eq('event_id', eventIdInt);
                        
                        // 일정 삭제
                        await SupaFlow.client
                            .from('calendar_events')
                            .delete()
                            .eq('id', eventIdInt);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('일정이 삭제되었습니다')),
                        );
                        
                        Navigator.of(context).pop(true); // 새로고침 플래그
                      } catch (e) {
                        print('일정 삭제 오류: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('삭제 실패: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      '삭제',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (widget.eventId != null && widget.eventId!.isNotEmpty)
                  SizedBox(width: 20.0),
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
                    
                    // 날짜 및 시간 유효성 검사
                    final startDateTime = DateTime(
                      _startDate.year,
                      _startDate.month,
                      _startDate.day,
                      _startTime.hour,
                      _startTime.minute,
                    );
                    final endDateTime = DateTime(
                      _endDate.year,
                      _endDate.month,
                      _endDate.day,
                      _endTime.hour,
                      _endTime.minute,
                    );
                    
                    if (endDateTime.isBefore(startDateTime) || endDateTime.isAtSameMomentAs(startDateTime)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('종료 일시는 시작 일시보다 늦어야 합니다')),
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
                      
                      // 1. calendar_events 테이블에 일정 저장 (INSERT or UPDATE)
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
                      
                      int eventId;
                      
                      if (widget.eventId != null && widget.eventId!.isNotEmpty) {
                        // UPDATE 모드: 기존 일정 수정
                        final eventIdInt = int.tryParse(widget.eventId!);
                        if (eventIdInt == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('잘못된 일정 ID입니다')),
                          );
                          return;
                        }
                        
                        print('UPDATE 모드: Event ID $eventIdInt');
                        
                        final response = await SupaFlow.client
                            .from('calendar_events')
                            .update(eventData)
                            .eq('id', eventIdInt)
                            .select()
                            .single();
                        
                        eventId = response['id'] as int;
                        print('일정 수정 성공: Event ID = $eventId');
                        
                        // 기존 공유 삭제 (다시 공유하기 위해)
                        await SupaFlow.client
                            .from('calendar_event_shares')
                            .delete()
                            .eq('event_id', eventId);
                      } else {
                        // INSERT 모드: 새 일정 등록
                        print('INSERT 모드: 새 일정 등록');
                        
                        final response = await SupaFlow.client
                            .from('calendar_events')
                            .insert(eventData)
                            .select()
                            .single();
                        
                        eventId = response['id'] as int;
                        print('일정 저장 성공: Event ID = $eventId');
                      }
                      
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
                        SnackBar(content: Text(widget.eventId != null ? '일정이 수정되었습니다' : '일정이 등록되었습니다')),
                      );
                      
                      // 캘린더 페이지로 돌아가며 새로고침 플래그 전달
                      Navigator.of(context).pop(true); // true를 전달하여 새로고침 필요 알림
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