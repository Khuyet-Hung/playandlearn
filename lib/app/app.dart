import 'package:material_ui/material_ui.dart';

import '../core/motion/motion_scope.dart';
import '../core/theme/app_theme.dart';
import 'app_dependencies.dart';
import 'shell/app_shell.dart';

class PlayAndLearnApp extends StatefulWidget {
  const PlayAndLearnApp({super.key, required this.dependencies});
  final AppDependencies dependencies;
  @override
  State<PlayAndLearnApp> createState() => _PlayAndLearnAppState();
}

class _PlayAndLearnAppState extends State<PlayAndLearnApp> {
  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: widget.dependencies.settings,
    builder: (context, _) => MaterialApp(
      title: 'Play & Learn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      builder: (context, child) => MotionScope(
        reduceMotion: widget.dependencies.settings.reduceMotion,
        child: child ?? const SizedBox.shrink(),
      ),
      home: AppShell(settings: widget.dependencies.settings),
    ),
  );

  @override
  void dispose() {
    widget.dependencies.settings.dispose();
    super.dispose();
  }
}
