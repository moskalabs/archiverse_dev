import 'package:flutter/material.dart';

/// Provides a fixed-width layout container for every page body so that the
/// desktop experience is no longer dependent on responsive breakpoints.
class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = 1280,
    this.alignment = Alignment.topCenter,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final Alignment alignment;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        width: double.infinity,
        padding: padding,
        alignment: alignment,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: child,
        ),
      ),
    );
  }
}
