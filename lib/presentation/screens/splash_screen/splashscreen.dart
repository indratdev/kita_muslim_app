import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/presentation/screens/home_screen/home_screen_v2.dart';
import 'package:kita_muslim/presentation/screens/home_screen/homescreen.dart';
import 'package:kita_muslim/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        BlocProvider.of<PrayerBloc>(context).add(NextPrayerTimeEvent());
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
