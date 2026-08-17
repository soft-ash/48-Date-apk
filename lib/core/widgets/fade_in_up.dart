import 'package:flutter/material.dart';

class FadeInUp extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double distance;

  const FadeInUp({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.distance = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    final totalDuration = duration + delay;
    final delayFraction = totalDuration.inMilliseconds > 0
        ? delay.inMilliseconds / totalDuration.inMilliseconds
        : 0.0;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: totalDuration,
      curve: Interval(delayFraction, 1.0, curve: Curves.easeOutCubic),
      builder: (context, value, childWidget) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, distance * (1 - value)),
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}
