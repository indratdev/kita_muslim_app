part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class LoadingSetUnsetFavoriteSurah extends FavoriteState {}

class SuccessGetFavoriteSurah extends FavoriteState {
  bool isFavorite;

  SuccessGetFavoriteSurah({
    required this.isFavorite,
  });

  @override
  List<Object> get props => [isFavorite];
}

class SuccessSetUnsetFavoriteSurah extends FavoriteState {
  bool isFavorite;
  String status;

  SuccessSetUnsetFavoriteSurah({
    required this.isFavorite,
    required this.status,
  });

  @override
  List<Object> get props => [isFavorite, status];
}

class FailureSetUnsetFavoriteSurah extends FavoriteState {
  String messageError;

  FailureSetUnsetFavoriteSurah({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

//////////////// favorite surah list
class LoadingListSurahFavorite extends FavoriteState {}

class FailureListSurahFavorite extends FavoriteState {
  String messageError;

  FailureListSurahFavorite({
    required this.messageError,
  });

  @override
  List<Object> get props => [messageError];
}

class SuccessListSurahFavorite extends FavoriteState {
  List<SpesifikSurahModel> result;

  SuccessListSurahFavorite({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
