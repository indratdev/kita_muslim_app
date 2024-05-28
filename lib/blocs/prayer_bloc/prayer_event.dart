part of 'prayer_bloc.dart';

sealed class PrayerEvent extends Equatable {
  const PrayerEvent();

  @override
  List<Object> get props => [];
}

class InitialPrayerEvent extends PrayerEvent {}

class NextPrayerTimeEvent extends PrayerEvent {}

class GetPrayerTimeEvent extends PrayerEvent {
  String? date;

  GetPrayerTimeEvent({
    this.date,
  });
}

class ChangeDatePrayerEvent extends PrayerEvent {
  String date;
  bool isAdd;

  ChangeDatePrayerEvent({
    required this.date,
    required this.isAdd,
  });
}


class GetRandomWallpaper extends PrayerEvent {}