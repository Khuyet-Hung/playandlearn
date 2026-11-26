import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/widgets/app_pressable.dart';
import '../../domain/game_preview.dart';

class ListeningGameCard extends StatelessWidget {
  const ListeningGameCard({
    super.key,
    required this.game,
    required this.number,
  });
  final GamePreview game;
  final int number;

  @override
  Widget build(BuildContext context) {
    final isOrder = game.id == 'listening-order';
    final color = isOrder ? AppColors.yellow : AppColors.lavender;
    return AppPressable(
      label:
          '${game.title}. ${game.description} ${game.difficulty}. ${game.duration}. Sắp có. Xem thông tin',
      padding: EdgeInsets.zero,
      onPressed: () {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Mini-game sẽ được bổ sung sau.')),
          );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppTokens.radius - AppTokens.borderWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Game artwork will be supplied when these games are implemented.
            Container(
              decoration: BoxDecoration(
                color: color,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.ink,
                    width: AppTokens.borderWidth,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Center(
                      child: Icon(
                        isOrder
                            ? Icons.local_cafe_outlined
                            : Icons.radio_rounded,
                        size: 62,
                        color: AppColors.ink.withValues(alpha: .75),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        border: AppTokens.border,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        number.toString().padLeft(2, '0'),
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Text(
                      'Sắp có',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final largeText =
                      MediaQuery.textScalerOf(context).scale(16) > 22;
                  final details = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          letterSpacing: -.6,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        game.description,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isOrder
                                  ? AppColors.yellow
                                  : AppColors.coral,
                              border: Border.all(
                                color: AppColors.ink,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              game.difficulty,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.3,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 12),
                            decoration: const BoxDecoration(
                              border: Border(
                                left: BorderSide(color: AppColors.ink),
                              ),
                            ),
                            child: Text(
                              game.duration,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                  final play = Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.listeningBlue,
                      shape: BoxShape.circle,
                      border: AppTokens.border,
                      boxShadow: const [
                        BoxShadow(color: AppColors.ink, offset: Offset(2, 3)),
                      ],
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  );
                  if (largeText) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        details,
                        const SizedBox(height: 10),
                        Align(alignment: Alignment.centerRight, child: play),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: details),
                      const SizedBox(width: 12),
                      play,
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
