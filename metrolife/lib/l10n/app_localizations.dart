import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('zh'),
    Locale('zh', 'HK'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In zh_HK, this message translates to:
  /// **'MetroLife'**
  String get appTitle;

  /// No description provided for @appTitleDescription.
  ///
  /// In zh_HK, this message translates to:
  /// **'MetroLife 香港生活管家'**
  String get appTitleDescription;

  /// No description provided for @home.
  ///
  /// In zh_HK, this message translates to:
  /// **'首頁'**
  String get home;

  /// No description provided for @daily.
  ///
  /// In zh_HK, this message translates to:
  /// **'日程'**
  String get daily;

  /// No description provided for @finance.
  ///
  /// In zh_HK, this message translates to:
  /// **'記帳'**
  String get finance;

  /// No description provided for @exercise.
  ///
  /// In zh_HK, this message translates to:
  /// **'運動'**
  String get exercise;

  /// No description provided for @settings.
  ///
  /// In zh_HK, this message translates to:
  /// **'設定'**
  String get settings;

  /// No description provided for @goodMorning.
  ///
  /// In zh_HK, this message translates to:
  /// **'早晨'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In zh_HK, this message translates to:
  /// **'午安'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In zh_HK, this message translates to:
  /// **'晚上好'**
  String get goodEvening;

  /// No description provided for @view9DayForecast.
  ///
  /// In zh_HK, this message translates to:
  /// **'查看9天天氣預報'**
  String get view9DayForecast;

  /// No description provided for @nearestStop.
  ///
  /// In zh_HK, this message translates to:
  /// **'最近站點'**
  String get nearestStop;

  /// No description provided for @distanceAway.
  ///
  /// In zh_HK, this message translates to:
  /// **'米'**
  String get distanceAway;

  /// No description provided for @refresh.
  ///
  /// In zh_HK, this message translates to:
  /// **'刷新'**
  String get refresh;

  /// No description provided for @searchOtherStop.
  ///
  /// In zh_HK, this message translates to:
  /// **'搜尋其他站點'**
  String get searchOtherStop;

  /// No description provided for @todaysTasks.
  ///
  /// In zh_HK, this message translates to:
  /// **'今日任務'**
  String get todaysTasks;

  /// No description provided for @completedTasks.
  ///
  /// In zh_HK, this message translates to:
  /// **'已完成'**
  String get completedTasks;

  /// No description provided for @startFocusTimer.
  ///
  /// In zh_HK, this message translates to:
  /// **'開始專注計時'**
  String get startFocusTimer;

  /// No description provided for @focusMinutes.
  ///
  /// In zh_HK, this message translates to:
  /// **'{minutes} 分鐘'**
  String focusMinutes(Object minutes);

  /// No description provided for @calendar.
  ///
  /// In zh_HK, this message translates to:
  /// **'日曆'**
  String get calendar;

  /// No description provided for @todo.
  ///
  /// In zh_HK, this message translates to:
  /// **'待辦'**
  String get todo;

  /// No description provided for @diary.
  ///
  /// In zh_HK, this message translates to:
  /// **'日記'**
  String get diary;

  /// No description provided for @addTask.
  ///
  /// In zh_HK, this message translates to:
  /// **'新增任務'**
  String get addTask;

  /// No description provided for @general.
  ///
  /// In zh_HK, this message translates to:
  /// **'一般'**
  String get general;

  /// No description provided for @documentRenewal.
  ///
  /// In zh_HK, this message translates to:
  /// **'證件續期'**
  String get documentRenewal;

  /// No description provided for @billReminder.
  ///
  /// In zh_HK, this message translates to:
  /// **'賬單提醒'**
  String get billReminder;

  /// No description provided for @hkid.
  ///
  /// In zh_HK, this message translates to:
  /// **'身份證'**
  String get hkid;

  /// No description provided for @homeReturnPermit.
  ///
  /// In zh_HK, this message translates to:
  /// **'回鄉證'**
  String get homeReturnPermit;

  /// No description provided for @passport.
  ///
  /// In zh_HK, this message translates to:
  /// **'護照'**
  String get passport;

  /// No description provided for @membership.
  ///
  /// In zh_HK, this message translates to:
  /// **'會員卡'**
  String get membership;

  /// No description provided for @expiresDays.
  ///
  /// In zh_HK, this message translates to:
  /// **'到期前 {days} 天'**
  String expiresDays(Object days);

  /// No description provided for @thisMonthBalance.
  ///
  /// In zh_HK, this message translates to:
  /// **'本月結餘'**
  String get thisMonthBalance;

  /// No description provided for @income.
  ///
  /// In zh_HK, this message translates to:
  /// **'收入'**
  String get income;

  /// No description provided for @expenses.
  ///
  /// In zh_HK, this message translates to:
  /// **'支出'**
  String get expenses;

  /// No description provided for @recentTransactions.
  ///
  /// In zh_HK, this message translates to:
  /// **'最近交易'**
  String get recentTransactions;

  /// No description provided for @spendingBreakdown.
  ///
  /// In zh_HK, this message translates to:
  /// **'支出分類'**
  String get spendingBreakdown;

  /// No description provided for @healthConnected.
  ///
  /// In zh_HK, this message translates to:
  /// **'已連接'**
  String get healthConnected;

  /// No description provided for @healthNotConnected.
  ///
  /// In zh_HK, this message translates to:
  /// **'未連接'**
  String get healthNotConnected;

  /// No description provided for @syncNow.
  ///
  /// In zh_HK, this message translates to:
  /// **'立即同步'**
  String get syncNow;

  /// No description provided for @lastSynced.
  ///
  /// In zh_HK, this message translates to:
  /// **'上次同步'**
  String get lastSynced;

  /// No description provided for @bmiCalculator.
  ///
  /// In zh_HK, this message translates to:
  /// **'BMI 計算器'**
  String get bmiCalculator;

  /// No description provided for @height.
  ///
  /// In zh_HK, this message translates to:
  /// **'身高'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In zh_HK, this message translates to:
  /// **'體重'**
  String get weight;

  /// No description provided for @yourBmi.
  ///
  /// In zh_HK, this message translates to:
  /// **'你的 BMI'**
  String get yourBmi;

  /// No description provided for @underweight.
  ///
  /// In zh_HK, this message translates to:
  /// **'過輕'**
  String get underweight;

  /// No description provided for @normal.
  ///
  /// In zh_HK, this message translates to:
  /// **'正常'**
  String get normal;

  /// No description provided for @overweight.
  ///
  /// In zh_HK, this message translates to:
  /// **'超重'**
  String get overweight;

  /// No description provided for @obese.
  ///
  /// In zh_HK, this message translates to:
  /// **'肥胖'**
  String get obese;

  /// No description provided for @todaysSteps.
  ///
  /// In zh_HK, this message translates to:
  /// **'今日步數'**
  String get todaysSteps;

  /// No description provided for @calories.
  ///
  /// In zh_HK, this message translates to:
  /// **'卡路里'**
  String get calories;

  /// No description provided for @quickActions.
  ///
  /// In zh_HK, this message translates to:
  /// **'快捷操作'**
  String get quickActions;

  /// No description provided for @running.
  ///
  /// In zh_HK, this message translates to:
  /// **'跑步'**
  String get running;

  /// No description provided for @swimming.
  ///
  /// In zh_HK, this message translates to:
  /// **'游泳'**
  String get swimming;

  /// No description provided for @cycling.
  ///
  /// In zh_HK, this message translates to:
  /// **'單車'**
  String get cycling;

  /// No description provided for @tableTennis.
  ///
  /// In zh_HK, this message translates to:
  /// **'乒乓球'**
  String get tableTennis;

  /// No description provided for @yoga.
  ///
  /// In zh_HK, this message translates to:
  /// **'瑜伽'**
  String get yoga;

  /// No description provided for @gym.
  ///
  /// In zh_HK, this message translates to:
  /// **'健身'**
  String get gym;

  /// No description provided for @others.
  ///
  /// In zh_HK, this message translates to:
  /// **'其他'**
  String get others;

  /// No description provided for @medals.
  ///
  /// In zh_HK, this message translates to:
  /// **'勤力兔勳章'**
  String get medals;

  /// No description provided for @bronze3Days.
  ///
  /// In zh_HK, this message translates to:
  /// **'銅牌 - 3天'**
  String get bronze3Days;

  /// No description provided for @silver7Days.
  ///
  /// In zh_HK, this message translates to:
  /// **'銀牌 - 7天'**
  String get silver7Days;

  /// No description provided for @gold30Days.
  ///
  /// In zh_HK, this message translates to:
  /// **'金牌 - 30天'**
  String get gold30Days;

  /// No description provided for @unlocked.
  ///
  /// In zh_HK, this message translates to:
  /// **'已解鎖'**
  String get unlocked;

  /// No description provided for @locked.
  ///
  /// In zh_HK, this message translates to:
  /// **'未解鎖'**
  String get locked;

  /// No description provided for @nextMedal.
  ///
  /// In zh_HK, this message translates to:
  /// **'再努力 {days} 天即可獲得 {medal}！'**
  String nextMedal(Object days, Object medal);

  /// No description provided for @profile.
  ///
  /// In zh_HK, this message translates to:
  /// **'個人資料'**
  String get profile;

  /// No description provided for @appearance.
  ///
  /// In zh_HK, this message translates to:
  /// **'外觀'**
  String get appearance;

  /// No description provided for @lightMode.
  ///
  /// In zh_HK, this message translates to:
  /// **'淺色模式'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In zh_HK, this message translates to:
  /// **'深色模式'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In zh_HK, this message translates to:
  /// **'語言'**
  String get language;

  /// No description provided for @focusSettings.
  ///
  /// In zh_HK, this message translates to:
  /// **'專注設定'**
  String get focusSettings;

  /// No description provided for @focusDuration.
  ///
  /// In zh_HK, this message translates to:
  /// **'專注時間'**
  String get focusDuration;

  /// No description provided for @breakDuration.
  ///
  /// In zh_HK, this message translates to:
  /// **'休息時間'**
  String get breakDuration;

  /// No description provided for @monthlySalary.
  ///
  /// In zh_HK, this message translates to:
  /// **'月薪'**
  String get monthlySalary;

  /// No description provided for @salaryDay.
  ///
  /// In zh_HK, this message translates to:
  /// **'出糧日'**
  String get salaryDay;

  /// No description provided for @exportData.
  ///
  /// In zh_HK, this message translates to:
  /// **'匯出資料'**
  String get exportData;

  /// No description provided for @clearAllData.
  ///
  /// In zh_HK, this message translates to:
  /// **'清除所有資料'**
  String get clearAllData;

  /// No description provided for @clearAllDataConfirm.
  ///
  /// In zh_HK, this message translates to:
  /// **'確定要清除所有資料嗎？此操作無法復原。'**
  String get clearAllDataConfirm;

  /// No description provided for @about.
  ///
  /// In zh_HK, this message translates to:
  /// **'關於'**
  String get about;

  /// No description provided for @version.
  ///
  /// In zh_HK, this message translates to:
  /// **'版本'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In zh_HK, this message translates to:
  /// **'私隱政策'**
  String get privacyPolicy;

  /// No description provided for @save.
  ///
  /// In zh_HK, this message translates to:
  /// **'儲存'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In zh_HK, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In zh_HK, this message translates to:
  /// **'刪除'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In zh_HK, this message translates to:
  /// **'編輯'**
  String get edit;

  /// No description provided for @confirm.
  ///
  /// In zh_HK, this message translates to:
  /// **'確認'**
  String get confirm;

  /// No description provided for @noData.
  ///
  /// In zh_HK, this message translates to:
  /// **'暫無資料'**
  String get noData;

  /// No description provided for @loading.
  ///
  /// In zh_HK, this message translates to:
  /// **'載入中...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In zh_HK, this message translates to:
  /// **'發生錯誤'**
  String get error;

  /// No description provided for @retry.
  ///
  /// In zh_HK, this message translates to:
  /// **'重試'**
  String get retry;

  /// No description provided for @noInternetConnection.
  ///
  /// In zh_HK, this message translates to:
  /// **'無網絡連接，請檢查網絡設置'**
  String get noInternetConnection;

  /// No description provided for @connectionTimedOut.
  ///
  /// In zh_HK, this message translates to:
  /// **'連接超時，請重試'**
  String get connectionTimedOut;

  /// No description provided for @unableToFetchData.
  ///
  /// In zh_HK, this message translates to:
  /// **'無法獲取資料，請稍後再試'**
  String get unableToFetchData;

  /// No description provided for @pleaseEnablePermissions.
  ///
  /// In zh_HK, this message translates to:
  /// **'請在設定中開啟健康數據權限'**
  String get pleaseEnablePermissions;

  /// No description provided for @rabbitTodo1.
  ///
  /// In zh_HK, this message translates to:
  /// **'做得好！又完成一件 💪'**
  String get rabbitTodo1;

  /// No description provided for @rabbitTodo2.
  ///
  /// In zh_HK, this message translates to:
  /// **'效率滿分！繼續保持 🌟'**
  String get rabbitTodo2;

  /// No description provided for @rabbitTodo3.
  ///
  /// In zh_HK, this message translates to:
  /// **'清單又短了，輕鬆曬～'**
  String get rabbitTodo3;

  /// No description provided for @rabbitIncome1.
  ///
  /// In zh_HK, this message translates to:
  /// **'距離億萬富翁又一步 💰'**
  String get rabbitIncome1;

  /// No description provided for @rabbitIncome2.
  ///
  /// In zh_HK, this message translates to:
  /// **'準備去環遊世界吧 ✈️'**
  String get rabbitIncome2;

  /// No description provided for @rabbitIncome3.
  ///
  /// In zh_HK, this message translates to:
  /// **'又有進帳了，繼續努力 ^_^'**
  String get rabbitIncome3;

  /// No description provided for @rabbitFocus.
  ///
  /// In zh_HK, this message translates to:
  /// **'恭喜你，成功專注 {minutes} 分鐘，休息 {breakMinutes} 分鐘。飲杯水先啦～'**
  String rabbitFocus(Object breakMinutes, Object minutes);

  /// No description provided for @rabbitBronze.
  ///
  /// In zh_HK, this message translates to:
  /// **'連續 3 天運動！你是真正的勤力兔！🏅'**
  String get rabbitBronze;

  /// No description provided for @rabbitSilver.
  ///
  /// In zh_HK, this message translates to:
  /// **'連續 7 天運動！你是真正的勤力兔！🏅'**
  String get rabbitSilver;

  /// No description provided for @rabbitGold.
  ///
  /// In zh_HK, this message translates to:
  /// **'連續 30 天運動！你是傳奇勤力兔！🏆'**
  String get rabbitGold;

  /// No description provided for @rabbitFirstLaunch.
  ///
  /// In zh_HK, this message translates to:
  /// **'你好！我係勤力兔，一齊打理生活啦！'**
  String get rabbitFirstLaunch;

  /// No description provided for @rabbitError.
  ///
  /// In zh_HK, this message translates to:
  /// **'哎呀，出了點問題，再試一次好嗎？'**
  String get rabbitError;

  /// No description provided for @pause.
  ///
  /// In zh_HK, this message translates to:
  /// **'暫停'**
  String get pause;

  /// No description provided for @stop.
  ///
  /// In zh_HK, this message translates to:
  /// **'停止'**
  String get stop;

  /// No description provided for @reset.
  ///
  /// In zh_HK, this message translates to:
  /// **'重置'**
  String get reset;

  /// No description provided for @focusTimeRemaining.
  ///
  /// In zh_HK, this message translates to:
  /// **'專注時間剩餘'**
  String get focusTimeRemaining;

  /// No description provided for @breakTime.
  ///
  /// In zh_HK, this message translates to:
  /// **'休息時間'**
  String get breakTime;

  /// No description provided for @nextBreak.
  ///
  /// In zh_HK, this message translates to:
  /// **'下次休息：{minutes} 分鐘'**
  String nextBreak(Object minutes);

  /// No description provided for @weatherCondition.
  ///
  /// In zh_HK, this message translates to:
  /// **'天氣狀況'**
  String get weatherCondition;

  /// No description provided for @temperature.
  ///
  /// In zh_HK, this message translates to:
  /// **'溫度'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In zh_HK, this message translates to:
  /// **'濕度'**
  String get humidity;

  /// No description provided for @rainWarning.
  ///
  /// In zh_HK, this message translates to:
  /// **'暴雨警告'**
  String get rainWarning;

  /// No description provided for @generalSituation.
  ///
  /// In zh_HK, this message translates to:
  /// **'天氣概況'**
  String get generalSituation;

  /// No description provided for @forecastDate.
  ///
  /// In zh_HK, this message translates to:
  /// **'日期'**
  String get forecastDate;

  /// No description provided for @psr.
  ///
  /// In zh_HK, this message translates to:
  /// **'降雨概率'**
  String get psr;

  /// No description provided for @note.
  ///
  /// In zh_HK, this message translates to:
  /// **'備註'**
  String get note;

  /// No description provided for @category.
  ///
  /// In zh_HK, this message translates to:
  /// **'分類'**
  String get category;

  /// No description provided for @amount.
  ///
  /// In zh_HK, this message translates to:
  /// **'金額'**
  String get amount;

  /// No description provided for @type.
  ///
  /// In zh_HK, this message translates to:
  /// **'類型'**
  String get type;

  /// No description provided for @recurring.
  ///
  /// In zh_HK, this message translates to:
  /// **'自動'**
  String get recurring;

  /// No description provided for @swipeToDelete.
  ///
  /// In zh_HK, this message translates to:
  /// **'向左滑動以刪除'**
  String get swipeToDelete;

  /// No description provided for @healthSync.
  ///
  /// In zh_HK, this message translates to:
  /// **'健康數據同步'**
  String get healthSync;

  /// No description provided for @healthSyncDescription.
  ///
  /// In zh_HK, this message translates to:
  /// **'與 Apple Health / Health Connect 同步步數和運動數據'**
  String get healthSyncDescription;

  /// No description provided for @colorAccent.
  ///
  /// In zh_HK, this message translates to:
  /// **'主題顏色'**
  String get colorAccent;

  /// No description provided for @hongKongRed.
  ///
  /// In zh_HK, this message translates to:
  /// **'香港紅'**
  String get hongKongRed;

  /// No description provided for @gold.
  ///
  /// In zh_HK, this message translates to:
  /// **'金色'**
  String get gold;

  /// No description provided for @blue.
  ///
  /// In zh_HK, this message translates to:
  /// **'藍色'**
  String get blue;

  /// No description provided for @cm.
  ///
  /// In zh_HK, this message translates to:
  /// **'厘米'**
  String get cm;

  /// No description provided for @kg.
  ///
  /// In zh_HK, this message translates to:
  /// **'公斤'**
  String get kg;

  /// No description provided for @lb.
  ///
  /// In zh_HK, this message translates to:
  /// **'磅'**
  String get lb;

  /// No description provided for @ft.
  ///
  /// In zh_HK, this message translates to:
  /// **'呎'**
  String get ft;

  /// No description provided for @unitInch.
  ///
  /// In zh_HK, this message translates to:
  /// **'吋'**
  String get unitInch;

  /// No description provided for @metric.
  ///
  /// In zh_HK, this message translates to:
  /// **'公制'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In zh_HK, this message translates to:
  /// **'英制'**
  String get imperial;

  /// No description provided for @switchUnit.
  ///
  /// In zh_HK, this message translates to:
  /// **'切換單位'**
  String get switchUnit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'HK':
            return AppLocalizationsZhHk();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
