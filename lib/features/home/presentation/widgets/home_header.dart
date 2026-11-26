import 'package:material_ui/material_ui.dart';

import '../../../../core/theme/app_colors.dart';

/// The bird artwork is a temporary placeholder for the final mascot asset.
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.streakDays = 0});

  final int streakDays;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(22, 24, 26, 8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Transform.rotate(
                angle: -0.065,
                child: const Text(
                  'PLAY &\nLEARN',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Semantics(
                  label: 'Chuỗi học: $streakDays ngày',
                  child: ExcludeSemantics(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: AppColors.ink, width: 2.3),
                        boxShadow: const [
                          BoxShadow(color: AppColors.ink, offset: Offset(3, 4)),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            color: Color(0xFFE37C0A),
                            size: 25,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$streakDays',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w900,
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ExcludeSemantics(
              child: SizedBox(
                width: 76,
                child: Text(
                  '🦜',
                  textAlign: TextAlign.center,
                  textScaler: TextScaler.noScaling,
                  style: TextStyle(fontSize: 70, height: 1.2),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 13),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23),
                    bottomLeft: Radius.circular(5),
                  ),
                  border: Border.all(color: AppColors.ink, width: 2.3),
                  boxShadow: const [
                    BoxShadow(color: AppColors.ink, offset: Offset(4, 5)),
                  ],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ê, hôm nay cậu muốn tám với ai?',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.2,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Mỗi bạn có cả đống game đang chờ.',
                      style: TextStyle(fontSize: 11, height: 1.3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
