import 'package:flutter/material.dart';
import 'scrollable_wrapper.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollableWrapper(
      minWidth: 1400.0,
      minHeight: 800.0,
      child: child,
    );
  }
}