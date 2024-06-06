import 'dart:developer';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kita_muslim/data/models/local/surah_local_model.dart';
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/data/providers/api_prayer_provider.dart';
import 'package:kita_muslim/data/providers/audio_provider.dart';
import 'package:kita_muslim/presentation/screens/quran_screen/widgets/list_quran_widget.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/utils/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../blocs/export.dart';

// class QuranScreen extends StatefulWidget {
//   QuranScreen({Key? key}) : super(key: key);

//   @override
//   State<QuranScreen> createState() => _QuranScreenState();
// }

// class _QuranScreenState extends State<QuranScreen> {
//   TextEditingController _searchController = TextEditingController();
//   AudioProvider audioProvider = AudioProvider();
//   List<SurahLocalModel> dataSurah = [];
//   int _indexSurah = 0;
//   String query = '';

//   ReceivePort _port = ReceivePort();

//   List<SurahLocalModel> searchResults = [];

//   void onQueryChanged(String newQuery) {
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: CustomWidgets.basicAppBar("Al-Quran",
//             centerTitle: true,
//             listAction: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: IconButton(
//                     onPressed: () {
//                       print("press");
//                     },
//                     icon: Icon(Icons.search)),
//               ),
//             ]),
//         body: Column(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.all(16),
//               child: TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Search',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.search),
//                 ),
//               ),
//             ),
//             BlocBuilder<SurahBloc, SurahState>(
//               builder: (context, state) {
//                 if (state is SuccessSendIndexSurah) {
//                   return Expanded(
//                     child: Column(
//                       children: [
//                         listviewBody(
//                           // data: state.surah.data,
//                           data: [],
//                           indexSurah: state.indexSurah,
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 if (state is FailureSurah) {
//                   return Center(child: Text(state.errorMessage.toString()));
//                 }
//                 if (state is LoadingSurah) {
//                   return const Expanded(
//                     child: Center(child: CircularProgressIndicator.adaptive()),
//                   );
//                 }
//                 if (state is SuccessGetSurah) {
//                   List<SurahLocalModel> data = state.surah;
//                   dataSurah = data;

//                   return Expanded(
//                     child: Column(
//                       children: [
//                         listviewBody(data: data, indexSurah: 0),
//                       ],
//                     ),
//                   );
//                 } else {
//                   return Container();
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class listviewBody extends StatelessWidget {
//   final ItemScrollController _itemScrollController = ItemScrollController();

//   listviewBody({
//     Key? key,
//     required this.data,
//     required this.indexSurah,
//   }) : super(key: key);

//   List<SurahLocalModel> data;
//   int indexSurah;

//   // Future<bool> audioFilesOnce(int data) async {
//   //   List<String> urlAudios = await ApiSurahProvider().getAudioResource(data);
//   //   var result = await AudioProvider().checkAllFileAudios(urlAudios);
//   //   return result;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ScrollablePositionedList.separated(
//         separatorBuilder: (context, index) => const SizedBox.shrink(),
//         itemScrollController: _itemScrollController,
//         initialScrollIndex: indexSurah,
//         itemCount: data.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               context
//                   .read<SurahBloc>()
//                   .add(ViewDetailSurah(number: data[index].number.toString()));

//               // // check have you ever read
//               // context.read<SurahBloc>().add(
//               //     GetLastAyatSurah(surah: data[index].name.transliteration.id));

//               // // check all file audio is exist
//               // context
//               //     .read<AudiomanagementBloc>()
//               //     .add(CheckAudioExistEvent(listAudio: data[index].number));

//               // // check this surah is favorite?
//               // context.read<FavoriteBloc>().add(GetFavoriteSurahStatusEvent(
//               //     surah: data[index].number.toString()));

//               // // set indexsurah
//               // context.read<SurahBloc>().add(GetIndexSurah(indexSurah: index));

//               Navigator.pushNamed(context, '/surahdetail');
//             },
//             child: ListQuranWidget(data: data, index: index),
//           );
//         },
//       ),
//     );
//   }
// }

class QuranScreen extends StatefulWidget {
  QuranScreen({Key? key}) : super(key: key);

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  TextEditingController _searchController = TextEditingController();
  AudioProvider audioProvider = AudioProvider();
  List<SurahLocalModel> dataSurah = [];
  List<SurahLocalModel> filteredDataSurah = [];
  int _indexSurah = 0;
  String query = '';
  bool isSearch = false;

  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    setState(() {
      query = _searchController.text;
      if (query.isEmpty) {
        filteredDataSurah = List.from(dataSurah);
      } else {
        filteredDataSurah = dataSurah
            .where((surah) => surah.transliteration_id
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            //     ||
            // surah.name_transliteration_en
            //     .toLowerCase()
            //     .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomWidgets.basicAppBar("Al-Quran",
            centerTitle: true,
            listAction: <Widget>[
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                  icon: (isSearch)
                      ? const Icon(Icons.search_off_rounded,
                          color: Constants.colorRedV2)
                      : const Icon(Icons.search_rounded))
            ]),
        body: Column(
          children: <Widget>[
            Visibility(
              visible: isSearch,
              child: Container(
                padding: EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            BlocBuilder<SurahBloc, SurahState>(
              builder: (context, state) {
                if (state is SuccessSendIndexSurah) {
                  return Expanded(
                    child: listviewBody(
                      data: filteredDataSurah,
                      indexSurah: state.indexSurah,
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
                  print(">>> SuccessGetSurah run");
                  dataSurah = state.surah;
                  filteredDataSurah = query.isEmpty
                      ? List.from(dataSurah)
                      : dataSurah
                          .where((surah) => surah.transliteration_id
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          //     ||
                          // surah.name_transliteration_en
                          //     .toLowerCase()
                          //     .contains(query.toLowerCase()))
                          .toList();

                  return Expanded(
                    child: listviewBody(
                      data: filteredDataSurah,
                      indexSurah: _indexSurah,
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

  final List<SurahLocalModel> data;
  final int indexSurah;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollablePositionedList.separated(
        separatorBuilder: (context, index) => const SizedBox.shrink(),
        itemScrollController: _itemScrollController,
        initialScrollIndex: indexSurah,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context
                  .read<SurahBloc>()
                  .add(ViewDetailSurah(number: data[index].number.toString()));

              Navigator.pushNamed(context, '/surahdetail');
            },
            child: ListQuranWidget(data: data, index: index),
          );
        },
      ),
    );
  }
}
