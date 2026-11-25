import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_page_header.dart';
import '../data/preview_catalog.dart';
import '../domain/skill.dart';
import 'widgets/skill_card.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key, required this.onOpenSkill});
  final ValueChanged<Skill> onOpenSkill;

  @override
  Widget build(BuildContext context) => ListView(
    key: const PageStorageKey('skills-scroll'),
    padding: AppTokens.pagePadding,
    children: [
      const AppPageHeader(
        title: 'Chơi theo cách\ncủa bạn.',
        subtitle: 'Bốn kỹ năng. Nhiều hành trình để khám phá.',
      ),
      const SizedBox(height: 28),
      for (final skill in PreviewCatalog.skills) ...[
        SkillCard(
          key: ValueKey('catalog-${skill.id.name}'),
          skill: skill,
          onPressed: () => onOpenSkill(skill),
        ),
        const SizedBox(height: 18),
      ],
    ],
  );
}
