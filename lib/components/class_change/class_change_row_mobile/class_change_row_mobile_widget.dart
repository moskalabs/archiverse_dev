import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'class_change_row_mobile_model.dart';
export 'class_change_row_mobile_model.dart';

class ClassChangeRowMobileWidget extends StatefulWidget {
  const ClassChangeRowMobileWidget({
    super.key,
    required this.studentName,
    required this.studentNumber,
    required this.currentSection,
    required this.requestedSection,
    required this.requestReason,
    required this.requestStatus,
    this.requestDate,
    required this.acceptRequest,
    this.isProcessing = false,
  });

  final String studentName;
  final String studentNumber;
  final String currentSection;
  final String requestedSection;
  final String requestReason;
  final String requestStatus;
  final DateTime? requestDate;
  final Future<void> Function(bool accept) acceptRequest;
  final bool isProcessing;

  @override
  State<ClassChangeRowMobileWidget> createState() =>
      _ClassChangeRowMobileWidgetState();
}

class _ClassChangeRowMobileWidgetState
    extends State<ClassChangeRowMobileWidget> {
  late ClassChangeRowMobileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassChangeRowMobileModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    final status = widget.requestStatus.toLowerCase();
    final isPending = status == 'pending';
    final statusLabel = () {
      switch (status) {
        case 'approved':
          return '승인';
        case 'rejected':
          return '거절';
        default:
          return '대기';
      }
    }();
    final statusColor = () {
      switch (status) {
        case 'approved':
          return const Color(0xFF2E7D32);
        case 'rejected':
          return const Color(0xFFC62828);
        default:
          return const Color(0xFFFFA000);
      }
    }();
    final formattedDate = widget.requestDate != null
        ? dateTimeFormat(
            'yMMMd',
            widget.requestDate,
            locale: FFLocalizations.of(context).languageCode,
          )
        : '-';
    final isActionDisabled = widget.isProcessing || !isPending;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: theme.neutral200, width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 6.0,
            offset: Offset(0.0, 2.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.studentName,
                style: theme.titleMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontStyle: theme.titleMedium.fontStyle,
                      ),
                      color: const Color(0xFF1F2933),
                      letterSpacing: 0.0,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Text(
                  statusLabel,
                  style: theme.bodySmall.override(
                        font: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontStyle: theme.bodySmall.fontStyle,
                        ),
                        color: statusColor,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            '학번: ${widget.studentNumber}',
            style: theme.bodySmall.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: theme.bodySmall.fontStyle,
                  ),
                  color: const Color(0xFF4B5563),
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '현재 분반: ${widget.currentSection}',
            style: theme.bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontStyle: theme.bodyMedium.fontStyle,
                  ),
                  color: const Color(0xFF4B5563),
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            '희망 분반: ${widget.requestedSection}',
            style: theme.bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontStyle: theme.bodyMedium.fontStyle,
                  ),
                  color: const Color(0xFF4B5563),
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            '사유: ${widget.requestReason}',
            style: theme.bodyMedium.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: theme.bodyMedium.fontStyle,
                  ),
                  color: const Color(0xFF1F2933),
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 4.0),
          Text(
            '요청일: $formattedDate',
            style: theme.bodySmall.override(
                  font: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontStyle: theme.bodySmall.fontStyle,
                  ),
                  color: const Color(0xFF6B7280),
                  letterSpacing: 0.0,
                ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Expanded(
                child: FFButtonWidget(
                  onPressed: () async {
                    if (isActionDisabled) {
                      return;
                    }
                    await widget.acceptRequest(true);
                  },
                  text: '승인',
                  options: FFButtonOptions(
                    height: 40.0,
                    color: isActionDisabled
                        ? const Color(0xFFE5E7EB)
                        : const Color(0xFF2E7D32),
                    textStyle: theme.titleSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: theme.titleSmall.fontWeight,
                            fontStyle: theme.titleSmall.fontStyle,
                          ),
                          color: isActionDisabled
                              ? const Color(0xFF9CA3AF)
                              : Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: FFButtonWidget(
                  onPressed: () async {
                    if (isActionDisabled) {
                      return;
                    }
                    await widget.acceptRequest(false);
                  },
                  text: '거절',
                  options: FFButtonOptions(
                    height: 40.0,
                    color: isActionDisabled
                        ? const Color(0xFFE5E7EB)
                        : const Color(0xFFC62828),
                    textStyle: theme.titleSmall.override(
                          font: GoogleFonts.inter(
                            fontWeight: theme.titleSmall.fontWeight,
                            fontStyle: theme.titleSmall.fontStyle,
                          ),
                          color: isActionDisabled
                              ? const Color(0xFF9CA3AF)
                              : Colors.white,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
