import 'package:intl/intl.dart';

class NumberUtils {
  static String convertToArabicNumber(int number) {
    return NumberFormat('#.##', 'ar_EG').format(number);
  }
}
