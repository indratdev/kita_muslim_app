import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';

class NextTimeDurationWidget extends StatefulWidget {
  String currentTimeString;
  String targetTimeeString;

   NextTimeDurationWidget({
    super.key,
    required this.datas,
    required this.currentTimeString,
    required this.targetTimeeString,
  });

  final Map<String, dynamic> datas;

  @override
  State<NextTimeDurationWidget> createState() => _NextTimeDurationWidgetState();
}

class _NextTimeDurationWidgetState extends State<NextTimeDurationWidget> {
  Duration difference = const Duration();
  Timer? timer;
  @override
  void initState() {
    super.initState();
    calculateDifference();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void calculateDifference() {
    DateTime now = DateTime.now();
    DateTime currentTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(widget.currentTimeString.split(':')[0]),
        int.parse(widget.currentTimeString.split(':')[1]));
    DateTime futureTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(widget.targetTimeeString.split(':')[0]),
        int.parse(widget.targetTimeeString.split(':')[1]));

    if (futureTime.isBefore(currentTime)) {
      futureTime = futureTime.add(const Duration(days: 1));
    }

    setState(() {
      difference = futureTime.difference(currentTime);
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (difference.isNegative) {
        timer.cancel();
      } else {
        setState(() {
          difference = difference - const Duration(seconds: 1);
        });
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if ("${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds" ==
        "00:00:00") {
      BlocProvider.of<PrayerBloc>(context).add(NextPrayerTimeEvent());
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "- ${formatDuration(difference)}",
      style: TextStyle(
        fontSize: MediaQuery.sizeOf(context).width / 23,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
