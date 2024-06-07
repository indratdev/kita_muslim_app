import 'package:flutter/material.dart';

import '../../../../data/models/local/export.dart';
import '../../../../utils/constants.dart';
import '../../../widgets/icon_number_arabic_widget.dart';

class ListQuranWidget extends StatelessWidget {
  final List<SurahLocalModel> data;
  final int index;

  const ListQuranWidget({
    super.key,
    required this.data,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 10,
      child: ListTile(
        minLeadingWidth: 10,
        leading: SizedBox(
          width: MediaQuery.sizeOf(context).width / 10,
          child: IconNumberArabicWidget(number: int.parse(data[index].number!)),
        ),
        title: Text(
          data[index].transliteration_id.toString(),
          style: const TextStyle(fontSize: Constants.sizeTextTitle),
        ),
        subtitle: Text(
            '${data[index].translation_id} (${data[index].number_of_verses} Ayat) ',
            maxLines: 2,
            style: const TextStyle(
              fontSize: Constants.sizeText,
            ),
            overflow: TextOverflow.ellipsis),
        trailing: Text(
          data[index].name_short.toString(),
          style: const TextStyle(
              fontSize: Constants.sizeTextArabian, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
