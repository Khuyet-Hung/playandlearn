import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:play_and_learn/features/skills/presentation/widgets/listening_game_card.dart';

import '../../helpers/pump_preview_app.dart';

void main() {
  for (final size in [
    const Size(320, 640),
    const Size(390, 844),
    const Size(1000, 900),
  ]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets('listening list fits $size at text scale $scale', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        tester.platformDispatcher.textScaleFactorTestValue = scale;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
        await pumpPreviewApp(tester);
        if (scale == 2) {
          await reveal(tester, find.byKey(const ValueKey('home-listening')));
        }
        await tester.tap(find.byKey(const ValueKey('home-listening')));
        await tester.pumpAndSettle();
        expect(find.text('Tai thính đã sẵn sàng?'), findsOneWidget);
        expect(find.byKey(const ValueKey('listening-mascot')), findsOneWidget);
        expect(tester.takeException(), isNull);
        final first = find.byKey(const ValueKey('game-listening-order'));
        await reveal(tester, first);
        expect(find.text('Giao đúng đơn'), findsOneWidget);
        final semantics = tester.ensureSemantics();
        expect(tester.getSemantics(first).label, contains('Sắp có'));
        semantics.dispose();
        await tester.tap(first);
        await tester.pumpAndSettle();
        expect(find.text('Mini-game sẽ được bổ sung sau.'), findsOneWidget);
        final second = find.byKey(const ValueKey('game-listening-detective'));
        await reveal(tester, second);
        expect(find.text('Thám tử âm thanh'), findsOneWidget);
        expect(tester.widget<ListeningGameCard>(second).number, 2);
        await tester.tap(second);
        await tester.pumpAndSettle();
        expect(find.text('Mini-game sẽ được bổ sung sau.'), findsOneWidget);
        await reveal(tester, find.text('Đeo tai nghe để chơi vui hơn!'));
        expect(tester.takeException(), isNull);
        tester
            .state<ScrollableState>(find.byType(Scrollable).first)
            .position
            .jumpTo(0);
        await tester.pumpAndSettle();
        await tester.tap(find.byTooltip('Quay lại'));
        await tester.pumpAndSettle();
        expect(find.byKey(const ValueKey('home-layout')), findsOneWidget);
      });
    }
  }
}
