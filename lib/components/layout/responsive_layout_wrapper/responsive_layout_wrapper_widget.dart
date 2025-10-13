import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:html' as html show document;

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
    
    print('\n=== ResponsiveLayoutWrapper START ===');
    print('Platform: ${kIsWeb ? "WEB" : "MOBILE"}');
    print('Screen: ${screenWidth.toInt()}px x ${screenHeight.toInt()}px');
    print('Mobile threshold: 768px');
    print('Desktop threshold: 1400px');
    
    // 모바일 기준: 가로 AND 세로 둘 다 768px 이하
    if (!kIsWeb || (screenWidth <= 768 && screenHeight <= 768)) {
      print('-> MOBILE MODE: 가로:${screenWidth}px, 세로:${screenHeight}px - 기존 레이아웃 유지');
      print('=== ResponsiveLayoutWrapper END ===\n');
      return child;
    }
    
    // 웹에서만 작동
    print('-> WEB MODE: 고정 레이아웃 적용');

    // 가로/세로 스크롤 필요 여부를 독립적으로 판단
    final bool needHorizontalScroll = screenWidth < 1400;
    final bool needVerticalScroll = screenHeight < 800;

    print('가로 스크롤 필요: $needHorizontalScroll (${screenWidth}px < 1400px)');
    print('세로 스크롤 필요: $needVerticalScroll (${screenHeight}px < 800px)');

    // 둘 다 스크롤 필요
    if (needHorizontalScroll && needVerticalScroll) {
      print('-> 🚀 가로+세로 양방향 스크롤 적용!');
      print('=== ResponsiveLayoutWrapper END ===\n');

      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.purple.withOpacity(0.3),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
            child: Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
                child: Container(
                  width: 1400.0,
                  height: 800.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 5),
                    color: Colors.purple.withOpacity(0.1),
                  ),
                  child: MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      size: Size(1400.0, 800.0),
                    ),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // 가로만 스크롤 필요
    if (needHorizontalScroll) {
      print('-> 🚀 가로 스크롤만 적용! (${screenWidth}px < 1400px)');
      print('=== ResponsiveLayoutWrapper END ===\n');

      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.orange.withOpacity(0.3),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: 1400.0,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 5),
                color: Colors.red.withOpacity(0.1),
              ),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  size: Size(1400.0, screenHeight),
                ),
                child: child,
              ),
            ),
          ),
        ),
      );
    }

    // 세로만 스크롤 필요
    if (needVerticalScroll) {
      print('-> 🚀 세로 스크롤만 적용! (${screenHeight}px < 800px)');
      print('=== ResponsiveLayoutWrapper END ===\n');

      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.yellow.withOpacity(0.3),
        child: Scrollbar(
          thumbVisibility: true,
          trackVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              height: 800.0,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 5),
                color: Colors.green.withOpacity(0.1),
              ),
              child: MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  size: Size(screenWidth, 800.0),
                ),
                child: child,
              ),
            ),
          ),
        ),
      );
    }

    print('-> RESPONSIVE MODE: 스크롤 없음 (${screenWidth}px x ${screenHeight}px)');
    print('=== ResponsiveLayoutWrapper END ===\n');
    return child;
  }
}
