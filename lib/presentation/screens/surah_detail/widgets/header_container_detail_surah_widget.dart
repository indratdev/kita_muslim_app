import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../data/models/local/export.dart';
import '../../../../utils/constants.dart';

class HeaderContainerDetailSurahWidget extends StatelessWidget {
  List<DetailSurahLocalModel> listData;
  bool isFavorite;
  ItemScrollController itemScrollController;
  int indexAyat;

  HeaderContainerDetailSurahWidget({
    super.key,
    required this.listData,
    required this.isFavorite,
    required this.itemScrollController,
    required this.indexAyat,
  });

  @override
  Widget build(BuildContext context) {
    /// scroll to index
    void scrollToIndex(int index, [int miliSecondDuration = 3000]) async {
      itemScrollController.scrollTo(
        index: index,
        duration: Duration(milliseconds: miliSecondDuration),
        curve: Curves.easeInOutCubic,
      );
    }

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        width: MediaQuery.sizeOf(context).width - 40,
        decoration: BoxDecoration(
          boxShadow: [Constants.boxShadowMenuNewVersion],
          color: Constants.whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Text(
              "${listData.first.name_transliteration_id}",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: Constants.sizeTextTitle,
              ),
            ),
            Text(
              "(${listData.first.name_translation_id} - ${listData.first.number_of_verses} ayat)",
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Constants.sizeText,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FavoriteWidget(
                  isFavorite: isFavorite,
                  listData: listData,
                ),
                SurahAudioWidget(
                  listAudioUrl: listData,
                  itemScrollController: itemScrollController,
                ),
                IconButton(
                  onPressed: () {
                    scrollToIndex(indexAyat);
                  },
                  icon: const Icon(Icons.move_down_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
