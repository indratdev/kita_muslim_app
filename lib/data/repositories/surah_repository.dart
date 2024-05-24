import 'dart:developer';

import '../models/surah/spesifik_surah_model.dart';
import '../models/surah/surah_harian_model.dart';
import '../models/surah/surah_model.dart';
import '../others/shared_preferences.dart';
import '../providers/api_surah_provider.dart';

class SurahRepository {
  final prayerApiProvider = ApiSurahProvider();
  final sharedPref = MySharedPref();

  Future<SurahModel> getAllSurah() {
    log(">>> Surah Repository Run : getAllSurah ");
    return prayerApiProvider.getSurah();
  }

  Future<SpesifikSurahModel> getDetailSurah(int number) {
    return prayerApiProvider.getDetailSurah(number);
  }

  Future<List<SurahHarianModel>> getSurahHarian() {
    return prayerApiProvider.getSurahHarian();
  }

  Future<List<String>> getAllFavoriteSharedPref() {
    return sharedPref.getAllFavorite();
  }

  void markLastAyatSurah(String surah, String ayat) {
    return sharedPref.markLastSurah(surah, ayat);
  }

  markFavoriteSurah(String surah, bool status) {
    return sharedPref.markFavoriteSurah(surah, status);
  }
}
