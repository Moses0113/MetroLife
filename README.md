# MetroLife

香港生活管家 — Hong Kong life management app built with Flutter. Offline-first with weather, bus ETA, finance, tasks, exercise, and focus timer.

## Features

- **Home** — HKO weather (temp/humidity/9-day forecast), KMB bus ETA, today's tasks, focus timer shortcut
- **Daily** — Calendar with color-coded dots, to-do (3 types), diary with mood rating
- **Finance** — Monthly balance card, pie chart by category, transaction CRUD, auto salary
- **Exercise** — BMI calculator, step counter (HealthKit/Health Connect), exercise logging with MET calories, streak medals
- **Focus Timer** — Full-screen Pomodoro with progress ring, focus/break auto-switch
- **Settings** — Profile, finance config, focus durations, theme toggle, health sync, data export

## Build

```bash
# Full codegen (clean + regenerate)
bash scripts/build.sh

# Or manually:
flutter pub get
dart run drift_dev generate
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n

# Run
flutter run

# Analyze (required before commit)
dart analyze
dart fix --apply
```

## Architecture

```
lib/
  core/          constants, theme (AppTheme), utilities
  data/local/    Drift database (tables/, daos/)
  data/models/   Freezed data classes
  data/repositories/ API services (HKO, KMB)
  domain/providers/ Riverpod providers
  presentation/  dialogs, pages, widgets
  l10n/          ARB files + generated AppLocalizations
```

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.41+ / Dart 3.11+ |
| State | Riverpod 3.x |
| Database | Drift 2.x (SQLite) |
| Networking | Dio 5.x + Retrofit 4.x |
| Charts | fl_chart |
| Calendar | table_calendar |
| Health | health 12.x (HealthKit + Health Connect) |
| Maps | google_maps_flutter |

## API Integration

| Service | Endpoint | Purpose |
|---------|----------|---------|
| HKO rhrread | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=rhrread` | Real-time temp & humidity |
| HKO flw | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=flw` | Weather forecast |
| HKO fnd | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=fnd` | 9-day forecast |
| HKO warningInfo | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=warningInfo` | Weather warnings |
| KMB stops | `data.etabus.gov.hk/v1/transport/kmb/stop` | Bus stop locations |
| KMB ETA | `data.etabus.gov.hk/v1/transport/kmb/stop-eta/{stop_id}` | Bus arrival times |

## Privacy

All data stored locally on device. No cloud backend, no account required. Health data never leaves the device.
