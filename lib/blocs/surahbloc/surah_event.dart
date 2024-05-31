part of 'surah_bloc.dart';

@immutable
abstract class SurahEvent {}

class GetIndexSurah extends SurahEvent {
  int indexSurah;

  GetIndexSurah({required this.indexSurah});
}

class SendIndexSurah extends SurahEvent {
  int indexSurah;

  SendIndexSurah({required this.indexSurah});
}

class GetAllSurah extends SurahEvent {}

class GetAllSurahHarian extends SurahEvent {
  int indexSurah;

  GetAllSurahHarian([
    this.indexSurah = 0,
  ]);
}

class ViewDetailSurah extends SurahEvent {
  int number;
  // BuildContext context;
  // Route routeName;

  ViewDetailSurah({
    required this.number,
  });
}

class MarkLastAyatSurah extends SurahEvent {
  String surah, ayat;

  MarkLastAyatSurah({
    required this.surah,
    required this.ayat,
  });
}

class GetLastAyatSurah extends SurahEvent {
  String surah;

  GetLastAyatSurah({
    required this.surah,
  });
}

class GetFavoriteSurahStatus extends SurahEvent {
  String surah;

  GetFavoriteSurahStatus({
    required this.surah,
  });
}

class SendDoaHarianDetailEvent extends SurahEvent {
  SurahHarianModel surah;
  int indexSurah;

  SendDoaHarianDetailEvent({
    required this.surah,
    required this.indexSurah,
  });
}

class SendIndexDoaHarianEvent extends SurahEvent {
  int indexSurah;

  SendIndexDoaHarianEvent({
    required this.indexSurah,
  });
}

class GetNumberOfSurahOnLocalStorage extends SurahEvent {}
