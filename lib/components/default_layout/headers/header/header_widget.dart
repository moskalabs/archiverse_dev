import '/auth/supabase_auth/auth_util.dart';
import '/backend/supabase/supabase.dart';
import '/components/not_used_comps/notifications/notifications_widget.dart';
import '/components/not_used_comps/user_menu/user_menu_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:badges/badges.dart' as badges;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'header_model.dart';
export 'header_model.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({
    super.key,
    String? years,
    String? semesterType,
  })  : this.years = years ?? '2025',
        this.semesterType = semesterType ?? '1gkrrl';

  final String years;
  final String semesterType;

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  late HeaderModel _model;
  Timer? _notificationTimer;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HeaderModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().mypageImageUrl = FFAppState().mypageImageUrl;
      await _loadUnreadNotifications();
      safeSetState(() {});
    });

    // 1분마다 알람을 자동으로 체크하는 타이머 시작
    _notificationTimer = Timer.periodic(Duration(minutes: 1), (timer) async {
      await _loadUnreadNotifications();
      if (mounted) {
        safeSetState(() {});
      }
    });

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  // 읽지 않은 알람 개수 로드
  Future<void> _loadUnreadNotifications() async {
    try {
      final userEmail = currentUserEmail;
      if (userEmail == null || userEmail.isEmpty) {
        print('사용자 이메일 없음');
        return;
      }

      // 오늘 날짜와 현재 시간
      final now = DateTime.now();
      final todayStr = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final currentTimeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      print('[교수] 알람 로드 시작: email=$userEmail, date=$todayStr, time=$currentTimeStr');

      // 오늘 날짜의 읽지 않은 알람 중 현재 시간이 지난 것만 가져오기
      final notifications = await SupaFlow.client
          .from('notifications')
          .select()
          .eq('recipient_email', userEmail)
          .eq('notification_date', todayStr)
          .eq('is_read', false)
          .lte('notification_time', currentTimeStr);  // 현재 시간보다 이전 알람만

      _model.unreadNotificationCount = (notifications as List).length;
      print('[교수] 읽지 않은 알람: ${_model.unreadNotificationCount}개');
    } catch (e) {
      print('[교수] 알람 로드 오류: $e');
      _model.unreadNotificationCount = 0;
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();
    _notificationTimer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Visibility(
      visible: responsiveVisibility(
        context: context,
        phone: false,
      ),
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height * 0.06,
        decoration: BoxDecoration(
          color: Color(0xFFEEF1F6),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 20.0, 0.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      width: 140.0,
                      height: MediaQuery.sizeOf(context).height * 0.04,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            flex: 4,
                            child: Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8.0, 4.0, 0.0, 2.0),
                                child: AnimatedDefaultTextStyle(
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF284E75),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn,
                                  child: Text(
                                    valueOrDefault<String>(
                                      FFAppState().yearSelected,
                                      '0000',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Align(
                              alignment: AlignmentDirectional(-4.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 2.0, 0.0, 2.0),
                                child: AnimatedDefaultTextStyle(
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF284E75),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn,
                                  child: Text(
                                    FFLocalizations.of(context).getText(
                                      'igfusr48' /* 년 */,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: Align(
                              alignment: AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 2.0, 3.0, 2.0),
                                child: AnimatedDefaultTextStyle(
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF284E75),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  duration: Duration(milliseconds: 600),
                                  curve: Curves.easeIn,
                                  child: Text(
                                    valueOrDefault<String>(
                                      FFAppState().semesterSelected,
                                      '-학기',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 8.0)),
              ),
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    'assets/images/_2.png',
                    height: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (false)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        height: 45.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).textFieldBachGround,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              tablet: false,
                              tabletLandscape: false,
                              desktop: false,
                            ))
                              FlutterFlowIconButton(
                                borderRadius: 12.0,
                                borderWidth: 1.0,
                                buttonSize: 48.0,
                                icon: Icon(
                                  Icons.menu,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  FFAppState().drawer = !FFAppState().drawer;
                                  FFAppState().update(() {});
                                },
                              ),
                            Container(
                              width: 48.0,
                              height: 48.0,
                              decoration: BoxDecoration(),
                              child: Icon(
                                Icons.search,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 18.0,
                              ),
                            ),
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Container(
                                width: 300.0,
                                child: TextFormField(
                                  controller: _model.textController,
                                  focusNode: _model.textFieldFocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.textController',
                                    Duration(milliseconds: 500),
                                    () => safeSetState(() {}),
                                  ),
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: false,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    hintText:
                                        FFLocalizations.of(context).getText(
                                      '3w5m7y2k' /* 검색해주세요... */,
                                    ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.openSans(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFF284E75),
                                          fontSize: () {
                                            if (MediaQuery.sizeOf(context)
                                                    .width <
                                                kBreakpointSmall) {
                                              return 10.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointMedium) {
                                              return 12.0;
                                            } else if (MediaQuery.sizeOf(
                                                        context)
                                                    .width <
                                                kBreakpointLarge) {
                                              return 14.0;
                                            } else {
                                              return 14.0;
                                            }
                                          }(),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        font: GoogleFonts.openSans(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  cursorColor: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  validator: _model.textControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  if (true)
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showAlignedDialog(
                                context: context,
                                isGlobal: false,
                                avoidOverflow: false,
                                targetAnchor: AlignmentDirectional(1.0, 1.0)
                                    .resolve(Directionality.of(context)),
                                followerAnchor: AlignmentDirectional(1.0, -1.0)
                                    .resolve(Directionality.of(context)),
                                builder: (dialogContext) {
                                  return Material(
                                    color: Colors.transparent,
                                    child: WebViewAware(
                                      child: NotificationsWidget(),
                                    ),
                                  );
                                },
                              );
                            },
                            child: badges.Badge(
                              badgeContent: Text(
                                '${_model.unreadNotificationCount}',
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.openSans(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                              ),
                              showBadge: _model.unreadNotificationCount > 0,
                              shape: badges.BadgeShape.circle,
                              badgeColor: FlutterFlowTheme.of(context).tertiary,
                              elevation: 4.0,
                              padding: EdgeInsets.all(5.0),
                              position: badges.BadgePosition.topEnd(),
                              animationType: badges.BadgeAnimationType.scale,
                              toAnimate: true,
                              child: Container(
                                width: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 30.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 35.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 40.0;
                                  } else {
                                    return 44.0;
                                  }
                                }(),
                                height: () {
                                  if (MediaQuery.sizeOf(context).width <
                                      kBreakpointSmall) {
                                    return 30.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointMedium) {
                                    return 35.0;
                                  } else if (MediaQuery.sizeOf(context).width <
                                      kBreakpointLarge) {
                                    return 40.0;
                                  } else {
                                    return 44.0;
                                  }
                                }(),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  shape: BoxShape.circle,
                                ),
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.notifications_none,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderRadius: 8.0,
                      buttonSize: 40.0,
                      fillColor: FFAppState().channelTalk == false
                          ? Color(0xFF284E75)
                          : FlutterFlowTheme.of(context).primaryBackground,
                      hoverColor:
                          FlutterFlowTheme.of(context).primaryBackground,
                      hoverIconColor: Color(0xFF284E75),
                      icon: Icon(
                        Icons.quora_rounded,
                        color: valueOrDefault<Color>(
                          FFAppState().channelTalk == false
                              ? FlutterFlowTheme.of(context).primaryBackground
                              : Color(0xFF284E75),
                          FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        size: 24.0,
                      ),
                      onPressed: () async {
                        FFAppState().channelTalk =
                            !(FFAppState().channelTalk);
                        _model.updatePage(() {});
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        await showAlignedDialog(
                          context: context,
                          isGlobal: false,
                          avoidOverflow: false,
                          targetAnchor: AlignmentDirectional(1.0, 1.0)
                              .resolve(Directionality.of(context)),
                          followerAnchor: AlignmentDirectional(1.0, -1.0)
                              .resolve(Directionality.of(context)),
                          builder: (dialogContext) {
                            return Material(
                              color: Colors.transparent,
                              child: WebViewAware(
                                child: UserMenuWidget(),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 30.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointMedium) {
                            return 35.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointLarge) {
                            return 40.0;
                          } else {
                            return 44.0;
                          }
                        }(),
                        height: () {
                          if (MediaQuery.sizeOf(context).width <
                              kBreakpointSmall) {
                            return 30.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointMedium) {
                            return 35.0;
                          } else if (MediaQuery.sizeOf(context).width <
                              kBreakpointLarge) {
                            return 40.0;
                          } else {
                            return 44.0;
                          }
                        }(),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          valueOrDefault<String>(
                            FFAppState().mypageImageUrl,
                            'https://ygagwsshehmtfqlkjwmv.supabase.co/storage/v1/object/public/profileimage/myprofile/1739097345656000.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ].divide(SizedBox(width: 24.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
