import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notifications_model.dart';
export 'notifications_model.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationsModel _model;
  List<NotificationsRow> _notifications = [];
  bool _isLoading = true;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsModel());

    _loadNotifications();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  // 오늘 알람 로드
  Future<void> _loadNotifications() async {
    try {
      final userEmail = currentUserEmail;
      if (userEmail == null || userEmail.isEmpty) {
        print('사용자 이메일 없음');
        setState(() => _isLoading = false);
        return;
      }

      // 오늘 날짜
      final today = DateTime.now();
      final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

      print('알람 목록 로드: email=$userEmail, date=$todayStr');

      // 오늘 날짜의 알람 가져오기 (읽음/안읽음 모두)
      final result = await NotificationsTable().queryRows(
        queryFn: (q) => q
            .eq('recipient_email', userEmail)
            .eq('notification_date', todayStr)
            .order('created_at', ascending: false),
      );

      setState(() {
        _notifications = result;
        _isLoading = false;
      });

      print('알람 ${_notifications.length}개 로드됨');
    } catch (e) {
      print('알람 로드 오류: $e');
      setState(() {
        _notifications = [];
        _isLoading = false;
      });
    }
  }

  // 알람 읽음 처리
  Future<void> _markAsRead(int notificationId) async {
    try {
      await SupaFlow.client
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);

      setState(() {
        final index = _notifications.indexWhere((n) => n.id == notificationId);
        if (index != -1) {
          _notifications[index].isRead = true;
        }
      });
    } catch (e) {
      print('알람 읽음 처리 오류: $e');
    }
  }

  // TIME 문자열을 포맷팅 (예: "15:30:00" -> "15:30")
  String _formatTime(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
      }
      return timeStr;
    } catch (e) {
      return timeStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.0,
      height: 500.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        boxShadow: [
          BoxShadow(
            blurRadius: 16.0,
            color: Color(0x1B080B1F),
            offset: Offset(
              0.0,
              6.0,
            ),
          )
        ],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 8.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      FFLocalizations.of(context).getText(
                        'rfmjblyf' /* Notifications */,
                      ),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                            ),
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .fontStyle,
                          ),
                    ),
                  ],
                ),
                FlutterFlowIconButton(
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 36.0,
                  icon: Icon(
                    Icons.close,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 16.0,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : _notifications.isEmpty
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                '오늘 알람이 없습니다.',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: _notifications.map((notification) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (!(notification.isRead ?? false)) {
                                        _markAsRead(notification.id);
                                      }
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: (notification.isRead ?? false)
                                            ? FlutterFlowTheme.of(context)
                                                .primaryBackground
                                            : Color(0xFFE8F4FF),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        border: Border.all(
                                          color: (notification.isRead ?? false)
                                              ? Colors.grey.shade300
                                              : Color(0xFF284E75),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            badges.Badge(
                                              badgeContent: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.openSans(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight: FlutterFlowTheme.of(context)
                                                          .titleSmall
                                                          .fontWeight,
                                                      fontStyle: FlutterFlowTheme.of(context)
                                                          .titleSmall
                                                          .fontStyle,
                                                    ),
                                              ),
                                              showBadge: true,
                                              shape: badges.BadgeShape.circle,
                                              badgeColor:
                                                  FlutterFlowTheme.of(context).primary,
                                              elevation: 0.0,
                                              position: badges.BadgePosition.topStart(),
                                              animationType: badges.BadgeAnimationType.scale,
                                              toAnimate: true,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8.0),
                                                child: Container(
                                                  width: 40.0,
                                                  height: 40.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        FlutterFlowTheme.of(context).brand100,
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons.ticketSimple,
                                                        color: FlutterFlowTheme.of(context)
                                                            .primary,
                                                        size: 12.0,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 12.0),
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '[${notification.courseName ?? ""}] ${notification.notificationTitle ?? ""}',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Text(
                                                    notification.notificationContent ?? '',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey[600],
                                                    ),
                                                    maxLines: 2,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 4.0),
                                                  Text(
                                                    notification.notificationTime != null
                                                        ? _formatTime(notification.notificationTime!)
                                                        : '',
                                                    style: TextStyle(
                                                      fontSize: 11.0,
                                                      color: Colors.grey[500],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
