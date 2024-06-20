import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';
import 'package:kita_muslim/presentation/screens/surah_harian/expansion_daily_prayer_widget.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../blocs/export.dart';
import '../../../data/models/daily_prayer/daily_prayer_model.dart';
import '../../../utils/constants.dart';

/// https://doa-doa-api-ahmadramadhan.fly.dev/api

class DoaHarianScreen extends StatelessWidget {
  final ItemScrollController _itemScrollController = ItemScrollController();

  DoaHarianScreen({Key? key}) : super(key: key);

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
            return ScrollablePositionedList.builder(
              itemScrollController: _itemScrollController,
              initialScrollIndex: state.indexSurah,
              itemCount: result.length,
              itemBuilder: (context, index) {
                return ExpansionDailyPrayerWidget(data: result);

                // return InkWell(
                //   onTap: () {

                //     Navigator.pushNamed(context, '/doahariandetail');
                //   },
                //   child: ListTile(
                //     minLeadingWidth: 10,
                //     leading: SizedBox(
                //       width: MediaQuery.sizeOf(context).width / 10,
                //       child: IconNumberArabicWidget(number: index + 1),
                //     ),
                //     title: Text(
                //       data.doa,
                //       style: const TextStyle(fontSize: Constants.sizeTextTitle),
                //     ),
                //     // subtitle: Text(
                //     //     '${data[index].translation_id} (${data[index].number_of_verses} Ayat) ',
                //     //     maxLines: 2,
                //     //     style: const TextStyle(
                //     //       fontSize: Constants.sizeText,
                //     //     ),
                //     //     overflow: TextOverflow.ellipsis),
                //     // trailing: Text(
                //     //   data[index].name_short.toString(),
                //     //   style: const TextStyle(
                //     //       fontSize: Constants.sizeTextArabian,
                //     //       fontWeight: FontWeight.bold),
                //     // ),
                //   ),
                //   // ListTile(
                //   //   minLeadingWidth: 10,
                //   //   leading: Text(
                //   //     "${index + 1}.",
                //   //     style: const TextStyle(
                //   //       fontSize: Constants.sizeSubTextTitle,
                //   //       overflow: TextOverflow.clip,
                //   //     ),
                //   //   ),
                //   //   title: Text(
                //   //     result[index].doa.toString(),
                //   //     style: const TextStyle(
                //   //       fontSize: Constants.sizeSubTextTitle,
                //   //       overflow: TextOverflow.clip,
                //   //     ),
                //   //   ),
                //   // ),
                // );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
