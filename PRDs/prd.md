---

# MetroLife 產品需求文檔 (PRD)
**版本**: 2.0 (Production Ready)  
**產品代號**: MetroLife-HK  
**技術棧**: Flutter 3.16+ / Dart 3 / Riverpod  
**平台**: iOS 15.0+ (HealthKit) / Android API 28+ (Health Connect)  
**地區**: 香港 (HK)  
**語言**: 英式英文 (en_GB) + 繁體中文 (zh_HK)  
**商業模式**: 純免費，無廣告  

---

## 1. 產品願景 (Product Vision)

**MetroLife** 是專為香港用戶設計的**生活管家 (Life Manager)**，整合**實時天氣警報**、**智能交通**、**財務預算**、**日程規劃**及**運動健康**五大核心模組。透過吉祥物「勤力兔」(Diligent Rabbit) 的遊戲化激勵機制，培養用戶規律的生活習慣，體現「港人勤力」精神。

**核心價值主張**:  
"One App to manage your Hong Kong life — from weather warnings to your daily commute, budget, and fitness."

---

## 2. 技術架構總覽 (Technical Architecture)

### 2.1 項目結構 (Clean Architecture)
```
lib/
├── main.dart
├── app.dart                    # MaterialApp 配置 (Theme, Locale)
├── core/
│   ├── constants/              # API endpoints, colours, units
│   ├── theme/                  # 米白 (Warm Beige) / 深色 (Dark Charcoal)
│   ├── utils/                  # 單位換算 (imperial/metric), date formatting (DD/MM/YYYY)
│   └── services/               # 本地通知, 背景定位, SharedPreferences
├── data/
│   ├── models/                 # Data classes (Freezed/Equatable)
│   ├── repositories/           # SQLite / Remote API / Health Platform abstraction
│   └── datasources/            # HKO API, KMB API, Google Maps
├── domain/
│   ├── entities/               # Business logic entities
│   └── providers/              # Riverpod StateNotifiers
├── presentation/
│   ├── views/                  # 五大頁面 (Home, Daily, Finance, Exercise, Settings)
│   ├── widgets/                # 共用組件 (Diligent Rabbit, Bottom Nav, Charts)
│   └── dialogs/                # 底部面板, 彈出框
└── assets/
    ├── images/rabbit/          # 勤力兔 SVG/PNG (idle, celebrate, medal-*)
    └── fonts/                  # 中英文字體 (Noto Sans TC, Inter)
```

### 2.2 關鍵依賴 (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.18.1
  
  # 狀態管理
  flutter_riverpod: ^2.4.5
  freezed_annotation: ^2.4.1
  
  # 本地存儲
  sqflite: ^2.3.0
  shared_preferences: ^2.2.2
  path_provider: ^2.1.1
  
  # 網絡與 API
  dio: ^5.3.3
  retrofit: ^4.0.3
  
  # 地圖 (Google Maps)
  google_maps_flutter: ^2.5.0
  flutter_polyline_points: ^2.0.0
  geolocator: ^10.1.0
  
  # 健康數據 (雙平台)
  health: ^11.0.0              # iOS HealthKit + Android Health Connect
  
  # 背景執行
  flutter_foreground_task: ^6.1.2
  workmanager: ^0.5.2
  
  # 圖表與日曆
  fl_chart: ^0.65.0
  table_calendar: ^3.0.9
  
  # 工具
  units_converter: ^2.1.0      # kg/lb, m/ft 轉換
  confetti: ^0.7.0             # 勤力兔勳章動畫
  flutter_svg: ^2.0.9          # SVG 支援
  lottie: ^2.7.0               # 複雜動畫 (可選)
  
dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.5
  retrofit_generator: ^8.0.6
```

### 2.3 平台特定配置

#### iOS (ios/Runner/Info.plist)
```xml
<!-- 健康數據 (英式英文描述) -->
<key>NSHealthShareUsageDescription</key>
<string>MetroLife reads your steps and workout data to display activity charts and calculate calories burnt.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>MetroLife writes running and exercise data to keep your Health records synchronised.</string>

<!-- 定位權限 -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>We need your location to show nearby bus stops and track running routes.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Background location is required to track your running route when the app is not in the foreground.</string>
<key>NSMotionUsageDescription</key>
<string>We need motion data to count your steps.</string>

<!-- Google Maps -->
<key>GMSApiKey</key>
<string>$(GOOGLE_MAPS_API_KEY)</string>

<!-- 通知 -->
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
    <string>processing</string>
</array>
```

#### iOS (ios/Runner/Runner.entitlements)
```xml
<key>com.apple.developer.healthkit</key>
<true/>
<key>com.apple.developer.healthkit.background-delivery</key>
<true/>
<key>com.apple.developer.healthkit.access</key>
<array>
    <string>health-records</string>
</array>
```

#### Android (android/app/src/main/AndroidManifest.xml)
```xml
<!-- Health Connect (Android 9+) -->
<uses-permission android:name="android.permission.health.READ_STEPS"/>
<uses-permission android:name="android.permission.health.WRITE_STEPS"/>
<uses-permission android:name="android.permission.health.READ_EXERCISE"/>
<uses-permission android:name="android.permission.health.WRITE_EXERCISE"/>
<uses-permission android:name="android.permission.health.READ_DISTANCE"/>
<uses-permission android:name="android.permission.health.WRITE_DISTANCE"/>
<uses-permission android:name="android.permission.health.READ_TOTAL_CALORIES_BURNED"/>
<uses-permission android:name="android.permission.health.WRITE_TOTAL_CALORIES_BURNED"/>

<!-- 定位 -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>

<!-- 前台服務 -->
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_LOCATION"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

<!-- Google Maps -->
<meta-data android:name="com.google.android.geo.API_KEY"
           android:value="${GOOGLE_MAPS_API_KEY}"/>

<!-- Health Connect 意圖過濾器 -->
<intent-filter>
  <action android:name="androidx.health.ACTION_SHOW_PERMISSIONS_RATIONALE"/>
</intent-filter>
<intent-filter>
  <action android:name="android.intent.action.VIEW_PERMISSION_USAGE"/>
  <category android:name="android.intent.category.HEALTH_PERMISSIONS"/>
</intent-filter>
```

---

## 3. 功能模組詳細規格 (Functional Specifications)

### 3.1 主頁面 (Home Page) - 中央樞紐

**佈局結構**:
```
┌─────────────────────────────────────────────┐
│  [Greeting] Good Morning, [Username]        │  // 動態時段: 05-12 Morning, 12-18 Afternoon, 18-05 Evening
│                                             │
│  ┌─────────────────────────────────────┐    │
│  │  🌤️ 24°C  Partly Cloudy            │    │  // HKO 實時天氣
│  │  ⚠️ Yellow Rainstorm Warning       │    │  // 紅色警示條 (如有)
│  │  [View 9-Day Forecast →]           │    │  // 點擊展開底部面板
│  └─────────────────────────────────────┘    │
│                                             │
│  ┌─────────────────────────────────────┐    │
│  │  🚌 Nearest Stop: Queen's Road C   │    │  // 自動定位最近巴士站
│  │  Distance: 150m                     │    │
│  │  111: 3 mins | 905: 5 mins         │    │  // KMB ETA
│  │  [↻ Refresh] [Search Other Stop]    │    │
│  └─────────────────────────────────────┘    │
│                                             │
│  ┌─────────────────────────────────────┐    │
│  │  📋 Today's Tasks (3/5 completed)   │    │  // 來自 Daily Page
│  │  - Buy groceries [Tick]             │    │
│  │  - Pay electricity bill [Tick]      │    │
│  │  - Call dentist [ ]                 │    │
│  └─────────────────────────────────────┘    │
│                                             │
│  ┌─────────────────────────────────────┐    │
│  │     [🍅 Start Focus Timer]         │    │  // 大按鈕，進入全屏番茄鐘
│  └─────────────────────────────────────┘    │
└─────────────────────────────────────────────┘
```

**功能邏輯**:

| 功能 | 技術實現 | 規格 |
|------|---------|------|
| **問候語** | `DateTime.now()` | Morning (05:00-11:59), Afternoon (12:00-17:59), Evening (18:00-04:59) |
| **實時天氣** | HKO WFS API | 獲取最近氣象站溫度、濕度、天氣狀況 (Partly Cloudy/Showers/Sunny) |
| **9天預報** | HKO `fnd` API | 底部彈出面板 (BottomSheet)，顯示 General Situation + 9日每日天氣 (含 PSR 降雨概率) |
| **天氣警告** | HKO `warningInfo` | 紅色/黃色/黑色警示條，顯示警告名稱 (如 "Yellow Rainstorm Warning Signal") |
| **巴士到站** | KMB ETA API + Google Maps | 1. 獲取 GPS 坐標 <br>2. 計算與所有站點距離 (Haversine formula) <br>3. 顯示最近站點 ETA <br>4. 下拉可手動輸入站號 |

**9天預報面板 (9-Day Forecast Panel)**:
- **API**: `https://data.weather.gov.hk/weatherAPI/opendata/weather.php?dataType=fnd&lang=en`
- **顯示內容**:
  - General Situation: 天氣概況文字 (如 "A trough of low pressure is bringing showers...")
  - 每日卡片 (9張): 日期 (DD/MM)、星期、天氣圖標、最高/最低溫 (°C)、濕度 (%)、PSR (High/Medium/Low)
  - 海洋/土壤溫度 (Sea Surface Temp: North Point, Soil Temp: 0.5m & 1.0m at HK Observatory)

---

### 3.2 日常頁 (Daily Page) - 生活管理

**子頁面**: Tab 切換 (Calendar | To-Do | Diary)

**A. 日曆視圖 (Calendar)**
- **組件**: `table_calendar` (自定義主題: 米白背景，紅色/金色標記)
- **標記點系統**:
  - 🔴 紅點: 有待辦事項 (To-do)
  - 🟢 綠點: 有日記記錄 (Diary)
  - 💰 金色點: 發薪日 (Salary Day，從 Settings 讀取)
  - 🏃 藍點: 有運動記錄 (Exercise)

**B. 待辦事項 (To-Do List)**
- **類型分類**:
  1. **General**: 用戶手動輸入
  2. **Document Renewal**: 證件續期 (身份證 HKID、回鄉證 Home Return Permit、護照 Passport、會員卡 Membership)，自動計算到期前 90/60/30/7 天提醒
  3. **Bill Reminder**: 水電煤賬單 (Water/Electricity/Gas)，每月固定日期提醒
- **智能提醒**: 本地通知 (`flutter_local_notifications`)，時間為 09:00 (上午提醒)
- **完成動畫**: 勾選後觸發 Diligent Rabbit 彈出，隨機顯示英式英文鼓勵語 (見 Section 6)

**C. 日記功能 (Diary)**
- **輸入**: Markdown 輕量編輯器，支援插入圖片 (相機/相簿)
- **關聯行程**: 可標記當日行程 (自動帶入時間、地點)
- **心情評分**: 1-5 星 (可選)，影響日曆標記顏色深淺

---

### 3.3 記帳頁 (Finance Page) - 財務管理

**視覺結構**:
```
┌─────────────────────────────────────────────┐
│  This Month's Balance: £12,450.00          │  // 大字顯示，使用千分位逗號
│  Income: £20,000.00  |  Expenses: £7,550.00│
│                                             │
│  [Pie Chart: Expense Breakdown]            │  // 使用 fl_chart
│  Food 30% | Transport 20% | Shopping 15%... │
│                                             │
│  [Recent Transactions]                     │
│  - Salary (Auto)      +£20,000.00  01/03   │
│  - Lunch at Café      -£65.00      02/03   │
│  - MTR Top-up         -£200.00     02/03   │
└─────────────────────────────────────────────┘
```

**核心功能**:

| 功能 | 規格 |
|------|------|
| **自動薪金入帳** | 每月 `salaryDay` (設定頁指定 1-31 日) 自動創建收入記錄，標記為 "Recurring" |
| **收支分類** | **可自定義**: 預設 Food, Transport, Entertainment, Shopping, Housing, Medical, Utilities, Others；用戶可添加/編輯/刪除分類 |
| **貨幣格式** | 英式格式: £X,XXX.XX (小數點兩位，千分位逗號) |
| **圖表** | 圓形圖 (Pie Chart) 顯示支出佔比，支援點擊查看詳情 |
| **日曆視圖** | 顯示每日收支總額，點擊查看該日明細 |
| **勤力兔互動** | 記錄收入時，兔子穿西裝拋金幣動畫，隨機說話 (見 Section 6) |

**數據模型**:
```dart
class Transaction {
  final String id;              // UUID
  final DateTime date;          // DD/MM/YYYY 存儲
  final double amount;          // 正數收入，負數支出
  final String category;        // 自定義分類名稱
  final String? note;           // 備註
  final bool isRecurring;       // 是否每月自動 (薪金用)
  final TransactionType type;   // income / expense
}

enum TransactionType { income, expense }
```

---

### 3.4 運動頁 (Exercise Page) - 健康追蹤

**Health 整合開關 (頁面頂部)**:
```
┌─────────────────────────────────────────────┐
│  [🍏 Apple Health Connected]  [Sync Now]   │  // iOS 樣式
│  or                                         │
│  [❤️ Health Connect Connected] [Sync Now]  │  // Android 樣式
└─────────────────────────────────────────────┘
```

**功能模組**:

**A. BMI 計算器**
- **單位**: 公制 (kg, cm) / 英制 (lb, ft/in) - 可切換
- **自動填充**: 從 HealthKit/Health Connect 讀取最新體重 (若授權)
- **顯示**: BMI 數值 + 分類 (Underweight <18.5 / Normal 18.5-24.9 / Overweight 25-29.9 / Obese ≥30)
- **歷史趨勢**: 折線圖顯示體重/BMI 變化 (過去30天)

**B. 計步器 (Pedometer)**
- **數據源**: 
  - 主要: HealthKit (iOS) / Health Connect (Android) 步數
  - 備用: `pedometer` plugin (手機傳感器)
- **顯示**: 
  - 今日步數 (大字)
  - 過去7日棒形圖 (Bar Chart)
  - 目標達成率 (預設 10,000 步/日，可調整)
- **後台同步**: 每15分鐘從 Health 平台同步一次

**C. 跑步模式 (Running) - 後台 GPS**
- **開始前**: 請求 `ACCESS_BACKGROUND_LOCATION` 權限
- **運行中**:
  1. 啟動 `flutter_foreground_task` (顯示持續通知 "Recording route...")
  2. Google Maps 顯示實時路線 (Polyline，藍色線條)
  3. 每 3 秒記錄 GPS 坐標 (Lat, Lng, Timestamp, Accuracy)
  4. 實時數據: 時間、距離 (km)、配速 (min/km)、消耗卡路里
- **卡路里計算 (標準公式)**:  
  `Calories = 0.75 × weightKg × distanceKm`  
  (若用戶未設體重，默認 60kg)
- **結束後**:
  1. 計算總距離 (累積 Haversine 距離)
  2. 生成路線截圖 (Google Maps Static API 或 Widget 截圖)
  3. 保存至本地 SQLite
  4. **寫入 Health 平台**: 
     - iOS: `HKWorkout` (Activity Type: Running, 包含路線樣本)
     - Android: `ExerciseSessionRecord` + `DistanceRecord` + `TotalCaloriesBurnedRecord`

**D. 其他運動**
- **類型**: Swimming, Table Tennis, Cycling, Yoga, Gym, Others (用戶可自定義)
- **輸入**: 運動時長 (minutes)
- **卡路里計算**: `MET value × weightKg × (durationMinutes / 60)`
  - Swimming: MET 8.0
  - Table Tennis: MET 4.0
  - Cycling: MET 7.5
  - Yoga: MET 2.5
  - Gym: MET 6.0

**E. 勤力兔勳章系統**
- **檢查邏輯**: 每日 00:01 檢查 `exercise_records` 表，過去 N 天是否有記錄
- **獎勵節點**:
  - 3天連續: 銅牌 (Bronze Medal) - 兔子戴銅牌
  - 7天連續: 銀牌 (Silver Medal) - 兔子戴銀牌  
  - 30天連續: 金牌 (Gold Medal) - 兔子戴金牌+光環+撒花特效
- **中斷規則**: 昨日無運動，連續天數歸零

---

### 3.5 設定頁 (Settings Page)

**配置項目**:

| 類別 | 項目 | 規格 |
|------|------|------|
| **Profile** | Username | 顯示於首頁問候語 |
| | Height/Weight | 用於 BMI/卡路里計算 |
| **Finance** | Monthly Salary | 自動記帳用 |
| | Salary Day | 每月 1-31 日 |
| **Focus** | Focus Duration | 1-60 分鐘 (默認 25) |
| | Break Duration | 1-30 分鐘 (默認 5) |
| **Appearance** | Theme | Light (米白 #F5F5DC) / Dark (深灰 #121212) |
| | Colour Accent | 香港紅 (#DE2910) / 金色 (#FFD700) / 藍色 |
| **Language** | Locale | English (UK) / 繁體中文 (香港) |
| **Health** | Sync with Apple Health | 開關 + 權限檢查 |
| | Sync with Health Connect | 開關 + 權限檢查 |
| **Data** | Export Data | CSV 格式 (英式日期 DD/MM/YYYY) |
| | Clear All Data | 二次確認密碼 |
| **About** | Version | 顯示版本號 |
| | Privacy Policy | 連結至網頁 |

---

## 4. 數據模型與數據庫設計 (Data Layer)

### 4.1 SQLite Schema

```sql
-- 用戶配置
CREATE TABLE user_profile (
    id INTEGER PRIMARY KEY CHECK (id = 1),
    username TEXT DEFAULT 'User',
    theme_mode TEXT DEFAULT 'light', -- 'light' or 'dark'
    locale TEXT DEFAULT 'en_GB',     -- 'en_GB' or 'zh_HK'
    monthly_salary REAL,
    salary_day INTEGER CHECK (salary_day BETWEEN 1 AND 31),
    focus_duration_minutes INTEGER DEFAULT 25,
    break_duration_minutes INTEGER DEFAULT 5,
    preferred_unit TEXT DEFAULT 'metric', -- 'metric' or 'imperial'
    accent_colour TEXT DEFAULT '#DE2910',
    height_cm REAL,
    weight_kg REAL,
    health_sync_enabled INTEGER DEFAULT 0,
    rabbit_enabled INTEGER DEFAULT 1
);

-- 收支分類 (可自定義)
CREATE TABLE categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    type TEXT CHECK (type IN ('income', 'expense')),
    icon_name TEXT,          -- Flutter icon name
    colour TEXT,             -- Hex colour
    is_default INTEGER DEFAULT 0,
    sort_order INTEGER
);

-- 記帳記錄
CREATE TABLE transactions (
    id TEXT PRIMARY KEY,
    date TEXT NOT NULL,      -- ISO 8601: YYYY-MM-DD
    amount REAL NOT NULL,    -- 正數收入，負數支出
    category_id TEXT,
    note TEXT,
    is_recurring INTEGER DEFAULT 0,
    created_at INTEGER,      -- Unix timestamp
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- 待辦事項
CREATE TABLE todos (
    id TEXT PRIMARY KEY,
    title TEXT NOT NULL,
    due_date TEXT,           -- YYYY-MM-DD
    is_completed INTEGER DEFAULT 0,
    type TEXT DEFAULT 'general', -- 'general', 'document', 'bill'
    document_type TEXT,      -- 'hkid', 'passport', 'membership', etc.
    reminder_date TEXT,      -- 提醒日期
    created_at INTEGER
);

-- 日記
CREATE TABLE diary_entries (
    id TEXT PRIMARY KEY,
    date TEXT UNIQUE,        -- YYYY-MM-DD (每日一條)
    content TEXT,
    mood INTEGER CHECK (mood BETWEEN 1 AND 5),
    image_paths TEXT,        -- JSON array of file paths
    linked_event_id TEXT
);

-- 運動記錄
CREATE TABLE exercise_records (
    id TEXT PRIMARY KEY,
    type TEXT NOT NULL,      -- 'running', 'swimming', 'walking', etc.
    start_time INTEGER,      -- Unix timestamp
    duration_seconds INTEGER,
    distance_km REAL,
    route_json TEXT,         -- JSON array of {lat, lng, timestamp}
    encoded_polyline TEXT,   -- Google Maps encoded polyline
    steps INTEGER,
    calories_burned REAL,
    weight_at_time_kg REAL,
    synced_to_health INTEGER DEFAULT 0,
    health_platform_id TEXT  -- HealthKit UUID or HealthConnect ID
);

-- 勤力兔勳章記錄
CREATE TABLE rabbit_achievements (
    id TEXT PRIMARY KEY,
    type TEXT,               -- 'bronze_3days', 'silver_7days', 'gold_30days'
    achieved_at INTEGER,
    shown_to_user INTEGER DEFAULT 0
);

-- 健康同步日誌
CREATE TABLE health_sync_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sync_time INTEGER,
    platform TEXT,           -- 'apple_health', 'health_connect'
    sync_type TEXT,
    status TEXT,             -- 'success', 'failed'
    records_count INTEGER,
    error_message TEXT
);
```

### 4.2 Health Platform 適配器 (Repository Pattern)

```dart
abstract class HealthRepository {
  Future<bool> requestPermissions();
  Future<bool> hasPermissions();
  
  // 讀取
  Future<int> getSteps(DateTime date);
  Future<double> getWeight();
  
  // 寫入
  Future<String?> writeRunningWorkout(RunningRecord record);
  Future<void> deleteWorkout(String platformId);
}

// iOS 實現
class HealthKitRepository implements HealthRepository {
  final Health _health = Health();
  
  @override
  Future<String?> writeRunningWorkout(RunningRecord record) async {
    // 使用 health.writeWorkout()
    // 返回 HealthKit UUID
  }
}

// Android 實現  
class HealthConnectRepository implements HealthRepository {
  final Health _health = Health(); // health package 封裝了 Health Connect
  
  @override
  Future<String?> writeRunningWorkout(RunningRecord record) async {
    // 使用 Health Connect SDK
    // 返回 record ID
  }
}
```

---

## 5. API 集成規格 (API Integration)

### 5.1 香港天文台 (HKO)

**A. 實時天氣 (Current Weather)**
```
Endpoint: https://portal.csdi.gov.hk/server/services/common/hko_rcd_1634806665997_63899/MapServer/WFSServer
Method: GET
Params:
  service: wfs
  request: GetFeature
  typenames: current_weather_report_weather_station
  outputFormat: geojson
  maxFeatures: 50

處理邏輯:
1. 獲取所有氣象站數據
2. 比較用戶 GPS 與各站 geometry.coordinates [lng, lat]
3. 使用 Haversine 公式找出最近站點
4. 提取: temperature, humidity, weather_condition (e.g., "Mainly Cloudy")
```

**B. 天氣警告 (Weather Warnings)**
```
Endpoint: https://data.weather.gov.hk/weatherAPI/opendata/weather.php
Method: GET
Params:
  dataType: warningInfo
  lang: en  (或 tc)

響應處理:
- 檢查 details 數組
- 若存在，顯示最高級別警告 (Red > Yellow > Amber > Signal)
- 顯示: name (e.g., "Yellow Rainstorm Warning Signal"), statement
```

**C. 9天天氣預報 (9-Day Forecast)**
```
Endpoint: https://data.weather.gov.hk/weatherAPI/opendata/weather.php
Method: GET
Params:
  dataType: fnd
  lang: en

響應字段:
- generalSituation: String (天氣概況)
- weatherForecast: Array[9]
  - forecastDate: "20240302"
  - week: "Saturday" 
  - forecastMaxtemp.value: 26 (°C)
  - forecastMintemp.value: 22 (°C)
  - forecastIcon: URL (天氣圖標)
  - PSR: String (High/Medium/Low 降雨概率)
  - forecastWind: String (風向風速)
- seaTemp: {place, value, unit}
- soilTemp: [{depth, value, unit}, ...]
```

### 5.2 九巴 (KMB)

**A. 獲取所有巴士站 (緩存)**
```
Endpoint: https://data.etabus.gov.hk/v1/transport/kmb/stop
Method: GET
Response: { type, version, generated_timestamp, data: [{stop, name_en, name_tc, lat, long}, ...] }

緩存策略: 每日首次打開 App 時獲取，存儲到 SQLite，過期時間 24 小時。
```

**B. 獲取巴士站 ETA**
```
Endpoint: https://data.etabus.gov.hk/v1/transport/kmb/stop-eta/{stop_id}
Method: GET
Response: 
{
  type, version, generated_timestamp,
  data: [{
    stop: "001110",
    route: "111",
    dir: "I",           // Inbound/Outbound
    service_type: 1,
    eta_seq: 1,         // 第幾班車 (1=下一班)
    eta: "2024-03-02T14:30:00+08:00",  // ISO 8601
    rmk_tc: "", rmk_en: ""  // 備註 (e.g., "Scheduled")
  }]
}

處理邏輯:
1. 解析 eta 時間，計算相對時間 (e.g., "3 mins")
2. 過濾已過期班次 (eta < now)
3. 按 route 分組顯示
```

**C. 自動定位最近站點算法**
```dart
Future<BusStop> findNearestStop(Position userLocation) async {
  final stops = await localDatabase.getAllStops(); // 從緩存讀取
  
  BusStop nearest;
  double minDistance = double.infinity;
  
  for (var stop in stops) {
    final distance = Geolocator.distanceBetween(
      userLocation.latitude, 
      userLocation.longitude,
      stop.lat, 
      stop.long
    );
    
    if (distance < minDistance) {
      minDistance = distance;
      nearest = stop;
    }
  }
  
  return nearest..distanceMeters = minDistance;
}
```

---

## 6. 吉祥物與遊戲化設計 (Diligent Rabbit)

### 6.1 視覺設計規格

**形象描述**:
- **物種**: 垂耳兔 (Holland Lop)，顯得親切友善
- **風格**: 簡約扁平插畫 (Flat Illustration)，輕微漸變陰影
- **配色**:
  - 毛色: 米白 `#F5F5F5` (Light) / 淺灰 `#E0E0E0` (Dark mode)
  - 領帶: 香港紅 `#DE2910` 或 金色 `#FFD700`
  - 腮紅: 淡粉 `#FFB6C1`
  - 眼鏡: 深灰 `#424242` (細框)
- **特徵**: 戴細框眼鏡 (象徵專業)、繫領帶、手持文件夾或咖啡杯 (視場景而定)

**素材清單** (需放入 `assets/images/rabbit/`):

| 文件名 | 描述 | 尺寸 | 格式 |
|--------|------|------|------|
| `rabbit_idle.svg` | 站立微笑，揮手 | 200x200 | SVG |
| `rabbit_celebrate.svg` | 跳起，撒花，開心 | 300x300 | SVG |
| `rabbit_money.svg` | 穿西裝，拋金幣 | 250x250 | SVG |
| `rabbit_medal_bronze.svg` | 戴銅牌，敬禮 | 200x200 | SVG |
| `rabbit_medal_silver.svg` | 戴銀牌，豎拇指 | 200x200 | SVG |
| `rabbit_medal_gold.svg` | 戴金牌，光環，星星 | 250x250 | SVG |
| `rabbit_thumbs_up.svg` | 豎起大拇指，眨眼 | 150x150 | SVG |
| `rabbit_sleepy.svg` | 打瞌睡，ZZZ | 150x150 | SVG |
| `rabbit_surprised.svg` | 驚訝，適合錯誤提示 | 150x150 | SVG |

### 6.2 動畫規格

**彈出動畫 (Popup)**:
- **觸發**: 完成任務/達成成就時
- **動畫**: Scale 0 → 1.2 → 1.0 (ElasticOut curve)
- **持續時間**: 400ms
- **位置**: 屏幕中央或右下角 ( draggable )
- **伴隨效果**: Confetti 金色紙屑 (使用 `confetti` package) 用於金牌成就

**對話氣泡 (Speech Bubble)**:
- **形狀**: 圓角矩形，底部尖角指向兔子
- **動畫**: 淡入 (Fade in) 300ms，停留 3 秒，淡出 300ms
- **文字**: 英式英文或繁體中文，根據 Locale 切換

### 6.3 互動場景與文本

| 場景 | 觸發條件 | 兔子動作 | 英式英文文本 (en_GB) | 繁體中文 (zh_HK) |
|------|---------|---------|---------------------|-----------------|
| **待辦完成** | 勾選 To-do | 跳出，揮手 | "Well done! Another task ticked off. Cheers!" | 「做得好！又完成一件 💪」 |
| | | | "Brilliant effort! Keep up the good work." | 「效率滿分！繼續保持 🌟」 |
| | | | "Sorted! Your list is getting shorter." | 「清單又短了，輕鬆曬～」 |
| **收入記帳** | 新增收入 | 穿西裝，拋金幣 | "One step closer to becoming a millionaire. Splendid!" | 「距離億萬富翁又進一步 💰」 |
| | | | "Pack your bags—world tour incoming! 🌍" | 「準備去環遊世界吧 ✈️」 |
| | | | "Another deposit! Keep at it. ^_^" | 「又有進帳了，繼續努力 ^_^」 |
| **番茄鐘完成** | 專注時間結束 | 全屏慶祝，撒花 | "Congratulations! You've focused for [25] minutes. Time for a [5] minutes break. Fancy a cuppa?" | 「恭喜你，成功專注 [25] 分鐘，休息 [5] 分鐘。飲杯水先啦～」 |
| **銅牌 (3天)** | 連續運動3天 | 戴銅牌，敬禮 | "3 days in a row! You've earned the Bronze Diligence Medal. Jolly good!" | 「連續 3 天運動！你是真正的勤力兔！🏅」 |
| **銀牌 (7天)** | 連續運動7天 | 戴銀牌，豎拇指 | "A whole week! Silver Medal unlocked. Absolutely smashing!" | 「連續 7 天運動！你是真正的勤力兔！🏅」 |
| **金牌 (30天)** | 連續運動30天 | 戴金牌，光環，撒花 | "A month of dedication! Gold Medal status achieved. You're a true Hong Kong Diligent Rabbit! 🏆" | 「連續 30 天運動！你是傳奇勤力兔！🏆」 |
| **首次啟動** | App 首次安裝 | 揮手，眨眼 | "Hello! I'm Diligent Rabbit. Let's get your life organised, shall we?" | 「你好！我係勤力兔，一齊打理生活啦！」 |
| **錯誤/例外** | 操作失敗 | 撓頭，困惑 | "Oh dear, something went wrong. Let's try again?" | 「哎呀，出了點問題，再試一次好嗎？」 |

---

## 7. 權限與私隱 (Permissions & Privacy)

### 7.1 權限清單

| 權限 | 平台 | 用途 | 請求時機 |
|------|------|------|----------|
| **HealthKit** | iOS | 讀寫 Steps, Workouts, Weight | 首次進入 Exercise 頁 |
| **Health Connect** | Android 9+ | 讀寫 Steps, Exercise, Distance, Calories | 首次進入 Exercise 頁 |
| **Location (Always)** | Both | 跑步背景追蹤, 巴士站定位 | 首次點擊「開始跑步」或「查找巴士站」 |
| **Location (When In Use)** | Both | 顯示地圖, 計算最近站點 | 首次使用地圖功能 |
| **Activity Recognition** | Android | 計步器後台運行 | 首次開啟計步器 |
| **Motion & Fitness** | iOS | 計步器數據 | 首次開啟計步器 |
| **Notifications** | Both | 待辦提醒, 番茄鐘完成, 證件到期 | 首次設定提醒 |
| **Camera** | Both | 日記拍照 | 首次添加日記照片 |
| **Photos** | Both | 讀取相簿 | 首次選擇照片 |

### 7.2 數據私隱政策
- **所有健康數據**僅存儲於本地 SQLite，**不上傳至任何服務器**
- **位置數據**僅用於實時功能，不記錄歷史軌跡 (除用戶主動記錄的跑步路線)
- **備份**: 用戶可手動導出 CSV/JSON 到本地文件夾

---

## 8. 開發路線圖 (Development Roadmap)

### Phase 1: 基礎架構 (Week 1-2)
- [ ] 項目初始化，配置 Riverpod, SQLite, 本地通知
- [ ] 實現主題切換 (米白/深色) 與本地持久化
- [ ] 實現本地化框架 (en_GB / zh_HK)
- [ ] 底部導航欄與頁面框架

### Phase 2: 天氣與交通 (Week 3-4)
- [ ] 集成 HKO API (實時天氣 + 9天預報 + 警告)
- [ ] 集成 Google Maps SDK
- [ ] 實現自動定位與最近巴士站算法
- [ ] 集成 KMB API (ETA 查詢)

### Phase 3: 生活與財務 (Week 5-6)
- [ ] 日曆視圖 (table_calendar) 與標記系統
- [ ] 待辦事項與提醒邏輯 (證件/賬單)
- [ ] 日記功能 (Markdown + 圖片)
- [ ] 記帳系統 (自定義分類, 圓形圖, 自動薪金)

### Phase 4: 健康整合 (Week 7-9) - **最複雜階段**
- [ ] 封裝 HealthKit (iOS) 與 Health Connect (Android) Repository
- [ ] 實現雙向同步邏輯 (讀取步數, 寫入跑步記錄)
- [ ] 後台 GPS 跑步追蹤 (flutter_foreground_task)
- [ ] BMI 計算器 (單位換算)
- [ ] 勤力兔勳章系統

### Phase 5: 遊戲化與優化 (Week 10)
- [ ] 勤力兔動畫與互動 (Overlay, Confetti)
- [ ] 番茄鐘全屏模式 (橫向/直向)
- [ ] 數據導出功能 (CSV with DD/MM/YYYY format)
- [ ] 性能優化 (圖片緩存, DB 索引)
- [ ] 測試與 Bug 修復

---

## 9. Trae 開發指南 (Trae Prompting Guide)

### 9.1 System Prompt 模板

在 Trae 開始項目時，使用以下 System Prompt:

```
You are an expert Flutter developer specialising in Hong Kong localised applications. 
You are developing MetroLife, a comprehensive life management app for Hong Kong users.

CRITICAL REQUIREMENTS:
1. Language: Use British English (en_GB) for ALL user-facing text. Spellings: customise, colour, centre, behaviour, analyse.
2. Architecture: Use Riverpod for state management, following Clean Architecture (Presentation -> Domain <- Data).
3. Health Integration: Must support both iOS HealthKit AND Android Health Connect using the `health: ^11.0.0` package.
4. Maps: Use Google Maps Flutter plugin. Handle Hong Kong coordinates (WGS84).
5. Background Execution: Use flutter_foreground_task for running GPS tracking.
6. Localisation: Support both British English and Traditional Chinese (Hong Kong) using flutter_localizations.
7. UI: Support Light theme (Warm Beige #F5F5DC) and Dark theme. Use Noto Sans TC for Chinese text.
8. Date Format: Use DD/MM/YYYY (British format) throughout the app.
9. Currency: Use £ symbol with comma thousand separators (e.g., £12,450.00).
10. Mascot: Include "Diligent Rabbit" interactions on success actions using Overlay widget.

When generating code:
- Always include proper error handling with try-catch
- Use Freezed for data models
- Include British English comments
- Follow the existing project structure: lib/presentation/, lib/domain/, lib/data/
- Never use American spellings (color, center, etc.)
```

### 9.2 功能開發 Prompt 範例

**範例 1: 開發天氣卡片組件**

```
Implement the Weather Card widget for the Home Page following MetroLife PRD Section 3.1.

Specifications:
- Display current temperature and weather condition (e.g., "Partly Cloudy")
- Fetch data from HKO API: https://data.weather.gov.hk/weatherAPI/opendata/weather.php (dataType=flw for current, warningInfo for warnings)
- Show Yellow/Red/Black warning banner if active
- Include a button to open 9-Day Forecast BottomSheet
- Use Riverpod for state management (WeatherNotifier)
- Handle loading and error states gracefully
- Theme-aware: Text colours adapt to Light/Dark theme
- British English labels: "Temperature", "Humidity", "Warning"

File location: lib/presentation/views/home/widgets/weather_card.dart
```

**範例 2: 開發跑步背景服務**

```
Implement the Running Background Service using flutter_foreground_task as per PRD Section 3.4.

Requirements:
1. Start a foreground service when user presses "Start Running"
2. Display persistent notification: "MetroLife is recording your route..."
3. Track GPS coordinates every 3 seconds using geolocator
4. Calculate distance using Haversine formula
5. Calculate calories: 0.75 * weightKg * distanceKm
6. Display real-time stats on RunningPage (Time, Distance, Pace, Calories)
7. Save route as Polyline encoded string when finished
8. Write workout data to Apple HealthKit (iOS) or Health Connect (Android) upon completion
9. Handle app termination gracefully (save current progress)

Create:
- lib/domain/providers/running_provider.dart (Riverpod)
- lib/core/services/running_service.dart (Foreground task handler)
- lib/data/repositories/health_repository.dart (Health platform abstraction)
```

**範例 3: 勤力兔互動組件**

```
Implement the Diligent Rabbit mascot interaction widget.

Behaviour:
- Display as Overlay entry when triggered by events (todo completed, income added, etc.)
- Show at screen centre with speech bubble containing British English encouragement text
- Animate: Scale 0 -> 1.2 -> 1.0 with elastic curve
- Auto-dismiss after 3 seconds with fade out
- Support different rabbit images based on context (rabbit_idle, rabbit_money, rabbit_celebrate)

Trigger points:
- Todo completed -> random message from ["Well done!", "Brilliant effort!", "Sorted!"]
- Income added -> random message from ["One step closer to becoming a millionaire...", etc.]
- Achievement unlocked -> Show medal rabbit with confetti animation

File: lib/presentation/widgets/diligent_rabbit_overlay.dart
```

---

## 10. 附錄 (Appendices)

### 10.1 單位換算公式

```dart
class UnitConverter {
  // Weight
  static double kgToLb(double kg) => kg * 2.20462;
  static double lbToKg(double lb) => lb / 2.20462;
  
  // Height
  static double cmToFt(double cm) => cm / 30.48;
  static double ftToCm(double ft) => ft * 30.48;
  static double cmToIn(double cm) => cm / 2.54;
  
  // Calories (Running)
  static double calculateRunningCalories(double distanceKm, double weightKg) {
    return 0.75 * weightKg * distanceKm;
  }
  
  // Calories (Other exercises)
  static double calculateMetCalories(double met, double weightKg, int minutes) {
    return met * weightKg * (minutes / 60);
  }
}
```

### 10.2 MET 值參考表

| 運動類型 | MET 值 | 說明 |
|---------|-------|------|
| Running (8km/h) | 8.0 | 跑步 (標準速度) |
| Swimming | 8.0 | 游泳 |
| Cycling (moderate) | 7.5 | 單車 (中等強度) |
| Table Tennis | 4.0 | 乒乓球 |
| Walking (brisk) | 4.0 | 快步行 |
| Yoga | 2.5 | 瑜伽 |
| Weight Training | 6.0 | 健身 |

### 10.3 錯誤處理規範

所有 API 調用必須處理以下錯誤:
- `SocketException`: 顯示 "No internet connection. Please check your network."
- `TimeoutException`: 顯示 "Connection timed out. Please try again."
- `HttpException` (4xx/5xx): 顯示 "Unable to fetch data. Please try again later."
- `AuthorizationException` (Health): 顯示 "Please enable permissions in Settings to sync health data."

---
