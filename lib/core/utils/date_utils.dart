/// Date formatting utilities (British format: DD/MM/YYYY)
/// 參考: prd.md Section 9.1

import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

class AppDateUtils {
  AppDateUtils._();

  static final DateFormat _dateFormat = DateFormat(
    AppConstants.dateFormatDdMmYyyy,
  );
  static final DateFormat _dateShort = DateFormat(AppConstants.dateFormatDdMm);
  static final DateFormat _timeFormat = DateFormat(AppConstants.timeFormatHhMm);
  static final DateFormat _yyMmFormat = DateFormat('yy/MM');

  static String formatDdMmYyyy(DateTime date) => _dateFormat.format(date);

  static String formatDdMm(DateTime date) => _dateShort.format(date);

  static String formatTime(DateTime time) => _timeFormat.format(time);

  static String formatYyMm(DateTime date) => _yyMmFormat.format(date);

  static String formatDateTime(DateTime dt) {
    return '${formatDdMmYyyy(dt)} ${formatTime(dt)}';
  }

  static String greeting() {
    final hour = DateTime.now().hour;
    if (hour >= AppConstants.morningStartHour &&
        hour < AppConstants.afternoonStartHour) {
      return '早晨';
    } else if (hour >= AppConstants.afternoonStartHour &&
        hour < AppConstants.eveningStartHour) {
      return '午安';
    } else {
      return '晚上好';
    }
  }

  static String dayOfWeek(DateTime date) {
    const days = ['日', '一', '二', '三', '四', '五', '六'];
    return '星期${days[date.weekday % 7]}';
  }
}
