import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'professor_right_layout_model.dart';
export 'professor_right_layout_model.dart';

class ProfessorRightLayoutWidget extends StatefulWidget {
  const ProfessorRightLayoutWidget({
    super.key,
    this.academicRecords = const [],
    this.teachingRecords = const [],
    this.specialtyFields = const [],
  });

  final List<dynamic> academicRecords;
  final List<dynamic> teachingRecords; 
  final List<String> specialtyFields;

  @override
  State<ProfessorRightLayoutWidget> createState() => _ProfessorRightLayoutWidgetState();
}

class _ProfessorRightLayoutWidgetState extends State<ProfessorRightLayoutWidget> {
  late ProfessorRightLayoutModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfessorRightLayoutModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  // 통일된 폰트 크기 (왼쪽 설계분야, 구조분야와 동일)
  double _getSectionTitleFontSize() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth < kBreakpointSmall) return 12.0;
    if (screenWidth < kBreakpointMedium) return 14.0;
    if (screenWidth < kBreakpointLarge) return 14.0;
    return 14.0; // 데스크탑 - 섹션 타이틀도 약간 작게
  }

  double _getContentFontSize() {
    final screenWidth = MediaQuery.sizeOf(context).width;
    if (screenWidth < kBreakpointSmall) return 10.0;
    if (screenWidth < kBreakpointMedium) return 12.0;
    if (screenWidth < kBreakpointLarge) return 12.0;
    return 12.0; // 데스크탑 - 더 작게 조정
  }

  // 동적 높이 계산 (row 수 기반)
  double _calculateSectionHeight(int rowCount) {
    final baseHeight = 60.0; // 헤더 높이
    final rowHeight = 40.0;  // 각 row 높이
    final padding = 16.0;    // 패딩
    return baseHeight + (rowCount * rowHeight) + padding;
  }

  // 섹션 타이틀 위젯
  Widget _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Color(0xFF284E75),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      child: Text(
        title,
        style: FlutterFlowTheme.of(context).titleMedium.override(
          font: GoogleFonts.openSans(
            fontWeight: FontWeight.w600,
          ),
          color: Colors.white,
          fontSize: _getSectionTitleFontSize(),
          letterSpacing: 0.0,
        ),
      ),
    );
  }

  // 섹션 컨테이너 위젯
  Widget _buildSectionContainer({
    required String title,
    required Widget content,
    required int rowCount,
  }) {
    return Container(
      height: _calculateSectionHeight(rowCount),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionTitle(title),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 학력 섹션 콘텐츠
  Widget _buildAcademicContent() {
    return Column(
      children: widget.academicRecords.map<Widget>((record) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  record['getDate'] ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: _getContentFontSize(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  record['university'] ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: _getContentFontSize(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  record['degree'] ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: _getContentFontSize(),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // 강사경력 섹션 콘텐츠
  Widget _buildTeachingContent() {
    return Column(
      children: widget.teachingRecords.map<Widget>((record) {
        return Container(
          margin: EdgeInsets.only(bottom: 8.0),
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  record['period'] ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: _getContentFontSize(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  record['university'] ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: _getContentFontSize(),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  record['subject'] ?? '',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontSize: _getContentFontSize(),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // 전문분야 섹션 콘텐츠
  Widget _buildSpecialtyContent() {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: widget.specialtyFields.map<Widget>((field) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Color(0xFF284E75),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Text(
            field,
            style: FlutterFlowTheme.of(context).bodySmall.override(
              fontSize: _getContentFontSize(),
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 70% 좌측 그룹
          Expanded(
            flex: 7,
            child: Column(
              children: [
                // 학력설정 섹션
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _buildSectionContainer(
                      title: '학력 설정',
                      content: _buildAcademicContent(),
                      rowCount: widget.academicRecords.length,
                    ),
                  ),
                ),
                // 강사경력 섹션
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _buildSectionContainer(
                      title: '강사 경력',
                      content: _buildTeachingContent(),
                      rowCount: widget.teachingRecords.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 30% 우측 그룹
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _buildSectionContainer(
                title: '전문 분야',
                content: _buildSpecialtyContent(),
                rowCount: (widget.specialtyFields.length / 3).ceil(), // 3개씩 한 줄로 가정
              ),
            ),
          ),
        ],
      ),
    );
  }
}