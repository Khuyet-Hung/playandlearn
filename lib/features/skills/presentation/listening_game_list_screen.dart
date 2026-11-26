import '../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../data/preview_catalog.dart';
import '../domain/skill.dart';
import 'widgets/listening_game_card.dart';
import 'widgets/listening_header.dart';

class ListeningGameListScreen extends StatelessWidget {
  const ListeningGameListScreen({super.key, required this.skill});

  final Skill skill;

  @override
  Widget build(BuildContext context) {
    final skill = PreviewCatalog.skillsFor(context.l10n)
        .firstWhere((item) => item.id == this.skill.id);
    final games = PreviewCatalog.gamesFor(skill.id, context.l10n);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              key: const ValueKey('listening-game-list'),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
              children: [
                ListeningHeader(title: skill.title),
                const SizedBox(height: 14),
                Text(
                  context.l10n.listeningFriend,
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 5),
                Text(
                  context.l10n.listeningGameCount(games.length),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 22),
                for (var i = 0; i < games.length; i++) ...[
                  ListeningGameCard(
                    key: ValueKey('game-${games[i].id}'),
                    game: games[i],
                    number: i + 1,
                  ),
                  const SizedBox(height: 16),
                ],
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ExcludeSemantics(
                        child: Icon(
                          Icons.headphones_rounded,
                          color: AppColors.berry,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          context.l10n.headphonesHint,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
