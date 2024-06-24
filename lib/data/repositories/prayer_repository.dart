import 'package:kita_muslim/data/providers/api_prayer_provider.dart';

import '../models/prayer_time/prayer_time_model.dart';

class PrayerRepository {
  final prayerApiProvider = ApiPrayerProvider();
  // final sharedPref = MySharedPref();

  //  PrayerTimeModel? prayerTime = await ApiPrayerProvider()
  //             .getPrayerTimeSpesific(DateTimeUtils.getTodayDate(),
  //                 locations.latitude, locations.longitude);

  Future<PrayerTimeModel?> getPrayerTimeSpesific(
      String today, double lat, double long) async {
    return await prayerApiProvider.getPrayerTimeSpesific(today, lat, long);
  }

  Future<String> getRandomWallpaper() async {
    return await prayerApiProvider.getRandomWallpaper();
  }

  // Future<SurahModel> getAllSurah() {
  //   log(">>> Surah Repository Run : getAllSurah ");
  //   return prayerApiProvider.getSurah();
  // }

  // Future<SpesifikSurahModel> getDetailSurah(int number) {
  //   return prayerApiProvider.getDetailSurah(number);
  // }

  // Future<List<SurahHarianModel>> getSurahHarian() {
  //   return prayerApiProvider.getSurahHarian();
  // }

  // Future<List<String>> getAllFavoriteSharedPref() {
  //   return sharedPref.getAllFavorite();
  // }

  // void markLastAyatSurah(String surah, String ayat) {
  //   return sharedPref.markLastSurah(surah, ayat);
  // }

  // markFavoriteSurah(String surah, bool status) {
  //   return sharedPref.markFavoriteSurah(surah, status);
  // }
}
