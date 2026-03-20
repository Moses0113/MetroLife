---

# MetroLife 技術架構文檔 v2.0
**架構原則**: Code-First + Generated-First | **部署模式**: 純本地離線優先  
**代碼生成率目標**: >70% (減少手寫代碼，降低 Bug 率)

---

## 1. 核心技術棧 (Mature Stack)

### 1.1 代碼生成驅動層 (Must-Have Generators)
這些套件能將聲明式代碼轉換為完整實現，Trae 只需維護定義文件：

| 套件 | 用途 | 生成內容 | 版本 |
|------|------|----------|------|
| **drift_dev** | 本地數據庫 | DAO、SQL 查詢、Migration | `^2.15.0` |
| **freezed** | 數據模型 | copyWith、JSON、Union Types | `^2.4.7` |
| **retrofit_generator** | API 客戶端 | Dio 接口實現、序列化 | `^8.0.6` |
| **riverpod_generator** | 狀態管理 | Provider 實現、依賴注入 | `^2.3.10` |
| **auto_route_generator** | 導航路由 | 類型安全路由、深度鏈接 | `^7.3.2` |
| **flutter_gen** | 資源管理 | 類型安全 Asset 路徑、字體 | `^5.4.0` |
| **json_serializable** | JSON 處理 | fromJson/toJson 實現 | `^6.7.1` |
| ** Injectable** | 依賴注入 | 服務定位器 (替代 GetIt) | `^2.3.2` |

### 1.2 基礎設施層 (Zero-Cloud Infrastructure)

```yaml
# pubspec.yaml - 核心依賴
dependencies:
  # 本地數據庫 (Drift = SQLite 的高級 ORM)
  drift: ^2.15.0
  sqlite3_flutter_libs: ^0.5.20  # 原生 SQLite 引擎
  
  # 本地文件存儲
  path_provider: ^2.1.2          # 應用目錄訪問
  path: ^1.8.3                   # 路徑操作
  
  # 本地鍵值存儲
  shared_preferences: ^2.2.2     # 輕量配置
  
  # 本地通知 (無需 FCM/APNs 後台)
  awesome_notifications: ^0.9.3  # 支持自定義布局和進度通知
  
  # 本地健康數據 (設備原生存儲)
  health: ^11.0.0                # HealthKit / Health Connect
  
  # 本地後台處理 (純本地計算)
  workmanager: ^0.5.2            # 本地定時任務 (非雲端)
  flutter_foreground_task: ^6.1.2 # 前台服務 (跑步追蹤)
  
  # 本地權限管理
  permission_handler: ^11.3.0    # 統一權限接口
  
  # 本地加密 (敏感數據)
  encrypt: ^5.0.1                # AES 加密本地數據
  flutter_secure_storage: ^9.0.0 # Keychain/Keystore 存密鑰

dev_dependencies:
  build_runner: ^2.4.8           # 代碼生成引擎
  drift_dev: ^2.15.0             # 數據庫生成器
  freezed: ^2.4.7                # 模型生成器
  retrofit_generator: ^8.0.6     # API 生成器
  riverpod_generator: ^2.3.10    # 狀態生成器
  auto_route_generator: ^7.3.2   # 路由生成器
  flutter_gen_runner: ^5.4.0     # 資源生成器
  injectable_generator: ^2.4.0   # DI 生成器
  custom_lint: ^0.6.4            # Riverpod 靜態分析
```

---

## 2. 項目結構 (Generated Architecture)

採用 **分層代碼生成** 結構，Trae 只需編輯 `*.drift`、`*.dart` (帶註解)、`*.yaml` 文件：

```
lib/
├── core/
│   ├── constants/              # 手寫：常量定義
│   ├── theme/                  # 手寫：主題配置
│   └── generated/              # 生成：顏色/字體生成的類
│
├── data/
│   ├── local/                  # 本地數據層 (零雲端)
│   │   ├── database.dart       # 聲明：Drift 數據庫 (@DriftDatabase)
│   │   ├── database.g.dart     # 生成：自動生成 (不編輯)
│   │   ├── tables/             # 聲明：表定義 (.drift 文件)
│   │   │   ├── user.drift
│   │   │   ├── transactions.drift
│   │   │   └── workouts.drift
│   │   └── daos/               # 聲明：數據訪問對象 (部分生成)
│   │       └── user_dao.dart   # 使用 @DriftDatabase 生成
│   │
│   ├── models/                 # 聲明：Freezed 數據類
│   │   ├── user_model.dart     # @freezed 註解
│   │   ├── user_model.freezed.dart # 生成
│   │   └── user_model.g.dart   # 生成 JSON
│   │
│   ├── api/                    # 聲明：Retrofit 接口
│   │   ├── hko_api.dart        # @RestApi 註解
│   │   ├── hko_api.g.dart      # 生成實現
│   │   └── kmb_api.dart
│   │
│   └── repositories/           # 手寫/生成混合：業務邏輯
│       └── transaction_repo.dart # @riverpod 註解生成 Provider
│
├── domain/
│   └── providers/              # 聲明：Riverpod 業務層
│       ├── auth_provider.dart  # @riverpod 函數
│       └── auth_provider.g.dart # 生成狀態管理
│
├── presentation/
│   ├── routes/                 # 聲明：AutoRoute 配置
│   │   ├── app_router.dart     # @MaterialAutoRouter
│   │   └── app_router.gr.dart  # 生成路由表
│   │
│   ├── pages/                  # 手寫：頁面 Widget
│   └── widgets/                # 手寫：組件
│
├── generated/                  # 集中生成文件
│   ├── assets.gen.dart         # FlutterGen 生成
│   └── fonts.gen.dart          # 字體路徑生成
│
└── main.dart                   # 入口 (極簡)
```

---

## 3. 代碼生成配置 (Zero-Handwriting Config)

### 3.1 Drift 數據庫 (替代手寫 SQL)

**文件**: `lib/data/local/tables/transactions.drift`
```sql
-- 聲明式表定義，生成 Dart 類和類型安全查詢
CREATE TABLE transactions (
    id TEXT NOT NULL PRIMARY KEY,
    date INTEGER NOT NULL,              -- Unix timestamp
    amount REAL NOT NULL,               -- 正數收入/負數支出
    category_id TEXT NOT NULL,
    note TEXT,
    is_recurring BOOLEAN DEFAULT FALSE,
    created_at INTEGER DEFAULT (cast(strftime('%s', 'now') as int))
) AS TransactionTable;

-- 生成複雜查詢方法，無需手寫 SQL
getMonthlySummary(INT month, INT year):
SELECT 
    SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) as income,
    SUM(CASE WHEN amount < 0 THEN amount ELSE 0 END) as expense,
    SUM(amount) as balance
FROM transactions
WHERE strftime('%m', datetime(date, 'unixepoch')) = printf('%02d', month)
  AND strftime('%Y', datetime(date, 'unixepoch')) = cast(year as TEXT);

-- 生成流式查詢 (自動更新 UI)
watchAllTransactions:
SELECT * FROM transactions ORDER BY date DESC;
```

**文件**: `lib/data/local/database.dart`
```dart
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';  // 生成文件

@DriftDatabase(
  tables: [TransactionTable, UserTable, WorkoutTable, TodoTable],
  queries: {
    'getCategoryTotal': 'SELECT category_id, SUM(amount) as total '
        'FROM transactions GROUP BY category_id',
  },
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'metrolife_db');  // 本地 SQLite 文件
  }
}
```

**生成命令**:
```bash
dart run build_runner build --delete-conflicting-outputs
```
**輸出**: `database.g.dart` 包含：
- 類型安全的 `TransactionTableData` 類
- `getMonthlySummary()` 方法 (自動參數綁定)
- `watchAllTransactions()` Stream (響應式更新)
- Migration 輔助工具

### 3.2 Freezed 模型 (替代手寫 Model)

**文件**: `lib/data/models/transaction_model.dart`
```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required DateTime date,
    required double amount,
    required String categoryId,
    String? note,
    @Default(false) bool isRecurring,
  }) = _Transaction;

  // 生成 JSON 序列化 (本地存儲用)
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}

// 生成內容包括：
// - copyWith()
// - == 和 hashCode
// - toString()
// - toJson() / fromJson()
```

### 3.3 Retrofit API (替代手寫 Dio)

**文件**: `lib/data/api/hko_api.dart`
```dart
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'hko_api.g.dart';

@RestApi(baseUrl: "https://data.weather.gov.hk/weatherAPI/opendata/")
abstract class HkoApi {
  factory HkoApi(Dio dio, {String baseUrl}) = _HkoApi;

  @GET("weather.php")
  Future<WeatherResponse> getCurrentWeather(
    @Query("dataType") String dataType,  // "flw", "fnd", "warningInfo"
    @Query("lang") String lang,          // "en", "tc"
  );

  @GET("weather.php")
  Future<NineDayForecast> getNineDayForecast(
    @Query("dataType") String dataType,  // "fnd"
    @Query("lang") String lang,
  );
}
```

**生成內容**: `hko_api.g.dart` 包含完整的 Dio 調用、錯誤處理、JSON 解析。

### 3.4 Riverpod Generator (替代手寫 Provider)

**文件**: `lib/domain/providers/transaction_provider.dart`
```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_provider.g.dart';

// 生成 FutureProvider 自動緩存
@riverpod
Future<List<Transaction>> monthlyTransactions(
  MonthlyTransactionsRef ref, {
  required int month,
  required int year,
}) async {
  final db = ref.watch(databaseProvider);
  final data = await db.getMonthlySummary(month, year);
  return data.map((e) => Transaction.fromDrift(e)).toList();
}

// 生成 StreamProvider 實時更新
@riverpod
Stream<List<Transaction>> transactionStream(TransactionStreamRef ref) {
  final db = ref.watch(databaseProvider);
  return db.watchAllTransactions().map(
    (rows) => rows.map((r) => Transaction.fromDrift(r)).toList(),
  );
}

// 生成 Notifier 處理狀態變更
@riverpod
class TransactionController extends _$TransactionController {
  @override
  FutureOr<void> build() async {}

  Future<void> addTransaction(Transaction transaction) async {
    final db = ref.read(databaseProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await db.into(db.transactionTable).insert(transaction.toCompanion());
    });
  }
}
```

**生成內容**: `transaction_provider.g.dart` 包含：
- `monthlyTransactionsProvider` (Family Provider，自動處理參數變化)
- `transactionStreamProvider` (Stream，UI 自動刷新)
- `transactionControllerProvider` (Notifier，支持 loading/error 狀態)

### 3.5 AutoRoute (替代手寫導航)

**文件**: `lib/presentation/routes/app_router.dart`
```dart
import 'package:auto_route/auto_route.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: DailyPage),
    AutoRoute(page: FinancePage),
    AutoRoute(page: ExercisePage),
    AutoRoute(page: SettingsPage),
    AutoRoute(page: FocusTimerPage, fullscreenDialog: true),
    AutoRoute(page: NineDayForecastSheet),  // 底部彈出
  ],
)
class AppRouter extends _$AppRouter {}
```

**使用方式**:
```dart
// 無需 BuildContext 的全局導航
context.router.push(const FinanceRoute());

// 類型安全參數傳遞
context.router.push(FocusTimerRoute(duration: 25));

// 深度鏈接自動處理
```

### 3.6 FlutterGen (替代手寫 Asset 路徑)

**文件**: `pubspec.yaml`
```yaml
flutter:
  assets:
    - assets/images/rabbit/
    - assets/fonts/

flutter_gen:
  output: lib/generated/
  integrations:
    flutter_svg: true
    lottie: true
```

**生成內容**: `lib/generated/assets.gen.dart`
```dart
// 類型安全訪問，無需手寫字符串
Image.asset(Assets.images.rabbit.idle.path)  // 自動補全和編譯檢查
SvgPicture.asset(Assets.images.rabbit.medalBronze)  // SVG 支持
```

---

## 4. 本地數據架構 (Offline-First Architecture)

### 4.1 數據存儲層級 (Zero Cloud)

| 數據類型 | 存儲方案 | 加密 | 備份 |
|---------|---------|------|------|
| **結構化數據** | Drift (SQLite) | SQLCipher (可選) | 本地 JSON 導出 |
| **圖片/文件** | 應用文檔目錄 (`path_provider`) | 否 | 用戶手動導出 |
| **配置** | SharedPreferences | 否 | 隨 DB 導出 |
| **敏感數據** | flutter_secure_storage | AES-256 | 設備 Keychain |
| **健康數據** | HealthKit/Health Connect (只讀緩存) | 系統級 | 不存儲，實時讀取 |

### 4.2 本地同步策略 (Health Data)

```dart
// 不存儲健康數據到雲端，僅緩存到本地 DB
@riverpod
class HealthSync extends _$HealthSync {
  @override
  FutureOr<void> build() => null;

  Future<void> syncSteps() async {
    final health = Health();
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    
    // 從 HealthKit/Health Connect 讀取
    final steps = await health.getHealthDataFromTypes(
      types: [HealthDataType.STEPS],
      startTime: yesterday,
      endTime: now,
    );
    
    // 僅存入本地 SQLite (Drift)
    final db = ref.read(databaseProvider);
    for (final step in steps) {
      await db.into(db.healthCacheTable).insert(
        HealthCacheTableCompanion(
          date: Value(step.dateFrom),
          value: Value(double.parse(step.value)),
          type: const Value('steps'),
        ),
      );
    }
  }
}
```

### 4.3 本地文件存儲 (圖片)

```dart
// 完全本地存儲，無雲端上傳
@riverpod
class LocalFileStorage extends _$LocalFileStorage {
  late final Directory _appDir;
  
  @override
  FutureOr<void> build() async {
    _appDir = await getApplicationDocumentsDirectory();
  }

  Future<String> saveImage(File sourceFile, String fileName) async {
    final imagesDir = Directory('${_appDir.path}/images');
    if (!await imagesDir.exists()) await imagesDir.create();
    
    final destPath = '${imagesDir.path}/$fileName';
    await sourceFile.copy(destPath);
    
    // 僅返回本地路徑，無 URL
    return destPath;
  }
  
  Future<void> deleteImage(String path) async {
    final file = File(path);
    if (await file.exists()) await file.delete();
  }
}
```

---

## 5. 本地後台處理 (Local Background Tasks)

### 5.1 定時提醒 (純本地)

使用 `workmanager` (Android) + `BGTaskScheduler` (iOS)，無需雲端推送：

```dart
// main.dart
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'dailyNotification':
        await showLocalNotification(
          title: 'Good Morning!',
          body: 'Check your tasks for today',
        );
        break;
      case 'billReminder':
        await checkUpcomingBills();  // 查詢本地 DB
        break;
    }
    return Future.value(true);
  });
}

void main() {
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    'dailyCheck',
    'dailyNotification',
    frequency: const Duration(hours: 24),
    constraints: Constraints(networkType: NetworkType.not_required), // 無需網絡
  );
  runApp(MyApp());
}
```

### 5.2 前台服務 (跑步追蹤)

```dart
// 純本地 GPS 追蹤，數據不離開設備
@pragma('vm:entry-point')
void startForegroundTaskCallback() {
  FlutterForegroundTask.setTaskHandler(RunningTaskHandler());
}

class RunningTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    // 本地定位服務
    Geolocator.getPositionStream().listen((position) {
      // 直接寫入本地 DB，無網絡傳輸
      _saveLocationToLocalDb(position);
    });
  }
}
```

---

## 6. 構建與部署 (Local Build Pipeline)

### 6.1 代碼生成腳本

**文件**: `scripts/build.sh`
```bash
#!/bin/bash
# 一鍵生成所有代碼，Trae 無需手寫

echo "🚀 Generating MetroLife Code..."

# 1. 清理舊生成文件
flutter clean
rm -rf lib/**/*.g.dart lib/**/*.freezed.dart lib/generated/

# 2. 獲取依賴
flutter pub get

# 3. 順序生成 (依賴順序很重要)
echo "📦 Generating Drift Database..."
dart run drift_dev generate

echo "🏗️ Generating Freezed Models..."
dart run build_runner build --delete-conflicting-outputs

echo "🌐 Generating Retrofit APIs..."
dart run retrofit_generator:retrofit_generator lib/data/api/

echo "🧭 Generating AutoRoute..."
dart run auto_route_generator:generate

echo "🎨 Generating Assets..."
dart run flutter_gen:flutter_gen_command

echo "✅ All generated! Ready for build."
```

### 6.2 本地 CI 配置 (可選)

**文件**: `.github/workflows/local-build.yml` (僅構建，無雲端部署)
```yaml
name: Local Build Check
on: [push]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: ./scripts/build.sh
      - run: flutter build apk --release  # 本地 APK
      - run: flutter build ios --release --no-codesign  # 本地 iOS
```

---

## 7. 安全與隱私 (Local-Only Security)

### 7.1 數據加密方案

```dart
// 敏感字段本地加密 (如身份證號碼)
import 'package:encrypt/encrypt.dart';

class LocalEncryption {
  final _key = Key.fromSecureRandom(32);  // 存儲於 Keychain
  final _iv = IV.fromLength(16);
  
  String encrypt(String plainText) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.encrypt(plainText, iv: _iv).base64;
  }
  
  String decrypt(String encrypted) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.decrypt64(encrypted, iv: _iv);
  }
}
```

### 7.2 零網絡傳輸聲明

**文件**: `PRIVACY.md` (應用內展示)
```markdown
MetroLife Privacy Guarantee:
- ❌ No cloud servers
- ❌ No data transmission to internet
- ❌ No third-party analytics (Firebase/Amplitude)
- ✅ All data stored on your device only
- ✅ Health data read locally from Apple Health/Google Health Connect
- ✅ Images stored in app documents folder
- ✅ You own and control all your data
```

---

## 8. Trae 開發指令集 (Prompts for AI)

### Prompt 1: 生成新數據表
```
在 lib/data/local/tables/workouts.drift 中定義跑步記錄表：
- 包含 id, start_time, duration, distance, calories, route_polyline
- 創建查詢：getWeeklyTotal(weekNumber) 計算週總距離
- 創建流式查詢：watchRecentRuns(limit: 10)

運行 build_runner 生成代碼後，創建對應的 WorkoutModel Freezed 類。
```

### Prompt 2: 生成 API 接口
```
為 KMB 巴士 API 創建 Retrofit 接口：
Base URL: https://data.etabus.gov.hk/v1/transport/kmb/
Endpoints:
- GET /stop-eta/{stop_id} 獲取到站時間
- GET /stop 獲取所有站點列表

使用 @RestApi 生成代碼，創建對應的 KmbApiProvider。
```

### Prompt 3: 生成頁面路由
```
使用 AutoRoute 為番茄鐘頁面創建路由：
- 路徑：/focus
- 參數：int duration (默認 25)
- 類型：全屏對話框 (fullscreenDialog: true)
- 過渡動畫：底部滑入

生成路由表並更新 main.dart。
```

---
