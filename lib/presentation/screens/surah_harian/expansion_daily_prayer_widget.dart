import 'package:flutter/material.dart';

import '../../../data/models/daily_prayer/daily_prayer_model.dart';

// class ExpansionDailyPrayerWidget extends StatefulWidget {
//   List<DailyPrayerModel> data;

//   ExpansionDailyPrayerWidget({
//     super.key,
//     required this.data,
//   });

//   @override
//   State<ExpansionDailyPrayerWidget> createState() =>
//       _ExpansionDailyPrayerWidgetState();
// }

// class _ExpansionDailyPrayerWidgetState
//     extends State<ExpansionDailyPrayerWidget> {
//   // final List<Item> _data = generateItems(8);

//   late List<ExpandableDailyPrayerModel> _data;

//   @override
//   void initState() {
//     _data = widget.data
//         .map((dailyPrayer) =>
//             ExpandableDailyPrayerModel(dailyPrayer: dailyPrayer))
//         .toList();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ExpansionPanelList(
//         expansionCallback: (int index, bool isExpanded) {
//           setState(() {
//             _data[index].isExpanded = !isExpanded;
//           });
//         },
//         children: _data.map<ExpansionPanel>((ExpandableDailyPrayerModel item) {
//           return ExpansionPanel(
//             headerBuilder: (BuildContext context, bool isExpanded) {
//               return ListTile(
//                 title: Text(item.dailyPrayer.doa),
//               );
//             },
//             body: ListTile(
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Ayat: ${item.dailyPrayer.ayat}'),
//                   Text('Latin: ${item.dailyPrayer.latin}'),
//                   Text('Artinya: ${item.dailyPrayer.artinya}'),
//                 ],
//               ),
//             ),
//             isExpanded: item.isExpanded,
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

class ExpansionDailyPrayerWidget extends StatefulWidget {
  final List<DailyPrayerModel> data;

  ExpansionDailyPrayerWidget({
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
        children: _data.map<ExpansionPanel>((ExpandableDailyPrayerModel item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.dailyPrayer.doa),
              );
            },
            body: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ayat: ${item.dailyPrayer.ayat}'),
                  Text('Latin: ${item.dailyPrayer.latin}'),
                  Text('Artinya: ${item.dailyPrayer.artinya}'),
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
