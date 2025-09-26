import 'package:flutter/material.dart';

class ZoomableWrapper extends StatelessWidget {
  final Widget child;
  final double minScale;
  final double maxScale;

  const ZoomableWrapper({
    Key? key,
    required this.child,
    this.minScale = 0.5,
    this.maxScale = 3.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      minScale: minScale,
      maxScale: maxScale,
      boundaryMargin: const EdgeInsets.all(double.infinity),
      child: child,
    );
  }
}
