import 'package:flutter/material.dart';

import 'scrollable_wrapper.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final bool enableHorizontalScroll;
  final bool enableVerticalScroll;

  const ResponsiveWrapper({
    Key? key,
    required this.child,
    this.maxWidth = 1200,
    this.enableHorizontalScroll = true,
    this.enableVerticalScroll = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ScrollableWrapper(
        fixedWidth: maxWidth,
        enableHorizontalScroll: enableHorizontalScroll,
        enableVerticalScroll: enableVerticalScroll,
        child: child,
      ),
    );
  }
}
