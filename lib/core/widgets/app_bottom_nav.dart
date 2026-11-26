import '../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.fromLTRB(14, 6, 14, 12),
    decoration: BoxDecoration(
      color: AppColors.ink,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(color: AppColors.berry, offset: Offset(0, 4)),
      ],
    ),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < 3; i++)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Semantics(
                    selected: selectedIndex == i,
                    button: true,
                    child: Material(
                      color: selectedIndex == i
                          ? AppColors.yellow
                          : AppColors.ink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: selectedIndex == i
                              ? AppColors.surface
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: InkWell(
                        key: ValueKey('tab-$i'),
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => onSelected(i),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 56),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                              vertical: 8,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  [
                                    Icons.home_outlined,
                                    Icons.grid_view_rounded,
                                    Icons.person_outline_rounded,
                                  ][i],
                                  size: 25,
                                  color: selectedIndex == i
                                      ? AppColors.ink
                                      : AppColors.surface,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  [
                                    context.l10n.homeTab,
                                    context.l10n.skillsTab,
                                    context.l10n.profileTab,
                                  ][i],
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.labelSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                        color: selectedIndex == i
                                            ? AppColors.ink
                                            : AppColors.surface,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
