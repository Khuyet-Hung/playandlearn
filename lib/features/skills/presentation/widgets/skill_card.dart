import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_pressable.dart';
import '../../domain/skill.dart';

class SkillCard extends StatelessWidget {
  const SkillCard({
    super.key,
    required this.skill,
    required this.onPressed,
    this.compact = false,
  });
  final Skill skill;
  final VoidCallback onPressed;
  final bool compact;

  @override
  Widget build(BuildContext context) => AppPressable(
    label: '${skill.title}, ${skill.englishTitle}',
    onPressed: onPressed,
    color: compact ? skill.color : AppColors.surface,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: compact ? AppColors.surface : skill.color,
                border: Border.all(color: AppColors.ink, width: 2),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(skill.icon, size: 27),
            ),
            const Spacer(),
            const Icon(Icons.north_east_rounded, size: 23),
          ],
        ),
        const SizedBox(height: 20),
        Text(skill.title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 5),
        Text(
          skill.englishTitle,
          style: Theme.of(context).textTheme.labelMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        if (!compact) ...[
          const SizedBox(height: 12),
          Text(
            skill.description,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(color: AppColors.muted),
          ),
        ],
      ],
    ),
  );
}
