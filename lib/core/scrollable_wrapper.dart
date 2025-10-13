import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ScrollableWrapper extends StatelessWidget {
  const ScrollableWrapper({
    super.key,
    required this.child,
    this.minWidth = 1400.0,
    this.minHeight = 800.0,
  });

  final Widget child;
  final double minWidth;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    
    print('=== ScrollableWrapper ===');
    print('화면 크기: ${screenWidth}px x ${screenHeight}px');
    print('최소 크기: ${minWidth}px x ${minHeight}px');
    print('플랫폼: ${kIsWeb ? "웹" : "모바일"}');
    
    // 모바일은 기존 반응형 유지
    if (!kIsWeb || screenWidth <= kBreakpointSmall) {
      print('모바일 모드: 기존 레이아웃 유지');
      return child;
    }
    
    // 웹에서 스크롤 처리
    final needsHScroll = screenWidth < minWidth;
    final needsVScroll = screenHeight < minHeight;
    
    print('가로 스크롤 필요: $needsHScroll');
    print('세로 스크롤 필요: $needsVScroll');
    
    Widget content = child;
    
    // 더 강력한 스크롤 처리
    if (needsHScroll && needsVScroll) {
      print('가로+세로 스크롤 모두 적용 - 이중 래핑');
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, 
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: minWidth,
            height: minHeight,
            color: Colors.red.withOpacity(0.1), // 디버깅용 색상
            child: child,
          ),
        ),
      );
    } else if (needsHScroll) {
      print('가로 스크롤만 적용');
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: minWidth,
          color: Colors.blue.withOpacity(0.1), // 디버깅용 색상
          child: child,
        ),
      );
    } else if (needsVScroll) {
      print('세로 스크롤만 적용');
      content = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: minHeight,
          color: Colors.green.withOpacity(0.1), // 디버깅용 색상
          child: child,
        ),
      );
    }
    
    return content;
  }
}