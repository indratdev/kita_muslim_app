import 'package:flutter/material.dart';

import '../../../../data/models/local/export.dart';
import '../../../../utils/constants.dart';

class BismillahWidget extends StatelessWidget {
  const BismillahWidget({
    super.key,
    required this.listData,
  });

  final List<DetailSurahLocalModel> listData;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            listData.first.prebismillah_arab!,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: Constants.sizeTextArabian),
          ),
          const SizedBox(height: 5),
          Text(
            listData.first.prebismillah_transliteration_en!,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: Constants.sizeTextTitle,
                color: Constants.deepGreenColor),
          ),
          const SizedBox(height: 15),
          Text(
            listData.first.prebismillah_translation_id!,
            maxLines: 3,
            textAlign: TextAlign.right,
            style: const TextStyle(
                fontSize: Constants.sizeTextTitle, color: Constants.blackColor),
          ),
        ],
      ),
    );
  }
}
