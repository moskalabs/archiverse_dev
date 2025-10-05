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
    
    // 모바일 (< 768px): 기본 모바일 레이아웃
    if (screenWidth < kBreakpointMedium) {
      return child;
    }
    
    // 가로/세로 독립적 처리
    final useFixedWidth = screenWidth < 1400;
    final useFixedHeight = screenHeight < 800;
    
    print('🔍 디버그 정보:');
    print('   화면: ${screenWidth.toInt()}x${screenHeight.toInt()}');
    print('   가로 고정: $useFixedWidth (< 1400)');
    print('   세로 고정: $useFixedHeight (< 800)');
    
    // 실제 사용할 크기 결정
    final containerWidth = useFixedWidth ? 1400.0 : null; // null이면 반응형
    final containerHeight = useFixedHeight ? 800.0 : null; // null이면 반응형
    
    Widget content;
    
    // 강제로 크기 고정
    if (useFixedWidth || useFixedHeight) {
      content = Container(
        width: containerWidth,
        height: containerHeight,
        constraints: BoxConstraints(
          minWidth: containerWidth ?? 0,
          maxWidth: containerWidth ?? double.infinity,
          minHeight: containerHeight ?? 0,
          maxHeight: containerHeight ?? double.infinity,
        ),
        child: child,
      );
    } else {
      content = child;
    }
    
    // 스크롤 적용 - 고정된 방향에만 스크롤
    if (useFixedWidth && useFixedHeight) {
      print('   → 가로+세로 스크롤 적용 (1400x800 고정)');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: content,
        ),
      );
    } else if (useFixedWidth) {
      print('   → 가로 스크롤만 적용 (1400x반응형)');
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: content,
      );
    } else if (useFixedHeight) {
      print('   → 세로 스크롤만 적용 (반응형x800)');
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: content,
      );
    } else {
      print('   → 완전 반응형 (스크롤 없음)');
      return child;
    }
  }
}