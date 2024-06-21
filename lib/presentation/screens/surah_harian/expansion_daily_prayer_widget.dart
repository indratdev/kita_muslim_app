import 'package:flutter/material.dart';

import '../../../data/models/daily_prayer/daily_prayer_model.dart';
import '../../../utils/constants.dart';
import '../surah_detail/widgets/export.dart';

class ExpansionDailyPrayerWidget extends StatefulWidget {
  final List<DailyPrayerModel> data;

  const ExpansionDailyPrayerWidget({
    super.key,
    required this.data,
  });

  @override
  State<ExpansionDailyPrayerWidget> createState() =>
      _ExpansionDailyPrayerWidgetState();
}

class _ExpansionDailyPrayerWidgetState
    extends State<ExpansionDailyPrayerWidget> {
  late List<ExpandableDailyPrayerModel> _data;

  @override
  void initState() {
    _data = widget.data
        .map((dailyPrayer) =>
            ExpandableDailyPrayerModel(dailyPrayer: dailyPrayer))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = isExpanded;
          });
        },
        children: _data.map((ExpandableDailyPrayerModel item) {
          final index = _data.indexOf(item);
          return ExpansionPanel(
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: IconNumberArabicWidget(number: index + 1),
                title: Text(item.dailyPrayer.doa),
              );
            },
            body: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      item.dailyPrayer.ayat,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: Constants.sizeTextArabian,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    item.dailyPrayer.latin,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: Constants.sizeSubTextTitle,
                      color: Constants.deepGreenColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    item.dailyPrayer.artinya,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: Constants.sizeSubTextTitle,
                      color: Constants.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }
}
