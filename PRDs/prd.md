MetroLife 產品需求與技術規格文檔 (V2.0 - 完整版)
1. 項目願景
MetroLife 是一款專為香港人設計的一站式生活輔助 App。核心理念是「勤力生活，簡化雜務」。透過「勤力兔」吉祥物的互動，以及以日曆為核心的功能整合，幫助用戶掌握生活節奏。

2. 技術棧與環境
框架: Flutter

狀態管理: Riverpod (推薦) 或 Provider

本地數據庫: sqflite (SQLite)

日曆組件: table_calendar 或 syncfusion_flutter_calendar (實現專業級視圖)

數據導出: JSON 格式 (本地文件讀寫)

3. 核心功能模塊
3.1 萬用日曆系統 (Calendar Module) - 新增
此模塊需具備像 Google Calendar 的操作體驗：

多維視圖: 支持「月視圖」、「周視圖」與「日程清單 (Agenda)」切換。

事件管理:

用戶可新增自定義行程（標題、時間、地點、提醒）。

顏色標籤分類（例如：工作、私人、重要）。

跨模組聯動 (核心特色):

財務: 自動在發薪日顯示「💰薪資入帳」圖示。

運動: 完成運動後，日曆當天顯示「🐰運動達標」小圖示。

待辦: 當天到期的 To-Do 自動出現在日曆下方的列表。

日記: 點擊日期可直接跳轉或預覽當天的日記內容。

3.2 主頁面 (Home Page) - 置中導航
動態問候: 根據系統時間顯示「早晨/午安/晚安 + [用戶名]」。

當日概覽: 顯示日曆中今日的前三項重要行程。

天氣與交通: 接入 CSDI/HKO 實時天氣及九巴 KMB ETA。

番茄鐘: 全屏模式切換，完成後「勤力兔」彈出激勵語。

3.3 日常頁 (Daily Page)
待辦清單 (To-Do): 支持設置優先級，過期任務自動在日曆標紅。

續期提醒: 證件、水電煤繳費自動同步至日曆事件。

日記功能: 記錄文字與心情。

3.4 記帳頁 (Finance Page)
收支流水: 快速記帳。

自動薪金: 設置發薪日，系統自動在日曆生成循環事件。

可視化: 圓餅圖分析。

3.5 運動頁 (Fitness Page)
計步與追蹤: 原生計步器與 Google Maps GPS 跑步記錄。

數據回溯: 點擊日曆上的運動圖示，可查看當天的跑步路線圖與卡路里。

3.6 設定頁 (Settings Page)
個人化: 主題色（米白/黑）、語言（繁中/英）。

數據管理: JSON 備份與還原。

4. 數據備份與還原 (JSON Backup)
全數據備份: 導出一個名為 metrolife_backup_YYYYMMDD.json 的文件。

包含內容: calendar_events, todo_list, finance_records, activity_logs, daily_journals, user_settings。

5. 數據庫結構更新 (Calendar Extension)
SQL
-- 行程事件表
CREATE TABLE calendar_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  start_time TEXT, -- ISO8601 格式
  end_time TEXT,
  color_code TEXT,
  is_all_day INTEGER DEFAULT 0,
  related_module TEXT -- 標記是否來自 'finance', 'fitness' 或 'todo'
);
🚀 Cursor 開發指令 (針對日曆功能)
當你開始開發日曆時，可以這樣對 Cursor 說：

整合插件:

「請在 pubspec.yaml 中加入 table_calendar 插件，並在資料庫中建立 calendar_events 表。」

建立基礎日曆:

「請在日常頁實現一個月視圖日曆，要求外觀簡約，支持點擊日期顯示當天行程列表，並能彈出對話框新增事件。」

實現聯動:

「請寫一個邏輯，讓資料庫中 finance 表的發薪日和 activities 表的運動記錄，自動以小圓點或圖示的形式顯示在月日曆視圖上。」