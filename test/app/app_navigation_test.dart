import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_and_learn/features/skills/presentation/skill_detail_screen.dart';

import '../helpers/pump_preview_app.dart';

void main() {
  testWidgets(
    'home opens one detail after rapid taps and system back returns home',
    (tester) async {
      await pumpPreviewApp(tester);
      final skill = find.byKey(const ValueKey('home-listening'));
      await tester.tap(skill);
      await tester.tap(skill, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byType(SkillDetailScreen), findsOneWidget);
      expect(find.text('Listening'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(SkillDetailScreen), findsNothing);
      expect(find.byKey(const ValueKey('home-layout')), findsOneWidget);
    },
  );

  testWidgets(
    'skills tab opens catalog and coming-soon game explains its status',
    (tester) async {
      await pumpPreviewApp(tester);
      await tester.tap(find.byKey(const ValueKey('tab-1')));
      await tester.pumpAndSettle();
      final skill = find.byKey(const ValueKey('catalog-listening'));
      await tester.tap(skill);
      await tester.pumpAndSettle();
      final game = find.byKey(const ValueKey('game-listening-order'));
      await reveal(tester, game);
      await tester.tap(game);
      await tester.pumpAndSettle();
      expect(find.byType(SkillDetailScreen), findsOneWidget);
      expect(find.text('Mini-game sẽ được bổ sung sau.'), findsOneWidget);
    },
  );

  for (final size in [
    const Size(334, 720),
    const Size(320, 640),
    const Size(407, 820),
  ]) {
    testWidgets('home fits $size without scrolling and keeps cards visible', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await pumpPreviewApp(tester);
      final home = find.byKey(const ValueKey('home-layout'));
      expect(
        find.descendant(of: home, matching: find.byType(Scrollable)),
        findsNothing,
      );
      expect(find.text('CHỌN BẠN HỌC'), findsNothing);
      expect(find.byKey(const ValueKey('explore-skills')), findsNothing);
      final cards = ['listening', 'speaking', 'reading', 'writing'];
      final before = <Rect>[];
      for (final id in cards) {
        final card = find.byKey(ValueKey('home-$id'));
        final rect = tester.getRect(card);
        expect(rect.top, greaterThanOrEqualTo(0));
        expect(
          rect.bottom,
          lessThanOrEqualTo(
            tester.getTopLeft(find.byKey(const ValueKey('tab-0'))).dy,
          ),
        );
        expect(card.hitTestable(), findsOneWidget);
        before.add(rect);
      }
      await tester.drag(home, const Offset(0, -200));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('tab-1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('tab-0')));
      await tester.pumpAndSettle();
      for (var i = 0; i < cards.length; i++) {
        expect(
          tester.getRect(find.byKey(ValueKey('home-${cards[i]}'))),
          before[i],
        );
      }
      expect(tester.takeException(), isNull);
    });
  }
  testWidgets(
    'failed settings save is visible and retry saves the requested value',
    (tester) async {
      final repository = await pumpPreviewApp(tester);
      repository.failWrite = true;
      await openSettings(tester);
      await reveal(tester, find.byType(Switch));
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(tester.widget<Switch>(find.byType(Switch)).value, isFalse);
      expect(find.text('Thử lại'), findsOneWidget);
      repository.failWrite = false;
      await reveal(tester, find.text('Thử lại'));
      await tester.tap(find.text('Thử lại'));
      await tester.pumpAndSettle();
      expect(tester.widget<Switch>(find.byType(Switch)).value, isTrue);
      expect(repository.value, isTrue);
    },
  );
}
