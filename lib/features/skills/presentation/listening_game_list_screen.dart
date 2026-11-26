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
    final games = PreviewCatalog.gamesFor(skill.id);
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
                  'Chuột Nghe Lén',
                  style: Theme.of(context).textTheme.headlineLarge
                      ?.copyWith(fontSize: 32, letterSpacing: -1),
                ),
                const SizedBox(height: 5),
                Text(
                  '${games.length} trò chơi · Nghe tiếng Anh thật vui',
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
                const Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ExcludeSemantics(
                        child: Icon(
                          Icons.headphones_rounded,
                          color: AppColors.berry,
                          size: 30,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          'Đeo tai nghe để chơi vui hơn!',
                          style: TextStyle(
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
