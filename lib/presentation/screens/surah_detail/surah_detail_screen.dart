import 'package:flutter/material.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/presentation/widgets/icon_number_arabic_widget.dart';

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
  String indexAyat = "0";

  // scroll to index
  void scrollToIndex(int index, [int miliSecondDuration = 3000]) async {
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: miliSecondDuration),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }

        BlocProvider.of<SurahBloc>(context).add(GetAllSurah());

        Navigator.pop(context);
      },
      child: SafeArea(
        child: Scaffold(
          // appBar: CustomWidgets.basicAppBar(
          //   "",
          //   <Widget>[
          //     IconButton(
          //       onPressed: () {},
          //       icon: Icon(Icons.favorite),
          //     ),
          //     IconButton(
          //       onPressed: () {},
          //       icon: Icon(Icons.play_circle_outline),
          //     ),
          //     PopupMenuButton(
          //       elevation: 20,
          //       icon: const Icon(Icons.more_horiz),
          //       color: Constants.iwhite,
          //       shape: const OutlineInputBorder(
          //           borderSide: BorderSide(color: Colors.black, width: 1)),
          //       onSelected: (value) {
          //         switch (value) {
          //           case 0:
          //             (indexAyat == "0")
          //                 ? //scrollToIndex(0)
          //                 CustomWidgets.showDialog1Button(context,
          //                     "Menandai Surat", "Anda Belum Menadai Surat Ini !")
          //                 : scrollToIndex(int.parse(indexAyat) - 1);
          //             break;

          //           default:
          //             (indexAyat == "0")
          //                 ? //scrollToIndex(0)
          //                 CustomWidgets.showDialog1Button(context,
          //                     "Menandai Surat", "Anda Belum Menadai Surat Ini!")
          //                 : scrollToIndex(int.parse(indexAyat) - 1);
          //             break;
          //         }
          //       },
          //       itemBuilder: (context) => [
          //         const PopupMenuItem<int>(
          //           value: 0,
          //           child: Text(
          //             'Ke Terakhir Dibaca',
          //             style: TextStyle(
          //               color: Constants.colorBlack,
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
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
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              if (state is FailureSurahDetail) {
                return Center(child: Text(state.info.toString()));
              }

              if (state is SuccessGetSurahDetail) {
                List<DetailSurahLocalModel> listData = state.data;
                bool hasBismillah = listData.first.prebismillah_arab != null;

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
                        child: Column(
                          children: [
                            Text(
                              "${listData.first.name_transliteration_id}",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: Constants.sizeTextTitle,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.play_circle_outline),
                                ),
                                PopupMenuButton(
                                  elevation: 20,
                                  icon: const Icon(Icons.more_horiz),
                                  color: Constants.iwhite,
                                  shape: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1)),
                                  onSelected: (value) {
                                    switch (value) {
                                      case 0:
                                        (indexAyat == "0")
                                            ? //scrollToIndex(0)
                                            CustomWidgets.showDialog1Button(
                                                context,
                                                "Menandai Surat",
                                                "Anda Belum Menadai Surat Ini !")
                                            : scrollToIndex(
                                                int.parse(indexAyat) - 1);
                                        break;

                                      default:
                                        (indexAyat == "0")
                                            ? //scrollToIndex(0)
                                            CustomWidgets.showDialog1Button(
                                                context,
                                                "Menandai Surat",
                                                "Anda Belum Menadai Surat Ini!")
                                            : scrollToIndex(
                                                int.parse(indexAyat) - 1);
                                        break;
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    const PopupMenuItem<int>(
                                      value: 0,
                                      child: Text(
                                        'Ke Terakhir Dibaca',
                                        style: TextStyle(
                                          color: Constants.colorBlack,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        itemScrollController: _itemScrollController,
                        itemCount: listData.length + (hasBismillah ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (hasBismillah && index == 0) {
                            return Container(
                              // color: Colors.amber,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 5, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    listData.first.prebismillah_arab!,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: Constants.sizeTextArabian),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    listData
                                        .first.prebismillah_transliteration_en!,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: Constants.sizeTextTitle,
                                        color: Constants.colorGreenDeep),
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    listData.first.prebismillah_translation_id!,
                                    maxLines: 3,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: Constants.sizeTextTitle,
                                        color: Constants.colorBlack),
                                  ),
                                ],
                              ),
                            );
                          }

                          DetailSurahLocalModel detailSurah =
                              listData[hasBismillah ? index - 1 : index];
                          return Container(
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? Constants.iwhite
                                  : Constants.lightGreenColor.withOpacity(0.8),
                            ),
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 5, left: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width / 10,
                                    child: IconNumberArabicWidget(
                                        number: int.parse(
                                            detailSurah.number_insurah!))),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 24),
                                    alignment: Alignment.centerRight,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          detailSurah.text_arab ?? "",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize:
                                                  Constants.sizeTextArabian),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          detailSurah.text_transliteration_en ??
                                              "",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: Constants.sizeTextTitle,
                                              color: Constants.colorGreenDeep),
                                        ),
                                        const SizedBox(height: 15),
                                        Text(
                                          detailSurah.translation_id ?? "",
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(
                                              fontSize: Constants.sizeTextTitle,
                                              color: Constants.colorBlack),
                                        ),
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
        ),
      ),
    );
  }
}
