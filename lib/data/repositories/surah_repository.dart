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
    downloadAllDetailSurah();
  }

  downloadAllDetailSurah() async {
    for (var i = 1; i <= 114; i++) {
      SpesifikSurahModel details = await prayerApiProvider.getDetailSurah(i);
      saveDetailSurahToLocal(details);
    }
    print("### downloadAllDetailSurah : done");
  }

  saveDetailSurahToLocal(SpesifikSurahModel surah) async {
    var allData = surah.data;
    for (var datas in allData.verses) {
      await helperDB.insertInitialSurahDetail(
          allData.number, allData.sequence, allData.numberOfVerses, allData.preBismillah, datas);
    }
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
