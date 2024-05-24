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

// prayer time
class FailurePrayerTime extends FailurePrayer {
  FailurePrayerTime({required super.message});
}

class LoadingPrayerTime extends PrayerState {}

class SuccessPrayerTime extends PrayerState {
  Map<String, dynamic> result;

  SuccessPrayerTime({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}

// change date prayer
class SuccessChangeDatePrayer extends PrayerState {
  String date;

  SuccessChangeDatePrayer({
    required this.date,
  });

  @override
  List<Object> get props => [date];
}
