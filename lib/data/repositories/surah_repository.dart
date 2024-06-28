import 'package:kita_muslim/data/models/daily_prayer/daily_prayer_model.dart';

import '../datasources/local_data_source.dart';
import '../models/local/export.dart';
import '../models/surah/spesifik_surah_model.dart' as spesifik;
import '../models/surah/surah_harian_model.dart' as harian;
import '../models/surah/surah_model.dart';

import '../providers/api_surah_provider.dart';

class SurahRepository {
  final prayerApiProvider = ApiSurahProvider();
  final helperDB = LocalDataSourceImpl();

  Future<SurahModel> getAllSurah() {
    return prayerApiProvider.getSurah();
  }

  Future<List<SurahLocalModel>> getAllSurahByNumberOnLocal(
      String number) async {
    return await helperDB.getAllSurahByNumberOnLocal(number);
  }

  Future<spesifik.SpesifikSurahModel> getDetailSurah(String number) {
    return prayerApiProvider.getDetailSurah(number);
  }

  /// daily surah
  Future<List<DailyPrayerModel>> getSurahHarian() async {
    int total = await readTotalDailyPrayer();
    if (total == 0) {
      await downloadAllDailyPrayer();
    }

    return await helperDB.getAllDailyPrayer();
  }

  Future<int> readTotalDailyPrayer() async {
    return await helperDB.readTotalDailyPrayer();
  }

  /// end daily surah

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
      await saveDetailSurahToLocal(details);

      print(">>> downloadAllDetailSurah from $i to 114");
    }
    print("### downloadAllDetailSurah : done");
  }

  ///testing
  downloadAllSurahToLocal2(
    dynamic Function(double) onProgress,
  ) async {
    SurahModel result = await prayerApiProvider.getSurah();
    print(">>> downloadAllSurahToLocal");
    for (Data element in result.data) {
      await helperDB.insertInitialSurahHeader(element);
    }

    print("### downloadAllSurahToLocal : done");
    return downloadAllDetailSurah2(onProgress);
  }

  downloadAllDetailSurah2(Function(double) onProgress) async {
    for (var i = 1; i <= 114; i++) {
      spesifik.SpesifikSurahModel details =
          await prayerApiProvider.getDetailSurah(i.toString());
      await saveDetailSurahToLocal(details);

      double totalProgress = (i / 114) * 100;
      print(">>> downloadAllDetailSurah from $i to 114");
      print(">>> downloadAllDetailSurah totalProgress : $totalProgress ");
      onProgress(totalProgress);
    }
    print("### downloadAllDetailSurah : done");
  }

  /// end testing

  Future<void> downloadAllDailyPrayer() async {
    List<DailyPrayerModel> result = await prayerApiProvider.getSurahHarian();
    for (var data in result) {
      await helperDB.insertInitialDailyPrayer(data);
    }
  }

  downloadAllSurahToLocalVersi2() async {
    SurahModel result = await prayerApiProvider.getSurah();
    print(">>> downloadAllSurahToLocal");
    for (var element in result.data) {
      await helperDB.insertInitialSurahHeader(element);
    }

    print("### downloadAllSurahToLocal : done");
    downloadAllDetailSurah();
  }

  Future<void> saveDetailSurahToLocal(spesifik.SpesifikSurahModel surah) async {
    spesifik.Data allData = surah.data;

    for (spesifik.Verses verse in allData.verses) {
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
      return await helperDB.insertSurahUser(0, data, lastVerseNumber);

      /// if found, updated!
    } else {
      int updateResult =
          await helperDB.updateLastReadSurah(surahNumber, lastVerseNumber);
      if (updateResult == 1) {
        return await helperDB.readStatusLastVerseSurah(surahNumber);
      } else {
        return 0;
      }
    }
  }

  Future<List<String>> getAllSurahFavoriteLocal() async {
    List<String> listNumberFavorite =
        await helperDB.readAllSurahNumberFavorite();
    return listNumberFavorite;
  }
}
