import 'package:flutter/material.dart';
import 'package:donnymaestro/core/constant/colors.dart';

/// Continuous animated scan line that sweeps top → bottom repeatedly.
/// Requires StatefulWidget because AnimationController needs a TickerProvider.
class ScanLineOverlay extends StatefulWidget {
  const ScanLineOverlay({super.key});

  @override
  State<ScanLineOverlay> createState() => _ScanLineOverlayState();
}

class _ScanLineOverlayState extends State<ScanLineOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) => Positioned(
        top: _anim.value * MediaQuery.of(context).size.height,
        left: 0,
        right: 0,
        height: 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                AppColor.primary400.withValues(alpha: 0.85),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
