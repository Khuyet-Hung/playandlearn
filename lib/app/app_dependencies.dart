import '../features/settings/presentation/settings_controller.dart';

/// Dependencies have one owner: PlayAndLearnApp disposes its settings controller.
class AppDependencies {
  const AppDependencies({required this.settings});
  final SettingsController settings;
}
