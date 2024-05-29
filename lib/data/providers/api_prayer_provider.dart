import 'package:dio/dio.dart';
import 'package:kita_muslim/data/models/prayer_time/prayer_time_model.dart';
import 'package:kita_muslim/utils/constants.dart';

class ApiPrayerProvider {
  String basePrayerTiming = 'http://api.aladhan.com/v1/timings/';
  String urlWallpaper = "https://api.unsplash.com/search/photos";
  // https://api.unsplash.com/search/photos?query=muslim&client_id=LbvlfhTLNsdV4qp5Rsm0JlfsBR06GTEuP_b9mjcjOJ4&per_page=20&orientation=landscape
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

  Future<String> getRandomWallpaper() async {
    try {
      Response response;
      Map<String, dynamic> params = {
        'query': "muslim",
        'client_id': Constants.clientIdUnsplash,
        'per_page': 20,
        'orientation': "landscape",
        'order_by': 'latest',
      };

      response = await dio.get(
        urlWallpaper,
        queryParameters: params,
      );

      return response.data["results"][0]["urls"]["regular"];
    } catch (e) {
      throw e.toString();
    }
  }
}
