// import 'package:shared_preferences/shared_preferences.dart';

// class MySharedPref {
//   late SharedPreferences pref;

//   clearAllSharedPref() async {
//     pref = await SharedPreferences.getInstance();
//     pref.clear();
//   }

//   void markLastSurah(String surah, String ayat) async {
//     pref = await SharedPreferences.getInstance();
//     pref.setString(surah, ayat);
//   }

//   Future<String> getMarkLastSurah(String surah) async {
//     pref = await SharedPreferences.getInstance();

//     String stringValue = pref.getString(surah) ?? "0";

//     return stringValue;
//   }

//   // SharedPref Favorite Surah   =========================
//   markFavoriteSurah(String surah, bool status) async {
//     pref = await SharedPreferences.getInstance();
//     pref.setBool(surah, status);
//   }

//   Future<bool> getFavoriteSurah(String surah) async {
//     pref = await SharedPreferences.getInstance();

//     bool boolValue = pref.getBool(surah) ?? false;

//     return boolValue;
//   }

//   // End SharedPref Favorite Surah  =========================

//   // get all
//   Future<Map<String, dynamic>> getAllFavorite2() async {
//     final prefs = await SharedPreferences.getInstance();
//     final keys = prefs.getKeys();

//     final prefsMap = Map<String, dynamic>();
//     // kalau shared prefnya true, dimasukin list favorite
//     for (String key in keys) {
//       (prefs.get(key) == true) ? prefsMap[key] = prefs.get(key) : null;
//     }

//     return prefsMap;
//   }

//   Future<List<String>> getAllFavorite() async {
//     final prefs = await SharedPreferences.getInstance();
//     final keys = prefs.getKeys();
//     final List<String> prefsMap2 = [];

//     // kalau shared prefnya true, dimasukin list favorite
//     for (String key in keys) {
//       if (prefs.get(key) == true) {
//         prefsMap2.add(key);
//       }
//     }
//     prefsMap2.sort();

//     return prefsMap2;
//   }
// }
