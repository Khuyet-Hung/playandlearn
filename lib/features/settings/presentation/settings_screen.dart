import 'widgets/language_selector.dart';

import '../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/app_page_header.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.controller});
  final SettingsController controller;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) => ListView(
              padding: AppTokens.pagePadding,
              children: [
                AppPageHeader(
                  title: context.l10n.settingsHeading,
                  subtitle: context.l10n.settingsSubtitle,
                  onBack: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 28),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.language,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      LanguageSelector(controller: controller),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.accessibility_new_rounded, size: 32),
                      const SizedBox(height: 20),
                      Text(
                        context.l10n.reduceMotion,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 10),
                      Text(context.l10n.reduceMotionDescription),
                      const SizedBox(height: 12),
                      Semantics(
                        label: context.l10n.reduceMotion,
                        child: Switch(
                          value: controller.reduceMotion,
                          onChanged: controller.isSaving || controller.isLoading
                              ? null
                              : controller.setReduceMotion,
                          activeThumbColor: AppColors.ink,
                          activeTrackColor: AppColors.yellow,
                          inactiveThumbColor: AppColors.ink,
                          inactiveTrackColor: AppColors.background,
                        ),
                      ),
                      if (controller.isSaving || controller.isLoading)
                        Text(
                          context.l10n.settingsBusy,
                          semanticsLabel: context.l10n.settingsBusySemantics,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        context.l10n.deviceMotionNotice,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                if (controller.errorMessage != null) ...[
                  const SizedBox(height: 20),
                  AppCard(
                    color: AppColors.coral,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          liveRegion: true,
                          child: Text(controller.errorMessage!),
                        ),
                        const SizedBox(height: 16),
                        AppButton(
                          label: context.l10n.retry,
                          color: AppColors.surface,
                          onPressed: controller.isSaving || controller.isLoading
                              ? null
                              : controller.retry,
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                Text(context.l10n.settingsStorageNotice),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
