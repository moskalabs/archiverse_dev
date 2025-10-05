import 'package:flutter/material.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SimpleResponsiveWrapper extends StatelessWidget {
  final Widget child;
  
  const SimpleResponsiveWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    
    // 모바일은 그대로
    if (screenWidth < kBreakpointMedium) {
      return child;
    }
    
    // 데스크톱에서 최소 크기 보장
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 1400,
        minHeight: 800,
      ),
      child: child,
    );
  }
}