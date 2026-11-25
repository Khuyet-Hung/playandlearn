import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:play_and_learn/core/widgets/app_progress.dart';

void main() {
  for (final example in [(0.0, 0.0), (0.4, 118.4), (1.0, 296.0)]) {
    testWidgets(
      'progress ${example.$1} fills the correct part of a full-width track',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SizedBox(
                width: 300,
                child: AppProgress(value: example.$1, label: 'Mục tiêu'),
              ),
            ),
          ),
        );
        final track = find.descendant(
          of: find.byType(AppProgress),
          matching: find.byWidgetPredicate(
            (widget) =>
                widget is Container && widget.constraints?.maxHeight == 14,
          ),
        );
        final fill = find.descendant(
          of: track,
          matching: find.byType(ColoredBox),
        );
        expect(tester.getSize(track).width, 300);
        expect(tester.getSize(fill).width, closeTo(example.$2, 0.01));
      },
    );
  }
}
