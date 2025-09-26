import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/core/font_constants.dart';
import '/core/responsive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDashboardWidget extends StatefulWidget {
  const StudentDashboardWidget({Key? key}) : super(key: key);

  static String routeName = 'StudentDashboard';
  static String routePath = '/student-dashboard';

  @override
  State<StudentDashboardWidget> createState() => _StudentDashboardWidgetState();
}

class _StudentDashboardWidgetState extends State<StudentDashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: ResponsiveWrapper(
        child: SafeArea(
          top: true,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: FlutterFlowTheme.of(context).primaryBackground,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Student Dashboard',
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                        fontSize: FontConstants.sizeXLarge,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).titleLargeFamily,
                        ),
                      ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 260,
                        margin: const EdgeInsets.only(right: 24),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Student Sidebar',
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily:
                                    FlutterFlowTheme.of(context).bodyMediumFamily,
                                fontSize: FontConstants.sizeMedium,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyMediumFamily,
                                ),
                              ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).secondaryBackground,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Student Content',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: FlutterFlowTheme.of(context)
                                          .bodyLargeFamily,
                                      fontSize: FontConstants.sizeLarge,
                                      useGoogleFonts:
                                          GoogleFonts.asMap().containsKey(
                                        FlutterFlowTheme.of(context)
                                            .bodyLargeFamily,
                                      ),
                                    ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
