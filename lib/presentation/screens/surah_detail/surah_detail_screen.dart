import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kita_muslim/blocs/surahbloc/surah_bloc.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/utils/number_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../blocs/export.dart';
import '../../../data/models/local/export.dart';
import '../../../utils/constants.dart';

class SurahDetailScreen extends StatefulWidget {
  const SurahDetailScreen({super.key});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();

  bool isAudioFileExist = false;
  bool _isPlay = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Surah"),
      ),
      body: BlocConsumer<SurahBloc, SurahState>(
        buildWhen: (previous, current) =>
            current is LoadingSurahDetail ||
            current is FailureSurahDetail ||
            current is SuccessGetSurahDetail,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadingSurahDetail) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is FailureSurahDetail) {
            return Center(child: Text(state.info.toString()));
          }

          if (state is SuccessGetSurahDetail) {
            List<DetailSurahLocalModel> listData = state.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width - 40,
                    decoration: BoxDecoration(
                      boxShadow: [Constants.boxShadowMenuNewVersion],
                      color: Constants.iwhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      // '${data.name.transliteration.id} (${data.name.translation.id})\n${data.revelation.id} ${data.numberOfVerses} Ayat',
                      // '${data.first.name_transliteration_id} (${data.first.translation_id})\n${data.first.revelation_id} ${data.first.number_of_verses} Ayat',
                      "${listData.first.name_transliteration_id}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: Constants.sizeTextTitle,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemScrollController: _itemScrollController,
                    itemCount: listData.length,
                    itemBuilder: (context, index) {
                      DetailSurahLocalModel detailSurah = listData[index];
                      return Container(
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadiusDirectional.circular(10),
                            color: index % 2 == 0
                                ? Constants.iwhite
                                : Constants.lightGreenColor.withOpacity(0.8)),
                        // margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 10, right: 5, left: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width / 10,
                              color: Colors.amber,
                              child: (detailSurah.prebismillah_arab == null)
                                  ? Text(NumberUtils.convertToArabicNumber(
                                      int.parse(detailSurah.number_insurah!)))
                                  : Text(NumberUtils.convertToArabicNumber(0)),
                            ),

                            // /// bismillah
                            // if (detailSurah.prebismillah_arab != null)
                            //   Container(
                            //     margin:
                            //         const EdgeInsets.symmetric(vertical: 24),
                            //     alignment: Alignment.centerRight,
                            //     child: ListView(
                            //       physics: const NeverScrollableScrollPhysics(),
                            //       shrinkWrap: true,
                            //       children: <Widget>[
                            //         Text(
                            //           detailSurah.prebismillah_arab ?? "",
                            //           textAlign: TextAlign.right,
                            //           style: const TextStyle(
                            //               fontSize: Constants.sizeTextArabian),
                            //         ),
                            //         const SizedBox(height: 5),
                            //         Text(
                            //           detailSurah
                            //                   .prebismillah_transliteration_en ??
                            //               "",
                            //           style: const TextStyle(
                            //               fontSize: Constants.sizeTextTitle,
                            //               color: Constants.colorGreenDeep),
                            //         ),
                            //         const SizedBox(height: 5),
                            //         Text(
                            //           detailSurah.prebismillah_translation_id ??
                            //               "",
                            //           style: const TextStyle(
                            //               fontSize: Constants.sizeTextTitle,
                            //               color: Constants.colorBlack),
                            //         )
                            //       ],
                            //     ),
                            //   ),

                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 24),
                                alignment: Alignment.centerRight,
                                child: ListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    Text(
                                      detailSurah.text_arab ?? "",
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          fontSize: Constants.sizeTextArabian),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      detailSurah.text_transliteration_en ?? "",
                                      style: const TextStyle(
                                          fontSize: Constants.sizeTextTitle,
                                          color: Constants.colorGreenDeep),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      detailSurah.translation_id ?? "",
                                      style: const TextStyle(
                                          fontSize: Constants.sizeTextTitle,
                                          color: Constants.colorBlack),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
