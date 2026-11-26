import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

import '../../../../l10n/l10n.dart';
import '../../../../core/theme/app_colors.dart';
import '../settings_controller.dart';

/// Only the two flags are visible; names and selection are available to assistive
/// technologies and tooltips. Flags are painted locally on every platform.
class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final code in ['vi', 'en']) ...[
          if (code == 'en') const SizedBox(width: 6),
          Semantics(
            label: code == 'vi' ? 'Tiếng Việt' : 'English',
            selected: controller.locale.languageCode == code,
            button: true,
            child: Tooltip(
              message: code == 'vi' ? 'Tiếng Việt' : 'English',
              excludeFromSemantics: true,
              child: Material(
                color: controller.locale.languageCode == code
                    ? AppColors.yellow
                    : AppColors.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: controller.locale.languageCode == code
                        ? AppColors.ink
                        : AppColors.muted,
                    width: controller.locale.languageCode == code ? 2.5 : 1,
                  ),
                ),
                child: InkWell(
                  key: ValueKey('language-$code'),
                  borderRadius: BorderRadius.circular(12),
                  onTap: controller.isLoading || controller.isSaving
                      ? null
                      : () async {
                          await controller.setLanguageCode(code);
                          if (!context.mounted ||
                              controller.errorMessage == null) {
                            return;
                          }
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                content: Text(controller.errorMessage!),
                                action: SnackBarAction(
                                  label: context.l10n.retry,
                                  onPressed: controller.retry,
                                ),
                              ),
                            );
                        },
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: ExcludeSemantics(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: CustomPaint(
                            size: const Size(30, 20),
                            painter: _FlagPainter(code),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ],
    ),
  );
}

class _FlagPainter extends CustomPainter {
  const _FlagPainter(this.code);
  final String code;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    if (code == 'vi') {
      canvas.drawRect(bounds, Paint()..color = const Color(0xFFDA251D));
      final star = Path();
      for (var i = 0; i < 10; i++) {
        final angle = -math.pi / 2 + i * math.pi / 5;
        final radius = size.height * (i.isEven ? .32 : .123);
        final x = size.width / 2 + math.cos(angle) * radius;
        final y = size.height / 2 + math.sin(angle) * radius;
        if (i == 0) {
          star.moveTo(x, y);
        } else {
          star.lineTo(x, y);
        }
      }
      canvas.drawPath(star..close(), Paint()..color = const Color(0xFFFFDF00));
      return;
    }
    canvas.save();
    canvas.clipRect(bounds);
    canvas.drawRect(bounds, Paint()..color = const Color(0xFF012169));
    final white = Paint()..color = Colors.white;
    final red = Paint()..color = const Color(0xFFC8102E);
    for (final paint in [white, red]) {
      paint.strokeWidth = size.height * (paint == white ? .24 : .08);
      canvas.drawLine(Offset.zero, Offset(size.width, size.height), paint);
      canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), paint);
    }
    for (final paint in [white, red]) {
      final thickness = size.height * (paint == white ? .35 : .2);
      canvas.drawRect(
        Rect.fromCenter(
          center: bounds.center,
          width: size.width,
          height: thickness,
        ),
        paint,
      );
      canvas.drawRect(
        Rect.fromCenter(
          center: bounds.center,
          width: thickness,
          height: size.height,
        ),
        paint,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_FlagPainter oldDelegate) => oldDelegate.code != code;
}
