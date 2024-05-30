import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/article_bloc/article_bloc.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/blocs/prayer_bloc/prayer_bloc.dart';
import 'package:kita_muslim/data/datasources/db/sqlhelper.dart';
import 'package:kita_muslim/data/datasources/local_data_source.dart';
import 'package:kita_muslim/data/providers/api_article_provider.dart';
import 'package:kita_muslim/presentation/screens/home_screen/home_screen_v2.dart';
import 'package:kita_muslim/presentation/screens/home_screen/homescreen.dart';
import 'package:kita_muslim/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalDataSourceImpl _helper = LocalDataSourceImpl();
  @override
  void initState() {
    _helper.readSurah();

    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        // BlocProvider.of<PrayerBloc>(context).add(NextPrayerTimeEvent());
        // BlocProvider.of<PrayerBloc>(context).add(GetRandomWallpaper());
        BlocProvider.of<PrayerBloc>(context)
          ..add(NextPrayerTimeEvent())
          ..add(GetRandomWallpaper());
        BlocProvider.of<ArticleBloc>(context).add(GetRandomArticleEvent());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreenV2(),
            ),
            (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.colorGreenDeep,
      body: Center(
          child: Image.asset(
        Constants.appWallpaper,
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
      )),
    );
  }
}
