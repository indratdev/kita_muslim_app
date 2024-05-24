import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/favorite_screens/favoritescreen.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadistSRscreen.dart';
import 'package:kita_muslim/presentation/screens/hadist_screen/hadistdetailscreen.dart';

import 'package:kita_muslim/presentation/screens/hadist_screen/hadistscreen.dart';
import 'package:kita_muslim/presentation/screens/home_screen/home_screen_v2.dart';
import 'package:kita_muslim/presentation/screens/home_screen/homescreen.dart';
import 'package:kita_muslim/presentation/screens/quranscreen.dart';
import 'package:kita_muslim/presentation/screens/splash_screen/splashscreen.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/surahdetailscreen.dart';
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
  static const String hadistsSR = "/hadistsSR";

  Map<String, WidgetBuilder> getRoutes = {
    homeScreen: (_) => const HomeScreenV2(),
    readAlquran: (_) => QuranScreen(),
    detailSurah: (_) => SurahDetailScreen(),
    dailyPrayer: (_) => DoaHarianScreen(),
    detailDailyPrayer: (_) => DoaHarianDetailScreen(),
    favoriteSurah: (_) => const FavoriteScreen(),
    hadists: (_) => const HadistScreen(),
    hadistDetail: (_) => HadistDetailScreen(nameHadist: ""),
    hadistsSR: (_) => HadistSRScreen(),
    splash: (_) => const SplashScreen(),
  };
}
