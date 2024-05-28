import 'package:dio/dio.dart';
import 'package:kita_muslim/data/models/prayer_time/prayer_time_model.dart';

class ApiPrayerProvider {
  String basePrayerTiming = 'http://api.aladhan.com/v1/timings/';
  final String method = '20';

  final dio = Dio();

  // dd-mm-yyyy
  Future<PrayerTimeModel?> getPrayerTimeSpesific(
      String date, double lat, double long) async {
    try {
      Response response;
      String url = basePrayerTiming + date;

      Map<String, dynamic> params = {
        'latitude': lat,
        'longitude': long,
        'method': method,
      };

      response = await dio.get(
        url,
        queryParameters: params,
      );

      return PrayerTimeModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
