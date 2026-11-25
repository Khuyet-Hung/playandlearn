import 'package:material_ui/material_ui.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: AppColors.yellow,
            brightness: Brightness.light,
          ).copyWith(
            primary: AppColors.ink,
            onPrimary: AppColors.surface,
            surface: AppColors.surface,
            onSurface: AppColors.ink,
            secondary: AppColors.yellow,
          ),
    );
    return base.copyWith(
      textTheme: base.textTheme
          .copyWith(
            headlineLarge: base.textTheme.headlineLarge?.copyWith(
              fontSize: 38,
              fontWeight: FontWeight.w900,
              height: 1.1,
              letterSpacing: -1.5,
            ),
            headlineMedium: base.textTheme.headlineMedium?.copyWith(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.15,
              letterSpacing: -0.8,
            ),
            titleLarge: base.textTheme.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
            titleMedium: base.textTheme.titleMedium?.copyWith(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
            bodyLarge: base.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.5,
            ),
            bodyMedium: base.textTheme.bodyMedium?.copyWith(
              fontSize: 14,
              height: 1.5,
            ),
            labelLarge: base.textTheme.labelLarge?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              height: 1.3,
            ),
          )
          .apply(bodyColor: AppColors.ink, displayColor: AppColors.ink),
      dividerColor: AppColors.ink,
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: TextStyle(color: AppColors.surface, fontSize: 15),
        behavior: SnackBarBehavior.floating,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
    );
  }
}
