import 'dart:developer';

import '../datasources/local_data_source.dart';
import '../models/surah/spesifik_surah_model.dart';
import '../models/surah/surah_harian_model.dart';
import '../models/surah/surah_model.dart' as surahmodel;
import '../others/shared_preferences.dart';
import '../providers/api_surah_provider.dart';

class SurahRepository {
  final prayerApiProvider = ApiSurahProvider();
  final helperDB = LocalDataSourceImpl();
  final sharedPref = MySharedPref();

  Future<surahmodel.SurahModel> getAllSurah() {
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

  downloadAllSurahToLocal() async {
    surahmodel.SurahModel result = await prayerApiProvider.getSurah();
    print(">>> downloadAllSurahToLocal");
    for (var element in result.data) {
      await helperDB.insertInitialSurahHeader(element);
    }

    print("### downloadAllSurahToLocal : done");
  }

  /// backup
  // downloadAllSurahToLocal() async {
  //   SurahModel result = await prayerApiProvider.getSurah();
  //   print(">>> downloadAllSurahToLocal");
  //   for (var element in result.data) {
  //     // insert header surah to local
  //     await helperDB.insertInitialSurahHeader(element);
  //   }

  //   print("### downloadAllSurahToLocal : done");
  // }

  // localstorage
  Future<String> getStatusSurahOnLocalStorage() async {
    return await helperDB.readNumberOfSurah();
  }

  removeDoubleQuotes(var data) {}
}
