import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:play_and_learn/features/skills/data/preview_catalog.dart';
import 'package:play_and_learn/features/skills/domain/skill.dart';
import 'package:play_and_learn/features/skills/presentation/widgets/game_preview_card.dart';

import '../helpers/pump_preview_app.dart';

void main() {
  testWidgets('hidden tab controls cannot take or activate keyboard focus', (
    tester,
  ) async {
    await pumpPreviewApp(tester);
    final buttonContext = tester.element(find.text('Chuột Nghe Lén'));
    final focus = Focus.of(buttonContext);
    focus.requestFocus();
    await tester.pump();
    expect(focus.hasFocus, isTrue);
    await tester.tap(find.byKey(const ValueKey('tab-2')));
    await tester.pumpAndSettle();
    focus.requestFocus();
    await tester.pump();
    expect(focus.hasFocus, isFalse);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Góc của bạn.'), findsOneWidget);
  });

  testWidgets(
    'game preview exposes description and status in a single activation target',
    (tester) async {
      final game = PreviewCatalog.gamesFor(SkillId.listening).first;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: GamePreviewCard(game: game, number: 1)),
        ),
      );
      final semantics = tester.ensureSemantics();
      try {
        final node = tester.getSemantics(find.byType(GamePreviewCard));
        expect(
          node.label,
          contains('Lắng nghe và khám phá yêu cầu của vị khách.'),
        );
        expect(node.label.toLowerCase(), contains('sắp có'));
        await tester.tap(find.byType(GamePreviewCard));
        await tester.pumpAndSettle();
        expect(find.text('Mini-game sẽ được bổ sung sau.'), findsOneWidget);
      } finally {
        semantics.dispose();
      }
    },
  );
}
