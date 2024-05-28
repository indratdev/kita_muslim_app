part of 'prayer_bloc.dart';

sealed class PrayerEvent extends Equatable {
  const PrayerEvent();

  @override
  List<Object> get props => [];
}

class NextPrayerTimeEvent extends PrayerEvent {}

class GetRandomWallpaper extends PrayerEvent {}