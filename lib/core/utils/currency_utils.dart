/// Currency formatting ($X,XXX.XX)
/// 參考: prd.md Section 3.3
library;

import 'package:intl/intl.dart';

class CurrencyUtils {
  CurrencyUtils._();

  static final NumberFormat _currencyFormat = NumberFormat('#,##0.00', 'en_US');

  static String formatGbp(double amount) {
    return '\$${_currencyFormat.format(amount)}';
  }

  static String formatGbpSigned(double amount) {
    final formatted = formatGbp(amount.abs());
    if (amount >= 0) return '+$formatted';
    return '-$formatted';
  }
}
