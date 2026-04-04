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

After editing these, re-run `dart run build_runner build --delete-conflicting-outputs`:
- Freezed models (`@freezed` in `lib/data/models/`)
- Drift tables (`.drift` in `lib/data/local/tables/`)
- Retrofit API clients (`@RestApi` in `lib/data/repositories/`)
- Riverpod providers (`@riverpod` annotation)
- AutoRoute route definitions, Injectable DI (`@Injectable`, `@singleton`)

After editing ARB files in `lib/l10n/arb/`, run `flutter gen-l10n`.

## Key Dependencies

State: `flutter_riverpod` 3.x, `riverpod_annotation` 4.x. Database: `drift` 2.x, `drift_flutter`.
Models: `freezed` 3.x, `json_serializable`. Network: `dio` 5.x, `retrofit` 4.x.
Routing: `auto_route` 10.x. DI: `injectable` 2.x, `get_it` 8.x.
Maps: `google_maps_flutter`, `geolocator`. Health: `health` 12.x.

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