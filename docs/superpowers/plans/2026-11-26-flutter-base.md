# Flutter Base Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Build a reusable Flutter mobile foundation and navigable preview for Play & Learn, leaving gameplay for later.

**Architecture:** Organize code by feature, with a small shared design system and explicit constructor injection. Flutter owns routing and animations; settings use a repository boundary over shared_preferences. No backend, game engine, service locator or large state framework is needed.

**Tech Stack:** Flutter stable, Dart, Flutter SDK widgets/animation/navigation, shared_preferences, flutter_test, flutter_lints.

**Spec:** `docs/superpowers/specs/2026-11-26-app-shell-design.md`

## Global Constraints

- Android and iOS; Windows development with Android verification first. Never claim iOS was tested without macOS/device execution.
- Colors: background #F3EFE6, surface #FFFEF8, ink #191919, yellow #FFD83D, coral #FF876B, blue #6088F5.
- Borders 2–3 logical pixels; radii 16–24; hard shadow offset 3–5 pixels; interactive targets at least 48 logical pixels.
- Vietnamese interface; working app name "Play & Learn"; default profile "Người chơi".
- Three tabs: Trang chủ, Kỹ năng, Hồ sơ. Preserve tab state and scroll position.
- Game cards show "Sắp có"; mock statistics explicitly show "Dữ liệu minh họa"; preview shows "Bản xem trước".
- No gameplay, AI, recording, login, backend, advertisements, payments, network requirement or camera/microphone permissions.
- Reduced motion combines device accessibility preference with saved user preference.
- Avoid Flame, Rive, Lottie, large state frameworks, database and speculative infrastructure.
- Use system fonts initially; any later external font must be bundled with its license.
- No existing Git repository: do not create one or make commits implicitly. Stage checkpoints only if a repository exists at execution time and committing is authorized.

## Review Focus

1. A 320-pixel viewport with 200% text must scroll without clipping content or hiding controls: task 4 widget test.
2. Storage initialization/write failure must leave a usable app and must not falsely claim a preference was saved: task 2 unit tests and task 4 settings test.
3. OS reduced motion must override a disabled user preference: task 3 widget test.
4. Cancelled button presses and repeated navigation taps must not leave pressed styling or duplicate destination routes: task 3 and task 4 tests.
5. Switching tabs and returning from details must retain scroll/tab state: task 4 widget test.

## File Map

```text
lib/
  main.dart                         # Flutter binding and bootstrap entry
  app/
    bootstrap.dart                  # Inject settings, recover startup errors
    app.dart                        # MaterialApp and dependency composition
    app_dependencies.dart           # Explicit application dependencies
    navigation/app_routes.dart      # Detail/settings routes and transitions
    shell/app_shell.dart            # Preserved tabs and tab fade
  core/
    theme/app_colors.dart           # Named reference palette
    theme/app_tokens.dart           # Spacing, borders, radii, shadows
    theme/app_theme.dart            # Typography and Material theme
    motion/motion_scope.dart        # Effective reduced motion and durations
    widgets/app_button.dart         # Accessible press/shadow behavior
    widgets/app_card.dart           # Static bordered surface
    widgets/app_chip.dart           # Status/category label
    widgets/app_progress.dart       # Labeled bounded progress bar
    widgets/app_page_header.dart    # Wrapping heading and optional back
    widgets/app_bottom_nav.dart     # Three accessible destinations
    widgets/app_reveal.dart         # One-shot entrance animation
  features/
    home/presentation/home_screen.dart
    skills/domain/skill.dart
    skills/domain/game_preview.dart
    skills/data/preview_catalog.dart
    skills/presentation/skills_screen.dart
    skills/presentation/skill_detail_screen.dart
    skills/presentation/widgets/skill_card.dart
    skills/presentation/widgets/game_preview_card.dart
    profile/presentation/profile_screen.dart
    settings/data/settings_repository.dart
    settings/presentation/settings_controller.dart
    settings/presentation/settings_screen.dart
test/
  features/settings/settings_controller_test.dart
  core/widgets/app_button_test.dart
  core/motion/motion_scope_test.dart
  app/app_navigation_test.dart
  app/app_layout_test.dart
  helpers/pump_preview_app.dart
README.md                           # Setup, architecture and extension recipe
analysis_options.yaml               # Flutter lints
pubspec.yaml / pubspec.lock          # Dependencies and reproducible resolution
android/ / ios/                     # Generated platform scaffolds
```

Dependencies flow from app to features/core; core never imports features. Feature-specific cards stay beside their feature. Do not create empty domain/use-case/network directories for future work.

## Task 1: Runnable project and dependency composition

**Files:** generated Flutter scaffolds, `pubspec.yaml`, `analysis_options.yaml`, `lib/main.dart`, `lib/app/bootstrap.dart`, `lib/app/app.dart`, `lib/app/app_dependencies.dart`.

**Interfaces:** `Future<void> bootstrap()`; `PlayAndLearnApp({Key? key, required AppDependencies dependencies})`; `AppDependencies({required SettingsController settings})`.

- [x] Locate Flutter using PATH and likely SDK locations. If absent, install stable SDK into a workspace-local `.tooling/flutter` directory or use an explicitly authorized existing SDK; record exact SDK version. Do not modify global PATH or accept SDK licenses silently.
- [x] Generate Android/iOS project using `flutter create --platforms=android,ios --project-name play_and_learn --org dev.playandlearn --no-pub .`; preserve `.agents` and `docs`. Identifier is a development placeholder, documented for later release changes.
- [x] Add shared_preferences with `flutter pub add shared_preferences`, retaining generated Flutter lint/test dependencies and the resolved lockfile. Add `.tooling/` to `.gitignore` if installed locally.
- [x] Implement dependency composition, binding initialization and a temporary preview entry surface; task 2 supplies the final settings classes. Keep entrypoint minimal and avoid globals.
- [x] Run `flutter pub get` and `flutter analyze`; expected: resolved dependencies and no analysis issues once task 2 interfaces exist. If tooling/network blocks this, record the exact failure; do not pretend compilation passed.

## Task 2: Persistent settings with honest failure handling

**Files:** `lib/features/settings/data/settings_repository.dart`, `lib/features/settings/presentation/settings_controller.dart`, `test/features/settings/settings_controller_test.dart`; connect bootstrap from task 1.

**Interfaces:** abstract `SettingsRepository` with `Future<bool> readReduceMotion()` and `Future<void> writeReduceMotion(bool value)`; `PreferencesSettingsRepository(SharedPreferencesAsync preferences)`; `SettingsController(SettingsRepository repository) extends ChangeNotifier` exposes `bool reduceMotion`, `String? errorMessage`, `Future<void> load()`, `Future<void> setReduceMotion(bool value)`.

- [x] Write tests with a fake repository: absent value defaults false; stored true loads true; successful true save is read as true by a fresh controller; failed read retains safe default and reports error; failed write preserves last saved value and reports error. Test serialized writes or reject overlapping saves so completion order cannot overwrite the newest intent.
- [x] Run `flutter test test/features/settings/settings_controller_test.dart`; expect failure before implementation.
- [x] Implement repository using key `settings.reduce_motion`, mapping null to false. Implement controller with a saving guard and notification; dispose it with its owning app state. Startup failure must still launch the app and provide a retry path on Settings.
- [x] Run the same tests; expect all pass.

## Task 3: Reusable design system and motion

**Files:** all `lib/core/` files, `test/core/widgets/app_button_test.dart`, `test/core/motion/motion_scope_test.dart`.

**Interfaces:** `AppTheme.light` returns `ThemeData`; `MotionScope({required bool reduceMotion, required Widget child})` and static `bool reducedOf(BuildContext context)` combine user setting with `MediaQuery.disableAnimationsOf(context)`; `AppButton({required String label, VoidCallback? onPressed, IconData? icon})`; `AppCard({required Widget child, Color? color, EdgeInsetsGeometry? padding})`; `AppChip({required String label, Color? color})`; `AppProgress({required double value, required String label})`; `AppPageHeader({required String title, String? subtitle, VoidCallback? onBack})`; `AppBottomNav({required int selectedIndex, required ValueChanged<int> onSelected})`; `AppReveal({required Widget child})`.

- [x] Write button tests: callback fires once on activation; null callback cannot activate; pointer cancellation restores visual position; semantic label and tap target remain available. Write motion test: OS disableAnimations true gives reducedOf true even when user setting false.
- [x] Run `flutter test test/core`; expect failures before implementation.
- [x] Implement palette/tokens and typography from global constraints. Use Flutter SDK icons and font fallback with Vietnamese text. Build the primitives; progress clamps to [0,1] and exposes semantic value. Button supports keyboard/focus/semantics; no nested competing gestures.
- [x] Implement 120ms press, 180ms tab fade, 220ms route transition and one-shot entrance fade/short translation. Reduced motion eliminates translation and stagger, and uses immediate state changes. Do not let offstage tabs run tickers. Rebuild must not replay entrance animation.
- [x] Run `flutter test test/core`; expect all pass. Run formatter and analyzer for this task.

## Task 4: Catalog, screens and complete navigation

**Files:** remaining `lib/app/`, `lib/features/home/`, `lib/features/skills/`, `lib/features/profile/`, settings screen, `test/app/`, `test/helpers/pump_preview_app.dart`.

**Interfaces:** `enum SkillId { listening, speaking, reading, writing }`; immutable `Skill({required SkillId id, required String title, required String englishTitle, required String description, required IconData icon, required Color color})`; `GamePreview({required String id, required SkillId skillId, required String title, required String description})` with this phase implicitly coming-soon; `PreviewCatalog.skills` and `PreviewCatalog.gamesFor(SkillId id)` return immutable lists; `AppRoutes.openSkill(BuildContext context, Skill skill)` and `AppRoutes.openSettings(BuildContext context)` return `Future<void>` and guard duplicate pushes until current route returns.

Screens: `HomeScreen({required VoidCallback onExplore})`, `SkillsScreen()`, `SkillDetailScreen({required Skill skill})`, `ProfileScreen()`, `SettingsScreen({required SettingsController controller})`, `AppShell()`; app composition exposes dependencies through explicit parameters or a small scoped inherited widget, without a third-party DI framework.

- [x] Write navigation tests: home skill opens matching detail and system back restores Home; explore selects Skills; profile opens Settings; tapping coming-soon card shows explanatory snackbar with no gameplay route; two rapid skill taps push one detail; switching tabs preserves scroll position.
- [x] Write settings UI test: failure displays actionable retry text, switch is not shown as successfully saved, retry can succeed.
- [x] Write layout test across Home, Skills, Profile, detail and Settings with logical viewport 320x640 and TextScaler.linear(2); assert `tester.takeException()` is null after layout and primary controls can be scrolled into view. Reset view metrics in teardown.
- [x] Run `flutter test test/app`; expect failures before implementation.
- [x] Implement immutable catalog: four skills with stable IDs; two placeholder game cards per skill with stable string IDs. No score history or invented achievements are needed.
- [x] Implement Home, Skills and Profile with responsive wrapping, SafeArea, scrollable content, preview labels and shared components. Use indexed tab preservation plus bounded fade; retain selected tab when returning from pushed screens.
- [x] Implement detail and Settings routes, accessible back buttons, route push guards, coming-soon feedback and persistent motion switch with error/retry. Settings must update the root motion policy immediately after successful save.
- [x] Run `flutter test test/app`; expect all pass. Run `flutter test` and `flutter analyze`; resolve failures before continuing.

## Task 5: Developer handoff and platform validation

**Files:** `README.md`, generated platform configuration, updated plan checkboxes and spec status.

**Interfaces:** documented commands `flutter pub get`, `flutter run`, `flutter analyze`, `flutter test`; README explains each folder and shows how to add a catalog entry, reuse AppButton/AppCard and later attach gameplay without changing shared core.

- [x] Write README with prerequisites, exact tested SDK version, folder ownership/import direction, current dependencies with purposes, Android launch steps, iOS/macOS requirement, offline behavior and explicit preview limitations.
- [x] Run `dart format --output=none --set-exit-if-changed lib test` after formatting changes; expect exit 0. Run `flutter analyze` and `flutter test`; expect no issues/all pass.
- [x] Inspect `flutter devices` and Android tooling. Run on an available emulator/device; visually inspect all screens, press/release behavior, back, switching tabs and reduced motion. If no device is available, report this and retain widget layout tests as limited evidence.
- [x] Run an Android debug build if toolchain permits; do not purchase cloud builds or modify global tooling unnecessarily. Report build blockers separately from code checks. iOS remains unverified until tested on macOS/iPhone.
- [x] Mark only completed steps, record verification outcomes and summarize the reusable foundation and remaining platform limitations. Commit checkpoints only when an authorized Git repository exists.

## Self-review

Spec coverage: all screens, navigation, design tokens, shared components, stable game IDs, motion policy, local persistence, preview copy and platform limitations map to tasks above. The five review-focus conditions have assigned tests. Settings signatures are consistent between repository, controller, bootstrap and screen tasks. No backend/gameplay or unused infrastructure is added.

## Execution status

All five tasks implemented and verified. Full suite: 21/21 passed; analyzer: no issues; formatter: 42 files, 0 changes, exit 0. Android final debug APK build exited 0. Installed/launched on local API 37 emulator; Home/Profile/Settings observed; reduce-motion setting restored after process force-stop and fresh startup. iOS build/runtime and physical-device testing remain unverified. Fresh independent review completed; four Important findings fixed with RED-to-GREEN tests; three minor follow-ups recorded in docs/verification.md. No Git repository, commits, merge or push were created.
