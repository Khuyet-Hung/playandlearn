import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_and_learn/core/widgets/app_button.dart';

void main() {
  testWidgets('activation fires once and disabled button cannot fire', (
    tester,
  ) async {
    var calls = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              AppButton(label: 'Khám phá', onPressed: () => calls++),
              const AppButton(label: 'Chưa có'),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('Khám phá'));
    await tester.tap(find.text('Chưa có'));
    await tester.pumpAndSettle();
    expect(calls, 1);
    expect(
      tester.getSize(find.byType(AppButton).first).height,
      greaterThanOrEqualTo(48),
    );
    final semantics = tester.ensureSemantics();
    expect(
      tester.getSemantics(find.byType(AppButton).first).label,
      contains('Khám phá'),
    );
    semantics.dispose();
  });

  testWidgets('cancelled pointer restores button position without activating', (
    tester,
  ) async {
    var calls = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(label: 'Nhấn thử', onPressed: () => calls++),
        ),
      ),
    );
    final finder = find.text('Nhấn thử');
    final initial = tester.getTopLeft(finder);
    final gesture = await tester.startGesture(tester.getCenter(finder));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(finder).dy, greaterThan(initial.dy));
    await gesture.cancel();
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(finder), initial);
    expect(calls, 0);
  });
}
