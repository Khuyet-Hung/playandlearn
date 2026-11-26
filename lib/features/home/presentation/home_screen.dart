import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_pressable.dart';
import '../../skills/data/preview_catalog.dart';
import '../../skills/domain/skill.dart';
import 'widgets/character_avatar.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onOpenSkill});
  final ValueChanged<Skill> onOpenSkill;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final diameter = constraints.maxWidth * 1.08;
      final headerHeight = (constraints.maxHeight * 0.31).clamp(132.0, 205.0);
      return ClipRect(
        key: const ValueKey('home-layout'),
        child: Stack(
          children: [
            Positioned(
              left: -diameter * 0.36,
              top: -diameter * 0.44,
              child: ExcludeSemantics(
                child: Container(
                  width: diameter,
                  height: diameter,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.pink,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: headerHeight,
                  width: double.infinity,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      child: const HomeHeader(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                    child: Column(
                      children: [
                        for (
                          var i = 0;
                          i < PreviewCatalog.skills.length;
                          i++
                        ) ...[
                          if (i > 0) const SizedBox(height: 10),
                          Expanded(
                            child: _FriendCard(
                              key: ValueKey(
                                'home-${PreviewCatalog.skills[i].id.name}',
                              ),
                              skill: PreviewCatalog.skills[i],
                              index: i,
                              onPressed: () =>
                                  onOpenSkill(PreviewCatalog.skills[i]),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class _FriendCard extends StatelessWidget {
  const _FriendCard({
    super.key,
    required this.skill,
    required this.index,
    required this.onPressed,
  });
  final Skill skill;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const names = [
      'Chuột Nghe Lén',
      'Vẹt Lắm Mồm',
      'Cú Mọt Sách',
      'Mèo Viết Bậy',
    ];
    const animals = ['🐭', '🦜', '🦉', '🐱'];
    const colors = [
      Color(0xFF3C59DA),
      Color(0xFFFF795F),
      Color(0xFFFFBA22),
      AppColors.berry,
    ];
    final foreground = index == 0 || index == 3 ? Colors.white : AppColors.ink;
    return AppPressable(
      label: '${names[index]}, ${skill.title}',
      onPressed: onPressed,
      color: colors[index],
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: LayoutBuilder(
        builder: (context, constraints) => Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Row(
                children: [
                  CharacterAvatar(emoji: animals[index], size: 64),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          names[index],
                          style: TextStyle(
                            color: foreground,
                            fontSize: 20,
                            height: 1.15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          skill.title,
                          style: TextStyle(
                            color: foreground,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.ink,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${PreviewCatalog.gamesFor(skill.id).length} trò chơi · Sắp có',
                            style: const TextStyle(
                              color: AppColors.surface,
                              fontSize: 10,
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
      ),
    );
  }
}
