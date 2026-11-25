import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

abstract final class AppTokens {
  static const space = 8.0;
  static const pagePadding = EdgeInsets.fromLTRB(22, 24, 22, 32);
  static const radius = 20.0;
  static const borderWidth = 2.5;
  static const shadowOffset = Offset(4, 4);
  static Border get border =>
      Border.all(color: AppColors.ink, width: borderWidth);
  static List<BoxShadow> get shadow => const [
    BoxShadow(color: AppColors.ink, offset: shadowOffset),
  ];
}
