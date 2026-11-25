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
    label: '${game.title}. ${game.description} Sắp có. Xem thông tin',
    onPressed: () {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Mini-game sẽ được bổ sung sau.')),
        );
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
            const AppChip(label: 'Sắp có'),
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
