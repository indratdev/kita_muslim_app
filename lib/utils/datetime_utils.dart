import 'package:intl/intl.dart';

class DateTimeUtils {

  static DateTime _getCurrentTime() {
    return DateTime.now();
  }

  /// Gets today's date formatted as 'yyyy-MM-dd'.
  static String getTodayDate() {
    // final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(_getCurrentTime());
  }

  /// Gets today's date formatted in a custom format.
  static String getTodayDateWithFormat(String format) {
    // final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(format);
    return formatter.format(_getCurrentTime());
  }

  /// Gets the current hour and minute formatted as 'HH:mm'.
  static String getCurrentTime() {
    // final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(_getCurrentTime());
  }

  bool isTimeStringGreater(String time1, String time2) {
    DateFormat dateFormat = DateFormat('HH:mm');

    DateTime dateTime1 = dateFormat.parse(time1);
    DateTime dateTime2 = dateFormat.parse(time2);

    return dateTime1.isAfter(dateTime2);
  }

  Map<String, dynamic> sortTimings(Map<String, dynamic> timings) {
    // Filter out the keys to be excluded
    List<String> excludeKeys = ["Sunset", "Midnight", "Firstthird"];
    Map<String, String> filteredTimings = Map.from(timings)
      ..removeWhere((key, value) => excludeKeys.contains(key));

    // Convert filtered timings to a list of entries
    List<MapEntry<String, String>> timingEntries =
        filteredTimings.entries.toList();

    // Sort the list based on the time values
    timingEntries.sort((a, b) {
      DateFormat dateFormat = DateFormat('HH:mm');
      DateTime timeA = dateFormat.parse(a.value);
      DateTime timeB = dateFormat.parse(b.value);
      return timeA.compareTo(timeB);
    });

    // Convert the sorted list back to a map
    Map<String, dynamic> sortedTimings = Map.fromEntries(timingEntries);
    return sortedTimings;
  }

  static String getCurrentTimeZoneName(){
    DateTime time = _getCurrentTime();
    return time.timeZoneName;
  }
}
