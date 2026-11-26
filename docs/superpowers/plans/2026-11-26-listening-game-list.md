# Listening Game List Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the approved Chuột Nghe Lén game list from the reference.

**Architecture:** Listening-only screen selected by SkillDetailScreen, with focused header and card widgets. Reuse the catalog, theme and pressable surfaces.

**Tech Stack:** Flutter, Dart, existing material_ui and flutter_test.

**Spec:** docs/superpowers/specs/2026-11-26-listening-game-list.md

## Global Constraints

- Bundle only the approved generated header mouse; defer artwork for game banners.
- Keep the other skill screens and existing routes working.
- No new dependencies, gameplay or runtime network resources.
- Preserve Vietnamese and support small viewports and enlarged text.

## Review Focus

- 320px phone and 200% text: scroll with no overflow.
- Wide viewport: constrain content width.
- Header image: load the bundled asset successfully.
- Card taps: show coming-soon feedback rather than launch gameplay.
- Back and other skills: preserve navigation and existing detail content.

### Task 1: Listening screen and catalog

**Files:** Create listening_game_list_screen.dart, widgets/listening_header.dart, widgets/listening_game_card.dart in lib/features/skills/presentation; modify skill_detail_screen.dart, domain/game_preview.dart, data/preview_catalog.dart, pubspec.yaml; add assets/characters/listening-mouse.png.

**Interfaces:** ListeningGameListScreen accepts Skill; GamePreview gains optional difficulty/duration metadata with defaults so other catalog entries stay compatible.

- [x] Add a focused widget test covering the greeting, two games, footer, card feedback, image loading and back action; run and observe the missing screen failure.
- [x] Copy the generated mascot, register assets, implement the screen and listening metadata, and select it only for SkillId.listening.
- [x] Run the focused tests at narrow/large-text and wide sizes; adjust the navigation assertion to the new header.

### Task 2: Verification and preview

**Files:** test/app/app_navigation_test.dart, test/features/skills/listening_game_list_test.dart, tool/capture_preview.dart, docs/preview/listening-game-list.png.

- [x] Run formatting, flutter analyze and the complete test suite.
- [x] Render and visually inspect a standalone listening screen preview; resolve layout defects and rerun relevant checks.
- [x] Review the final diff and record results in this plan.

## Verification

Implemented in the shared workspace as requested. No commits or deployment performed. `flutter analyze`: no issues; `flutter test`: 29 passed. Six listening-screen scenarios cover widths 320, 390 and 1000 at text scales 1 and 2, both card actions and back navigation. Preview render passed and the bundled mascot loaded. Visual review found an unsupported box-drawing character; replaced it with a native border and reran analyze, the whole suite and preview capture successfully. Final diff reviewed locally. Preview is a widget render, not an on-device capture.
