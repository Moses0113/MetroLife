/// App-wide constants for MetroLife
/// 參考: prd.md Section 1, 2.1, 3.5
library;

class AppConstants {
  AppConstants._();

  // ========== App Info ==========
  static const String appName = 'MetroLife';
  static const String appVersion = '1.0.0';

  // ========== Locale ==========
  static const String localeZhHk = 'zh_HK';
  static const String localeZh = 'zh';

  // ========== Date Format (British) ==========
  static const String dateFormatDdMmYyyy = 'dd/MM/yyyy';
  static const String dateFormatDdMm = 'dd/MM';
  static const String timeFormatHhMm = 'HH:mm';

  // ========== Focus Timer Defaults ==========
  static const int defaultFocusMinutes = 25;
  static const int defaultBreakMinutes = 5;
  static const int minFocusMinutes = 1;
  static const int maxFocusMinutes = 60;
  static const int minBreakMinutes = 1;
  static const int maxBreakMinutes = 30;

  // ========== Steps Goal ==========
  static const int defaultStepsGoal = 10000;

  // ========== Health Sync ==========
  static const int healthSyncIntervalMinutes = 15;

  // ========== Cache ==========
  static const int kmbStopCacheHours = 24;

  // ========== Calorie ==========
  static const double defaultWeightKg = 60.0;
  static const double runningCaloriesFactor = 0.75;

  // ========== MET Values ==========
  static const double metSwimming = 8.0;
  static const double metTableTennis = 4.0;
  static const double metCycling = 7.5;
  static const double metYoga = 2.5;
  static const double metGym = 6.0;

  // ========== BMI Categories ==========
  static const double bmiUnderweight = 18.5;
  static const double bmiNormalMax = 24.9;
  static const double bmiOverweightMax = 29.9;

  // ========== Document Reminder Days ==========
  static const List<int> documentReminderDays = [90, 60, 30, 7];

  // ========== Rabbit ==========
  static const List<String> rabbitTodoMessages = [
    '做得好！又完成一件 💪',
    '效率滿分！繼續保持 🌟',
    '清單又短了，輕鬆曬～',
  ];
  static const List<String> rabbitIncomeMessages = [
    '距離億萬富翁又一步 💰',
    '準備去環遊世界吧 ✈️',
    '又有進帳了，繼續努力 ^_^',
  ];
  static const int rabbitDisplayDurationMs = 3000;
  static const int rabbitAnimationDurationMs = 400;

  // ========== Achievement Streak Days ==========
  static const int achievementBronzeDays = 3;
  static const int achievementSilverDays = 7;
  static const int achievementGoldDays = 30;

  // ========== Greeting Hours ==========
  static const int morningStartHour = 5;
  static const int afternoonStartHour = 12;
  static const int eveningStartHour = 18;
}
