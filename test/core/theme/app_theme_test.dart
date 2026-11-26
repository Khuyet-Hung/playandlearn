import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:play_and_learn/core/theme/app_theme.dart';
import 'package:play_and_learn/core/theme/app_colors.dart';

void main() {
  testWidgets('custom typography stays readable on the light surface', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Builder(
            builder: (context) => Column(
              children: [
                Text(
                  'Tiêu đề',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text('Nội dung', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      ),
    );
    for (final text in ['Tiêu đề', 'Nội dung']) {
      final paragraph = tester.widget<RichText>(
        find.descendant(of: find.text(text), matching: find.byType(RichText)),
      );
      final style = (paragraph.text as TextSpan).style!;
      expect(style.color, AppColors.ink);
    }
  });
}
