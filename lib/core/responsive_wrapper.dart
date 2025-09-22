import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.minWidth = 1200,
  });

  final Widget child;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < 600) {
      return child;
    }

    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: minWidth,
            minHeight: size.height,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              width: minWidth,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
