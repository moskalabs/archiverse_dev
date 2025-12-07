import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'check_submitted_model.dart';
export 'check_submitted_model.dart';

/// 주차는 하드코딩, 아래의 ['O', 'X', '-'] 세 유형을 불러와 현재의 시간값에 따라 O X - 세 타입을 설정.
///
/// <- 좀 과한 액션이 들어가지 않는가?
class CheckSubmittedWidget extends StatefulWidget {
  const CheckSubmittedWidget({
    super.key,
    this.portfolioSubmitted,
    this.weeklyStatus,
  });

  final SubjectportpolioRow? portfolioSubmitted;

  /// Map of week number (1-15) to submission status (true = submitted, false = not submitted)
  final Map<int, bool>? weeklyStatus;

  @override
  State<CheckSubmittedWidget> createState() => _CheckSubmittedWidgetState();
}

class _CheckSubmittedWidgetState extends State<CheckSubmittedWidget> {
  late CheckSubmittedModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CheckSubmittedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  /// Helper method to get status indicator
  String _getStatusIndicator(int weekNum) {
    if (widget.weeklyStatus == null) return '-';
    return widget.weeklyStatus![weekNum] == true ? 'O' : '-';
  }

  /// Helper method to get status color
  Color _getStatusColor(int weekNum, BuildContext context) {
    if (widget.weeklyStatus == null) return Color(0xFF666666);
    return widget.weeklyStatus![weekNum] == true
        ? Color(0xFF284E75)
        : Color(0xFF666666);
  }

  /// Helper to build a week column
  Widget _buildWeekColumn(BuildContext context, int weekNum, String weekLabel) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              border: Border.all(color: Color(0xFFE3E3E3)),
            ),
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Text(
                weekLabel,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.notoSansKr(
                        fontWeight: FontWeight.w500,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: Color(0xFF666666),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            decoration: BoxDecoration(
              color: widget.weeklyStatus?[weekNum] == true
                  ? Color(0xFF284E75).withOpacity(0.1)
                  : FlutterFlowTheme.of(context).secondaryBackground,
              border: Border.all(color: Color(0xFFE3E3E3)),
            ),
            child: Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Text(
                _getStatusIndicator(weekNum),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.notoSansKr(
                        fontWeight: FontWeight.w600,
                        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      color: _getStatusColor(weekNum, context),
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ),
          ),
        ].divide(SizedBox(height: 10.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Row 1: Weeks 1-8
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildWeekColumn(context, 1, '1주차'),
            _buildWeekColumn(context, 2, '2주차'),
            _buildWeekColumn(context, 3, '3주차'),
            _buildWeekColumn(context, 4, '4주차'),
            _buildWeekColumn(context, 5, '5주차'),
            _buildWeekColumn(context, 6, '6주차'),
            _buildWeekColumn(context, 7, '7주차'),
            _buildWeekColumn(context, 8, '8주차'),
          ],
        ),
        SizedBox(height: 10.0),
        // Row 2: Weeks 9-15 + empty column
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildWeekColumn(context, 9, '9주차'),
            _buildWeekColumn(context, 10, '10주차'),
            _buildWeekColumn(context, 11, '11주차'),
            _buildWeekColumn(context, 12, '12주차'),
            _buildWeekColumn(context, 13, '13주차'),
            _buildWeekColumn(context, 14, '14주차'),
            _buildWeekColumn(context, 15, '15주차'),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(color: Color(0xFFE3E3E3)),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      border: Border.all(color: Color(0xFFE3E3E3)),
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
