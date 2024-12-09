import 'package:flutter/material.dart';

import '../../core/util/time_util.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  static const BoxDecoration dayGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF87CEFA),
        Color(0xFFB0E0E6),
        Color(0xFFFFFFFF),
      ],
      stops: [0.0, 0.7, 1.0],
    ),
  );

  static const BoxDecoration nightGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF0B0D39),
        Color(0xFF1C1C4D),
        Color(0xFF4A4A7D),
      ],
      stops: [0.0, 0.6, 1.0],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final bool isDayTime = TimeUtils.isDayTime();
    return Container(
      decoration: isDayTime ? dayGradient : nightGradient,
      child: SafeArea(
        child: child,
      ),
    );
  }
}
