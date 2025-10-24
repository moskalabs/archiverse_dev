import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/flutter_flow_util.dart';

class PdfDownloadSelectionDialog extends StatefulWidget {
  const PdfDownloadSelectionDialog({
    super.key,
    required this.year,
    required this.semester,
    required this.courseName,
    required this.professorName,
    required this.grade,
    required this.section,
    required this.classId,
  });

  final String? year;
  final String? semester;
  final String? courseName;
  final String? professorName;
  final int? grade;
  final String? section;
  final int? classId;

  @override
  State<PdfDownloadSelectionDialog> createState() =>
      _PdfDownloadSelectionDialogState();
}

class _PdfDownloadSelectionDialogState
    extends State<PdfDownloadSelectionDialog> {
  // 각 항목의 선택 상태
  bool selectedAttendance = false; // 출석부
  bool selectedGrade = false; // 성적기록표
  bool selectedWeeklyProgress = false; // 주차별 설계 진행표
  bool selectedStudentEvaluation = false; // 학생작품 평가표
  bool selectedMidterm = false; // 중간 결과물
  bool selectedFinal = false; // 기말 결과물
  bool selectedCoursePlan = false; // 수업계획서
  bool selectedLectureMaterial = false; // 강의자료

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.5,
        constraints: BoxConstraints(
          maxWidth: 600,
          maxHeight: 500,
        ),
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Color(0xFF284E75),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 헤더
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.download,
                      color: Color(0xFF284E75),
                      size: 24,
                    ),
                    SizedBox(width: 8),
                    Text(
                      '전체파일 다운로드',
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 20,
                          ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.close, color: FlutterFlowTheme.of(context).secondaryText),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 16),

            // 설명 텍스트
            Text(
              '원하는 파일을 선택하여 다운로드를 하면 PDF파일로 받아보실 수 있습니다.',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.openSans(),
                    color: FlutterFlowTheme.of(context).secondaryText,
                    fontSize: 14,
                  ),
            ),
            SizedBox(height: 24),

            // 체크박스 그리드 (2열)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _buildCheckboxTile('수업계획서', selectedCoursePlan, (value) {
                            setState(() => selectedCoursePlan = value ?? false);
                          }),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildCheckboxTile('출석부', selectedAttendance, (value) {
                            setState(() => selectedAttendance = value ?? false);
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCheckboxTile('성적기록표', selectedGrade, (value) {
                            setState(() => selectedGrade = value ?? false);
                          }),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildCheckboxTile('강의자료', selectedLectureMaterial, (value) {
                            setState(() => selectedLectureMaterial = value ?? false);
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCheckboxTile('주차별 설계 진행표', selectedWeeklyProgress, (value) {
                            setState(() => selectedWeeklyProgress = value ?? false);
                          }),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildCheckboxTile('학생작품 평가표', selectedStudentEvaluation, (value) {
                            setState(() => selectedStudentEvaluation = value ?? false);
                          }),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildCheckboxTile('중간 결과물', selectedMidterm, (value) {
                            setState(() => selectedMidterm = value ?? false);
                          }),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildCheckboxTile('기말 결과물', selectedFinal, (value) {
                            setState(() => selectedFinal = value ?? false);
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),

            // 하단 버튼들
            Row(
              children: [
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () async {
                      // 선택 다이얼로그 닫기
                      Navigator.of(context).pop();

                      // 로딩 다이얼로그 표시 및 context 저장
                      BuildContext? loadingDialogContext;
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (dialogContext) {
                          loadingDialogContext = dialogContext;
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            content: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'PDF 미리보기 준비 중',
                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                          font: GoogleFonts.openSans(
                                            fontWeight: FontWeight.w600,
                                          ),
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  SizedBox(height: 16),
                                  LinearProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text(
                                    FFAppState().downloadProgressMessage,
                                    style: FlutterFlowTheme.of(context).bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );

                      try {
                        // PDF 미리보기 생성
                        await actions.previewPdf(
                          year: widget.year,
                          semester: widget.semester,
                          courseName: widget.courseName,
                          professorName: widget.professorName,
                          grade: widget.grade,
                          section: widget.section,
                          classId: widget.classId,
                          selectedItems: {
                            'coursePlan': selectedCoursePlan,
                            'attendance': selectedAttendance,
                            'grade': selectedGrade,
                            'lectureMaterial': selectedLectureMaterial,
                            'weeklyProgress': selectedWeeklyProgress,
                            'studentEvaluation': selectedStudentEvaluation,
                            'midterm': selectedMidterm,
                            'final': selectedFinal,
                          },
                        );

                        // 로딩 다이얼로그 닫기 - 저장된 context 사용
                        if (loadingDialogContext != null && loadingDialogContext!.mounted) {
                          Navigator.of(loadingDialogContext!).pop();
                        }
                      } catch (e) {
                        print('미리보기 에러: $e');

                        // 에러 시에도 로딩 다이얼로그 닫기
                        if (loadingDialogContext != null && loadingDialogContext!.mounted) {
                          Navigator.of(loadingDialogContext!).pop();
                        }
                      }
                    },
                    text: '미리보기',
                    options: FFButtonOptions(
                      height: 48,
                      padding: EdgeInsets.zero,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14,
                          ),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () {
                      // 선택된 항목들을 Map으로 반환
                      Navigator.of(context).pop({
                        'coursePlan': selectedCoursePlan,
                        'attendance': selectedAttendance,
                        'grade': selectedGrade,
                        'lectureMaterial': selectedLectureMaterial,
                        'weeklyProgress': selectedWeeklyProgress,
                        'studentEvaluation': selectedStudentEvaluation,
                        'midterm': selectedMidterm,
                        'final': selectedFinal,
                      });
                    },
                    text: '선택 다운로드',
                    options: FFButtonOptions(
                      height: 48,
                      padding: EdgeInsets.zero,
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 14,
                          ),
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: FFButtonWidget(
                    onPressed: () {
                      // 모든 항목을 true로 설정하여 반환
                      Navigator.of(context).pop({
                        'coursePlan': true,
                        'attendance': true,
                        'grade': true,
                        'lectureMaterial': true,
                        'weeklyProgress': true,
                        'studentEvaluation': true,
                        'midterm': true,
                        'final': true,
                      });
                    },
                    text: '전체 다운로드',
                    options: FFButtonOptions(
                      height: 48,
                      padding: EdgeInsets.zero,
                      color: Color(0xFF284E75),
                      textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.openSans(
                              fontWeight: FontWeight.w600,
                            ),
                            color: Colors.white,
                            fontSize: 14,
                          ),
                      borderRadius: BorderRadius.circular(8),
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

  Widget _buildCheckboxTile(
    String label,
    bool value,
    Function(bool?) onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value ? Color(0xFF284E75) : FlutterFlowTheme.of(context).alternate,
            width: value ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: value ? Color(0xFF284E75) : Colors.transparent,
                border: Border.all(
                  color: value ? Color(0xFF284E75) : FlutterFlowTheme.of(context).alternate,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: value
                  ? Icon(
                      Icons.check,
                      size: 14,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.openSans(
                        fontWeight: value ? FontWeight.w600 : FontWeight.normal,
                      ),
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 13,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
