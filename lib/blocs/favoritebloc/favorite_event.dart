part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteSurahStatusEvent extends FavoriteEvent {
  String surah;

  GetFavoriteSurahStatusEvent({
    required this.surah,
  });
}

class SetFavoriteSurahStatus extends FavoriteEvent {
  String surah;
  bool status;

  SetFavoriteSurahStatus({
    required this.surah,
    required this.status,
  });
}

class GetListAllSurahFavoriteEvent extends FavoriteEvent {} //old

class ListAllSurahFavoriteEvent extends FavoriteEvent {}
