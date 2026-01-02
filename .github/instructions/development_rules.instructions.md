---
applyTo: '**'
name: Reseller App — Development Rules
description: This file provides development rules and guidelines for the Reseller app project.
---
Provide project context and coding guidelines that AI should follow when generating code, answering questions, or reviewing changes.

# Reseller App — Development Rules (Draft)

## Context
- Stack: Flutter/Dart, null-safety, Material 3 not required. Primary target: mobile, secondary: web.
- Domain: recipe/costing/ingredients management for small businesses.
- Visual direction: warm palette (background F6EFE7, primary text 6B4A2A, accent C78B54), rounded cards, soft shadows.

## Architecture & State
- Prefer simple state (setState) for single screens; elevate to Provider/Riverpod only when shared across pages.
- Keep widgets small and composable; extract UI atoms into `lib/widgets` when reused.
- Data flow: presentation -> services -> data sources. Avoid business logic in widgets.

## Code Style
- Follow `flutter_lints`; run `flutter format`/`dart format` on touched files.
- Naming: widgets/classes UpperCamelCase, methods/fields lowerCamelCase, constants lowerCamelCase with `const` where possible.
- Imports: package imports before relative; avoid unused imports; prefer `const` constructors and widgets.

## UI/UX
- Spacing: base 8px grid; cards radius ~22; shadows subtle (`blur 18-24`, low alpha).
- Typography: use theme defaults; weights bold for headlines, medium for body; avoid custom fonts unless specified.
- Accessibility: tappable areas >= 44x44; provide semantics/labels for icons; keep contrast with warm palette.
- States: always consider loading/empty/error for data-driven sections; placeholders over blank screens.

## Assets & Colors
- Centralize colors in `AppColors` (lib/core/constants/app_constants.dart). Do not hardcode magic color values elsewhere.
- Icons: prefer Material Icons; if adding assets, place in `assets/` and register in `pubspec.yaml`.

## Networking & Data
- Keep async calls cancel-safe; avoid unawaited futures unless intentional (document).
- Parse/serialize models with `json_serializable` if model count grows; otherwise simple manual fromMap/toMap is OK.
- Error handling: surface user-friendly messages; log technical details via debug prints only in debug mode.

## Testing
- Minimum: widget tests for new screens/components; unit tests for pure logic.
- Commands: `flutter analyze`, `flutter test`; ensure they pass before delivery.

## Performance
- Use `const` widgets where stable; avoid rebuilding heavy widgets unnecessarily (keys, selectors).
- Defer large images/assets loading; prefer `CachedNetworkImage` for remote images (if added).

## Git & Review
- Keep changes scoped; avoid unrelated formatting churn.
- In reviews: call out risky logic, missing states, and test gaps first.

## How to Ask the AI
- Give path, goal, and constraints: e.g., “Implement card list in lib/screens/home.dart using AppColors and 8px spacing.”
- Provide visual/behavioral refs (screenshots, counts, sample data).
- Request outputs as summaries with file/line refs; ask for test commands to run.