import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/prayer_schedule_screen/widgets/banner_payer_time_widget.dart';
import 'package:kita_muslim/presentation/screens/prayer_schedule_screen/widgets/list_prayer_time_widget.dart';



class PrayerScheduleScreen extends StatefulWidget {
  const PrayerScheduleScreen({super.key});

  @override
  State<PrayerScheduleScreen> createState() => _PrayerScheduleScreenState();
}

class _PrayerScheduleScreenState extends State<PrayerScheduleScreen> {

 
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Column(
        children: [
          BannerPrayerTimeWidget(),
          Expanded(child: ListPrayerTimeWidget()),
        ],
      ),
    );
  }
}
