import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../blocs/export.dart';
import '../../../../data/models/local/export.dart';
import '../../../../utils/constants.dart';

class DetailSurahWidget extends StatelessWidget {
  final ItemScrollController itemScrollController;
  final ItemPositionsListener itemPositionsListener;
  final List<DetailSurahLocalModel> listData;
  final bool hasBismillah;

  const DetailSurahWidget({
    super.key,
    required this.itemScrollController,
    required this.itemPositionsListener,
    required this.listData,
    required this.hasBismillah,
  });

  @override
  Widget build(BuildContext context) {
    showMarkSurah(DetailSurahLocalModel data) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            '${data.name_transliteration_id} : Ayat ${data.number_insurah}',
            style: const TextStyle(color: Constants.blackColor),
          ),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () async {
                context.read<SurahBloc>().add(SetLastReadSurah(
                      surahNumber: int.parse(data.number ?? '0'),
                      lasReadSurahNumber: int.parse(data.number_insurah ?? '0'),
                      data: data,
                    ));
                Navigator.of(context).pop();
              },
              child: const Text(
                'Tandai Terakhir Dibaca',
                style: TextStyle(color: Constants.blackColor),
              ),
            ),
          ],
          cancelButton: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal', style: TextStyle(color: Colors.red)),
          ),
        ),
      );
    }

    return Expanded(
      child: ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount: listData.length + (hasBismillah ? 1 : 0),
        itemBuilder: (context, index) {
          if (hasBismillah && index == 0) {
            return BismillahWidget(listData: listData);
          }

          DetailSurahLocalModel detailSurah =
              listData[hasBismillah ? index - 1 : index];
          return InkWell(
            onTap: () {
              showMarkSurah(detailSurah);
            },
            child: Container(
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? Constants.whiteColor
                    : Constants.deepGreenColor.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width / 10,
                                child: IconNumberArabicWidget(
                                    number:
                                        int.parse(detailSurah.number_insurah!)),
                              ),
                              Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    detailSurah.text_arab ?? "",
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      fontSize: Constants.sizeTextArabian,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            detailSurah.text_transliteration_en ?? "",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: Constants.sizeTextTitle,
                              color: Constants.deepGreenColor,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            detailSurah.translation_id ?? "",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: Constants.sizeTextTitle,
                              color: Constants.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
