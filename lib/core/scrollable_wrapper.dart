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

    // 모바일은 기존 반응형 유지
    if (!kIsWeb || screenWidth <= kBreakpointSmall) {
      return child;
    }

    // 웹에서 스크롤 처리
    final needsHScroll = screenWidth < minWidth;
    final needsVScroll = screenHeight < minHeight;

    Widget content = child;

    // 더 강력한 스크롤 처리
    if (needsHScroll && needsVScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            width: minWidth,
            height: minHeight,
            child: child,
          ),
        ),
      );
    } else if (needsHScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          width: minWidth,
          child: child,
        ),
      );
    } else if (needsVScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          height: minHeight,
          child: child,
        ),
      );
    }

    return content;
  }
}
