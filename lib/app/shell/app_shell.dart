import 'package:material_ui/material_ui.dart';

import '../../core/motion/motion_scope.dart';
import '../../core/widgets/app_bottom_nav.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/settings/presentation/settings_controller.dart';
import '../../features/skills/presentation/skills_screen.dart';
import '../navigation/app_routes.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.settings});
  final SettingsController settings;
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell>
    with SingleTickerProviderStateMixin {
  final _routes = AppRoutes();
  int _selectedIndex = 0;
  late final _fade = AnimationController(vsync: this, value: 1);
  late final List<Widget> _screens = [
    HomeScreen(
      onExplore: () => _select(1),
      onOpenSkill: (skill) => _routes.openSkill(context, skill),
    ),
    SkillsScreen(onOpenSkill: (skill) => _routes.openSkill(context, skill)),
    ProfileScreen(
      onOpenSettings: () => _routes.openSettings(context, widget.settings),
    ),
  ];

  void _select(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);
    _fade.duration = MotionScope.durationOf(context, 180);
    if (MotionScope.reducedOf(context)) {
      _fade.value = 1;
    } else {
      _fade.forward(from: 0);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MotionScope.reducedOf(context)) _fade.value = 1;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      bottom: false,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Stack(
            fit: StackFit.expand,
            children: [
              for (var i = 0; i < _screens.length; i++)
                Offstage(
                  offstage: i != _selectedIndex,
                  child: ExcludeFocus(
                    excluding: i != _selectedIndex,
                    child: TickerMode(
                      enabled: i == _selectedIndex,
                      child: FadeTransition(
                        opacity: i == _selectedIndex
                            ? _fade
                            : const AlwaysStoppedAnimation(1),
                        child: _screens[i],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ),
    bottomNavigationBar: AppBottomNav(
      selectedIndex: _selectedIndex,
      onSelected: _select,
    ),
  );

  @override
  void dispose() {
    _fade.dispose();
    super.dispose();
  }
}
