part of 'hadists_bloc.dart';

abstract class HadistsEvent extends Equatable {
  const HadistsEvent();

  @override
  List<Object> get props => [];
}

class GetListBookHadists extends HadistsEvent {}

class SelectedHadistEvent extends HadistsEvent {
  bool isSpesifik;

  SelectedHadistEvent({
    required this.isSpesifik,
  });
}

class GetSpesifikRangeHadistEvent extends HadistsEvent {
  int numSpesifik;
  int numRange1;
  int numRange2;
  bool isSpesifik;
  String nameHadist;

  GetSpesifikRangeHadistEvent({
    required this.isSpesifik,
    required this.numRange1,
    required this.numRange2,
    required this.numSpesifik,
    required this.nameHadist,
  });
}
