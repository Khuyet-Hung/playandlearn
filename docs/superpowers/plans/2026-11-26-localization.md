# Localization Implementation Plan

> **For agentic workers:** Implement in the current session task by task.

**Goal:** Support Vietnamese and English throughout the app with two flag buttons and a saved preference.

**Architecture:** Flutter gen-l10n generates AppLocalizations from ARB files. Existing settings state owns locale persistence; MaterialApp rebuilds localized descendants without resetting navigation.

**Tech Stack:** Flutter, material_ui, flutter_localizations, intl, shared_preferences.

**Spec:** docs/superpowers/specs/2026-11-26-localization-design.md

## Global Constraints

- Default `vi`; supported languages `vi` and `en`.
- Two flag buttons, no language menu or dialog.
- Retain the existing motion setting and storage retry behavior.
- Use material_ui's GlobalMaterialLocalizations.delegates.

## Review Focus

- Unsupported persisted locale falls back to Vietnamese.
- Failed writes preserve the confirmed selection and retry the intended language.
- Repeated taps during a pending write cannot race preference writes.
- Language changes preserve selected tabs and navigation.
- Both languages fit 320×640 at 200% text size.

### Task 1: Localization and persistence

Files: pubspec.yaml, l10n.yaml, lib/l10n/, settings_repository.dart, settings_controller.dart, settings tests and fakes.

- [x] Add tests for language default, restoration, invalid values, storage failure/retry, concurrent writes, and real SharedPreferences persistence; observe failure.
- [x] Add ARB resources and generate AppLocalizations. Add `readLanguageCode()` and `writeLanguageCode(String)` to SettingsRepository. Add `locale` and `setLanguageCode(String)` to SettingsController; localize existing errors.
- [x] Generate translations and run settings tests.

### Task 2: Localized app and flag controls

Files: lib/app/app.dart, lib/app/shell/app_shell.dart, lib/features/**/presentation/, lib/core/widgets/, lib/features/skills/data/, test/app/localization_test.dart, README.md.

- [x] Add widget tests for switching, navigation, restoration, and small layouts. Existing accessibility tests continue to pass.
- [x] Configure locale/delegates, translate UI and catalog metadata, add a reusable flag selector in the home header and settings, and preserve navigation state.
- [x] Run format, analyze, complete test suite, and web build. Review diff and document results.

## Verification results

- `dart format lib test tool`: completed.
- `flutter analyze`: no issues found.
- `flutter test`: 39 tests passed.
- `flutter test tool/capture_preview.dart --plain-name 'capture localized home'`: passed; inspected Vietnamese/English renders and the large-text layout.
- `flutter build web`: succeeded, including the Wasm compatibility dry run.
- `git diff --check`: passed.
- Review performed locally by the implementer; no device runtime verification in this change.
