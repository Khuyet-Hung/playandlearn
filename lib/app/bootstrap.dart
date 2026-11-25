import 'package:flutter/widgets.dart';

import '../features/settings/data/settings_repository.dart';
import '../features/settings/presentation/settings_controller.dart';
import 'app.dart';
import 'app_dependencies.dart';

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsController(PreferencesSettingsRepository());
  await settings.load();
  runApp(PlayAndLearnApp(dependencies: AppDependencies(settings: settings)));
}
