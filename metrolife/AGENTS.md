# MetroLife - Agent Instructions

MetroLife is a Flutter/Dart mobile app (Hong Kong life manager) using Clean Architecture.

## Build & Run Commands

```bash
# Initial setup (run once)
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Full code generation (use after model/provider/schema changes)
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

Tests use `flutter_test`. Wrap widgets in `ProviderScope` for Riverpod. Use `pumpAndSettle()` for async operations.

## Code Generation

After editing any of these, re-run `dart run build_runner build --delete-conflicting-outputs`:
- Freezed models (`@freezed` classes)
- Drift tables (`.drift` files in `lib/data/local/tables/`)
- Retrofit API clients
- Riverpod providers using `@riverpod`
- AutoRoute route definitions
- Injectable DI annotations

After editing ARB files in `lib/l10n/`, run `flutter gen-l10n`.

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
    dialogs/     Bottom sheet forms
    pages/       Screen widgets
    widgets/     Shared reusable widgets
  l10n/          Localization (zh_HK)
```

## Code Style

### Imports

Order: `dart:` → `package:flutter/` → third-party packages → local (package:metrolife/...). Use `package:` paths for all lib/ imports (no relative paths crossing layers).

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
- Enums/consts: `UPPER_SNAKE_CASE` for library-level constants

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

Use `AppLocalizations.of(context)` for all user-facing strings. Never hardcopy localized text.

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
