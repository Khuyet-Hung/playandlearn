import '../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_chip.dart';
import '../../../core/widgets/app_page_header.dart';
import '../../../core/widgets/app_progress.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onOpenSettings});
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) => ListView(
    key: const PageStorageKey('profile-scroll'),
    padding: AppTokens.pagePadding,
    children: [
      AppPageHeader(
        title: context.l10n.profileHeading,
        subtitle: context.l10n.profileSubtitle,
      ),
      const SizedBox(height: 28),
      AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 76,
              height: 76,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.yellow,
                border: AppTokens.border,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'N',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.player,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            AppChip(label: context.l10n.localProfile),
            const SizedBox(height: 16),
            Text(context.l10n.profilePreview),
          ],
        ),
      ),
      const SizedBox(height: 24),
      AppCard(
        color: AppColors.mint,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.progressHeading,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            AppChip(label: context.l10n.sampleData),
            const SizedBox(height: 20),
            AppProgress(value: 0.4, label: context.l10n.sampleGoal),
            const SizedBox(height: 12),
            Text(context.l10n.progressNotice),
          ],
        ),
      ),
      const SizedBox(height: 26),
      AppButton(
        key: const ValueKey('open-settings'),
        label: context.l10n.openSettings,
        icon: Icons.tune_rounded,
        color: AppColors.surface,
        onPressed: onOpenSettings,
      ),
      const SizedBox(height: 24),
      Text(
        context.l10n.brandTagline,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.labelSmall
            ?.copyWith(color: AppColors.muted, letterSpacing: 0.7),
      ),
    ],
  );
}
