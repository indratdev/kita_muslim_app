import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../blocs/export.dart';
import '../../../utils/constants.dart';

/// https://doa-doa-api-ahmadramadhan.fly.dev/api

class DoaHarianScreen extends StatelessWidget {
  final ItemScrollController _itemScrollController = ItemScrollController();

  DoaHarianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar("Doa - doa harian"),
      body: BlocBuilder<SurahBloc, SurahState>(
        builder: (context, state) {
          if (state is FailureSurah) {
            return Center(
              child: Text(state.errorMessage.toString()),
            );
          }
          if (state is LoadingSurah) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is SuccessGetSurahHarian) {
            var result = state.surah;
            return ScrollablePositionedList.separated(
              separatorBuilder: (context, index) =>
                  CustomWidgets.standartDivider(),
              itemScrollController: _itemScrollController,
              initialScrollIndex: state.indexSurah,
              itemCount: result.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<SurahBloc>().add(SendDoaHarianDetailEvent(
                          surah: state.surah[index],
                          indexSurah: index,
                        ));
                    Navigator.pushNamed(context, '/doahariandetail');
                  },
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: Text(
                      "${index + 1}.",
                      style: const TextStyle(
                        fontSize: Constants.sizeSubTextTitle,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    title: Text(
                      result[index].doa.toString(),
                      style: const TextStyle(
                        fontSize: Constants.sizeSubTextTitle,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
