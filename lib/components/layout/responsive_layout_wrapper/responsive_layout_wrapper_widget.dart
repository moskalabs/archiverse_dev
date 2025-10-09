import 'package:flutter/foundation.dart' show kIsWeb;
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
    
    print('=== ResponsiveLayoutWrapper ===');
    print('화면: ${screenWidth}px x ${screenHeight}px');
    
    // 모바일: 가로 AND 세로 둘 다 768px 이하
    if (!kIsWeb || (screenWidth <= 768 && screenHeight <= 768)) {
      print('모바일 모드: 기존 레이아웃');
      return child;
    }
    
    // 1400px 미만: 1400px x 800px 고정 레이아웃 + 가로 스크롤
    if (screenWidth < 1400) {
      print('🔴 1400px 고정 레이아웃 + 가로 스크롤');
      
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: 1400.0, // 고정 너비
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 3),
          ),
          child: MediaQuery(
            // 내부 컴포너트들에게 1500px 데스크톱이라고 완전히 속이기
            data: MediaQuery.of(context).copyWith(
              size: Size(1500.0, 1000.0), // 1400px보다 큰 가짜 화면
            ),
            child: child,
          ),
        ),
      );
    }
    
    // 800px 미만: 1400px x 800px 고정 레이아웃 + 세로 스크롤
    if (screenHeight < 800) {
      print('🟢 800px 고정 레이아웃 + 세로 스크롤');
      
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: double.infinity,
          height: 800.0, // 고정 높이
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 3),
          ),
          child: MediaQuery(
            // 내부 컴포너트들에게 1500px 데스크톱이라고 완전히 속이기
            data: MediaQuery.of(context).copyWith(
              size: Size(1500.0, 1000.0), // 가짜 큰 화면
            ),
            child: child,
          ),
        ),
      );
    }
    
    print('반응형 모드: 스크롤 없음');
    return child;
  }
}
