import 'package:flutter/material.dart';
import 'package:kita_muslim/presentation/widgets/customwidgets.dart';
import 'package:kita_muslim/utils/constants.dart';

import '../../../blocs/export.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomWidgets.basicAppBar("Surat Favorit"),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FailureListSurahFavorite) {
            Center(
              child: Text(state.messageError.toString()),
            );
          }
          if (state is LoadingListSurahFavorite) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is SuccessListSurahFavorite) {
            var datas = state.result;
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  CustomWidgets.standartDivider(),
              itemCount: datas.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context
                        .read<SurahBloc>()
                        .add(ViewDetailSurah(number: datas[index].data.number));

                    // // check have you ever read
                    context.read<SurahBloc>().add(GetLastAyatSurah(
                        surah: datas[index].data.name.transliteration.id));

                    // // check all file audio is exist
                    context.read<AudiomanagementBloc>().add(
                        CheckAudioExistEvent(
                            listAudio: datas[index].data.number));

                    // check this surah is favorite?
                    context.read<FavoriteBloc>().add(
                        GetFavoriteSurahStatusEvent(
                            surah: datas[index].data.number.toString()));

                    // set indexsurah
                    context
                        .read<SurahBloc>()
                        .add(GetIndexSurah(indexSurah: index));

                    Navigator.pushNamed(context, '/surahdetail');
                  },
                  child: ListTile(
                    minLeadingWidth: 10,
                    leading: Text(
                      '${index + 1}.',
                      style: const TextStyle(fontSize: Constants.sizeTextTitle),
                    ),
                    title: Text(
                      datas[index].data.name.transliteration.id,
                      style: const TextStyle(
                        fontSize: Constants.sizeTextTitle,
                      ),
                    ),
                    subtitle: Text(
                      "${datas[index].data.name.translation.id} (${datas[index].data.numberOfVerses})",
                      style: const TextStyle(
                        fontSize: Constants.sizeText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      // data[index].name.short,
                      datas[index].data.name.short,
                      style: const TextStyle(
                        fontSize: Constants.sizeTextArabian,
                        fontWeight: FontWeight.bold,
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
