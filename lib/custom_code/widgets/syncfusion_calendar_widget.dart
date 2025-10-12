// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/index.dart'; // Imports other custom actions
// Begin custom action code
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class SyncfusionCalendarWidget extends StatefulWidget {
  const SyncfusionCalendarWidget({
    super.key,
    required this.width,
    required this.height,
    this.compact = false, // compact 모드 여부
  });

  final double width;
  final double height;
  final bool compact;

  @override
  State<SyncfusionCalendarWidget> createState() =>
      _SyncfusionCalendarWidgetState();
}

class _SyncfusionCalendarWidgetState extends State<SyncfusionCalendarWidget> {
  // final 제거하여 새 컨트롤러로 교체 가능하도록 함
  CalendarController _calendarController = CalendarController();
  CalendarView _currentView = CalendarView.month;
  DateTime _selectedDate = DateTime.now();

  // 더블 탭 감지 관련
  DateTime? _lastTapTime;
  DateTime? _lastTappedDate;
  String? _lastTappedEventName;
  
  // 실시간 일정 데이터
  List<Meeting> _calendarEvents = [];
  bool _isLoadingEvents = true;

    @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _calendarController.displayDate = today; // 현재 날짜로 디스플레이 설정
    _calendarController.selectedDate = today; // 현재 날짜 선택
    _calendarController.view = _currentView; // 초기 뷰 설정
    
    // 실제 일정 데이터 로드
    _loadCalendarEvents();
  }
  
  // 실제 DB에서 일정 가져오기
  Future<void> _loadCalendarEvents() async {
    try {
      setState(() {
        _isLoadingEvents = true;
      });
      
      // 현재 로그인한 교수님 이름 가져오기
      final professorName = FFAppState().professorNameSelected;
      
      if (professorName == null || professorName.isEmpty || professorName == '교수님') {
        print('교수님 정보 없음 - 기본 일정 사용');
        setState(() {
          _calendarEvents = _getDefaultDataSource();
          _isLoadingEvents = false;
        });
        return;
      }
      
      // calendar_events 테이블에서 해당 교수님이 생성한 일정 가져오기
      final eventsData = await SupaFlow.client
          .from('calendar_events')
          .select()
          .eq('created_by_name', professorName);
      
      final events = eventsData as List;
      print('DB에서 가져온 일정: ${events.length}개');
      
      // Meeting 객체로 변환
      final List<Meeting> meetings = events.map((event) {
        final startDateStr = event['start_date'] as String?;
        final startTimeStr = event['start_time'] as String?;
        final endDateStr = event['end_date'] as String?;
        final endTimeStr = event['end_time'] as String?;
        final isAllDay = event['is_all_day'] as bool? ?? false;
        
        // 날짜 파싱
        DateTime startDateTime;
        DateTime endDateTime;
        
        if (isAllDay) {
          startDateTime = DateTime.parse(startDateStr!);
          endDateTime = DateTime.parse(endDateStr!);
        } else {
          startDateTime = DateTime.parse('$startDateStr $startTimeStr');
          endDateTime = DateTime.parse('$endDateStr $endTimeStr');
        }
        
                        // 과목명으로 색상 할당
        final courseName = event['course_name'] as String? ?? '과목명';
        final eventId = event['id'] as int?;
        
        final meeting = Meeting(
          eventName: event['title'] as String? ?? '일정',
          from: startDateTime,
          to: endDateTime,
          background: _getColorByCourse(courseName),
          isAllDay: isAllDay,
          eventId: eventId, // 일정 ID 포함
        );

        print('Meeting 생성: ${meeting.eventName}, eventId: ${meeting.eventId}');
        return meeting;
      }).toList();
      
      setState(() {
        _calendarEvents = meetings;
        _isLoadingEvents = false;
      });
      
      print('캘린더 일정 로드 성공: ${meetings.length}개');
    } catch (e) {
      print('캘린더 일정 로드 오류: $e');
      setState(() {
        _calendarEvents = _getDefaultDataSource();
        _isLoadingEvents = false;
      });
    }
  }
  
    // 과목별 고유 색상 매핑
  final Map<String, Color> _courseColorMap = {};
  
  // 과목별 색상 가져오기 (없으면 새로 할당)
  Color _getColorByCourse(String courseName) {
    // 이미 할당된 색상이 있으면 반환
    if (_courseColorMap.containsKey(courseName)) {
      return _courseColorMap[courseName]!;
    }
    
    // 새로운 과목이면 색상 할당
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
      Colors.cyan,
      Colors.amber,
    ];
    
    // 현재 사용된 색상 수를 기준으로 다음 색상 선택
    final assignedColor = colors[_courseColorMap.length % colors.length];
    _courseColorMap[courseName] = assignedColor;
    
    return assignedColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          // 1) compact=false 일 때만 주간/월간 버튼 보여주기
          if (!widget.compact)
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('주간 버튼 누름 전 - 컨트롤러 뷰: ${_calendarController.view}');

                      // 새 컨트롤러 생성 및 설정
                      final newController = CalendarController();

                      // 현재 날짜로 설정
                      final today = DateTime.now();

                      // 컨트롤러에 현재 날짜와 뷰 설정
                      newController.displayDate = today;
                      newController.selectedDate = today;
                      newController.view = CalendarView.week;

                      setState(() {
                        // 컨트롤러 교체
                        _calendarController = newController;
                        _currentView = CalendarView.week;
                        _selectedDate = today;
                      });

                      print('주간 버튼 누름 후 - 컨트롤러 뷰: ${_calendarController.view}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentView == CalendarView.week
                          ? const Color(0xFF284E75)
                          : const Color(0xFF284E75).withOpacity(0.5),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('주간'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      print('월간 버튼 누름 전 - 컨트롤러 뷰: ${_calendarController.view}');

                      // 새 컨트롤러 생성 및 설정
                      final newController = CalendarController();

                      // 현재 날짜로 설정
                      final today = DateTime.now();

                      // 컨트롤러에 현재 날짜와 뷰 설정
                      newController.displayDate = today;
                      newController.selectedDate = today;
                      newController.view = CalendarView.month;

                      setState(() {
                        // 컨트롤러 교체
                        _calendarController = newController;
                        _currentView = CalendarView.month;
                        _selectedDate = today;
                      });

                      print('월간 버튼 누름 후 - 컨트롤러 뷰: ${_calendarController.view}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _currentView == CalendarView.month
                          ? const Color(0xFF284E75)
                          : const Color(0xFF284E75).withOpacity(0.5),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('월간'),
                  ),
                ],
              ),
            ),

          // 2) 달력 본체
          Expanded(
            child: Theme(
              // 테마 사용하여 전체적인 캘린더 스타일 적용
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: const Color(0xFF284E75), // 선택 및 강조색
                  onSurface: const Color(0xFF284E75), // 표면 위 텍스트 및 아이콘 색상
                ),
              ),
              child: SfCalendar(
                controller: _calendarController,
                dataSource: MeetingDataSource(_calendarEvents),
                headerStyle: const CalendarHeaderStyle(
                  backgroundColor: Colors.white,
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                showNavigationArrow: true,
                showTodayButton: !widget.compact, // compact 모드일 때는 Today 버튼 숨김
                selectionDecoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFF284E75), // 선택된 날짜 테두리 색상
                    width: 2.0,
                  ),
                ),
                monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                  dayFormat: 'EEE',
                  showAgenda: false,
                  agendaViewHeight: 0,
                  numberOfWeeksInView: 6,
                  monthCellStyle: MonthCellStyle(
                    // 버전 28.2.7에서는 mouseOverBackground 속성이 지원되지 않음
                    // 대신 기본 스타일만 설정
                    backgroundColor: Colors.white,
                    todayBackgroundColor: Color(0xFFDCF0FF), // 오늘 날짜 배경색
                    textStyle: TextStyle(color: Colors.black),
                    todayTextStyle: TextStyle(
                      color: Color(0xFF284E75),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                timeSlotViewSettings: const TimeSlotViewSettings(
                  timeInterval: Duration(hours: 1),
                  timeFormat: 'HH:mm',
                ),
                firstDayOfWeek: 1,
                todayHighlightColor: const Color(0xFF284E75),
                backgroundColor: Colors.white,
                cellBorderColor: Colors.grey.withOpacity(0.2),
                onViewChanged: (ViewChangedDetails details) {
                  // 뷰 변경 시 로깅 (디버깅용)
                  print('View changed to: ${_calendarController.view}');
                  print('Display date: ${_calendarController.displayDate}');
                },
                                onTap: (details) {
                  final now = DateTime.now();
                  
                  if (details.targetElement == CalendarElement.calendarCell) {
                    final tappedDate = details.date!;
                    final formattedDate = DateFormat('yyyy-MM-dd').format(tappedDate);
                    
                    setState(() {
                      _selectedDate = tappedDate;
                    });

                    // 더블클릭 감지
                    final isDoubleTap = _lastTapTime != null &&
                        now.difference(_lastTapTime!).inMilliseconds < 500 &&
                        _lastTappedDate != null &&
                        DateFormat('yyyy-MM-dd').format(_lastTappedDate!) == formattedDate;

                    if (isDoubleTap) {
                      // 더블클릭 시 calendar_detail로 이동
                      _navigateToCalendarDetail(context, tappedDate);
                      _lastTapTime = null;
                      _lastTappedDate = null;
                    } else {
                      // 첫 번째 클릭
                      _lastTapTime = now;
                      _lastTappedDate = tappedDate;
                    }
                  } else if (details.targetElement == CalendarElement.appointment) {
                    final appointment = details.appointments![0] as Meeting;
                    final formattedDate = DateFormat('yyyy-MM-dd').format(appointment.from);

                    // 이벤트 더블클릭 감지
                    final isDoubleTap = _lastTapTime != null &&
                        now.difference(_lastTapTime!).inMilliseconds < 500 &&
                        _lastTappedEventName == appointment.eventName &&
                        _lastTappedDate != null &&
                        DateFormat('yyyy-MM-dd').format(_lastTappedDate!) == formattedDate;

                                        if (isDoubleTap) {
                      // 더블클릭 시 이벤트 정보와 함께 이동
                      print('일정 더블클릭: ${appointment.eventName}, eventId: ${appointment.eventId}');
                      _navigateToCalendarDetailWithEvent(context, appointment);
                      _lastTapTime = null;
                      _lastTappedDate = null;
                      _lastTappedEventName = null;
                    } else {
                      // 첫 번째 클릭
                      _lastTapTime = now;
                      _lastTappedDate = appointment.from;
                      _lastTappedEventName = appointment.eventName;
                    }
                  }
                },
              ),
            ),
          ),

          // 3) compact=false AND 뷰가 month일 때만 Agenda 보이기
          if (!widget.compact && _currentView == CalendarView.month)
            Container(
              color: Colors.white,
              child: _buildDailyRowsAgendaView(),
            ),
        ],
      ),
    );
  }

  // 날짜별 간단 Agenda
  Widget _buildDailyRowsAgendaView() {
    final List<DateTime> dateRange = List.generate(
      3,
      (index) => DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day + index,
      ),
    );

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: dateRange.length,
      separatorBuilder: (context, index) => Divider(height: 1),
      itemBuilder: (context, index) {
        final date = dateRange[index];
        final dayEvents = _getEventsForDate(date);

        return Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 날짜 + 요일
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        '${date.day}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getDayOfWeekInKorean(date),
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(width: 16),
                  // 일정 목록
                  Expanded(
                    child: dayEvents.isEmpty
                        ? Text(
                            '등록된 일정이 없습니다.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: dayEvents.map((event) {
                              final timeStr = event.isAllDay
                                  ? '종일'
                                  : '${DateFormat('HH:mm').format(event.from)} - ${DateFormat('HH:mm').format(event.to)}';

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // 일정 탭 시 상세 이동 기능 비활성화 (주석 처리)
                                    /*
                                    _navigateToCalendarDetailWithEvent(
                                      context,
                                      event,
                                    );
                                    */
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 10,
                                        height: 10,
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          color: event.background,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              event.eventName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              timeStr,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // 요일 한글 변환
  String _getDayOfWeekInKorean(DateTime date) {
    switch (date.weekday) {
      case 1:
        return '월요일';
      case 2:
        return '화요일';
      case 3:
        return '수요일';
      case 4:
        return '목요일';
      case 5:
        return '금요일';
      case 6:
        return '토요일';
      case 7:
        return '일요일';
    }
    return '';
  }

    // 특정 날짜의 일정 가져오기
  List<Meeting> _getEventsForDate(DateTime date) {
    final events = _calendarEvents;

    // 선택된 날짜의 시작(00:00)과 끝(23:59)
    final targetStart = DateTime(date.year, date.month, date.day);
    final targetEnd = DateTime(date.year, date.month, date.day, 23, 59, 59);

    print('========================================');
    print('_getEventsForDate 호출: ${DateFormat('yyyy-MM-dd').format(date)}');
    print('targetStart: $targetStart');
    print('targetEnd: $targetEnd');
    print('전체 일정 수: ${events.length}');

    final filteredEvents = events.where((event) {
      // 일정의 시작과 끝
      final eventStart = event.from;
      final eventEnd = event.to;

      // 일정이 해당 날짜에 걸쳐있는지 확인
      // 조건: 일정 시작이 target 이전이거나 같고, 일정 끝이 target 이후이거나 같음
      final startsBeforeOrOnTarget = eventStart.isBefore(targetEnd.add(Duration(seconds: 1)));
      final endsAfterOrOnTarget = eventEnd.isAfter(targetStart.subtract(Duration(seconds: 1)));

      final isInRange = startsBeforeOrOnTarget && endsAfterOrOnTarget;

      if (isInRange) {
        print('✅ 포함: ${event.eventName} (${DateFormat('yyyy-MM-dd').format(eventStart)} ~ ${DateFormat('yyyy-MM-dd').format(eventEnd)})');
      }

      return isInRange;
    }).toList();

    print('필터링된 일정 수: ${filteredEvents.length}');
    print('========================================');

    return filteredEvents;
  }

  // 라우팅 함수들은 주석 처리하지 않고 유지 (호출되지는 않지만 코드는 보존)
    void _navigateToCalendarDetail(BuildContext context, DateTime date) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    try {
      final result = await context.pushNamed(
        'CalendarDetail',
        queryParameters: {
          'date': formattedDate,
        },
      );
      
      // 돌아왔을 때 result가 true면 새로고침
      if (result == true) {
        print('일정 등록 후 돌아옴 - 캘린더 새로고침');
        await _loadCalendarEvents();
      }
      
      print('pushNamed 성공');
    } catch (e) {
      print('첫 번째 라우팅 방법 실패: $e');
      try {
        final result = await context.pushNamed(
          'calendarDetail',
          queryParameters: {
            'date': formattedDate,
          },
        );
        
        if (result == true) {
          print('일정 등록 후 돌아옴 - 캘린더 새로고침');
          await _loadCalendarEvents();
        }
        
        print('소문자 라우트로 성공');
      } catch (e2) {
        print('두 번째 라우팅 방법도 실패: $e2');
        try {
          final result = await Navigator.of(context).pushNamed(
            '/CalendarDetail',
            arguments: {
              'date': formattedDate,
            },
          );
          
          if (result == true) {
            print('일정 등록 후 돌아옴 - 캘린더 새로고침');
            await _loadCalendarEvents();
          }
          
          print('Navigator API 성공');
        } catch (e3) {
          print('모든 라우팅 방법 실패: $e3');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('페이지 이동 중 오류가 발생했습니다.'),
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    }
  }

        void _navigateToCalendarDetailWithEvent(BuildContext context, Meeting event) async {
    final formattedDate = DateFormat('yyyy-MM-dd').format(event.from);
    print('========================================');
    print('이벤트로 이동 - eventId: ${event.eventId}, date: $formattedDate');
    print('event.eventId == null? ${event.eventId == null}');
    print('========================================');

    try {
      // eventId가 있을 때만 전달
      final queryParams = <String, String>{
        'date': formattedDate,
      };

      if (event.eventId != null) {
        queryParams['eventId'] = event.eventId.toString();
        print('✅ eventId 추가됨: ${queryParams['eventId']}');
      } else {
        print('❌ eventId가 null입니다!');
      }

      print('최종 queryParams: $queryParams');

      final result = await context.pushNamed(
        'CalendarDetail',
        queryParameters: queryParams,
      );
      
      if (result == true) {
        print('일정 수정 후 돌아옴 - 캘린더 새로고침');
        await _loadCalendarEvents();
      }
      
      print('일정 관련 페이지 이동 성공');
    } catch (e) {
      print('일정 탭 페이지 이동 오류: $e');
      try {
                        // eventId가 있을 때만 전달
        final queryParams2 = <String, String>{
          'date': formattedDate,
        };
        
        if (event.eventId != null) {
          queryParams2['eventId'] = event.eventId.toString();
        }
        
        final result = await context.pushNamed(
          'calendarDetail',
          queryParameters: queryParams2,
        );
        
        if (result == true) {
          print('일정 수정 후 돌아옴 - 캘린더 새로고침');
          await _loadCalendarEvents();
        }
        
        print('소문자 라우트로 성공');
      } catch (e2) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('페이지 이동 중 오류가 발생했습니다.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

    // 기본 일정들 (로드 실패 시 사용)
  List<Meeting> _getDefaultDataSource() {
    final List<Meeting> meetings = [];
    final now = DateTime.now();

    // 오늘
    meetings.add(
      Meeting(
        eventName: '회의',
        from: now,
        to: now.add(Duration(hours: 2)),
        background: Colors.blue,
      ),
    );

    // 내일
    final tomorrow = now.add(Duration(days: 1));
    meetings.add(
      Meeting(
        eventName: '미팅',
        from: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 14, 0),
        to: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 16, 0),
        background: Colors.green,
      ),
    );

    // 모레
    final dayAfterTomorrow = now.add(Duration(days: 2));
    meetings.add(
      Meeting(
        eventName: '프로젝트 미팅',
        from: DateTime(dayAfterTomorrow.year, dayAfterTomorrow.month,
            dayAfterTomorrow.day, 10, 0),
        to: DateTime(dayAfterTomorrow.year, dayAfterTomorrow.month,
            dayAfterTomorrow.day, 12, 0),
        background: Colors.orange,
      ),
    );

    // 특정일 휴일
    final fifteenth = DateTime(now.year, now.month, 15);
    meetings.add(
      Meeting(
        eventName: '서비스 오픈',
        from: fifteenth,
        to: fifteenth,
        background: Colors.purple,
        isAllDay: true,
      ),
    );

    return meetings;
  }
}

// 모델
class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    this.background = Colors.grey,
    this.isAllDay = false,
    this.eventId,
  });

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  int? eventId; // DB에 저장된 일정 ID
}

// Syncfusion용 DataSource
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) => appointments![index].from;
  @override
  DateTime getEndTime(int index) => appointments![index].to;
  @override
  String getSubject(int index) => appointments![index].eventName;
  @override
  Color getColor(index) => appointments![index].background;
  @override
  bool isAllDay(int index) => appointments![index].isAllDay;
}
