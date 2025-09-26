import 'package:flutter/material.dart';

import 'scrollable_wrapper.dart';

/// Provides a fixed-width layout container for every page body so that the
/// desktop experience is no longer dependent on responsive breakpoints while
/// still allowing the content to scroll when it exceeds the viewport.
class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = 1280,
    this.alignment = Alignment.topCenter,
    this.padding,
    this.enableHorizontalScroll = true,
    this.enableVerticalScroll = true,
  });

  final Widget child;
  final double maxWidth;
  final Alignment alignment;
  final EdgeInsetsGeometry? padding;
  final bool enableHorizontalScroll;
  final bool enableVerticalScroll;

  @override
  Widget build(BuildContext context) {
    return ScrollableWrapper(
      child: child,
      fixedWidth: maxWidth,
      alignment: alignment,
      padding: padding,
      enableHorizontalScroll: enableHorizontalScroll,
      enableVerticalScroll: enableVerticalScroll,
    );
  }
}
