import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

import 'widgets/export.dart';

class PrayerScheduleScreen extends StatelessWidget {
  const PrayerScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          CustomWidgets.basicAppBar(context, centerTitle: true, "Waktu Shalat"),
      body: const Column(
        children: [
          BannerPrayerTimeWidget(),
          Expanded(child: ListPrayerTimeWidget()),
        ],
      ),
    );
  }
}
