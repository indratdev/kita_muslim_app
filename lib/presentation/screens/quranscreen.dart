import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:kita_muslim/data/models/local/surah_local_model.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/data/providers/api_prayer_provider.dart';
import 'package:kita_muslim/data/providers/audio_provider.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/utils/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../blocs/export.dart';

class QuranScreen extends StatefulWidget {
  QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  TextEditingController _searchController = TextEditingController();
  AudioProvider audioProvider = AudioProvider();
  List<SurahLocalModel> dataSurah = [];
  int _indexSurah = 0;

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomWidgets.basicAppBar("Surat Al-Qur'an"),
        body: Column(
          children: <Widget>[
            BlocBuilder<SurahBloc, SurahState>(
              builder: (context, state) {
                if (state is SuccessSendIndexSurah) {
                  return Expanded(
                    child: Column(
                      children: [
                        listviewBody(
                          // data: state.surah.data,
                          data: [],
                          indexSurah: state.indexSurah,
                        ),
                      ],
                    ),
                  );
                }

                if (state is FailureSurah) {
                  return Center(child: Text(state.errorMessage.toString()));
                }
                if (state is LoadingSurah) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator.adaptive()),
                  );
                }
                if (state is SuccessGetSurah) {
                  List<SurahLocalModel> data = state.surah;
                  dataSurah = data;

                  return Expanded(
                    child: Column(
                      children: [
                        listviewBody(data: data, indexSurah: 0),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class listviewBody extends StatelessWidget {
  final ItemScrollController _itemScrollController = ItemScrollController();

  listviewBody({
    Key? key,
    required this.data,
    required this.indexSurah,
  }) : super(key: key);

  List<SurahLocalModel> data;
  int indexSurah;

  // Future<bool> audioFilesOnce(int data) async {
  //   List<String> urlAudios = await ApiSurahProvider().getAudioResource(data);
  //   var result = await AudioProvider().checkAllFileAudios(urlAudios);
  //   return result;
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollablePositionedList.separated(
        separatorBuilder: (context, index) => CustomWidgets.standartDivider(),
        itemScrollController: _itemScrollController,
        initialScrollIndex: indexSurah,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context
                  .read<SurahBloc>()
                  .add(ViewDetailSurah(number: data[index].number.toString()));

              // // check have you ever read
              // context.read<SurahBloc>().add(
              //     GetLastAyatSurah(surah: data[index].name.transliteration.id));

              // // check all file audio is exist
              // context
              //     .read<AudiomanagementBloc>()
              //     .add(CheckAudioExistEvent(listAudio: data[index].number));

              // // check this surah is favorite?
              // context.read<FavoriteBloc>().add(GetFavoriteSurahStatusEvent(
              //     surah: data[index].number.toString()));

              // // set indexsurah
              // context.read<SurahBloc>().add(GetIndexSurah(indexSurah: index));

              Navigator.pushNamed(context, '/surahdetail');
            },
            child: ListTile(
              minLeadingWidth: 10,
              leading: Text(
                '${data[index].number}.',
                style: const TextStyle(fontSize: Constants.sizeTextTitle),
              ),
              title: Text(
                // data[index].name.transliteration.id,
                data[index].transliteration_id.toString(),
                style: const TextStyle(
                  fontSize: Constants.sizeTextTitle,
                ),
              ),
              subtitle: Text(
                // '${data[index].name.translation.id} (${data[index].numberOfVerses}) ',
                '${data[index].translation_id} (${data[index].number_of_verses}) ',
                style: const TextStyle(
                  fontSize: Constants.sizeText,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                // data[index].name.short,
                data[index].name_short.toString(),
                style: const TextStyle(
                  fontSize: Constants.sizeTextArabian,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
