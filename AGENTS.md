# MetroLife - Agent Instructions

Flutter/Dart mobile app (香港生活管家) using Clean Architecture. Dart SDK ^3.11.0, zh_HK only.

## Essential Commands

```bash
# Full codegen (clean + regenerate all)
bash scripts/build.sh

# Run app
flutter run

# Lint & analyze (MUST pass before commit)
dart analyze
dart fix --apply

# Tests
flutter test                              # all
flutter test test/widget_test.dart        # single file
flutter test --name "test name"          # by name
```

## Code Generation (Order matters)

1. `flutter clean` - clean generated files
2. `flutter pub get` - get dependencies
3. `flutter gen-l10n` - generate localizations (ARB files in `lib/l10n/arb/`)
4. `dart run drift_dev generate` - generate Drift database (tables in `lib/data/local/tables/*.drift`)
5. `dart run build_runner build --delete-conflicting-outputs` - Freezed, Retrofit, Riverpod, AutoRoute, JSON

## Architecture

```
lib/
  core/          constants, theme (AppTheme), utilities
  data/local/    Drift database (tables/, daos/, database.dart)
  data/models/   Freezed data classes
  data/repositories/ API services (HKO, KMB)
  domain/providers/ Riverpod providers
  presentation/  dialogs, pages, widgets
  l10n/          ARB files + generated AppLocalizations
```

## Code Style

- Imports: `dart:` → `package:flutter/` → third-party → `package:metrolife/`
- Use `AppTheme` constants (never hardcode colors/spacing/radii)
- Use `AppLocalizations.of(context)` for all user-facing strings
- Freezed: `abstract class` + `with _$ClassName` + `fromJson` factory + `@Default()`
- Error handling: silent failure with defaults (`null`, `false`, `0`, `[]`). No `print()`.
- Widgets: `super.key`, `ConsumerWidget`/`ConsumerStatefulWidget`, dialogs have `static void show()`

## Key Dependencies

Riverpod 3.x, Drift 2.x, Freezed 3.x, Retrofit 4.x, AutoRoute 10.x, Injectable 2.x.

## Testing

- Use `flutter test`
- No special fixtures or services required for unit tests
- Widget tests use standard Flutter testing utilities
