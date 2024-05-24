import 'dart:convert';

import 'package:kita_muslim/data/models/hadits/hadistRange_model.dart';
import 'package:kita_muslim/data/models/hadits/hadistsR_model.dart';
import 'package:kita_muslim/data/models/hadits/hadists_model.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart';
import 'package:kita_muslim/data/models/surah/surah_harian_model.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:http/http.dart' as http;

class ApiSurahProvider {
  String baseUrl = 'https://quran-api-mu.vercel.app/';
  String baseUrlHadists = 'https://hadith-api-one.vercel.app';
  // String basePrayerTime = ' http://api.aladhan.com/v1/calendar/';
  //     'http://api.aladhan.com/v1/timings/21-05-2024?latitude=-6.273298&longitude=106.869469&method=20';
  // final currentTime = Times().currentTime();

  // Future<PrayTimes> getDailyTimesPray(double lat, double lon) async {
  //   Uri url = Uri.parse(
  //       'https://api.pray.zone/v2/times/day.json?date=$currentTime&longitude=$lon&latitude=$lat');
  //   // 'https://api.pray.zone/v2/times/day.json?date=2022-04-07&longitude=-73.935242&latitude=40.730610'); // new york times
  //   var response = await http.get(url);
  //   var result = jsonDecode(response.body);

  //   if (result['code'] == 200 && result['status'] == "OK") {
  //     return PrayTimes.fromJson(result['results']);
  //   } else {
  //     throw Exception('failed');
  //   }
  // }

  Future<SurahModel> getSurah() async {
    Uri url = Uri.parse('$baseUrl/surah');
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    if (result['code'] == 200 || result['status'] == 'OK.') {
      return SurahModel.fromJson(result);
    } else {
      throw Exception('Failed Get Surah');
    }
  }

  Future<List<SurahHarianModel>> getSurahHarian() async {
    Uri url = Uri.parse("https://doa-doa-api-ahmadramadhan.fly.dev/api");
    var response = await http.get(url);
    var result = jsonDecode(response.body) as List;

    if (result.length > 0 || result.isNotEmpty) {
      List<SurahHarianModel> finalResult =
          result.map((e) => SurahHarianModel.fromJson(e)).toList();
      return finalResult;
    } else {
      throw Exception('Failed Get Surah');
    }
  }

  Future<SpesifikSurahModel> getDetailSurah(int number) async {
    Uri url = Uri.parse('$baseUrl/surah/$number');
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    if (result['code'] == 200 || result['code'] == 'OK.') {
      // var data = result['data'];
      return SpesifikSurahModel.fromJson(result);
    } else {
      throw Exception('Failed Get Detail Surah');
    }
  }

  Future<List<SpesifikSurahModel>> getListFavoriteSurah(
      List<String> listSurahNumber) async {
    List<SpesifikSurahModel> result = [];

    for (var surah in listSurahNumber) {
      var data = await getDetailSurah(int.parse(surah));
      result.add(data);
    }

    return result;
  }

  Future<HadistsModel> getHadistsBooks() async {
    Uri url = Uri.parse('$baseUrlHadists/books');
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    if (result['code'] == 200) {
      return HadistsModel.fromJson(result);
    } else {
      throw Exception('Failed Get List Books Hadists');
    }
  }

  Future<HadistsRModel> getRandomHadists(String bookName, int number) async {
    Uri url = Uri.parse('$baseUrlHadists/books/$bookName/$number');

    var response = await http.get(url);
    var result = jsonDecode(response.body);

    if (result['code'] == 200) {
      return HadistsRModel.fromJson(result);
    } else {
      throw Exception('Failed Get random/spesifik  Hadists');
    }
  }

  Future<HadistRangeModel> getRangeHadist(
      String bookName, int range1, int range2) async {
    Uri url =
        Uri.parse('$baseUrlHadists/books/$bookName?range=$range1-$range2');
    var response = await http.get(url);
    var result = jsonDecode(response.body);

    if (result['code'] == 200) {
      return HadistRangeModel.fromJson(result);
    } else {
      throw Exception('Failed Get Range  Hadists');
    }
  }
}
