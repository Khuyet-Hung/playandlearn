import '../../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/app_pressable.dart';
import '../../domain/game_preview.dart';

class GamePreviewCard extends StatelessWidget {
  const GamePreviewCard({super.key, required this.game, required this.number});
  final GamePreview game;
  final int number;

  @override
  Widget build(BuildContext context) => AppPressable(
    label:
        '${game.title}. ${game.description} ${context.l10n.comingSoon}. ${context.l10n.viewInformation}',
    onPressed: () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(context.l10n.gameUnavailable)));
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 10,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text('0$number', style: Theme.of(context).textTheme.headlineMedium),
            AppChip(label: context.l10n.comingSoon),
          ],
        ),
        const SizedBox(height: 18),
        Text(game.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(game.description),
      ],
    ),
  );
}
