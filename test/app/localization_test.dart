import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:play_and_learn/app/app.dart';
import 'package:play_and_learn/app/app_dependencies.dart';
import 'package:play_and_learn/features/settings/presentation/settings_controller.dart';

import '../helpers/pump_preview_app.dart';

void main() {
  testWidgets('flags switch the interface, routes and settings both ways', (
    tester,
  ) async {
    final repository = await pumpPreviewApp(tester);
    expect(find.text('Trang chủ'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('language-en')));
    await tester.pumpAndSettle();
    expect(repository.languageCode, 'en');
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Eavesdropping Mouse'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('home-listening')));
    await tester.pumpAndSettle();
    expect(find.text('Are your ears ready?'), findsOneWidget);
    await reveal(tester, find.byKey(const ValueKey('game-listening-order')));
    expect(find.text('Get the Order Right'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('game-listening-order')));
    await tester.pumpAndSettle();
    expect(find.text('Mini-games will be added later.'), findsOneWidget);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    await openSettings(tester);
    expect(find.text('Language'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('language-vi')));
    await tester.pumpAndSettle();
    expect(find.text('Giảm chuyển động'), findsOneWidget);
    expect(repository.languageCode, 'vi');
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    tester
        .state<ScrollableState>(find.byType(Scrollable).first)
        .position
        .jumpTo(0);
    await tester.pumpAndSettle();
    expect(find.text('Góc của bạn.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('restores English before the first app frame', (tester) async {
    final repository = TestSettingsRepository()..languageCode = 'en';
    final settings = SettingsController(repository);
    await settings.load();
    await tester.pumpWidget(
      PlayAndLearnApp(dependencies: AppDependencies(settings: settings)),
    );
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).locale,
      const Locale('en'),
    );
  });

  testWidgets('failed language save reports an error and can retry', (
    tester,
  ) async {
    final repository = await pumpPreviewApp(tester);
    await openSettings(tester);
    repository.failWrite = true;
    await tester.tap(find.byKey(const ValueKey('language-en')));
    await tester.pumpAndSettle();
    await reveal(tester, find.text('Thử lại'));
    expect(
      find.text('Chưa lưu được thay đổi. Bạn có thể thử lại.'),
      findsOneWidget,
    );
    repository.failWrite = false;
    await tester.tap(find.text('Thử lại'));
    await tester.pumpAndSettle();
    expect(repository.languageCode, 'en');
    await reveal(tester, find.text('Reduce motion'));
    expect(find.text('Reduce motion'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  for (final language in ['vi', 'en']) {
    testWidgets('$language fits a small phone at double text size', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(320, 640);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
      await pumpPreviewApp(tester);
      await tester.tap(find.byKey(ValueKey('language-$language')));
      await tester.pumpAndSettle();
      expect(
        tester.getRect(find.byKey(ValueKey('language-$language'))).height,
        greaterThanOrEqualTo(48),
      );
      expect(tester.takeException(), isNull);
      await reveal(tester, find.byKey(const ValueKey('home-listening')));
      await tester.tap(find.byKey(const ValueKey('home-listening')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      await openSettings(tester);
      expect(tester.takeException(), isNull);
    });
  }
}
