import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  bool _isProgressDialogShowing = false;

  // Future<void> createFolder(String path) async {
  //   try {
  //     final directory = await getExternalStorageDirectory();
  //     final path = '${directory!.path}/audios';
  //     final newDirectory = Directory(path);

  //     if (!newDirectory.existsSync()) {
  //       newDirectory.createSync(recursive: true);
  //       print('Folder created: $path');
  //     } else {
  //       print('Folder already exists: $path');
  //     }
  //   } catch (e) {
  //     print('Error creating folder: $e');
  //   }
  // }

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
          appBar: CustomWidgets.basicAppBar(""),
          floatingActionButton: BlocBuilder<SurahBloc, SurahState>(
            builder: (context, state) {
              return ScrollDownSurahWidget(
                isScrolling: isScrolling,
                itemScrollController: _itemScrollController,
                numberOfVerse: numberOfVerse,
              );
            },
          ),
          body: BlocConsumer<AudiomanagementBloc, AudiomanagementState>(
            listener: (context, state) {
              if (state is LoadingDownloadAudioState) {
                CustomWidgets.showCenterLoading(context);
              }

              if (state is UpdateDownloadProgressState) {
                if (!_isProgressDialogShowing) {
                  _isProgressDialogShowing = true;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return PopScope(
                        onPopInvoked: (didPop) => false,
                        child: AlertDialog(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          backgroundColor: Constants.colorBlackV2,
                          content: BlocBuilder<AudiomanagementBloc,
                              AudiomanagementState>(
                            builder: (context, state) {
                              if (state is UpdateDownloadProgressState) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    LinearProgressIndicator(
                                        value: state.progress / 100),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${state.progress.toStringAsFixed(2)}%',
                                      style: const TextStyle(
                                          color: Constants.colorWhitekV2),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
              } else if (state is SuccessDownloadAudio ||
                  state is FailedDownloadListAudio) {
                if (_isProgressDialogShowing) {
                  Navigator.of(context, rootNavigator: true).pop();
                  _isProgressDialogShowing = false;
                }
                if (state is SuccessDownloadAudio) {
                  Navigator.pop(context);
                }
              }
            },
            builder: (context, state) {
              return BlocConsumer<SurahBloc, SurahState>(
                buildWhen: (previous, current) =>
                    current is LoadingSurahDetail ||
                    current is FailureSurahDetail ||
                    current is SuccessGetSurahDetail,
                listener: (context, state) {
                  if (state is LoadingSurahDetail) {
                    CustomWidgets.showCenterLoading(context);
                  }
                  if (state is SuccessLastReadSurah) {
                    indexAyat = state.value;
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
                  if (state is FailureSurahDetail) {
                    return Center(child: Text(state.info.toString()));
                  }

                  if (state is SuccessGetSurahDetail) {
                    List<DetailSurahLocalModel> listData = state.data;
                    bool hasBismillah =
                        listData.first.prebismillah_arab != "null";
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
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<AudiomanagementBloc>()
                                              .add(DownloadBatchAudioEvent(
                                                listAudio: listData
                                                    .map((e) => e
                                                        .audio_secondary_0
                                                        .toString())
                                                    .toList(),
                                                // [
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3',
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/2.mp3',
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/3.mp3',
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/4.mp3',
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/5.mp3',
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/6.mp3',
                                                //   'https://cdn.islamic.network/quran/audio/128/ar.alafasy/7.mp3',
                                                // ],
                                              ));
                                        },
                                        icon: const Icon(Icons.download)),
                                    // AudioWidget(
                                    //   numberInquran: int.parse(
                                    //       listData.first.number_inquran ?? "0"),
                                    //   numberOfVerse: int.parse(
                                    //       listData.first.number_of_verses ??
                                    //           "0"),
                                    // ),
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
                                    // IconButton(
                                    //   onPressed: () async {
                                    //     context
                                    //         .read<AudiomanagementBloc>()
                                    //         .add(DownloadBatchAudioEvent(
                                    //           listAudio: [
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/1.mp3',
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/2.mp3',
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/3.mp3',
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/4.mp3',
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/5.mp3',
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/6.mp3',
                                    //             'https://cdn.islamic.network/quran/audio/128/ar.alafasy/7.mp3',
                                    //           ],
                                    //         ));
                                    //   },
                                    //   icon: const Icon(Icons.ac_unit_sharp),
                                    // ),
                                  ],
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                    width: MediaQuery.sizeOf(
                                                                context)
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
                                                        detailSurah.text_arab ??
                                                            "",
                                                        textAlign:
                                                            TextAlign.right,
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
                                                      Constants.colorGreenDeep,
                                                ),
                                              ),
                                              const SizedBox(height: 15),
                                              Text(
                                                detailSurah.translation_id ??
                                                    "",
                                                textAlign: TextAlign.justify,
                                                style: const TextStyle(
                                                  fontSize:
                                                      Constants.sizeTextTitle,
                                                  color: Constants.colorBlack,
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
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
