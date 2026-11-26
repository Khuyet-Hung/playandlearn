import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_pressable.dart';
import '../../skills/data/preview_catalog.dart';
import '../../skills/domain/skill.dart';
import 'widgets/character_avatar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onExplore,
    required this.onOpenSkill,
  });
  final VoidCallback onExplore;
  final ValueChanged<Skill> onOpenSkill;

  @override
  Widget build(BuildContext context) => ListView(
    key: const PageStorageKey('home-scroll'),
    padding: const EdgeInsets.fromLTRB(22, 24, 22, 28),
    children: [
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 16,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Transform.rotate(
            angle: -0.06,
            child: const Text(
              'PLAY &\nLEARN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                height: 0.95,
                letterSpacing: -0.6,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.ink, width: 2),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_fire_department_rounded,
                  color: Color(0xFFBA471A),
                  size: 23,
                ),
                SizedBox(width: 5),
                Flexible(
                  child: Text(
                    'Chơi mỗi ngày',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 25),
      Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.pink,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.ink, width: 2.5),
          boxShadow: const [
            BoxShadow(color: AppColors.ink, offset: Offset(4, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CharacterAvatar(emoji: '🦜', size: 68),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'CHƠI MỘT CHÚT,\nGIỎI THÊM MỘT CHÚT.',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      height: 1.5,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                Icon(Icons.auto_awesome_rounded, size: 22),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.ink, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ê, hôm nay cậu muốn\ntám với ai?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Chọn một người bạn. Khám phá tiếng Anh theo cách của cậu!',
                    style: TextStyle(fontSize: 13, height: 1.45),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 28),
      const Row(
        children: [
          Expanded(
            child: Text(
              'CHỌN BẠN HỌC',
              style: TextStyle(
                color: AppColors.berry,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.8,
              ),
            ),
          ),
          Icon(Icons.auto_awesome_outlined, color: AppColors.berry, size: 18),
        ],
      ),
      const SizedBox(height: 14),
      for (var i = 0; i < PreviewCatalog.skills.length; i++) ...[
        _FriendCard(
          key: ValueKey('home-${PreviewCatalog.skills[i].id.name}'),
          skill: PreviewCatalog.skills[i],
          index: i,
          onPressed: () => onOpenSkill(PreviewCatalog.skills[i]),
        ),
        const SizedBox(height: 12),
      ],
      const SizedBox(height: 10),
      AppButton(
        key: const ValueKey('explore-skills'),
        label: 'Khám phá kỹ năng',
        icon: Icons.arrow_forward_rounded,
        color: AppColors.surface,
        onPressed: onExplore,
      ),
      const SizedBox(height: 16),
      const Text(
        'Mỗi ngày một chút, tiếng Anh tiến xa hơn.',
        textAlign: TextAlign.center,
        style: TextStyle(color: AppColors.muted, fontSize: 12),
      ),
    ],
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
    final largeText = MediaQuery.textScalerOf(context).scale(16) > 23;
    final details = Column(
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
        const SizedBox(height: 4),
        Text(
          skill.title,
          style: TextStyle(
            color: foreground,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
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
    );
    return AppPressable(
      label: '${names[index]}, ${skill.title}',
      onPressed: onPressed,
      color: colors[index],
      padding: const EdgeInsets.all(13),
      child: largeText
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CharacterAvatar(emoji: animals[index], size: 64),
                const SizedBox(height: 12),
                details,
              ],
            )
          : Row(
              children: [
                CharacterAvatar(emoji: animals[index], size: 68),
                const SizedBox(width: 14),
                Expanded(child: details),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, color: foreground, size: 19),
              ],
            ),
    );
  }
}
