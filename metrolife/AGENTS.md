# MetroLife - Agent Instructions

MetroLife is a Flutter/Dart mobile app (Hong Kong life manager, 香港生活管家) using Clean Architecture.
Dart SDK ^3.11.0. Localization: zh_HK only.

## Build & Run Commands

```bash
# Initial setup (run once)
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Full code generation (cleans + regenerates everything)
bash scripts/build.sh

# Run app
flutter run

# Build
flutter build apk --debug
flutter build apk --release
flutter build ios
```

## Lint & Analyze

```bash
dart analyze              # Static analysis (MUST pass before commit)
dart fix --apply          # Auto-fix lint issues
```

Lint rules in `analysis_options.yaml`: `prefer_const_constructors`, `prefer_const_declarations`, `avoid_print`, `prefer_single_quotes`. Suppress `invalid_annotation_target` for code gen annotations.

## Testing

```bash
flutter test                                    # Run all tests
flutter test test/widget_test.dart              # Run single test file
flutter test --name "App renders correctly"     # Run single test by name
```

Tests use `flutter_test`. Wrap widgets in `ProviderScope` for Riverpod. Use `pumpAndSettle()` for async widget operations. Test file naming: `test/<name>_test.dart`.

## Code Generation

After editing any of these, re-run `dart run build_runner build --delete-conflicting-outputs`:
- Freezed models (`@freezed` classes in `lib/data/models/`)
- Drift tables (`.drift` files in `lib/data/local/tables/`)
- Retrofit API clients (`@RestApi` in `lib/data/repositories/`)
- Riverpod providers using `@riverpod` annotation
- AutoRoute route definitions
- Injectable DI annotations (`@Injectable`, `@singleton`)

After editing ARB files in `lib/l10n/arb/`, run `flutter gen-l10n`.

## Key Dependencies

State: `flutter_riverpod` 3.x, `riverpod_annotation` 4.x
Database: `drift` 2.x (SQLite ORM), `drift_flutter`
Models: `freezed` 3.x, `json_serializable`
Network: `dio` 5.x, `retrofit` 4.x
Routing: `auto_route` 10.x
DI: `injectable` 2.x, `get_it` 8.x
Maps: `google_maps_flutter`, `geolocator`
Health: `health` 12.x (HealthKit + Health Connect)

## Architecture

```
lib/
  core/          Constants, theme (AppTheme), utilities
  data/
    local/       Drift database (tables/, daos/, database.dart)
    models/      Freezed data classes
    repositories/ API services (HealthService, KMB, HKO)
  domain/
    providers/   Riverpod providers (all business logic)
  presentation/
    dialogs/     Bottom sheet forms with static show() methods
    pages/       Screen widgets
    widgets/     Shared reusable widgets
  l10n/          Localization ARB files + generated AppLocalizations
```

## Code Style

### Imports

Order: `dart:` → `package:flutter/` → third-party packages → local `package:metrolife/...`.
Use `package:` paths for all lib/ imports — no relative paths crossing layers.

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metrolife/data/local/database.dart';
import 'package:metrolife/domain/providers/todo_provider.dart';
```

### Naming

- Files: `snake_case.dart` (`app_theme.dart`, `add_todo_dialog.dart`)
- Classes: `PascalCase` (`AppTheme`, `HealthService`, `AddTodoDialog`)
- Variables/methods: `camelCase` (`getTodaySteps()`)
- Private members: `_leadingUnderscore` (`_health`, `_configured`)
- Providers: `camelCase` + `Provider` suffix (`themeModeProvider`, `todoServiceProvider`)
- Enums/library consts: `UPPER_SNAKE_CASE`

### Widgets

Use `super.key` constructor pattern. Use `ConsumerWidget` for Riverpod access, `ConsumerStatefulWidget` for stateful + Riverpod. Provide static `show()` methods for dialogs/bottom sheets.

```dart
class MyWidget extends ConsumerWidget {
  const MyWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) { ... }
}
```

### Design Tokens

Always use `AppTheme` constants — never hardcode colors/spacing/radii:
`AppTheme.bgPrimary`, `AppTheme.spacingMd`, `AppTheme.radiusMedium`, `AppTheme.shadowSm`.

### Localization

Use `AppLocalizations.of(context)` for all user-facing strings. Never hardcode localized text.

### Error Handling

Silent failure with defaults is the standard pattern. Use `try/catch` returning safe defaults (`null`, `false`, `0`, `[]`). Do not use `print()` (lint forbids it).

```dart
try {
  return await _health.requestAuthorization(_types, permissions: permissions);
} catch (_) {
  return false;
}
```

### Database

Drift tables are defined in `.drift` files under `lib/data/local/tables/`. Use `TodosCompanion` pattern for inserts/updates. Providers expose `StreamProvider` for reactive queries.

### Static Utilities

Use private constructors for utility classes: `AppConstants._()`, `AppDateUtils._()`.

## AI Assistant Rules

No Cursor rules, Copilot instructions, or other AI config files exist in this repo. Follow this AGENTS.md as the authoritative style guide.
