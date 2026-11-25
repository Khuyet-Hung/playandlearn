import 'package:material_ui/material_ui.dart';

import '../motion/motion_scope.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

/// Shared raised surface: pointer, keyboard, focus and accessibility activation.
class AppPressable extends StatefulWidget {
  const AppPressable({
    super.key,
    required this.child,
    required this.label,
    this.onPressed,
    this.color = AppColors.surface,
    this.padding = const EdgeInsets.all(18),
  });

  final Widget child;
  final String label;
  final VoidCallback? onPressed;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  State<AppPressable> createState() => _AppPressableState();
}

class _AppPressableState extends State<AppPressable> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onPressed != null;
    final pressed = _pressed && enabled && !MotionScope.reducedOf(context);
    final radius = BorderRadius.circular(AppTokens.radius);
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      onTap: widget.onPressed,
      child: ExcludeSemantics(
        child: Padding(
          padding: const EdgeInsets.only(right: 4, bottom: 4),
          child: AnimatedContainer(
            duration: MotionScope.durationOf(context, 120),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(
              pressed ? 3 : 0,
              pressed ? 3 : 0,
              0,
            ),
            decoration: BoxDecoration(
              color: enabled ? widget.color : AppColors.background,
              borderRadius: radius,
              border: AppTokens.border,
              boxShadow: [
                BoxShadow(
                  color: AppColors.ink,
                  offset: pressed ? const Offset(1, 1) : AppTokens.shadowOffset,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: radius,
              child: InkWell(
                onTap: widget.onPressed,
                onHighlightChanged: (value) {
                  if (mounted) setState(() => _pressed = value);
                },
                borderRadius: radius,
                splashColor: AppColors.ink.withValues(alpha: 0.08),
                focusColor: AppColors.blue.withValues(alpha: 0.25),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 48,
                    minWidth: 48,
                  ),
                  child: Padding(padding: widget.padding, child: widget.child),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
