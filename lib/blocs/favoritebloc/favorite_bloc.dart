import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart';

import 'package:kita_muslim/data/repositories/surah_repository.dart';

import '../../data/models/local/export.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final surahRepository = SurahRepository();

  FavoriteBloc() : super(FavoriteInitial()) {
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

        emit(SuccessListAllSurahFavorite(result: result));
      } catch (e) {
        emit(FailureListAllSurahFavorite(messageError: e.toString()));
      }
    });

    ///
  }
}
