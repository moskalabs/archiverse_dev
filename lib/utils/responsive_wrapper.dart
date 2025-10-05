import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  
  const ResponsiveWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    
    print('💻 반응형 레이아웃 확인:');
    print('   화면: ${screenWidth.toInt()}x${screenHeight.toInt()}');
    print('   최소: 1400x800');
    
    // 모바일 (< 768px): 기본 모바일 레이아웃
    if (screenWidth < kBreakpointMedium) {
      print('📱 모바일 레이아웃 적용');
      return child;
    }
    
    // 가로 또는 세로 중 하나라도 최소 크기보다 작으면: 고정 레이아웃 + 스크롤
    final needsHorizontalScroll = screenWidth < 1400;
    final needsVerticalScroll = screenHeight < 800;
    
    if (needsHorizontalScroll || needsVerticalScroll) {
      print('🔒 고정 레이아웃 적용:');
      print('   가로 스크롤 필요: $needsHorizontalScroll');
      print('   세로 스크롤 필요: $needsVerticalScroll');
      
      Widget scrollableChild = Container(
        width: 1400,
        height: 800,
        child: child,
      );
      
      // 필요한 방향으로만 스크롤 추가
      if (needsHorizontalScroll && needsVerticalScroll) {
        print('가로 + 세로 스크롤 모두 적용');
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: scrollableChild,
          ),
        );
      } else if (needsHorizontalScroll) {
        print('가로 스크롤만 적용');
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: scrollableChild,
        );
      } else {
        print('세로 스크롤만 적용');
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: scrollableChild,
        );
      }
    }
    
    // 데스크톱 대형 (≥ 1400px & ≥ 800px): 반응형으로 화면 크기에 맞춰 확장
    print('🖥️ 반응형 레이아웃 적용 - 화면에 맞춰 확장');
    return child;
  }
}