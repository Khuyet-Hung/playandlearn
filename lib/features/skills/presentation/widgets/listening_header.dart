import '../../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_tokens.dart';

class ListeningHeader extends StatelessWidget {
  const ListeningHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              shape: BoxShape.circle,
              border: AppTokens.border,
              boxShadow: const [
                BoxShadow(color: AppColors.ink, offset: Offset(2, 3)),
              ],
            ),
            child: IconButton(
              tooltip: context.l10n.back,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_rounded, size: 26),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: AppColors.listeningBlue,
                borderRadius: BorderRadius.circular(30),
                border: AppTokens.border,
                boxShadow: const [
                  BoxShadow(color: AppColors.ink, offset: Offset(2, 3)),
                ],
              ),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  height: 1.1,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Semantics(
            label: context.l10n.streakDays(0),
            child: ExcludeSemantics(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  border: AppTokens.border,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(color: AppColors.ink, offset: Offset(2, 3)),
                  ],
                  color: AppColors.background,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      color: Color(0xFFE37C0A),
                      size: 25,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '0',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      LayoutBuilder(
        builder: (context, constraints) {
          final stacked =
              constraints.maxWidth < 350 &&
              MediaQuery.textScalerOf(context).scale(16) > 22;
          final mascot = ExcludeSemantics(
            child: SizedBox(
              width: stacked ? 150 : constraints.maxWidth * .35,
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.listeningBlue,
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Image.asset(
                        'assets/characters/listening-mouse.png',
                        key: const ValueKey('listening-mascot'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          final bubble = CustomPaint(
            painter: _SpeechTail(),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: AppTokens.border,
                boxShadow: const [
                  BoxShadow(color: AppColors.ink, offset: Offset(3, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.listeningGreeting,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    context.l10n.listeningSubtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
          if (stacked) {
            return Column(
              children: [mascot, const SizedBox(height: 14), bubble],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              mascot,
              const SizedBox(width: 12),
              Expanded(child: bubble),
            ],
          );
        },
      ),
    ],
  );
}

class _SpeechTail extends CustomPainter {
  _SpeechTail();

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(14, size.height - 27)
      ..quadraticBezierTo(-2, size.height - 5, -5, size.height + 4)
      ..quadraticBezierTo(14, size.height + 2, 29, size.height - 4)
      ..close();
    canvas.drawPath(
      path.shift(const Offset(2, 3)),
      Paint()..color = AppColors.ink,
    );
    canvas.drawPath(path, Paint()..color = AppColors.surface);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.ink
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant _SpeechTail oldDelegate) => false;
}
