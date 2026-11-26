import '../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_pressable.dart';
import '../../skills/data/preview_catalog.dart';
import '../../skills/domain/skill.dart';
import '../../settings/presentation/settings_controller.dart';
import 'widgets/character_avatar.dart';
import 'widgets/home_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onOpenSkill,
    required this.settings,
  });
  final ValueChanged<Skill> onOpenSkill;
  final SettingsController settings;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final skills = PreviewCatalog.skillsFor(context.l10n);
      final diameter = constraints.maxWidth * 1.08;
      final scrollHome =
          MediaQuery.textScalerOf(context).scale(16) > 22 ||
          constraints.maxHeight < 420;
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
            if (scrollHome)
              ListView(
                key: const PageStorageKey('home-scroll'),
                children: [
                  HomeHeader(settings: settings),
                  const SizedBox(height: 12),
                  for (var i = 0; i < skills.length; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                      child: _FriendCard(
                        key: ValueKey('home-${skills[i].id.name}'),
                        skill: skills[i],
                        index: i,
                        onPressed: () => onOpenSkill(skills[i]),
                      ),
                    ),
                ],
              )
            else
              Column(
                children: [
                  HomeHeader(settings: settings),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 16),
                      child: Column(
                        children: [
                          for (var i = 0; i < skills.length; i++) ...[
                            if (i > 0) const SizedBox(height: 10),
                            Expanded(
                              child: _FriendCard(
                                key: ValueKey('home-${skills[i].id.name}'),
                                skill: skills[i],
                                index: i,
                                onPressed: () => onOpenSkill(skills[i]),
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
    final names = [
      context.l10n.listeningFriend,
      context.l10n.speakingFriend,
      context.l10n.readingFriend,
      context.l10n.writingFriend,
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
                            fontFamily: 'Baloo2',
                            color: foreground,
                            fontSize: 20,
                            height: 1.25,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0,
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
                            context.l10n.gameCountSoon(
                              PreviewCatalog.gamesFor(skill.id).length,
                            ),
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
