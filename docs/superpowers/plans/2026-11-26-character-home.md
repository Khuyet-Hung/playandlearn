# Character Home Implementation Plan

**Goal:** Implement the supplied character-led home mockup in the existing Flutter app.
**Architecture:** Retain AppShell routing and shared AppPressable interactions. Replace the home presentation, isolate temporary art in CharacterAvatar, and restyle AppBottomNav.
**Tech Stack:** Flutter, Dart, material_ui.
**Spec:** docs/superpowers/specs/2026-11-26-character-home-design.md

## Constraints
No additional dependencies. Preserve route keys, navigation, scroll state, reduced motion, and enlarged text support. Counts come from PreviewCatalog.

## Tasks
- [x] Inspect home, navigation, theme, and existing layout/accessibility tests.
- [x] Implement cream/plum palette, pink welcome panel, animal skill cards and replaceable artwork.
- [x] Restyle shared navigation and align theme test with the new palette.
- [x] Run Dart formatting, Flutter analysis, and existing widget tests; fix regressions.

## Review focus
320px viewport with double text size; keyboard access to home CTA; skill navigation and back behavior; retained tab scroll position; actual preview counts and coming-soon labels.

Validation: Flutter analyze --no-pub reports no issues; flutter test --no-pub passes all 21 tests. git diff --check passes. Existing 320px/double-text test caught the welcome badge overflow; wrapping header and flexible badge text resolve it. No diagnostic test edits remain.

