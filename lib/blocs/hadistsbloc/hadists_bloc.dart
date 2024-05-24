import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kita_muslim/data/models/hadits/hadistRange_model.dart';
import 'package:kita_muslim/data/models/hadits/hadistsR_model.dart';
import 'package:kita_muslim/data/models/hadits/hadists_model.dart';

import 'dart:math';

import 'package:kita_muslim/data/repositories/hadist_repository.dart';

part 'hadists_event.dart';
part 'hadists_state.dart';

class HadistsBloc extends Bloc<HadistsEvent, HadistsState> {
  final hadistRepository = HadistRepository();

  HadistsBloc() : super(HadistsInitial()) {
    on<GetListBookHadists>((event, emit) async {
      try {
        emit(LoadingHadistsBooks());

        var result = await hadistRepository.getHadistBooks();
        int maxBooks = result.data.length;
        Random random = Random();
        int randomNumber = random.nextInt(maxBooks);
        int randomNumberHadist = random.nextInt(
            result.data[randomNumber].available); // get random hadist number
        String randomBookName = result.data[randomNumber].id;

        var resultRandom = await hadistRepository.getRandomHadist(
            randomBookName, randomNumberHadist);
        emit(SuccessHadistsBooks(result: result, resultRandom: resultRandom));
      } catch (e) {
        emit(FailureHadistsBooks(
            message: "Error: Memuat Data, Silahkan dicoba kembali!"));
      }
    });

    // select spesifik or range
    on<SelectedHadistEvent>((event, emit) {
      try {
        emit(LoadingSelectedHadistSpesifikRange());
        emit(SuccessSelectedHadistSpesifikRange(result: event.isSpesifik));
      } catch (e) {
        emit(FailureSelectedHadistSpesifikRange(
            messageError: "Error: Gagal Dalam Pemilihan Hadis"));
      }
    });

    on<GetSpesifikRangeHadistEvent>((event, emit) async {
      try {
        emit(LoadingSpesifikRangeHadist());
        var result;
        // cek spesifik / range
        if (!event.isSpesifik) {
          result = await hadistRepository.getSpesifikHadist(
              event.nameHadist, event.numSpesifik);
          emit(
            SuccessSpesifikRangeHadist(
              isSpesifik: event.isSpesifik,
              spesifikModel: result,
              nameHadist: event.nameHadist,
              rangeModel: HadistRangeModel(
                code: 0,
                message: "",
                error: false,
                data: null,
              ),
            ),
          );
        } else {
          result = await hadistRepository.getRangeHadist(
              event.nameHadist, event.numRange1, event.numRange2);
          emit(SuccessSpesifikRangeHadist(
              isSpesifik: event.isSpesifik,
              nameHadist: event.nameHadist,
              spesifikModel: HadistsRModel(),
              rangeModel: result));
        }
      } catch (e) {
        emit(FailureSelectedHadistSpesifikRange(
            messageError: "Error: Memuat Data, Silahkan dicoba kembali! "));
      }
    });
  }
}
