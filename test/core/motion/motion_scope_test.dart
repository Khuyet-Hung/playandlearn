import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:play_and_learn/core/motion/motion_scope.dart';

void main() {
  testWidgets('OS reduced motion overrides an off user preference', (
    tester,
  ) async {
    bool? reduced;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: MotionScope(
          reduceMotion: false,
          child: Builder(
            builder: (context) {
              reduced = MotionScope.reducedOf(context);
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    expect(reduced, isTrue);
  });
}
