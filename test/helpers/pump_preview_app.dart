import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_and_learn/app/app.dart';
import 'package:play_and_learn/app/app_dependencies.dart';
import 'package:play_and_learn/features/settings/data/settings_repository.dart';
import 'package:play_and_learn/features/settings/presentation/settings_controller.dart';

class TestSettingsRepository implements SettingsRepository {
  bool value = false;
  bool failWrite = false;
  @override
  Future<bool> readReduceMotion() async => value;
  @override
  Future<void> writeReduceMotion(bool next) async {
    if (failWrite) throw StateError('disk full');
    value = next;
  }
}

Future<TestSettingsRepository> pumpPreviewApp(WidgetTester tester) async {
  final repository = TestSettingsRepository();
  final settings = SettingsController(repository);
  await settings.load();
  await tester.pumpWidget(
    PlayAndLearnApp(dependencies: AppDependencies(settings: settings)),
  );
  await tester.pumpAndSettle();
  return repository;
}

Future<void> openSettings(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('tab-2')));
  await tester.pumpAndSettle();
  await reveal(tester, find.byKey(const ValueKey('open-settings')));
  await tester.tap(find.byKey(const ValueKey('open-settings')));
  await tester.pumpAndSettle();
}

Future<void> reveal(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    160,
    scrollable: find.byType(Scrollable).first,
    maxScrolls: 80,
  );
  await tester.pumpAndSettle();
}
