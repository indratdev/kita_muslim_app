import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:kita_muslim/data/providers/api_prayer_provider.dart';
import 'package:kita_muslim/data/repositories/prayer_repository.dart';
import 'package:kita_muslim/data/services/location_services.dart';
import 'package:kita_muslim/utils/datetime_utils.dart';

import '../../data/models/prayer_time/prayer_time_model.dart';

part 'prayer_event.dart';
part 'prayer_state.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final prayerRepository = PrayerRepository();

  PrayerBloc() : super(PrayerInitial()) {
    on<NextPrayerTimeEvent>(
      (event, emit) async {
        try {
          emit(LoadingNextPrayerTime());

          Map<String, dynamic> result = {};
          print(">>> NextPrayerTimeEvent run");

          LocationService locationService = LocationService();
          Position? locations = await locationService.getCurrentPosition();
          if (locations == null) {
            return;
          }

          String currentTime = DateTimeUtils.getCurrentTime();
          String currentTimeZoneName = DateTimeUtils.getCurrentTimeZoneName();
          String today = DateTimeUtils.getTodayDate();
          PrayerTimeModel? prayerTime =
              await prayerRepository.getPrayerTimeSpesific(
                  today, locations.latitude, locations.longitude);

          Map<String, dynamic> sortedTimings =
              DateTimeUtils().sortTimings(prayerTime!.data.timings.toJson());

          for (var entry in sortedTimings.entries) {
            var key = entry.key;
            var value = entry.value;
            if (!DateTimeUtils().isTimeStringGreater(currentTime, value)) {
              result['description'] = key;
              result['current_times'] = currentTime;
              result['current_timezone_name'] = currentTimeZoneName;
              result['next_times'] = value;
              // result['next_times'] = '13:19';
              break; // Menghentikan loop setelah menemukan data yang cocok
            }
          }

          emit(SuccessNextPrayerTime(result: result));
        } catch (e) {
          emit(FailureNextPrayerTime(message: e.toString()));
        }
      },
    );

    on<GetRandomWallpaper>((event, emit) async {
      // https://images.unsplash.com/photo-1574545640323-59dc7a2b4a6d?crop=entropy&cs=srgb&fm=jpg&ixid=M3wyMTMxMTh8MHwxfHNlYXJjaHwxfHxtdXNsaW18ZW58MHwwfHx8MTcxNjkxMjA3MHww&ixlib=rb-4.0.3&q=85
      emit(LoadingRandomWallpaper());
      try {
        String result = await prayerRepository.getRandomWallpaper();
        print("result : $result");
        emit(SuccessRandomWallpaper(urlImage: result));

      } catch (e) {
        emit(FailureRandomWallpaper(message: e.toString()));
      }
    },);
  }
}
