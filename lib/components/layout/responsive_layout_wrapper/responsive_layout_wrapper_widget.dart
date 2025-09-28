import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResponsiveLayoutWrapperWidget extends StatelessWidget {
  const ResponsiveLayoutWrapperWidget({
    super.key,
    required this.child,
    this.minDesktopWidth = 1400.0,
    this.enableHorizontalScroll = true,
  });

  final Widget child;
  final double minDesktopWidth;
  final bool enableHorizontalScroll;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final minHeight = 800.0;
    
    // 모바일은 기존 반응형 유지 (768px 이하)
    if (screenWidth <= kBreakpointSmall) {
      return child;
    }
    
    // 웹/데스크탑: 고정 레이아웃 (1400px x 800px 최소)
    final needsHorizontalScroll = screenWidth < minDesktopWidth;
    final needsVerticalScroll = screenHeight < minHeight;
    
    debugPrint('💻 고정 레이아웃 적용:');
    debugPrint('   화면: ${screenWidth}x${screenHeight}');
    debugPrint('   최소: ${minDesktopWidth}x${minHeight}');
    debugPrint('   가로 스크롤 필요: $needsHorizontalScroll');
    debugPrint('   세로 스크롤 필요: $needsVerticalScroll');
    
    // 고정 크기 컨텐츠 만들기
    Widget fixedContent = SizedBox(
      width: minDesktopWidth,
      height: minHeight,
      child: child,
    );
    
    // 스크롤 적용 전략
    if (needsVerticalScroll && needsHorizontalScroll) {
      debugPrint('가로 + 세로 스크롤 모두 적용');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: fixedContent,
        ),
      );
    } else if (needsHorizontalScroll) {
      debugPrint('가로 스크롤만 적용');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: fixedContent,
      );
    } else if (needsVerticalScroll) {
      debugPrint('세로 스크롤만 적용');
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: fixedContent,
      );
    } else {
      debugPrint('스크롤 필요 없음');
      return fixedContent;
    }
  }
}