import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/blocs/export.dart';
import 'package:kita_muslim/data/models/daily_prayer/daily_prayer_model.dart';
import 'package:kita_muslim/data/models/surah/surah_harian_model.dart'
    as harian;
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/data/others/shared_preferences.dart';

import 'package:kita_muslim/data/repositories/surah_repository.dart';

import '../../data/models/local/export.dart';

part 'surah_event.dart';
part 'surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final surahRepository = SurahRepository();
  final pref = MySharedPref();

  SurahBloc() : super(SurahInitial()) {
    on<GetAllSurah>((event, emit) async {
      try {
        emit(LoadingSurah());
        // final result = await surahRepository.getAllSurah();
        final result = await surahRepository.getSurahLocal();
        emit(SuccessGetSurah(surah: result));
      } catch (e) {
        print(e.toString());
        emit(FailureSurah(
            errorMessage: "Error: Gagal Memuat Data, Silahkan dicoba Kembali"));
      }
    });

    on<ViewDetailSurah>((event, emit) async {
      try {
        emit(LoadingSurahDetail());
        // var result = await surahRepository.getDetailSurah(event.number);

        List<DetailSurahLocalModel> result =
            await surahRepository.getDetailSurahLocal(event.number);
        emit(SuccessGetSurahDetail(data: result));
      } catch (e) {
        emit(FailureSurahDetail(info: "Error: Gagal Memuat Detail Surat"));
      }
    });

    on<MarkLastAyatSurah>((event, emit) {
      try {
        emit(LoadingMarkLastAyatSurah());
        // pref.markLastSurah(event.surah, event.ayat);
        surahRepository.markLastAyatSurah(event.surah, event.ayat);
        emit(SuccessMarkLastAyatSurah());
      } catch (e) {
        emit(FailureMarkLastAyatSurah(info: "Error: Gagal Menandai Surat"));
      }
    });

    on<GetLastAyatSurah>((event, emit) async {
      try {
        var result = await pref.getMarkLastSurah(event.surah);
        emit(SuccessGetLastAyatSurah(ayat: result));
      } catch (e) {
        emit(FailureGetLastAyatSurah(
            info: "Error: Gagal Memuat Data, Silahkan dicoba Kembali"));
      }
    });

    on<GetAllSurahHarian>((event, emit) async {
      try {
        emit(LoadingSurah());
        final result = await surahRepository.getSurahHarian();
        emit(
            SuccessGetSurahHarian(surah: result, indexSurah: event.indexSurah));
      } catch (e) {
        emit(FailureSurah(
            errorMessage: "Error: Gagal Memuat Data, Silahkan dicoba Kembali"));
      }
    });

    on<SendDoaHarianDetailEvent>((event, emit) {
      try {
        emit(LoadingDoaHarianDetail());
        harian.SurahHarianModel result = event.surah;
        emit(SuccessSendDoaHarianDetailState(
            surah: result, indexSurah: event.indexSurah));
      } catch (e) {
        emit(FailureDoaHarianDetail(
            errorMessage:
                "Error: Gagal Memuat Detail Surat, Silahkan dicoba Kembali"));
      }
    });

    on<GetIndexSurah>((event, emit) {
      try {
        emit(SuccessGetIndexSurah(indexSurah: event.indexSurah));
      } catch (e) {
        log(e.toString());
      }
    });

    on<SendIndexSurah>((event, emit) async {
      try {
        emit(LoadingSurah());
        final result = await surahRepository.getAllSurah();
        emit(
            SuccessSendIndexSurah(indexSurah: event.indexSurah, surah: result));
      } catch (e) {
        emit(FailureSurah(errorMessage: "Error: Gagal Memuat Index Data"));
      }
    });

    // on<SendIndexDoaHarianEvent>((event, emit) async {
    //   try {
    //     emit(LoadingSurah());
    //     final result = await surahRepository.getSurahHarian();
    //     emit(SuccessSendIndexSurahHarian(
    //         indexSurah: event.indexSurah, surah: result));
    //   } catch (e) {
    //     emit(FailureSurah(errorMessage: "Error: Gagal Memuat Index Data"));
    //   }
    // });

    /// localstorage
    on<GetNumberOfSurahOnLocalStorage>((event, emit) async {
      emit(LoadingGetNumberOfSurahOnLocalStorage());

      try {
        // check total number surah on localstorage
        String totalSurah =
            await surahRepository.getStatusSurahOnLocalStorage();

        // if number of surah not 144 let's download
        if (totalSurah != "144") {}
      } catch (e) {
        emit(FailureGetNumberOfSurahOnLocalStorage(errorMessage: e.toString()));
      }
    });

    on<InitialFavoriteSurah>((event, emit) async {
      int result =
          await surahRepository.readStatusFavoriteSurah(event.surahNumber);
      emit(SuccessFavoriteSurah(result: "", value: result));
    });

    on<SetFavoriteSurah>((event, emit) async {
      emit(LoadingSetFavoriteSurah());
      try {
        int result = await surahRepository.setFavoriteSurah(
            event.surahNumber, event.value, event.data);
        print(">>> result: $result");
        (result >= 0)
            ? emit(SuccessSetFavoriteSurah(
                result: "Berhasil set favorite surah", value: result))
            : FailureSetFavoriteSurah(errorMessage: "Gagal set favorite surah");
      } catch (e) {
        FailureSetFavoriteSurah(errorMessage: "Gagal set favorite surah");
      }
    });

    on<InitialLastReadSurah>((event, emit) async {
      int result =
          await surahRepository.readStatusLastReadSurah(event.surahNumber);
      emit(SuccessInitialLastReadSurah(result: "", value: result));
    });

    on<SetLastReadSurah>((event, emit) async {
      emit(LoadingLastReadSurah());
      try {
        int result = await surahRepository.setLastReadSurah(
            event.surahNumber, event.lasReadSurahNumber, event.data);
        (result >= 1)
            ? emit(SuccessLastReadSurah(
                result: "Sukses Update Last Surah", value: result))
            : emit(FailureLastReadSurah(errorMessage: "Gagal update"));
      } catch (e) {
        emit(FailureLastReadSurah(errorMessage: e.toString()));
      }
    });
  }
}
