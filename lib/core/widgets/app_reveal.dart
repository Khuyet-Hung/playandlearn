import 'package:flutter/widgets.dart';

import '../motion/motion_scope.dart';

class AppReveal extends StatefulWidget {
  const AppReveal({super.key, required this.child});
  final Widget child;
  @override
  State<AppReveal> createState() => _AppRevealState();
}

class _AppRevealState extends State<AppReveal>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 240),
  );
  late final _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );
  bool _started = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MotionScope.reducedOf(context)) {
      _controller.value = 1;
      _started = true;
    } else if (!_started && TickerMode.valuesOf(context).enabled) {
      _started = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _curve,
    child: SlideTransition(
      position: Tween(
        begin: const Offset(0, 0.025),
        end: Offset.zero,
      ).animate(_curve),
      child: widget.child,
    ),
  );

  @override
  void dispose() {
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }
}
