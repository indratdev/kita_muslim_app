part of 'hadists_bloc.dart';

abstract class HadistsState extends Equatable {
  const HadistsState();

  @override
  List<Object> get props => [];
}

class HadistsInitial extends HadistsState {}

class LoadingHadistsBooks extends HadistsState {}

class FailureHadistsBooks extends HadistsState {
  String message;

  FailureHadistsBooks({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class SuccessHadistsBooks extends HadistsState {
  HadistsModel result;
  HadistsRModel resultRandom;

  SuccessHadistsBooks({
    required this.result,
    required this.resultRandom,
  });

  @override
  List<Object> get props => [result, resultRandom];
}

// select spesifik or range

class LoadingSelectedHadistSpesifikRange extends HadistsState {}

class FailureSelectedHadistSpesifikRange extends HadistsState {
  String messageError;

  FailureSelectedHadistSpesifikRange({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class SuccessSelectedHadistSpesifikRange extends HadistsState {
  bool result;

  SuccessSelectedHadistSpesifikRange({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

class LoadingSpesifikRangeHadist extends HadistsState {}

class FailureSpesifikRangeHadist extends HadistsState {
  String messageError;

  FailureSpesifikRangeHadist({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class SuccessSpesifikRangeHadist extends HadistsState {
  HadistsRModel spesifikModel;
  HadistRangeModel rangeModel;
  bool isSpesifik;
  String nameHadist;

  SuccessSpesifikRangeHadist({
    required this.isSpesifik,
    required this.spesifikModel,
    required this.rangeModel,
    required this.nameHadist,
  });

  @override
  List<Object> get props => [isSpesifik, spesifikModel, rangeModel];
}
