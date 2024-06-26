import 'dart:async';
import 'dart:isolate';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:kita_muslim/data/providers/audio_provider.dart';

import 'package:kita_muslim/presentation/screens/surah_detail/widgets/download_audio_icon_widget.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/playing_audio_icon_widget.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import 'package:kita_muslim/utils/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../blocs/export.dart';

class SurahDetailScreen extends StatefulWidget {
  SurahDetailScreen({Key? key}) : super(key: key);

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final audioPlayer = AudioPlayer();
  final audioCache = AudioCache(prefix: 'assets/audios/');

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  bool isAudioFileExist = false;

  int indexSurah = 0;
  String indexAyat = "0";
  String surahName = "";
  int surahNumber = 0;
  List<String> listAudioDwn = [];
  List<String> listAudioPlay = [];
  List<String> listDwnSuccess = [];
  int _numberAudioPlay = 0;
  int _totalAyat = 0;
  bool _isPlay = false;
  bool audioStatus = false;

  bool _isFavorite = false;

  ReceivePort _port = ReceivePort();
  List<Map> downloadsListMaps = [];
  int progressDownload = 0;

  Map<String, MyDownloadableItem> _taskToItem = {};

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerComplete.listen((event) {
      if (_numberAudioPlay < listAudioPlay.length - 1) {
        _numberAudioPlay += 1;
        playAudio();
        setState(() {});
      } else {
        stopAudio();
      }
    });
  }

  stopAudio() {
    audioPlayer.stop();
    _isPlay = false;
    _numberAudioPlay = 0;

    setState(() {});
  }

  playAudio() async {
    if (_numberAudioPlay <= listAudioPlay.length - 1) {
      setState(() {
        _isPlay = true;
        scrollToIndex(_numberAudioPlay);
      });
      await audioPlayer.play(DeviceFileSource(listAudioPlay[_numberAudioPlay]));
    }
  }

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
    return WillPopScope(
      // back button
      onWillPop: () async {
        BlocProvider.of<SurahBloc>(context)
            .add(SendIndexSurah(indexSurah: indexSurah));

        // balikan buat surah favorite
        context.read<FavoriteBloc>().add(GetListAllSurahFavoriteEvent());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: CustomWidgets.basicAppBar(
            "Surah",
            <Widget>[
              Row(
                children: [
                  BlocConsumer<FavoriteBloc, FavoriteState>(
                    listener: (context, state) {
                      if (state is SuccessSetUnsetFavoriteSurah) {
                        _isFavorite = state.isFavorite;
                        Timer(const Duration(milliseconds: 500), () {
                          CustomWidgets.showDialog1Button(context,
                              "Favorit Surat", state.status.toString());
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is SuccessGetFavoriteSurah) {
                        _isFavorite = state.isFavorite;
                      }

                      return IconButton(
                        onPressed: () {
                          CustomWidgets.showDialog2Button(context, "Favorit",
                              "Apakah Anda Menyukai Surat Ini ?", () {
                            context.read<FavoriteBloc>().add(
                                SetFavoriteSurahStatus(
                                    surah: surahNumber.toString(),
                                    status: !_isFavorite));
                            Navigator.pop(context);
                          },
                              (!_isFavorite)
                                  ? "Suka"
                                  : "Hapus Yang Telah Ditandai");
                        },
                        icon: const Icon(Icons.favorite),
                        color: (_isFavorite)
                            ? Colors.red
                            : Colors.white, // kalau false putih, true red
                      );
                    },
                  ),

                  // icon download, jika file audio tidak ada akan tampil icon nya.
                  BlocConsumer<AudiomanagementBloc, AudiomanagementState>(
                    listener: (context, state) {
                      if (state is LoadingDownloadAudioState) {
                        CustomWidgets.showLoadingVersion2(context);
                      }

                      if (state is SuccessDownloadAudio) {
                        Navigator.pop(context);

                        CustomWidgets.showDialog1Button(
                            context, "Status Unduh", "Unduh Audio Berhasil");
                      }
                    },
                    builder: (context, state) {
                      if (state is SuccessDownloadAudio) {
                        listAudioDwn = state.statusFile["listAudio"];
                        listAudioPlay = state.statusFile["fileNameAudio"];
                        audioStatus = state.statusFile["audioStatus"];

                        if (audioStatus) {
                          return PlayingAudioIconWidget(
                            visible: true,
                            isPlay: (_isPlay),
                            callBack: () =>
                                (!_isPlay) ? playAudio() : stopAudio(),
                          );
                        }
                      }

                      // if audio file haven't download, this icon will be show
                      if (state is ResultAllAudioFilesState) {
                        listAudioDwn = state.statusFile["listAudio"];
                        listAudioPlay = state.statusFile["fileNameAudio"];
                        audioStatus = state.statusFile["audioStatus"];

                        if (audioStatus) {
                          return DownloadAudioIconWidget(
                              visible: true,
                              surahName: surahName,
                              listAudioDwn: listAudioDwn);
                        } else {
                          return PlayingAudioIconWidget(
                            visible: true,
                            isPlay: (_isPlay),
                            callBack: () =>
                                (!_isPlay) ? playAudio() : stopAudio(),
                          );
                        }
                      }

                      return Container();
                    },
                  ),

                  // popup menu
                  PopupMenuButton(
                    elevation: 20,
                    icon: const Icon(Icons.more_horiz),
                    color: Constants.iwhite,
                    shape: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1)),
                    onSelected: (value) {
                      switch (value) {
                        case 0:
                          (indexAyat == "0")
                              ? //scrollToIndex(0)
                              CustomWidgets.showDialog1Button(
                                  context,
                                  "Menandai Surat",
                                  "Anda Belum Menadai Surat Ini !")
                              : scrollToIndex(int.parse(indexAyat) - 1);
                          break;

                        default:
                          (indexAyat == "0")
                              ? //scrollToIndex(0)
                              CustomWidgets.showDialog1Button(
                                  context,
                                  "Menandai Surat",
                                  "Anda Belum Menadai Surat Ini!")
                              : scrollToIndex(int.parse(indexAyat) - 1);
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
                // );
                // },
              ),
            ],
          ),
          body: BlocConsumer<SurahBloc, SurahState>(
            listener: (context, state) {
              if (state is SuccessMarkLastAyatSurah) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Berhasil Menandai Surat',
                      style: TextStyle(color: Colors.green),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SuccessGetIndexSurah) {
                indexSurah = state.indexSurah;
              }

              if (state is SuccessGetFavoriteSurah) {
                _isFavorite = true; //state.isFavorite;
              }

              if (state is SuccessGetLastAyatSurah) {
                indexAyat = state.ayat;
              }

              // loading surah
              if (state is LoadingSurahDetail) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is FailureSurahDetail) {
                return Center(child: Text(state.info.toString()));
              } else if (state is SuccessGetSurahDetail) {
                var data = state.data.data;
                surahName = data.name.transliteration.id.toString();
                surahNumber = data.number;
                _totalAyat = data.numberOfVerses; // set surah name

                return Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [Constants.boxShadowMenu],
                          color: Constants.iwhite,
                        ),
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Text(
                          '${data.name.transliteration.id} (${data.name.translation.id})\n${data.revelation.id} ${data.numberOfVerses} Ayat',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Constants.sizeTextTitle,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        itemScrollController: _itemScrollController,
                        itemCount: data.numberOfVerses,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              var surah =
                                  data.name.transliteration.id.toString();

                              var ayat =
                                  data.verses[index].number.inSurah.toString();
                              showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                  title: Text('$surah : Ayat $ayat'),
                                  actions: <Widget>[
                                    CupertinoActionSheetAction(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0),
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      top: 5.0, left: 5),
                                              title: const Text(
                                                'Menandai Surah',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                    'Anda Akan Menandai Terakhir Baca Pada Surat : $surah ayat $ayat , yakin ?'),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('Batal'),
                                                ),
                                                TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  Colors.blue)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();

                                                    BlocProvider.of<SurahBloc>(
                                                            context)
                                                        .add(MarkLastAyatSurah(
                                                            surah: surah,
                                                            ayat: ayat));
                                                    BlocProvider.of<SurahBloc>(
                                                            context)
                                                        .add(ViewDetailSurah(
                                                            number:
                                                                data.number));
                                                    BlocProvider.of<SurahBloc>(
                                                            context)
                                                        .add(GetLastAyatSurah(
                                                            surah: surah));
                                                  },
                                                  child: const Text('OK',
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child:
                                          const Text('Tandai Terakhir Dibaca'),
                                    ),
                                  ],
                                  cancelButton: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Batal',
                                        style: TextStyle(color: Colors.red)),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                color: index % 2 == 0
                                    ? Constants.iwhite
                                    : Constants.colorCream.withOpacity(0.8),
                              ),
                              margin: const EdgeInsets.all(10),
                              padding: const EdgeInsets.only(
                                  top: 10, bottom: 10, right: 5, left: 5),
                              child: Column(
                                children: <Widget>[
                                  BlocConsumer<AudiomanagementBloc,
                                      AudiomanagementState>(
                                    listener: (context, state) {
                                      if (state is FailedPlayAudioState) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'GAGAL Audio',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            duration: Duration(
                                              seconds: 2,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      // if (state is ProgressDownloadAudio) {
                                      //   // WidgetsBinding.instance
                                      //   //     .addPostFrameCallback((_) {
                                      //   //   // CustomWidgets.showProgressDownload(
                                      //   //   //     context,
                                      //   //   //     state.progress,
                                      //   //   //     state.total);
                                      //   //   // Navigator.pop(context);

                                      //   //   Text(
                                      //   //       "Progress : ${state.progress} .. ${state.total}");
                                      //   // });
                                      //   return Text(
                                      //       'Downloading: ${state.progress}%');
                                      // }
                                      // if (state is SuccessDownloadAudio) {
                                      //   Navigator.pop(context);
                                      //   return CustomWidgets.showDialog1Button(
                                      //       context,
                                      //       "Status Unduh",
                                      //       "Unduh Berhasil");
                                      // }
                                      return SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 1,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text(
                                                        "${data.verses[index].number.inSurah.toString()}.",
                                                        style: const TextStyle(
                                                            fontSize: Constants
                                                                .sizeTextTitle)),
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 8,
                                                  child: Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: ListView(
                                                      physics:
                                                          const ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      children: <Widget>[
                                                        Text(
                                                          data.verses[index]
                                                              .text.arab,
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: const TextStyle(
                                                              fontSize: Constants
                                                                  .sizeTextArabian),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          data
                                                              .verses[index]
                                                              .text
                                                              .transliteration
                                                              .en
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: Constants
                                                                  .sizeTextTitle,
                                                              color: Constants
                                                                  .colorGreenDeep),
                                                        ),
                                                        const SizedBox(
                                                            height: 5),
                                                        Text(
                                                          data.verses[index]
                                                              .translation.id
                                                              .toString(),
                                                          style: const TextStyle(
                                                              fontSize: Constants
                                                                  .sizeTextTitle,
                                                              color: Constants
                                                                  .colorBlack),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                (isAudioFileExist) // kalau file audio udah ada akan tampil tombol play
                                                    ? Flexible(
                                                        flex: 2,
                                                        child: IconButton(
                                                          icon: Icon(
                                                            isPlaying
                                                                ? Icons.pause
                                                                : Icons
                                                                    .play_circle,
                                                            size: 35,
                                                          ),
                                                          onPressed: () async {
                                                            BlocProvider.of<
                                                                        AudiomanagementBloc>(
                                                                    context)
                                                                .add(PlayAudioEvent(
                                                                    numberFileAudio: data
                                                                        .verses[
                                                                            index]
                                                                        .number
                                                                        .inQuran
                                                                        .toString()));
                                                          },
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
