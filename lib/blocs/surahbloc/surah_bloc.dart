import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/models/local/surah_local_model.dart';
import 'package:kita_muslim/data/models/surah/spesifik_surah_model.dart'
    as spesifik;
import 'package:kita_muslim/data/models/surah/surah_harian_model.dart'
    as harian;
import 'package:kita_muslim/data/models/surah/surah_model.dart';
import 'package:kita_muslim/data/others/shared_preferences.dart';

import 'package:kita_muslim/data/repositories/surah_repository.dart';

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
        var result = await surahRepository.getDetailSurah(event.number);
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
        // final indexSurah = event.indexSurah;
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

    on<SendIndexDoaHarianEvent>((event, emit) async {
      try {
        emit(LoadingSurah());
        final result = await surahRepository.getSurahHarian();
        emit(SuccessSendIndexSurahHarian(
            indexSurah: event.indexSurah, surah: result));
      } catch (e) {
        emit(FailureSurah(errorMessage: "Error: Gagal Memuat Index Data"));
      }
    });

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
  }
}
