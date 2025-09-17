import '/components/default_layout/headers/student_header/student_header_widget.dart';
import '/components/default_layout/headers/student_header_mobile/student_header_mobile_widget.dart';
import '/components/default_layout/left_right/student_left_widget/student_left_widget_widget.dart';
import '/components/default_layout/left_right/student_right_widget/student_right_widget_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar/student_navi_sidebar_widget.dart';
import '/components/default_layout/nav_bar/student_navi_sidebar_mobile/student_navi_sidebar_mobile_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'student_calender_model.dart';
export 'student_calender_model.dart';

class StudentCalenderWidget extends StatefulWidget {
  const StudentCalenderWidget({super.key});

  static String routeName = 'StudentCalender';
  static String routePath = '/StudentCalender';

  @override
  State<StudentCalenderWidget> createState() => _StudentCalenderWidgetState();
}

class _StudentCalenderWidgetState extends State<StudentCalenderWidget> {
  late StudentCalenderModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StudentCalenderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFEEF1F6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                    ))
                      wrapWithModel(
                        model: _model.studentNaviSidebarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: StudentNaviSidebarWidget(
                          activePageName: 'Student_Calender',
                          pageIsInSubMenu: false,
                        ),
                      ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: wrapWithModel(
                                  model: _model.studentHeaderModel,
                                  updateCallback: () => safeSetState(() {}),
                                  child: StudentHeaderWidget(),
                                ),
                              ),
                            ],
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEF1F6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    wrapWithModel(
                                      model: _model.studentLeftWidgetModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: StudentLeftWidgetWidget(),
                                    ),
                                  Flexible(
                                    flex: 16,
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(0.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 5.0, 0.0),
                                              child: Container(
                                                width: double.infinity,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.95,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: custom_widgets
                                                      .SyncfusionCalendarWidget(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    compact: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (responsiveVisibility(
                                    context: context,
                                    phone: false,
                                    tablet: false,
                                  ))
                                    wrapWithModel(
                                      model: _model.studentRightWidgetModel,
                                      updateCallback: () => safeSetState(() {}),
                                      child: StudentRightWidgetWidget(),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEF1F6),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: wrapWithModel(
                              model: _model.studentHeaderMobileModel,
                              updateCallback: () => safeSetState(() {}),
                              child: StudentHeaderMobileWidget(),
                            ),
                          ),
                        ],
                      ),
                      if (responsiveVisibility(
                        context: context,
                        tabletLandscape: false,
                        desktop: false,
                      ))
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFEEF1F6),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, -1.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 0.0),
                                    child: Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.95,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        child: custom_widgets
                                            .SyncfusionCalendarWidget(
                                          width: double.infinity,
                                          height: double.infinity,
                                          compact: false,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (responsiveVisibility(
                                  context: context,
                                  tabletLandscape: false,
                                  desktop: false,
                                ))
                                  wrapWithModel(
                                    model: _model.studentNaviSidebarMobileModel,
                                    updateCallback: () => safeSetState(() {}),
                                    child: StudentNaviSidebarMobileWidget(
                                      activePageName: 'Student_Calender',
                                      pageIsInSubMenu: false,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              if (FFAppState().channelTalk == true)
                Align(
                  alignment: AlignmentDirectional(1.0, 1.0),
                  child: FlutterFlowWebView(
                    content:
                        '<script>\n  (function(){var w=window;if(w.ChannelIO){return w.console.error(\"ChannelIO script included twice.\");}var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};w.ChannelIO=ch;function l(){if(w.ChannelIOInitialized){return;}w.ChannelIOInitialized=true;var s=document.createElement(\"script\");s.type=\"text/javascript\";s.async=true;s.src=\"https://cdn.channel.io/plugin/ch-plugin-web.js\";var x=document.getElementsByTagName(\"script\")[0];if(x.parentNode){x.parentNode.insertBefore(s,x);}}if(document.readyState===\"complete\"){l();}else{w.addEventListener(\"DOMContentLoaded\",l);w.addEventListener(\"load\",l);}})();\n\n  ChannelIO(\'boot\', {\n    \"pluginKey\": \"4f440600-f8b3-494e-b133-5476520fcf8a\"\n  });\n</script>',
                    width: () {
                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                        return 340.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointMedium) {
                        return 500.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointLarge) {
                        return 550.0;
                      } else {
                        return 550.0;
                      }
                    }(),
                    height: () {
                      if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
                        return 550.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointMedium) {
                        return 650.0;
                      } else if (MediaQuery.sizeOf(context).width <
                          kBreakpointLarge) {
                        return 680.0;
                      } else {
                        return 680.0;
                      }
                    }(),
                    verticalScroll: false,
                    horizontalScroll: false,
                    html: true,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
