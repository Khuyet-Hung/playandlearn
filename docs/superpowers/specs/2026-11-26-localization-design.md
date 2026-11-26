# Vietnamese and English localization

Scope confirmed in conversation: Vietnamese and English, selected by two flag buttons. Reuse the existing settings persistence and keep the control simple.

## Design

- Default to Vietnamese; restore a saved `vi` or `en` preference on startup.
- Place Vietnam and UK flag buttons side by side in the home header. Highlight the selected language, expose language names and selection to accessibility, and support keyboard activation. Draw flags locally so Windows and web do not depend on flag emoji support.
- Keep flag touch targets at least 48×48. Allow home content to scroll on short screens or with large text instead of shrinking the entire header.
- Translate all app interface copy, catalog descriptions, notifications, accessibility labels, and settings errors. Keep the Play & Learn brand and English learning content as appropriate.
- Save the language through SettingsRepository/SettingsController using SharedPreferencesAsync. Commit the language after a successful write, disable controls during loading/saving, and expose a localized error and retry on failure.
- Change MaterialApp.locale without replacing the navigator or resetting the selected tab or scroll positions.

## Approaches

Use Flutter's official ARB and gen-l10n tooling with flutter_localizations and intl. This follows the user's request to use Flutter's localization library and supplies typed translation accessors. A hand-written dictionary would duplicate Flutter tooling; another localization framework adds a dependency without a requirement that needs it.

For Flutter 3.50/material_ui, configure AppLocalizations.delegate with GlobalMaterialLocalizations.delegates from material_ui explicitly, as documented by Flutter.

## Validation

Check both languages throughout navigation, language restoration, missing/unsupported saved values, storage failure and retry, rapid taps, and 320×640 layouts at 200% text size. Run Flutter analyze and the full test suite.

## Implementation notes

The selector is also available in Settings. It belongs to the settings feature so the core layer does not import a feature controller. All game metadata now supplies localized difficulty and duration explicitly.

Visual inspection caught the pre-existing home header scaling the flag targets below 48px at 200% text size. A regression test reproduced this in both languages; removing header scaling and allowing scroll at large text made both tests pass. The standard text layout continues to show all four friend cards without scrolling.

Generated previews in `.superpowers/localization/` are widget renders with local Roboto and Material icon fonts, not device screenshots.
