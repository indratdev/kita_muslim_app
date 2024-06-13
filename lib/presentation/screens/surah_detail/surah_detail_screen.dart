import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../blocs/export.dart';
import '../../../data/models/local/export.dart';
import '../../../utils/constants.dart';
import 'widgets/export.dart';

class SurahDetailScreen extends StatefulWidget {
  const SurahDetailScreen({super.key});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  bool isAudioFileExist = false;
  bool _isPlay = false;
  int indexAyat = 0;
  bool _isFavorite = false;

  bool isScrolling = false;
  int currentIndexScroll = 0;
  int numberOfVerse = 0;

  /// scroll to index
  void scrollToIndex(int index, [int miliSecondDuration = 3000]) async {
    _itemScrollController.scrollTo(
      index: index,
      duration: Duration(milliseconds: miliSecondDuration),
      curve: Curves.easeInOutCubic,
    );
  }

  showMarkSurah(DetailSurahLocalModel data) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(
            '${data.name_transliteration_id} : Ayat ${data.number_insurah}'),
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
            child: const Text('Tandai Terakhir Dibaca'),
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
          appBar: CustomWidgets.basicAppBar(
            "",
          ),
          floatingActionButton: BlocBuilder<SurahBloc, SurahState>(
            builder: (context, state) {
              return ScrollDownSurahWidget(
                isScrolling: isScrolling,
                itemScrollController: _itemScrollController,
                numberOfVerse: numberOfVerse,
              );
            },
          ),
          body: BlocConsumer<SurahBloc, SurahState>(
            buildWhen: (previous, current) =>
                current is LoadingSurahDetail ||
                current is FailureSurahDetail ||
                current is SuccessGetSurahDetail,
            listener: (context, state) {
              if (state is SuccessLastReadSurah) {
                indexAyat = state.value;
                // print(">>> baru : ${state.value}");
                // print(">>> indexAyat baru : $indexAyat");

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Surah sudah ditandai')),
                );
              }
              if (state is FailureLastReadSurah) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMessage)),
                );
              }

              if (state is SuccessInitialLastReadSurah) {
                indexAyat = state.value;
              }
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
                bool hasBismillah = listData.first.prebismillah_arab != "null";
                numberOfVerse =
                    int.parse(state.data.first.number_of_verses ?? "0");

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
                                    isFavorite: _isFavorite,
                                    listData: listData),
                                AudioWidget(
                                  numberInquran: int.parse(
                                      listData.first.number_inquran ?? "0"),
                                  numberOfVerse: int.parse(
                                      listData.first.number_of_verses ?? "0"),
                                ),
                                IconButton(
                                  onPressed: () async {},
                                  icon: const Icon(
                                      Icons.play_circle_fill_rounded),
                                ),
                                IconButton(
                                  onPressed: () {
                                    scrollToIndex(indexAyat);
                                  },
                                  icon: const Icon(Icons.move_down_rounded),
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
                        itemPositionsListener: _itemPositionsListener,
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
                                    ? Constants.iwhite
                                    : Constants.lightGreenColor
                                        .withOpacity(0.8),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 24),
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width /
                                                        10,
                                                child: IconNumberArabicWidget(
                                                    number: int.parse(
                                                        detailSurah
                                                            .number_insurah!)),
                                              ),
                                              Expanded(
                                                child: Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Text(
                                                    detailSurah.text_arab ?? "",
                                                    textAlign: TextAlign.right,
                                                    style: const TextStyle(
                                                      fontSize: Constants
                                                          .sizeTextArabian,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            detailSurah
                                                    .text_transliteration_en ??
                                                "",
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                fontSize:
                                                    Constants.sizeTextTitle,
                                                color:
                                                    Constants.colorGreenDeep),
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                            detailSurah.translation_id ?? "",
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                                fontSize:
                                                    Constants.sizeTextTitle,
                                                color: Constants.colorBlack),
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

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:kita_muslim/presentation/screens/surah_detail/widgets/audio_widget.dart';
// import 'package:kita_muslim/presentation/screens/surah_detail/widgets/favorite_widget.dart';
// import 'package:kita_muslim/presentation/screens/surah_detail/widgets/scroll_down_surah_widget.dart';

// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

// import '../../../blocs/export.dart';
// import '../../../data/models/local/export.dart';
// import '../../../utils/constants.dart';
// import 'widgets/export.dart';

// class SurahDetailScreen extends StatefulWidget {
//   const SurahDetailScreen({super.key});

//   @override
//   State<SurahDetailScreen> createState() => _SurahDetailScreenState();
// }

// class _SurahDetailScreenState extends State<SurahDetailScreen> {
//   final ItemScrollController _itemScrollController = ItemScrollController();
//   final ItemPositionsListener _itemPositionsListener =
//       ItemPositionsListener.create();

//   bool isAudioFileExist = false;
//   bool _isPlay = false;
//   int indexAyat = 0;
//   bool _isFavorite = false;

//   bool isScrolling = false;
//   int currentIndexScroll = 0;
//   int numberOfVerse = 0;

//   /// scroll to index
//   void scrollToIndex(int index, [int miliSecondDuration = 3000]) async {
//     _itemScrollController.scrollTo(
//       index: index,
//       duration: Duration(milliseconds: miliSecondDuration),
//       curve: Curves.easeInOutCubic,
//     );
//   }

//   void showMarkSurah(DetailSurahLocalModel data) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         title: Text(
//             '${data.name_transliteration_id} : Ayat ${data.number_insurah}'),
//         actions: <Widget>[
//           CupertinoActionSheetAction(
//             onPressed: () async {
//               context.read<SurahBloc>().add(SetLastReadSurah(
//                     surahNumber: int.parse(data.number ?? '0'),
//                     lasReadSurahNumber: int.parse(data.number_insurah ?? '0'),
//                     data: data,
//                   ));
//               Navigator.of(context).pop();
//             },
//             child: const Text('Tandai Terakhir Dibaca'),
//           ),
//         ],
//         cancelButton: TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Batal', style: TextStyle(color: Colors.red)),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (didPop) {
//           return;
//         }
//         BlocProvider.of<SurahBloc>(context).add(GetAllSurah());
//         Navigator.pop(context);
//       },
//       child: SafeArea(
//         child: Scaffold(
//           appBar: CustomWidgets.basicAppBar(
//             "",
//           ),
//           floatingActionButton: BlocBuilder<SurahBloc, SurahState>(
//             builder: (context, state) {
//               return ScrollDownSurahWidget(
//                 isScrolling: isScrolling,
//                 itemScrollController: _itemScrollController,
//                 numberOfVerse: numberOfVerse, // Pass the numberOfVerse here
//               );
//             },
//           ),
//           body: BlocConsumer<SurahBloc, SurahState>(
//             buildWhen: (previous, current) =>
//                 current is LoadingSurahDetail ||
//                 current is FailureSurahDetail ||
//                 current is SuccessGetSurahDetail,
//             listener: (context, state) {
//               if (state is SuccessLastReadSurah) {
//                 indexAyat = state.value;
//                 print(">>> baru : ${state.value}");
//                 print(">>> indexAyat baru : $indexAyat");

//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Surah sudah ditandai')),
//                 );
//               }
//               if (state is FailureLastReadSurah) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.errorMessage)),
//                 );
//               }

//               if (state is SuccessInitialLastReadSurah) {
//                 indexAyat = state.value;
//               }

//               if (state is SuccessGetSurahDetail) {
//                 setState(() {
//                   numberOfVerse =
//                       int.parse(state.data.first.number_of_verses ?? "0");
//                 });
//               }
//             },
//             builder: (context, state) {
//               if (state is LoadingSurahDetail) {
//                 return const Center(
//                     child: CircularProgressIndicator.adaptive());
//               }

//               if (state is FailureSurahDetail) {
//                 return Center(child: Text(state.info.toString()));
//               }

//               if (state is SuccessGetSurahDetail) {
//                 List<DetailSurahLocalModel> listData = state.data;
//                 bool hasBismillah = listData.first.prebismillah_arab != "null";

//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       margin: const EdgeInsets.only(left: 10, right: 10),
//                       child: Container(
//                         width: MediaQuery.sizeOf(context).width - 40,
//                         decoration: BoxDecoration(
//                           boxShadow: [Constants.boxShadowMenuNewVersion],
//                           color: Constants.iwhite,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: const EdgeInsets.only(top: 10, bottom: 10),
//                         margin: const EdgeInsets.only(top: 10, bottom: 10),
//                         child: Column(
//                           children: [
//                             Text(
//                               "${listData.first.name_transliteration_id}",
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w800,
//                                 fontSize: Constants.sizeTextTitle,
//                               ),
//                             ),
//                             Text(
//                               "(${listData.first.name_translation_id} - ${listData.first.number_of_verses} ayat)",
//                               textAlign: TextAlign.center,
//                               maxLines: 2,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: Constants.sizeText,
//                               ),
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 FavoriteWidget(
//                                     isFavorite: _isFavorite,
//                                     listData: listData),
//                                 AudioWidget(
//                                   numberInquran: int.parse(
//                                       listData.first.number_inquran ?? "0"),
//                                   numberOfVerse: int.parse(
//                                       listData.first.number_of_verses ?? "0"),
//                                 ),
//                                 IconButton(
//                                   onPressed: () {
//                                     scrollToIndex(indexAyat);
//                                   },
//                                   icon: const Icon(Icons.move_down_rounded),
//                                 ),
//                                 IconButton(
//                                   onPressed: () async {},
//                                   icon: Icon(Icons.downhill_skiing),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: ScrollablePositionedList.builder(
//                         itemScrollController: _itemScrollController,
//                         itemPositionsListener: _itemPositionsListener,
//                         itemCount: listData.length + (hasBismillah ? 1 : 0),
//                         itemBuilder: (context, index) {
//                           if (hasBismillah && index == 0) {
//                             return BismillahWidget(listData: listData);
//                           }

//                           DetailSurahLocalModel detailSurah =
//                               listData[hasBismillah ? index - 1 : index];
//                           return InkWell(
//                             onTap: () {
//                               showMarkSurah(detailSurah);
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: index % 2 == 0
//                                     ? Constants.iwhite
//                                     : Constants.lightGreenColor
//                                         .withOpacity(0.8),
//                               ),
//                               padding: const EdgeInsets.all(10),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 24),
//                                       alignment: Alignment.centerRight,
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: <Widget>[
//                                           Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               SizedBox(
//                                                 width:
//                                                     MediaQuery.sizeOf(context)
//                                                             .width /
//                                                         10,
//                                                 child: IconNumberArabicWidget(
//                                                     number: int.parse(
//                                                         detailSurah
//                                                             .number_insurah!)),
//                                               ),
//                                               Expanded(
//                                                 child: Directionality(
//                                                   textDirection:
//                                                       TextDirection.rtl,
//                                                   child: Text(
//                                                     detailSurah.text_arab ?? "",
//                                                     textAlign: TextAlign.right,
//                                                     style: const TextStyle(
//                                                       fontSize: Constants
//                                                           .sizeTextArabian,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Text(
//                                             detailSurah
//                                                     .text_transliteration_en ??
//                                                 "",
//                                             textAlign: TextAlign.justify,
//                                             style: TextStyle(
//                                                 fontSize:
//                                                     Constants.sizeTextTitle,
//                                                 color: Constants.colorGreenV2),
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Text(
//                                             detailSurah.translation_id ?? "",
//                                             textAlign: TextAlign.justify,
//                                             style: const TextStyle(
//                                                 fontSize: Constants.sizeText),
//                                           ),
//                                           const SizedBox(height: 10),
//                                           Visibility(
//                                             visible:
//                                                 detailSurah.tafsir_id_short !=
//                                                     null,
//                                             child: Text(
//                                               detailSurah.tafsir_id_short ?? "",
//                                               textAlign: TextAlign.justify,
//                                               style: const TextStyle(
//                                                   fontSize: Constants.sizeText),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 );
//               }

//               return Container();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
