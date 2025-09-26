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
    if (!kIsWeb) {
      // Mobile and desktop builds outside the web target should keep the
      // original layout behaviour.
      return padding != null ? Padding(padding: padding!, child: child) : child;
    }

    Widget constrainedChild = SizedBox(
      width: fixedWidth,
      child: child,
    );

    Widget wrapped = Align(
      alignment: alignment,
      child: constrainedChild,
    );

    if (enableHorizontalScroll) {
      wrapped = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Align(
          alignment: alignment,
          child: constrainedChild,
        ),
      );
    }

    if (enableVerticalScroll) {
      wrapped = LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: padding ?? EdgeInsets.zero,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: wrapped,
            ),
          );
        },
      );
    } else if (padding != null) {
      wrapped = Padding(
        padding: padding!,
        child: wrapped,
      );
    }

    return wrapped;
  }
}
