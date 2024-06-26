import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/article_screen/article_screen.dart';
import 'package:kita_muslim/presentation/screens/calculator_screen/calculator_screen.dart';
import 'package:kita_muslim/presentation/screens/favorite_screens/favorite_screen.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadist_result_screen.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadist_menu_screen.dart';

import 'package:kita_muslim/presentation/screens/hadist_screen/hadist_screen.dart';
import 'package:kita_muslim/presentation/screens/home_screen/home_screen_v2.dart';

import 'package:kita_muslim/presentation/screens/prayer_schedule_screen/prayer_schedule_screen.dart';

import 'package:kita_muslim/presentation/screens/qiblah_screen/qiblah_screen.dart';
import 'package:kita_muslim/presentation/screens/quran_screen/quran_screen.dart';
import 'package:kita_muslim/presentation/screens/settings_screen/settings_screen.dart';
import 'package:kita_muslim/presentation/screens/splash_screen/splashscreen.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/surah_detail_screen.dart';

import 'package:kita_muslim/presentation/screens/surah_harian/doahariandetailscreen.dart';
import 'package:kita_muslim/presentation/screens/surah_harian/doaharianscreen.dart';

class Routes {
  static const String splash = "/splash";
  static const String homeScreen = "/homescreen";
  static const String readAlquran = "/bacaalquran";
  static const String detailSurah = "/surahdetail";
  static const String dailyPrayer = "/doaharian";
  static const String detailDailyPrayer = "/doahariandetail";
  static const String favoriteSurah = "/favoriteSurah";
  static const String hadists = "/hadists";
  static const String hadistDetail = "/hadistdetail";
  static const String hadistResultScreen = "/hadistsSR";
  static const String prayerSchedule = "/prayerschedule";
  static const String qiblahScreen = "/qiblahscreen";
  static const String calculatorScreen = "/calculatorscreen";
  static const String articleScreen = "/articlescreen";
  static const String settingsScreen = "/settingsscreen";

  Map<String, WidgetBuilder> getRoutes = {
    homeScreen: (_) => const HomeScreenV2(),
    readAlquran: (_) => QuranScreen(),
    detailSurah: (_) => SurahDetailScreen(),
    dailyPrayer: (_) => DoaHarianScreen(),
    detailDailyPrayer: (_) => DoaHarianDetailScreen(),
    favoriteSurah: (_) => FavoriteScreen(),
    hadists: (_) => const HadistScreen(),
    hadistDetail: (_) => HadistMenuScreen(),
    hadistResultScreen: (_) => HadistResultScreen(),
    splash: (_) => const SplashScreen(),
    prayerSchedule: (_) => const PrayerScheduleScreen(),
    qiblahScreen: (_) => QiblahScreen(),
    calculatorScreen: (_) => CalculatorScreen(),
    articleScreen: (_) => ArticleScreen(),
    settingsScreen: (_) => SettingsScreen(),
  };
}
