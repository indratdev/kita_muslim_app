import 'package:flutter/material.dart';
import 'package:kita_muslim/blocs/export.dart';

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
          return const Center(
            child: Text("Failed to load data"),
          );
        }

        if (state is SuccessPrayerTime) {
          Map<String, dynamic> datas = state.result;
          List<MapEntry<String, String>> prayerTimes = datas.entries
              .map((e) => MapEntry<String, String>(e.key, e.value.toString()))
              .toList();

          return Container(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height / 18,
            // decoration: BoxDecoration(
            //   color: Colors.amber,
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(12),
            //     topRight: Radius.circular(12),
            //   ),
            // ),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: prayerTimes.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // Map<String, dynamic> data = widget.datas[index];
                    var data = prayerTimes[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.key.toString()),
                          Text(data.value.toString()),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
