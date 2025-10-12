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

  // 알람 리스트
  List<NotificationItem> _notifications = [];

  @override
  void initState() {
    super.initState();

    print('========================================');
    print('===== CalendarDetailSimple initState =====');
    print('selectedDate: ${widget.selectedDate}');
    print('eventId: ${widget.eventId}');
    print('eventId가 null인가? ${widget.eventId == null}');
    print('eventId가 비어있는가? ${widget.eventId?.isEmpty}');
    print('========================================');
    
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

      // 기존 알람 데이터 로드
      await _loadExistingNotifications(eventIdInt);

      setState(() {});
      print('기존 일정 로드 완료');
    } catch (e) {
      print('기존 일정 로드 오류: $e');
    }
  }

  // 기존 알람 데이터 로드
  Future<void> _loadExistingNotifications(int eventId) async {
    try {
      print('========================================');
      print('기존 알람 로드 시작: eventId=$eventId');

      // 해당 이벤트의 알람 가져오기 (한 명의 수신자 기준으로, 날짜별로 그룹화)
      final notifications = await NotificationsTable().queryRows(
        queryFn: (q) => q
            .eq('event_id', eventId)
            .order('notification_date', ascending: true),
      );

      print('DB에서 가져온 알람 개수: ${notifications.length}');

      if (notifications.isEmpty) {
        print('등록된 알람 없음');
        print('========================================');
        return;
      }

      // 알람을 NotificationItem으로 변환
      // 같은 날짜는 한 번만 추가 (여러 수신자에게 같은 알람이 있을 수 있음)
      final Map<String, NotificationItem> uniqueNotifications = {};

      for (final notif in notifications) {
        print('알람 데이터: date=${notif.notificationDate}, time=${notif.notificationTime}');

        final notifDate = notif.notificationDate;
        final notifTimeStr = notif.notificationTime;

        if (notifDate != null && notifTimeStr != null && notifTimeStr.isNotEmpty) {
          // TIME 문자열 파싱 (예: "15:30:00")
          final timeParts = notifTimeStr.split(':');
          if (timeParts.length < 2) {
            print('잘못된 시간 형식: $notifTimeStr');
            continue;
          }

          final hour = int.tryParse(timeParts[0]);
          final minute = int.tryParse(timeParts[1]);

          if (hour == null || minute == null) {
            print('시간 파싱 실패: $notifTimeStr');
            continue;
          }

          // 알람 날짜/시간과 일정 시작 날짜/시간의 차이 계산
          final eventStartDateTime = DateTime(
            _startDate.year,
            _startDate.month,
            _startDate.day,
            _startTime.hour,
            _startTime.minute,
          );

          final notificationDateTime = DateTime(
            notifDate.year,
            notifDate.month,
            notifDate.day,
            hour,
            minute,
          );

          print('일정 시작: $eventStartDateTime');
          print('알람 시간: $notificationDateTime');

          final difference = eventStartDateTime.difference(notificationDateTime);
          final daysBefore = difference.inDays;

          print('며칠 전: $daysBefore');

          final key = '${notifDate}_$hour:$minute';

          if (!uniqueNotifications.containsKey(key)) {
            uniqueNotifications[key] = NotificationItem(
              daysBefore: daysBefore,
              time: TimeOfDay(hour: hour, minute: minute),
            );
            print('알람 추가됨: $daysBefore일 전, $hour:$minute');
          }
        } else {
          print('알람 날짜 또는 시간이 null: date=$notifDate, time=$notifTimeStr');
        }
      }

      _notifications = uniqueNotifications.values.toList();
      print('최종 알람 개수: ${_notifications.length}');
      print('========================================');

    } catch (e) {
      print('알람 로드 오류: $e');
      print('========================================');
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
      
      // FFAppState에서 선택된 년도와 학기 가져오기
      final currentYear = FFAppState().yearSelected;
      final currentSemester = FFAppState().semesterSelected;

      print('선택된 학기 정보: $currentYear년 $currentSemester');
      
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
            // 알림 목록 표시
            if (_notifications.isNotEmpty)
              Container(
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: _notifications.asMap().entries.map((entry) {
                    final index = entry.key;
                    final notification = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Icon(Icons.notifications, color: Color(0xFF284E75), size: 20),
                          SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              '${notification.daysBeforeText} - ${notification.timeText}',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close, size: 20, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _notifications.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            if (_notifications.isNotEmpty)
              SizedBox(height: 10.0),
            InkWell(
              onTap: () => _showAddNotificationDialog(),
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

                      // 3. 알람 생성 (교수 + 학생들)
                      if (_notifications.isNotEmpty) {
                        print('알람 생성 시작: ${_notifications.length}개');

                        // 알람을 받을 사람 목록 (교수 + 학생들)
                        final recipients = <Map<String, dynamic>>[];

                        // 교수 추가
                        recipients.add({
                          'email': professorEmail,
                          'name': professorName,
                          'user_type': 1, // professor
                        });

                        // 학생들 추가
                        for (final student in students) {
                          recipients.add({
                            'email': student['stu_email'] ?? '',
                            'name': student['name'] ?? '',
                            'user_type': 2, // student
                          });
                        }

                        // 각 알람 설정에 대해
                        for (final notification in _notifications) {
                          // 알람 날짜 계산
                          final notificationDateTime = DateTime(
                            _startDate.year,
                            _startDate.month,
                            _startDate.day,
                            notification.time.hour,
                            notification.time.minute,
                          ).subtract(Duration(days: notification.daysBefore));

                          final notificationDate = '${notificationDateTime.year}-${notificationDateTime.month.toString().padLeft(2, '0')}-${notificationDateTime.day.toString().padLeft(2, '0')}';
                          final notificationTime = '${notification.time.hour.toString().padLeft(2, '0')}:${notification.time.minute.toString().padLeft(2, '0')}:00';

                          // 각 수신자에게 알람 생성
                          for (final recipient in recipients) {
                            await SupaFlow.client.from('notifications').insert({
                              'event_id': eventId,
                              'recipient_email': recipient['email'],
                              'recipient_name': recipient['name'],
                              'user_type': recipient['user_type'],
                              'notification_title': _titleController.text.trim(),
                              'notification_content': _contentController.text.trim(),
                              'notification_date': notificationDate,
                              'notification_time': notificationTime,
                              'is_read': false,
                              'event_title': _titleController.text.trim(),
                              'course_name': _selectedClass!.course,
                            });
                          }
                        }

                        print('알람 생성 완료');
                      }

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

  // 알림 추가 다이얼로그
  void _showAddNotificationDialog() {
    int selectedDaysBefore = 0; // 당일
    TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text('알림 추가'),
              content: Container(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('알림 시점', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    DropdownButtonFormField<int>(
                      value: selectedDaysBefore,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: [
                        DropdownMenuItem(value: 0, child: Text('당일')),
                        DropdownMenuItem(value: 1, child: Text('1일 전')),
                        DropdownMenuItem(value: 2, child: Text('2일 전')),
                        DropdownMenuItem(value: 3, child: Text('3일 전')),
                        DropdownMenuItem(value: 7, child: Text('7일 전')),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          selectedDaysBefore = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text('알림 시간', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (time != null) {
                          setDialogState(() {
                            selectedTime = time;
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
                            Icon(Icons.access_time, size: 20.0),
                            SizedBox(width: 10.0),
                            Text('${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('취소'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _notifications.add(NotificationItem(
                        daysBefore: selectedDaysBefore,
                        time: selectedTime,
                      ));
                    });
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF284E75),
                  ),
                  child: Text('추가', style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

// 알림 아이템 클래스
class NotificationItem {
  final int daysBefore; // 0: 당일, 1: 1일 전, 2: 2일 전, ...
  final TimeOfDay time;

  NotificationItem({
    required this.daysBefore,
    required this.time,
  });

  String get daysBeforeText {
    if (daysBefore == 0) return '당일';
    return '$daysBefore일 전';
  }

  String get timeText {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}