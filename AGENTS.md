# MetroLife - Agent Instructions

MetroLife is a Flutter/Dart mobile app (Hong Kong life manager, 香港生活管家) using Clean Architecture.
Dart SDK ^3.11.0. Localization: zh_HK only.

## Build & Run Commands

```bash
# Initial setup (run once)
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Full code generation (clean + regenerate everything)
bash scripts/build.sh

# Run app
flutter run

# Build
flutter build apk --debug
flutter build ios
```

## Lint & Analyze

```bash
dart analyze              # Static analysis (MUST pass before commit)
dart fix --apply          # Auto-fix lint issues
```

Lint rules (`analysis_options.yaml`): extends `flutter_lints`, plus `prefer_const_constructors`, `prefer_const_declarations`, `avoid_print`, `prefer_single_quotes`. Suppress `invalid_annotation_target` for code gen annotations.

## Testing

```bash
flutter test                                    # Run all tests
flutter test test/widget_test.dart              # Run single test file
flutter test --name "App renders correctly"     # Run single test by name
```

Tests use `flutter_test`. Wrap widgets in `ProviderScope` for Riverpod. Use `pumpAndSettle()` for async operations. Test file naming: `test/<name>_test.dart`.

## Code Generation

After editing Drift tables (`lib/data/local/tables/*.drift`):
```bash
dart run drift_dev generate
```

After editing Freezed, Retrofit, Riverpod, AutoRoute, or JSON models:
```bash
dart run build_runner build --delete-conflicting-outputs
```

After editing ARB files in `lib/l10n/arb/`, run `flutter gen-l10n`.

## Key Dependencies

Riverpod 3.x, Drift 2.x, Freezed 3.x, Retrofit 4.x, AutoRoute 10.x, Injectable 2.x.

## Architecture

```
lib/
  core/          Constants, theme (AppTheme), utilities
  data/local/    Drift database (tables/, daos/, database.dart)
  data/models/   Freezed data classes
  data/repositories/ API services (HealthService, KMB, HKO)
  domain/providers/ Riverpod providers (all business logic)
  presentation/dialogs/ Bottom sheet forms with static show() methods
  presentation/pages/ Screen widgets
  presentation/widgets/ Shared reusable widgets
  l10n/          Localization ARB files + generated AppLocalizations
```

## Code Style

### Imports

Order: `dart:` → `package:flutter/` → third-party → local `package:metrolife/...`. Use `package:` paths for all lib/ imports.

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/local/database.dart';
```

### Naming

- Files: `snake_case.dart` | Classes: `PascalCase` | Methods/variables: `camelCase`
- Private members: `_leadingUnderscore` | Providers: `camelCase` + `Provider` suffix
- Enums/consts: `UPPER_SNAKE_CASE`

### Widgets

Use `super.key` constructor. Use `ConsumerWidget` for Riverpod, `ConsumerStatefulWidget` for stateful. Always provide `static void show()` for dialogs/bottom sheets.

### Design Tokens

Always use `AppTheme` constants — never hardcode colors/spacing/radii: `AppTheme.bgPrimary`, `AppTheme.spacingMd`, `AppTheme.radiusMedium`.

### Localization

Use `AppLocalizations.of(context)` for all user-facing strings. Never hardcode localized text.

### Freezed Models

Use `@Default()` for optional fields, `abstract class` with `with _$ClassName` mixin, and include `fromJson` factory.

### Error Handling

Silent failure with defaults. Use `try/catch` returning safe defaults (`null`, `false`, `0`, `[]`). Do not use `print()`.

### Static Utilities

Use private constructors: `AppConstants._()`, `AppDateUtils._()`.

## AI Assistant Rules

No Cursor rules (.cursor/rules/, .cursorrules) or Copilot instructions (.github/copilot-instructions.md) exist in this repo. Follow this AGENTS.md as the authoritative style guide.