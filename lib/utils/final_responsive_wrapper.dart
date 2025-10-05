import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FinalResponsiveWrapper extends StatelessWidget {
  final Widget child;
  
  const FinalResponsiveWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    
    print('📱 스크린 크기: ${screenWidth.toInt()}x${screenHeight.toInt()}');
    
    // 모바일은 그대로
    if (screenWidth < kBreakpointMedium) {
      print('📱 모바일 레이아웃 사용');
      return child;
    }
    
    // 스크롤 필요 여부 확인
    final needsHorizontalScroll = screenWidth < 1400;
    final needsVerticalScroll = screenHeight < 800;
    
    print('🔄 스크롤 필요: 가로=$needsHorizontalScroll, 세로=$needsVerticalScroll');
    
    Widget content = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 1400,
        minHeight: 800,
      ),
      child: child,
    );
    
    // 필요한 스크롤 적용
    if (needsHorizontalScroll && needsVerticalScroll) {
      print('↔️↕️ 양방향 스크롤 적용');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: content,
        ),
      );
    } else if (needsHorizontalScroll) {
      print('↔️ 가로 스크롤만 적용');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: content,
      );
    } else if (needsVerticalScroll) {
      print('↕️ 세로 스크롤만 적용');
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: content,
      );
    } else {
      print('🖥️ 완전 반응형 (스크롤 없음)');
      return content;
    }
  }
}