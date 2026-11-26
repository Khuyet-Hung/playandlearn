import '../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/app_page_header.dart';
import '../data/preview_catalog.dart';
import '../domain/skill.dart';
import 'widgets/game_preview_card.dart';
import 'listening_game_list_screen.dart';

class SkillDetailScreen extends StatelessWidget {
  const SkillDetailScreen({super.key, required this.skill});
  final Skill skill;

  @override
  Widget build(BuildContext context) {
    final skill = PreviewCatalog.skillsFor(context.l10n)
        .firstWhere((item) => item.id == this.skill.id);
    if (skill.id == SkillId.listening) {
      return ListeningGameListScreen(skill: skill);
    }
    final games = PreviewCatalog.gamesFor(skill.id, context.l10n);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: AppTokens.pagePadding,
              children: [
                AppPageHeader(
                  title: skill.title,
                  subtitle: skill.englishTitle,
                  onBack: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 28),
                AppCard(
                  color: skill.color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(skill.icon, size: 52),
                      const SizedBox(height: 20),
                      Text(
                        skill.description,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 18),
                      AppChip(label: context.l10n.waitForGames),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  context.l10n.gameCorner,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(context.l10n.gamePreviewNotice),
                const SizedBox(height: 20),
                for (var i = 0; i < games.length; i++) ...[
                  GamePreviewCard(
                    key: ValueKey('game-${games[i].id}'),
                    game: games[i],
                    number: i + 1,
                  ),
                  const SizedBox(height: 18),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
