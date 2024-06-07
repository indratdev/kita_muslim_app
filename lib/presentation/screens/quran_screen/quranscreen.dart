import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:kita_muslim/data/models/local/surah_local_model.dart';

import 'package:kita_muslim/data/providers/audio_provider.dart';

import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';
import 'widgets/export.dart';

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
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
            ),
            BlocBuilder<SurahBloc, SurahState>(
              builder: (context, state) {
                if (state is SuccessSendIndexSurah) {
                  return Expanded(
                    child: ListViewBodyWidget(
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
                          .toList();

                  return ListViewBodyWidget(
                    data: filteredDataSurah,
                    indexSurah: _indexSurah,
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
