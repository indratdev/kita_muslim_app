import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';
import 'package:kita_muslim/presentation/screens/surah_harian/expansion_daily_prayer_widget.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import '../../../blocs/export.dart';
import '../../../data/models/daily_prayer/daily_prayer_model.dart';

/// https://doa-doa-api-ahmadramadhan.fly.dev/api

class DoaHarianScreen extends StatelessWidget {
  const DoaHarianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar("Doa - doa harian"),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          if (state is FailureSurah) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          if (state is LoadingSurah) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is SuccessGetSurahHarian) {
            List<DailyPrayerModel> result = state.surah;
            return ExpansionDailyPrayerWidget(data: result);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
