import 'package:kita_muslim/data/providers/api_surah_provider.dart';

import '../models/hadits/hadistRange_model.dart';
import '../models/hadits/hadistsR_model.dart';
import '../models/hadits/hadists_model.dart';

class HadistRepository {
  final prayerApiProvider = ApiSurahProvider();

  Future<HadistsModel> getHadistBooks() {
    return prayerApiProvider.getHadistsBooks();
  }

  Future<HadistsRModel> getRandomHadist(String bookName, int number) {
    return prayerApiProvider.getRandomHadists(bookName, number);
  }

  Future<HadistsRModel> getSpesifikHadist(String bookName, int number) {
    return prayerApiProvider.getRandomHadists(bookName, number);
  }

  Future<HadistRangeModel> getRangeHadist(
      String bookName, int range1, int range2) {
    return prayerApiProvider.getRangeHadist(bookName, range1, range2);
  }
}
