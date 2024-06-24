import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart';
import 'package:kita_muslim/data/others/shared_preferences.dart';
import 'package:kita_muslim/data/providers/api_surah_provider.dart';
import 'package:kita_muslim/data/repositories/surah_repository.dart';

import '../../data/models/local/export.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final pref = MySharedPref();
  final surahRepository = SurahRepository();

  FavoriteBloc() : super(FavoriteInitial()) {
    on<GetFavoriteSurahStatusEvent>((event, emit) async {
      try {
        var result = await pref.getFavoriteSurah(event.surah);
        emit(SuccessGetFavoriteSurah(isFavorite: result));
      } catch (e) {}
    });
    on<SetFavoriteSurahStatus>((event, emit) async {
      try {
        emit(LoadingSetUnsetFavoriteSurah());
        // var result = await pref.markFavoriteSurah(event.surah, event.status);
        await surahRepository.markFavoriteSurah(event.surah, event.status);

        String status = (event.status)
            ? "Sukses Menandai Surat"
            : "Sukses Hapus Yang Telah Ditandai";

        emit(SuccessSetUnsetFavoriteSurah(
            isFavorite: event.status, status: status));
      } catch (e) {
        emit(FailureSetUnsetFavoriteSurah(
            messageError: "Error: Gagal Menandai Surat"));
      }
    });

    on<GetListAllSurahFavoriteEvent>((event, emit) async {
      try {
        emit(LoadingListSurahFavorite());
        var listSharedSurah = await surahRepository.getAllFavoriteSharedPref();

        List<SpesifikSurahModel> result =
            await ApiSurahProvider().getListFavoriteSurah(listSharedSurah);

        emit(SuccessListSurahFavorite(result: result));
      } catch (e) {
        emit(FailureListSurahFavorite(
            messageError: "Error: Memuat Data Surat Favorit"));
      }
    });

    /// new
    on<ListAllSurahFavoriteEvent>((event, emit) async {
      emit(LoadingListAllSurahFavorite());
      try {
        List<String> listNumberSurahFavorite =
            await surahRepository.getAllSurahFavoriteLocal();

        // ubah dari list string join koma (,)
        String inClause = listNumberSurahFavorite.map((e) => e).join(", ");

        List<SurahLocalModel> result =
            await surahRepository.getAllSurahByNumberOnLocal(inClause);

        print(">>> result : $result");
      } catch (e) {
        emit(FailureListAllSurahFavorite(messageError: e.toString()));
      }
    });

    ///
  }
}
