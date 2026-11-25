import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/app_reveal.dart';
import '../../skills/data/preview_catalog.dart';
import '../../skills/domain/skill.dart';
import '../../skills/presentation/widgets/skill_card.dart';

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
    padding: AppTokens.pagePadding,
    children: [
      Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 12,
        runSpacing: 12,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: AppColors.yellow,
                  border: AppTokens.border,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.bolt_rounded, size: 26),
              ),
              const SizedBox(width: 10),
              Text(
                'PLAY &\nLEARN',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const AppChip(label: 'Bản xem trước'),
        ],
      ),
      const SizedBox(height: 32),
      Text(
        'Xin chào, người chơi!',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      const SizedBox(height: 6),
      Text(
        'Hôm nay, mình\nchơi gì nhỉ?',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
      const SizedBox(height: 24),
      AppReveal(
        child: AppCard(
          color: AppColors.yellow,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Wrap(
                spacing: 10,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  AppChip(label: 'CHƠI VUI. HỌC THẬT.'),
                  Icon(Icons.auto_awesome_rounded, size: 27),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                'Một chút chơi.\nThêm tiếng Anh.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Khám phá những cách luyện tập mới, bắt đầu từ kỹ năng bạn yêu thích.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 22),
              AppButton(
                key: const ValueKey('explore-skills'),
                label: 'Khám phá kỹ năng',
                icon: Icons.arrow_forward_rounded,
                color: AppColors.surface,
                onPressed: onExplore,
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 32),
      Text('Chọn một kỹ năng', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 6),
      Text(
        'Mỗi kỹ năng, một cách khám phá.',
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: AppColors.muted),
      ),
      const SizedBox(height: 18),
      LayoutBuilder(
        builder: (context, constraints) {
          final twoColumns =
              constraints.maxWidth >= 310 &&
              MediaQuery.textScalerOf(context).scale(16) <= 22;
          final width = twoColumns
              ? (constraints.maxWidth - 14) / 2
              : constraints.maxWidth;
          return Wrap(
            spacing: 14,
            runSpacing: 14,
            children: [
              for (final skill in PreviewCatalog.skills)
                SizedBox(
                  width: width,
                  child: SkillCard(
                    key: ValueKey('home-${skill.id.name}'),
                    skill: skill,
                    compact: true,
                    onPressed: () => onOpenSkill(skill),
                  ),
                ),
            ],
          );
        },
      ),
      const SizedBox(height: 28),
      const AppCard(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_outline_rounded),
            SizedBox(height: 10),
            Text(
              'Một khởi đầu nhỏ, một thói quen mới.',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 6),
            Text(
              'Các mini-game đang được chuẩn bị. Bạn có thể khám phá khung ứng dụng ngay hôm nay.',
            ),
          ],
        ),
      ),
    ],
  );
}
