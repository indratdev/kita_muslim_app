import 'package:flutter/material.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../blocs/export.dart';
import '../../../../data/models/local/export.dart';
import 'export.dart';

class ListViewBodyWidget extends StatelessWidget {
  final ItemScrollController _itemScrollController = ItemScrollController();

  ListViewBodyWidget({
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

              // initial status favorite
              context.read<SurahBloc>().add(InitialFavoriteSurah(
                  surahNumber: int.parse(data[index].number.toString())));

              context.read<SurahBloc>().add(InitialLastReadSurah(
                  surahNumber: int.parse(data[index].number.toString())));

              Navigator.pushNamed(context, '/surahdetail');
            },
            child: ListQuranWidget(data: data, index: index),
          );
        },
      ),
    );
  }
}
