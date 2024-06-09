import 'package:flutter/material.dart';

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
        if (state is SuccessFavoriteSurah) {
          print(">>> state ::: ${state.value}");
          isFavorite = (state.value == 1) ? true : false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Favorite status updated')),
          );
        }
      },
      buildWhen: (previous, current) => current is SuccessFavoriteSurah,
      builder: (context, state) {
        if (state is SuccessFavoriteSurah) {
          // int valueFavorite = state.value;
          isFavorite = (state.value == 1) ? true : false;
          print(">>> _isFavorite : ${isFavorite}");

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
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
