part of 'prayer_bloc.dart';

sealed class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object> get props => [];
}

final class PrayerInitial extends PrayerState {}

class FailurePrayer extends PrayerState {
  String message;

  FailurePrayer({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class FailureNextPrayerTime extends FailurePrayer {
  FailureNextPrayerTime({required super.message});
}

class LoadingNextPrayerTime extends PrayerState {}

class SuccessNextPrayerTime extends PrayerState {
  Map<String, dynamic> result;

  SuccessNextPrayerTime({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

// GetRandomWallpaper
class FailureRandomWallpaper extends FailurePrayer {
  FailureRandomWallpaper({required super.message});
}

class LoadingRandomWallpaper extends PrayerState {}

class SuccessRandomWallpaper extends PrayerState {
  // Map<String, dynamic> result;
  String urlImage;

  SuccessRandomWallpaper({
    required this.urlImage,
  });

  @override
  List<Object> get props => [urlImage];
}
