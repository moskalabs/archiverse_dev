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

    final constrainedChild = ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: fixedWidth,
        maxWidth: fixedWidth,
      ),
      child: child,
    );

    final paddedChild = padding != null
        ? Padding(
            padding: padding!,
            child: constrainedChild,
          )
        : constrainedChild;

    final alignedChild = Align(
      alignment: alignment,
      child: paddedChild,
    );

    final horizontalWrapped = enableHorizontalScroll
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Align(
              alignment: alignment,
              child: paddedChild,
            ),
          )
        : alignedChild;

    if (!enableVerticalScroll) {
      return horizontalWrapped;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: horizontalWrapped,
          ),
        );
      },
    );
  }
}
