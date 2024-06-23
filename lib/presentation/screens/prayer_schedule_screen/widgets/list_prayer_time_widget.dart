import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';

import '../../../../utils/constants.dart';
import '../../../widgets/customwidgets.dart';

class ListPrayerTimeWidget extends StatefulWidget {
  const ListPrayerTimeWidget({
    super.key,
  });

  @override
  State<ListPrayerTimeWidget> createState() => _ListPrayerTimeWidgetState();
}

class _ListPrayerTimeWidgetState extends State<ListPrayerTimeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerBloc, PrayerState>(
      buildWhen: (previous, current) =>
          current is LoadingPrayerTime ||
          current is SuccessPrayerTime ||
          current is FailurePrayerTime,
      builder: (context, state) {
        if (state is FailurePrayerTime) {
          return const Center(child: Text("Gagal memuat data"));
        }

        if (state is SuccessPrayerTime) {
          Map<String, dynamic> datas = state.result;
          List<MapEntry<String, String>> prayerTimes = datas.entries
              .map((e) => MapEntry<String, String>(e.key, e.value.toString()))
              .toList();

          return Container(
            padding: const EdgeInsets.only(top: 8),
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height / 18,
            child: Column(
              children: [
                ListView.builder(
                  itemCount: prayerTimes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    MapEntry<String, String> data = prayerTimes[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.key.toString(),
                            style: const TextStyle(
                                fontSize: Constants.sizeSubTextTitle),
                          ),
                          Text(
                            data.value.toString(),
                            style: const TextStyle(
                                fontSize: Constants.sizeSubTextTitle),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return CustomWidgets.showLoadingIndicatorWithContainer(
            context,
            MediaQuery.sizeOf(context).height / 5,
            double.infinity,
          );
        }
      },
    );
  }
}
