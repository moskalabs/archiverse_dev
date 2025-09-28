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
    
    // 항상 디버깅 정보 표시
    debugPrint('🔍 ResponsiveLayoutWrapper 호출됨!');
    debugPrint('   screenWidth: $screenWidth');
    debugPrint('   minDesktopWidth: $minDesktopWidth');
    debugPrint('   kBreakpointSmall: $kBreakpointSmall');
    
    // 모바일/태블릿은 기존 반응형 유지 (768px 이하)
    if (screenWidth <= kBreakpointSmall) {
      debugPrint('📱 모바일 모드: 기존 반응형 유지');
      return child;
    }
    
    // 웹/데스크탑(768px 초과)에서 화면이 1400px보다 작으면 가로 스크롤
    if (enableHorizontalScroll && screenWidth > kBreakpointSmall && screenWidth < minDesktopWidth) {
      debugPrint('💻 데스크탑 스크롤 모드: 가로 스크롤 활성화');
      
      return Scrollbar(
        thumbVisibility: true,
        trackVisibility: false,
        thickness: 8.0,
        radius: Radius.circular(4.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Scrollbar(
            thumbVisibility: true,
            trackVisibility: false, 
            thickness: 8.0,
            radius: Radius.circular(4.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Container(
                width: minDesktopWidth,
                constraints: BoxConstraints(
                  minHeight: MediaQuery.sizeOf(context).height,
                ),
                child: child,
              ),
            ),
          ),
        ),
      );
    }
    
    // 충분한 화면 크기(1400px 이상)일 때는 최소 width만 보장
    debugPrint('🖥️  데스크탑 일반 모드: 최소 width 보장');
    return Container(
      constraints: BoxConstraints(
        minWidth: minDesktopWidth,
      ),
      child: child,
    );
  }
}