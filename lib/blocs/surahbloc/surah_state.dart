part of 'surah_bloc.dart';

@immutable
abstract class SurahState {}

class SurahInitial extends SurahState {}

class LoadingSurahDetail extends SurahState {}

class LoadingDoaHarianDetail extends SurahState {}

class FailureSurahDetail extends SurahState {
  String info;

  FailureSurahDetail({
    required this.info,
  });

  @override
  List<Object> get props => [info];
}

class SuccessGetSurahDetail extends SurahState {
  // spesifik.SpesifikSurahModel data;
  // String status;
  // var uuid = Uuid().v1();
  List<DetailSurahLocalModel> data;

  SuccessGetSurahDetail({
    required this.data,
    // this.status = "",
    // required this.context,
    // required this.routeName,
  });

  @override
  List<Object> get props => [data];
}

class SuccessGetIndexSurah extends SurahState {
  int indexSurah;

  SuccessGetIndexSurah({
    required this.indexSurah,
  });

  @override
  List<Object> get props => [indexSurah];
}

class SuccessSendIndexSurah extends SurahState {
  int indexSurah;
  SurahModel surah;

  SuccessSendIndexSurah({
    required this.indexSurah,
    required this.surah,
  });

  @override
  List<Object> get props => [indexSurah, surah];
}

class LoadingMarkLastAyatSurah extends SurahState {}

class FailureMarkLastAyatSurah extends SurahState
    implements FailureSurahDetail {
  @override
  String info;

  FailureMarkLastAyatSurah({
    required this.info,
  });

  @override
  // TODO: implement props
  List<Object> get props => [info];
}

class SuccessMarkLastAyatSurah extends SurahState {}

class SuccessGetLastAyatSurah extends SurahState {
  String ayat;

  SuccessGetLastAyatSurah({
    required this.ayat,
  });
}

class FailureGetLastAyatSurah extends FailureSurahDetail {
  FailureGetLastAyatSurah({required String info}) : super(info: info);
}

class LoadingSurah extends SurahState {}

class FailureSurah extends SurahState {
  String errorMessage;

  FailureSurah({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class SuccessGetSurah extends SurahState {
  // SurahModel surah;
  // List<Data> surah;
  List<SurahLocalModel> surah;

  SuccessGetSurah({
    required this.surah,
  });

  @override
  List<Object> get props => [surah];
}

class SuccessGetSurahHarian extends SurahState {
  List<harian.SurahHarianModel> surah;
  int indexSurah;

  SuccessGetSurahHarian({
    required this.surah,
    this.indexSurah = 0,
  });

  @override
  List<Object> get props => [surah];
}

// class SuccessGetFavoriteSurah extends SurahState {
//   bool isFavorite;

//   SuccessGetFavoriteSurah({
//     required this.isFavorite,
//   });

//   @override
//   List<Object> get props => [isFavorite];
// }

class SuccessSendDoaHarianDetailState extends SurahState {
  harian.SurahHarianModel surah;
  int indexSurah;

  SuccessSendDoaHarianDetailState({
    required this.surah,
    required this.indexSurah,
  });

  @override
  List<Object> get props => [surah, indexSurah];
}

class FailureDoaHarianDetail extends SurahState {
  String errorMessage;

  FailureDoaHarianDetail({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class SuccessSendIndexSurahHarian extends SurahState {
  int indexSurah;
  List<harian.SurahHarianModel> surah;

  SuccessSendIndexSurahHarian({
    required this.indexSurah,
    required this.surah,
  });

  @override
  List<Object> get props => [indexSurah, surah];
}

/// localstorage
///
class LoadingGetNumberOfSurahOnLocalStorage extends SurahState {}

class FailureGetNumberOfSurahOnLocalStorage extends SurahState {
  String errorMessage;

  FailureGetNumberOfSurahOnLocalStorage({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}

class SuccessGetNumberOfSurahOnLocalStorage extends SurahState {
  String result;

  SuccessGetNumberOfSurahOnLocalStorage({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
