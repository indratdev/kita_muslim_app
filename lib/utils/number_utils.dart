import 'package:intl/intl.dart';

class NumberUtils {
  static String convertToArabicNumber(int number) {
    return NumberFormat('#.##', 'ar_EG').format(number);
  }

  static String convertToIdr(dynamic number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return currencyFormatter.format(number);
  }
}
