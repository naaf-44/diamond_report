import 'package:intl/intl.dart';

class NumUtils {
  static String currencyFormat(double amount) {
    String formattedAmount = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 2,
    ).format(amount);

    return formattedAmount;
  }
}
