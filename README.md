# MetroLife

A Hong Kong-focused life management app built with Flutter. MetroLife combines weather, transport, finance tracking, daily planning, exercise logging, and productivity tools into a single offline-first mobile application.

---

## Features

### 🏠 Home
- **HK Observatory Weather** — real-time temperature & humidity via HKO API (rhrread + flw), 9-day forecast with Chinese descriptions
- **KMB Bus ETA** — nearest bus stop auto-detection, live arrival times grouped by route
- **Daily Tasks Preview** — today's to-do summary at a glance
- **Focus Timer CTA** — one-tap access to the Pomodoro timer

### 📅 Daily (日程)
- **Calendar** — month view with table_calendar, colour-coded dot markers (todo / diary / salary / exercise)
- **To-Do** — three types (General, Document Renewal, Bill Reminder), swipe-to-delete and inline delete button, completion with rabbit mascot feedback
- **Diary** — daily entries with mood rating (1-5 stars), content editor, date picker

### 💰 Finance (記帳)
- **Balance Card** — monthly income / expense / balance with `$` formatting
- **Pie Chart** — spending breakdown by category (fl_chart Donut Chart)
- **Transaction CRUD** — add income or expense, auto-category selection, date picker
- **Auto Salary** — automatic income entry on configured salary day

### 🏃 Exercise (運動)
- **BMI Calculator** — metric / imperial toggle, synced with Settings, category display
- **Step Counter** — today's steps and calories from Health Connect / HealthKit
- **Exercise Logging** — Running, Swimming, Table Tennis, Cycling, Yoga, Gym with MET-based calorie calculation
- **Streak Medals** — Bronze (3 days) / Silver (7 days) / Gold (30 days) with rabbit mascot celebration

### 🐰 Diligent Rabbit (勤力兔)
- **SVG Mascot** — five scene variants (idle, money, celebrate, thumbs-up, surprised)
- **Overlay Animations** — elastic scale-in, speech bubble, auto-dismiss after 3 seconds
- **Confetti Effect** — gold confetti for achievements and focus completion
- **8 Trigger Scenes** — todo complete, income added, focus complete, 3 medal tiers, first launch, error

### ⏱️ Focus Timer (番茄鐘)
- **Full-screen Dark Mode** — gradient progress ring, monospace timer display
- **Start / Pause / Resume / Stop / Reset** controls
- **Focus ↔ Break** automatic mode switching

### ⚙️ Settings
- **Profile** — username (editable), height, weight
- **Finance** — monthly salary, salary day (1-31)
- **Focus** — focus duration (1-60 min), break duration (1-30 min)
- **Appearance** — Light / Dark theme toggle
- **Health** — Health Connect sync toggle
- **Data** — export (CSV), clear all data with confirmation
- **About** — version, privacy policy

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.41+ / Dart 3.11+ |
| State Management | Riverpod 3.x (Notifier / FutureProvider / StreamProvider) |
| Database | Drift ORM 2.x (SQLite) with code generation |
| Networking | Dio 5.x |
| Charts | fl_chart 0.71 |
| Calendar | table_calendar 3.x |
| Animations | confetti 0.8 |
| SVG | flutter_svg 2.x |
| Localization | flutter_localizations (zh_HK) |
| Persistence | SharedPreferences |
| Health | health 12.x (HealthKit + Health Connect) |
| Maps | google_maps_flutter 2.x |

---

## Architecture

```
lib/
├── core/
│   ├── constants/          # API endpoints, app constants
│   ├── theme/              # Light/Dark themes, design tokens
│   └── utils/              # Date, currency, unit, rabbit SVG helpers
├── data/
│   ├── local/              # Drift database, .drift table definitions
│   │   ├── tables/         # 8 Drift table schemas
│   │   └── database.dart   # AppDatabase with seed data
│   ├── models/             # Freezed models (weather, bus)
│   └── repositories/       # API services (HKO, KMB)
├── domain/
│   └── providers/          # Riverpod providers (all business logic)
├── presentation/
│   ├── dialogs/            # Bottom sheet forms (todo, diary, transaction, exercise)
│   ├── pages/              # 7 screens (Home, Daily, Finance, Exercise, Settings, Focus Timer, Main Shell)
│   ├── routes/             # Navigation
│   └── widgets/            # Shared widgets (cards, buttons, rabbit overlay)
└── l10n/                   # ARB localisation files (zh_HK)
```

---

## Build

### Prerequisites
- Flutter SDK 3.41+
- Android SDK 28+ (for Health Connect)
- Xcode 15+ (for iOS)

### Setup
```bash
cd metrolife
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

### Run
```bash
flutter run
```

### Build APK
```bash
# Debug
flutter build apk --debug

# Release
flutter build apk --release
```

### Build iOS
```bash
flutter build ios
```

---

## API Integration

| API | Endpoint | Purpose |
|-----|----------|---------|
| HKO FLW | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=flw` | Weather forecast |
| HKO rhrread | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=rhrread` | Real-time temp & humidity |
| HKO FND | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=fnd` | 9-day forecast |
| HKO Warning | `data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=warningInfo` | Weather warnings |
| KMB Stops | `data.etabus.gov.hk/v1/transport/kmb/stop` | All bus stop locations |
| KMB ETA | `data.etabus.gov.hk/v1/transport/kmb/stop-eta/{stop_id}` | Bus arrival times |

---

## Localisation

Currently supports **Traditional Chinese (zh_HK)** only. The i18n framework (ARB files) is in place, ready for additional locales.

| File | Locale |
|------|--------|
| `lib/l10n/arb/app_zh_HK.arb` | zh_HK (primary) |
| `lib/l10n/arb/app_zh.arb` | zh (fallback) |

---

## Design System

| Token | Light | Dark |
|-------|-------|------|
| Background | `#FAF9F6` | `#121212` |
| Card | `#FFFFFF` | `#1E1E1E` |
| Accent (Red) | `#DE2910` | `#DE2910` |
| Accent (Gold) | `#FFD700` | `#FFD700` |
| Success | `#34C759` | `#34C759` |
| Warning | `#FF9500` | `#FF9500` |
| Danger | `#FF3B30` | `#FF3B30` |

- **Border Radius**: 12px inputs, 16px small cards, 20px medium cards, 24px large cards
- **Typography**: Noto Sans TC (Chinese), system default (Latin)
- **Spacing**: 8pt grid system

---

## Privacy

- **All data stored locally** on device via SQLite
- **No cloud backend**, no account required
- Health data never leaves the device
- Location used only for real-time features (bus stop, running GPS)

---

## License

Private project. All rights reserved.
