import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

/// Provides a scrollable container that keeps content within a fixed width on
/// web while remaining unobtrusive on mobile targets.
class ScrollableWrapper extends StatelessWidget {
  const ScrollableWrapper({
    super.key,
    required this.child,
    this.fixedWidth = 1280,
    this.alignment = Alignment.topCenter,
    this.padding,
    this.enableHorizontalScroll = true,
    this.enableVerticalScroll = true,
  });

  final Widget child;
  final double fixedWidth;
  final Alignment alignment;
  final EdgeInsetsGeometry? padding;
  final bool enableHorizontalScroll;
  final bool enableVerticalScroll;

  @override
  Widget build(BuildContext context) {
    Widget addPadding(Widget input) {
      if (padding == null) {
        return input;
      }
      return Padding(
        padding: padding!,
        child: input,
      );
    }

    if (!kIsWeb) {
      return addPadding(child);
    }

    final constrained = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: fixedWidth,
        maxWidth: fixedWidth,
      ),
      child: SizedBox(
        width: fixedWidth,
        child: child,
      ),
    );

    Widget content = Align(
      alignment: alignment,
      child: addPadding(constrained),
    );

    if (enableHorizontalScroll) {
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: content,
      );
    }

    if (!enableVerticalScroll) {
      return content;
    }

    return SingleChildScrollView(
      child: content,
    );
  }
}
