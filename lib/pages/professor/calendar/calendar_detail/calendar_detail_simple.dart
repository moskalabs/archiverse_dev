import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';

/// 간단한 일정 등록 폼
class CalendarDetailSimple extends StatefulWidget {
  const CalendarDetailSimple({super.key});

  @override
  State<CalendarDetailSimple> createState() => _CalendarDetailSimpleState();
}

class _CalendarDetailSimpleState extends State<CalendarDetailSimple> {
  final _titleController = TextEditingController();
  final _shareTargetController = TextEditingController();
  final _locationController = TextEditingController();
  final _contentController = TextEditingController();
  
  DateTime _startDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay _endTime = TimeOfDay.now();
  bool _isAllDay = false;

  @override
  void dispose() {
    _titleController.dispose();
    _shareTargetController.dispose();
    _locationController.dispose();
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
            // 헤더
            Row(
              children: [
                Icon(Icons.add_task, color: Color(0xFFA9B4CD), size: 36.0),
                SizedBox(width: 15.0),
                Text(
                  '일정 등록',
                  style: GoogleFonts.openSans(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF284E75),
                  ),
                ),
              ],
            ),
            
            Divider(height: 40.0, thickness: 2.0),
            
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
            
            // 3. 공유 대상
            _buildLabel('공유 대상'),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _shareTargetController,
              decoration: InputDecoration(
                hintText: '공유 대상을 입력하세요',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              ),
            ),
            SizedBox(height: 20.0),
            
            // 4. 장소
            _buildLabel('장소'),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: '장소를 입력하세요',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
              ),
            ),
            SizedBox(height: 20.0),
            
            // 5. 내용
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
                  onPressed: () {
                    // TODO: 저장 로직 (Supabase에 저장)
                    print('제목: ${_titleController.text}');
                    print('시작: $_startDate ${_startTime.format(context)}');
                    print('종료: $_endDate ${_endTime.format(context)}');
                    print('종일: $_isAllDay');
                    print('공유 대상: ${_shareTargetController.text}');
                    print('장소: ${_locationController.text}');
                    print('내용: ${_contentController.text}');
                    
                    Navigator.of(context).pop();
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