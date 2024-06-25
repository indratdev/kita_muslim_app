import 'package:flutter/material.dart';
import 'package:kita_muslim/config/routes.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';

import '../../../blocs/export.dart';
import '../../../data/models/local/export.dart';
import '../quran_screen/widgets/export.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  List<SurahLocalModel> dataSurah = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar(context, "Surah Favorit"),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is LoadingListAllSurahFavorite) {
            return CustomWidgets.showLoadingIndicatorWithContainer(
                context,
                MediaQuery.sizeOf(context).height,
                MediaQuery.sizeOf(context).width);
          }

          if (state is FailureListAllSurahFavorite) {
            Center(
              child: Text(state.messageError.toString()),
            );
          }

          if (state is SuccessListAllSurahFavorite) {
            dataSurah = state.result;

            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox.shrink(),
              shrinkWrap: true,
              itemCount: dataSurah.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.read<SurahBloc>().add(ViewDetailSurah(
                        number: dataSurah[index].number.toString()));

                    // initial status favorite
                    context.read<SurahBloc>().add(InitialFavoriteSurah(
                        surahNumber:
                            int.parse(dataSurah[index].number.toString())));

                    context.read<SurahBloc>().add(InitialLastReadSurah(
                        surahNumber:
                            int.parse(dataSurah[index].number.toString())));

                    Navigator.pushNamed(context, Routes.detailSurah);
                  },
                  child: ListQuranWidget(data: dataSurah, index: index),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
