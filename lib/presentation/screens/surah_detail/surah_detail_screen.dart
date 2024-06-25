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

  List<DetailSurahLocalModel> listData = [];

  bool isAudioFileExist = false;

  int indexAyat = 0;
  bool _isFavorite = false;

  bool isScrolling = false;
  int currentIndexScroll = 0;
  int numberOfVerse = 0;
  bool _isProgressDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar(
        context,
        backIconFunction: () {
          BlocProvider.of<SurahBloc>(context).add(GetAllSurah());
          BlocProvider.of<FavoriteBloc>(context)
              .add(ListAllSurahFavoriteEvent());
          Navigator.pop(context);
        },
        "Surah",
        centerTitle: true,
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
                      backgroundColor: Constants.blackColor,
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
                                      color: Constants.whiteColor),
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
              context.read<AudiomanagementBloc>().add(
                  AllAudioAlreadyDownloadedEvent(
                      listUrlAudio: listData
                          .map((e) => e.audio_secondary_0.toString())
                          .toList()));
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

              if (state is LoadingSurahDetail) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }

              if (state is SuccessGetSurahDetail) {
                listData = state.data;
                bool hasBismillah = listData.first.prebismillah_arab != "null";
                numberOfVerse =
                    int.parse(state.data.first.number_of_verses ?? "0");
                _isFavorite = state.isFavorite;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderContainerDetailSurahWidget(
                      listData: listData,
                      isFavorite: _isFavorite,
                      itemScrollController: _itemScrollController,
                      indexAyat: indexAyat,
                    ),
                    DetailSurahWidget(
                      itemScrollController: _itemScrollController,
                      itemPositionsListener: _itemPositionsListener,
                      listData: listData,
                      hasBismillah: hasBismillah,
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
    );
  }
}
