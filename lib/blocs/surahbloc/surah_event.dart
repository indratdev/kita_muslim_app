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
  String number;

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
  harian.SurahHarianModel surah;
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

class InitialFavoriteSurah extends SurahEvent {
  final int surahNumber;

  InitialFavoriteSurah({
    required this.surahNumber,
  });
}

class SetFavoriteSurah extends SurahEvent {
  final int surahNumber;
  final int value;
  final DetailSurahLocalModel data;

  SetFavoriteSurah({
    required this.surahNumber,
    required this.value,
    required this.data,
  });
}

class SetLastReadSurah extends SurahEvent {
  final int surahNumber, lasReadSurahNumber;
  final DetailSurahLocalModel data;

  SetLastReadSurah({
    required this.surahNumber,
    required this.lasReadSurahNumber,
    required this.data,
  });
}
