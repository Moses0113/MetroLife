# MetroLife 技術實施架構 (Tech Spec)

## 1. 核心開發環境與策略

* **Framework:** Flutter (Latest Stable)
* **Architecture:** **Clean Architecture** + **Riverpod** (用於狀態管理，其代碼生成功能可減少 Cursor 出錯)。
* **Data Sovereignty:** 100% 本地存儲，不連接 Firebase、AWS 或任何第三方後端（天氣與交通 API 除外）。

## 2. 核心組件棧 (Tech Stack)

為確保 Cursor 生成高品質代碼，請指定其使用以下成熟庫：

| 功能模組 | 推薦組件 (Pub.dev) | 理由 |
| --- | --- | --- |
| **狀態管理** | `flutter_riverpod` + `riverpod_generator` | 比 Provider 更強大，代碼自動生成，減少人為錯誤。 |
| **本地數據庫** | `sqflite` + `drift` | Drift 提供類型安全的查詢，Cursor 處理 SQL Schema 會更準確。 |
| **日曆功能** | `table_calendar` | 目前 Flutter 最成熟的日曆 UI，支持事件點標記。 |
| **原生運動** | `pedometer` | 封裝 iOS HealthKit & Android Sensor 邏輯。 |
| **定位/地圖** | `geolocator` + `Maps_flutter` | 業界標準定位與地圖顯示方案。 |
| **數據圖表** | `fl_chart` | 用於實現運動棒形圖與記帳圓餅圖。 |
| **本地存儲** | `shared_preferences` | 用於存儲主題切換、用戶名等輕量設定。 |
| **備份與路徑** | `path_provider` + `share_plus` | 獲取本地路徑並將 JSON 備份文件導出/分享。 |

---

## 3. 數據持久化設計 (Local Database Schema)

要求 Cursor 依照以下邏輯設計 `Drift` 或 `Sqflite` 表結構：

1. **Events Table**: 存儲日曆行程、待辦事項、提醒（字段：`id, title, desc, type, startTime, endTime, isDone`）。
2. **Finance Table**: 存儲收支（字段：`id, amount, category, type[income/expense], timestamp`）。
3. **Fitness Table**: 存儲每日步數與 GPS 軌跡（字段：`id, steps, calories, distance, polylineData[Text/JSON], date`）。
4. **Journal Table**: 存儲日記內容（字段：`id, content, mood, timestamp`）。

---

## 4. API 調用標準 (Networking)

所有 API 請求應統一封裝在 `Dio` 客戶端中：

* **天氣實時**: CSDI GeoJSON (GET)
* **天氣警告**: HKO API (GET)
* **交通 ETA**: KMB API (需處理：路線列表 -> 分站列表 -> 預估到站)。

---

## 5. 本地備份邏輯 (JSON Backup/Restore)

這是防止數據遺失的唯一機制，要求 Cursor 實現：

```dart
// 偽代碼邏輯供 Cursor 參考
Future<void> exportDataAsJson() async {
  // 1. 從 SQLite 讀取所有數據表
  // 2. 將 List<Map> 轉換為 Map<String, dynamic>
  // 3. 使用 jsonEncode 序列化
  // 4. 通過 path_provider 寫入 [App_Doc_Dir]/metrolife_backup.json
  // 5. 調用 share_plus 讓用戶可以儲存到文件夾或 AirDrop
}

```

---
