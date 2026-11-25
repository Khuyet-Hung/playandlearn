import 'package:material_ui/material_ui.dart';

import '../../core/motion/motion_scope.dart';
import '../../features/settings/presentation/settings_controller.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/skills/domain/skill.dart';
import '../../features/skills/presentation/skill_detail_screen.dart';

/// One router per shell; guards repeated taps until the pushed page is closed.
class AppRoutes {
  bool _opening = false;

  Future<void> openSkill(BuildContext context, Skill skill) =>
      _push(context, SkillDetailScreen(skill: skill));

  Future<void> openSettings(
    BuildContext context,
    SettingsController controller,
  ) => _push(context, SettingsScreen(controller: controller));

  Future<void> _push(BuildContext context, Widget screen) async {
    if (_opening) return;
    _opening = true;
    try {
      await Navigator.of(context).push<void>(
        PageRouteBuilder<void>(
          transitionDuration: MotionScope.durationOf(context, 220),
          reverseTransitionDuration: MotionScope.durationOf(context, 180),
          pageBuilder: (context, animation, secondaryAnimation) => screen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (MotionScope.reducedOf(context)) return child;
            final curve = animation.drive(
              CurveTween(curve: Curves.easeOutCubic),
            );
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(curve),
                child: child,
              ),
            );
          },
        ),
      );
    } finally {
      _opening = false;
    }
  }
}
