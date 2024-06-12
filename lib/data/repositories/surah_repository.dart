import 'dart:developer';

import '../datasources/local_data_source.dart';
import '../models/local/export.dart';
import '../models/surah/spesifik_surah_model.dart' as spesifik;
import '../models/surah/surah_harian_model.dart' as harian;
import '../models/surah/surah_model.dart';
import '../others/shared_preferences.dart';
import '../providers/api_surah_provider.dart';

class SurahRepository {
  final prayerApiProvider = ApiSurahProvider();
  final helperDB = LocalDataSourceImpl();
  final sharedPref = MySharedPref();

  Future<SurahModel> getAllSurah() {
    log(">>> Surah Repository Run : getAllSurah ");
    return prayerApiProvider.getSurah();
  }

  Future<spesifik.SpesifikSurahModel> getDetailSurah(String number) {
    return prayerApiProvider.getDetailSurah(number);
  }

  Future<List<harian.SurahHarianModel>> getSurahHarian() {
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
    SurahModel result = await prayerApiProvider.getSurah();
    print(">>> downloadAllSurahToLocal");
    for (var element in result.data) {
      await helperDB.insertInitialSurahHeader(element);
    }

    print("### downloadAllSurahToLocal : done");
    downloadAllDetailSurah();
  }

  downloadAllDetailSurah() async {
    for (var i = 1; i <= 114; i++) {
      spesifik.SpesifikSurahModel details =
          await prayerApiProvider.getDetailSurah(i.toString());
      saveDetailSurahToLocal(details);

      print(">>> downloadAllDetailSurah from $i to 114");
    }
    print("### downloadAllDetailSurah : done");
  }

  saveDetailSurahToLocal(spesifik.SpesifikSurahModel surah) async {
    spesifik.Data allData = surah.data;

    for (var verse in allData.verses) {
      print("======== run $verse ==========");
      await helperDB.insertInitialSurahDetail(allData.number, allData.sequence,
          allData.numberOfVerses, allData, verse);
    }
    print("================ end ======================;;;");
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

  Future<List<SurahLocalModel>> getSurahLocal() async {
    print(">>> getSurahLocal run...");
    return await helperDB.getAllSurah();
  }

  Future<List<DetailSurahLocalModel>> getDetailSurahLocal(String number) async {
    return await helperDB.getDetailSurah(number);
  }

  Future<int> readStatusFavoriteSurah(int surahNumber) async {
    return await helperDB.readStatusFavoriteSurah(surahNumber);
  }

  Future<int> readStatusLastReadSurah(int surahNumber) async {
    return await helperDB.readStatusLastReadSurah(surahNumber);
  }

  Future<int> setFavoriteSurah(
    int surahNumber,
    int isFavorite,
    DetailSurahLocalModel data,
  ) async {
    /// data favorite surah already exist?
    int isExist = await helperDB.readSurahUserExist(surahNumber);

    /// if not found, insert it!
    if (isExist == 0) {
      print(">>>  if not found, insert it!");
      return await helperDB.insertSurahUser(isFavorite, data, 0);

      /// if found, updated!
    } else {
      print(">>>  if found, updated!");
      // return await helperDB.updateFavoriteSurahUser(value, data);
      int updateResult =
          await helperDB.updateFavoriteSurahUser(isFavorite, data);
      if (updateResult == 1) {
        // return await readStatusFavoriteSurah(surahNumber);
        return await helperDB.readStatusFavoriteSurah(surahNumber);
      } else {
        return 0;
      }
    }
  }

  Future<int> setLastReadSurah(
    int surahNumber,
    int lastVerseNumber,
    DetailSurahLocalModel data,
  ) async {
    /// data favorite surah already exist?
    int isExist = await helperDB.readSurahUserExist(surahNumber);

    /// if not found, insert it!
    if (isExist == 0) {
      print(">>>  if not found, insert it!");
      return await helperDB.insertSurahUser(0, data, lastVerseNumber);

      /// if found, updated!
    } else {
      print(">>>  if found, updated!");
      int updateResult =
          await helperDB.updateLastReadSurah(surahNumber, lastVerseNumber);
      if (updateResult == 1) {
        // return await readStatusFavoriteSurah(surahNumber);
        return await helperDB.readStatusLastVerseSurah(surahNumber);
      } else {
        return 0;
      }
    }
  }
}
