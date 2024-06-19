import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/screens/surah_detail/widgets/export.dart';

import '../../../../blocs/export.dart';
import '../../../../data/models/local/export.dart';

class FavoriteWidget extends StatelessWidget {
  bool isFavorite;
  final List<DetailSurahLocalModel> listData;

  FavoriteWidget({
    super.key,
    this.isFavorite = false,
    required this.listData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SurahBloc, SurahState>(
      listener: (context, state) {
        if (state is SuccessSetFavoriteSurah) {
          CustomWidgets.showSnackBarCustom(
              context,
              (isFavorite)
                  ? 'Berhasil menghapus surah dari favorit'
                  : 'Berhasil menandai surah ke favorit',
              true);
        }
      },
      buildWhen: (previous, current) =>
          current is SuccessFavoriteSurah || current is SuccessSetFavoriteSurah,
      builder: (context, state) {
        if (state is SuccessSetFavoriteSurah) {
          isFavorite = (state.value == 1) ? true : false;
        }

        if (state is SuccessFavoriteSurah) {
          isFavorite = (state.value == 1) ? true : false;
        }

        return IconButton(
          onPressed: () {
            context.read<SurahBloc>().add(SetFavoriteSurah(
                  surahNumber: int.parse(listData.first.number!),
                  value: (isFavorite) ? 0 : 1,
                  data: listData.first,
                ));
          },
          icon: (!isFavorite)
              ? const Icon(Icons.favorite_border)
              : const Icon(Icons.favorite, color: Colors.red),
        );
      },
    );
  }
}
