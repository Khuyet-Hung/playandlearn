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
      await reveal(tester, skill);
      await tester.tap(skill);
      await tester.tap(skill, warnIfMissed: false);
      await tester.pumpAndSettle();
      expect(find.byType(SkillDetailScreen), findsOneWidget);
      expect(find.text('Listening'), findsOneWidget);
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.byType(SkillDetailScreen), findsNothing);
      expect(find.byKey(const PageStorageKey('home-scroll')), findsOneWidget);
    },
  );

  testWidgets(
    'explore selects skills and coming-soon game explains its status',
    (tester) async {
      await pumpPreviewApp(tester);
      await reveal(tester, find.byKey(const ValueKey('explore-skills')));
      await tester.tap(find.byKey(const ValueKey('explore-skills')));
      await tester.pumpAndSettle();
      final skill = find.byKey(const ValueKey('catalog-listening'));
      await reveal(tester, skill);
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

  testWidgets('switching tabs preserves home scroll position', (tester) async {
    await pumpPreviewApp(tester);
    final scroll = find.byKey(const PageStorageKey('home-scroll'));
    await tester.drag(scroll, const Offset(0, -260));
    await tester.pumpAndSettle();
    final before = tester
        .state<ScrollableState>(
          find.descendant(of: scroll, matching: find.byType(Scrollable)).first,
        )
        .position
        .pixels;
    expect(before, greaterThan(0));
    await tester.tap(find.byKey(const ValueKey('tab-1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('tab-0')));
    await tester.pumpAndSettle();
    final after = tester
        .state<ScrollableState>(
          find.descendant(of: scroll, matching: find.byType(Scrollable)).first,
        )
        .position
        .pixels;
    expect(after, before);
  });

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
