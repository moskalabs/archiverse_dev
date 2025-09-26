import 'package:flutter/material.dart';

class ScrollableWrapper extends StatelessWidget {
  final Widget child;
  final double fixedWidth;
  final bool enableHorizontalScroll;
  final bool enableVerticalScroll;

  const ScrollableWrapper({
    Key? key,
    required this.child,
    this.fixedWidth = 1200,
    this.enableHorizontalScroll = true,
    this.enableVerticalScroll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      width: fixedWidth,
      constraints: BoxConstraints(minWidth: fixedWidth),
      child: child,
    );

    if (enableVerticalScroll && enableHorizontalScroll) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: content,
        ),
      );
    } else if (enableHorizontalScroll) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: content,
      );
    } else if (enableVerticalScroll) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: content,
      );
    }

    return content;
  }
}
